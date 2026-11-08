#!/usr/bin/env python3
"""Beryllium publication gate for public pushes (PMD-20261108-001).

This program holds no denylisted term. It reads terms at run time from the
private denylist that the human-run scripts/publication-gate-setup.sh
installs at ${XDG_CONFIG_HOME:-~/.config}/beryllium/publication-gate/denylist
(mode 0600); the canonical copy is .publication-gate/denylist in the private
parent coordination repository. Encoded variants of every entry are derived
in memory and never written anywhere. A finding names an object or file, a
path, a line, a variant class, and a denylist entry number; it never prints
the matched text or the entry.

usage:
  publication-gate.py pre-push REMOTE URL   Git pre-push hook entry; Git's ref
                                            lines arrive on standard input
  publication-gate.py check [--repo DIR] [--remote NAME] [--denylist FILE]
                            [--advisory] [REF ...]
  publication-gate.py audit [--repo DIR] [--all-refs] [--denylist FILE]
                            [--advisory] [REF ...]
  publication-gate.py audit [--repo DIR] --remote NAME [--denylist FILE]
                            [--advisory]
  publication-gate.py scan-tree [--denylist FILE] [--advisory] PATH ...
  publication-gate.py scan-worktree [--repo DIR] [--denylist FILE] [--advisory]
  publication-gate.py validate-denylist [--denylist FILE]
  publication-gate.py classify URL
  publication-gate.py self-test

pre-push and check scan only pushes to a public remote: a remote is public
when it is listed below or anonymous `git ls-remote` succeeds with every
credential source disabled. A listed remote, or one treated as public, that
cannot be read anonymously (for example, made private for containment) is
still scanned as public, excluding only what the remote already holds for
the pushed refs. A private or local remote passes unscanned; a remote whose
visibility cannot be determined is refused. audit scans
everything reachable from the named refs (local branches and tags by
default), as required before any visibility change to public, any new
public repository, or any first push to a public remote. audit --remote
scans what a public remote serves now: every live ref name it lists
anonymously and everything reachable from those tips; it fails closed when
a live tip is not present locally (fetch first) or when a listed remote
cannot be read anonymously (then fetch and use --all-refs). scan-tree scans
files and file names; - reads standard input. scan-worktree scans the
tracked and untracked, not ignored, files of a working tree.

exit status: 0 pass, or the remote is not public; 1 a denylisted term was
found; 2 a configuration, usage, Git, or visibility error (fail closed).
Passing the gate is not publication approval and grants no human gate.
"""

import argparse
import base64
import codecs
import os
import re
import stat
import subprocess
import sys
import tempfile
import threading

PASS, FOUND, ERROR = 0, 1, 2
RECORD = "PMD-20261108-001"
PROBE_TIMEOUT = 60
FINDINGS_PER_OBJECT = 10

# Repositories recorded public by PMD-20261012-001, PMD-20261012-002, and the
# public Beryllium review snapshot. A listed repository that cannot be read
# anonymously (for example, private for containment) is scanned as public,
# excluding only what the remote already holds for the pushed refs, and is
# never treated as private (PMD-20261108-002).
KNOWN_PUBLIC = frozenset({
    "beryllium-project/beryllium-hypervisor",
    "beryllium-project/helium-te-poc",
    "beryllium-project/project-manager",
    "beryllium-project/provenance-review",
    "beryllium-project/security-reviewer",
    "beryllium-project/threat-modeler",
})

# Colon-separated URL prefixes or local paths treated as public in addition
# to the probe. It can only widen gating; nothing makes a remote private.
TREAT_AS_PUBLIC_ENV = "BERYLLIUM_PUBLICATION_GATE_TREAT_AS_PUBLIC"

AUTH_FAILURE_MARKERS = (
    "could not read username",
    "could not read password",
    "unable to get password",
    "terminal prompts disabled",
    "authentication failed",
    "http 401",
    "returned error: 401",
    "repository not found",
)

GITHUB_URL = re.compile(
    r"^(?:https?://(?:[^@/]+@)?github\.com/|git@github\.com:|"
    r"ssh://git@github\.com(?::[0-9]+)?/|git://github\.com/)"
    r"([A-Za-z0-9_.-]+)/([A-Za-z0-9_.-]+?)(?:\.git)?/?$",
    re.IGNORECASE)
SCP_LIKE = re.compile(r"^(?:[^/@:]+@)?[A-Za-z0-9_.-]+:")
ZERO_ID = re.compile(r"^0+$")

_ALNUM = b"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
# Bytes that may not precede a numeric-family match.
BOUNDARY = {
    "decimal-code-list": frozenset(_ALNUM + b"."),
    "hex-code-list": frozenset(_ALNUM),
    "hex-bytes": frozenset(b"0123456789ABCDEFabcdef"),
}

GIT_LOCATION_VARIABLES = (
    "GIT_DIR", "GIT_WORK_TREE", "GIT_INDEX_FILE", "GIT_OBJECT_DIRECTORY",
    "GIT_ALTERNATE_OBJECT_DIRECTORIES", "GIT_COMMON_DIR", "GIT_PREFIX",
)

ADVISORY = (
    ("private key header", re.compile(rb"-----BEGIN [A-Z0-9 ]*PRIVATE KEY-----")),
    ("token format", re.compile(
        rb"\b(?:gh[pousr]_[A-Za-z0-9]{36,}|github_pat_[A-Za-z0-9_]{22,}|"
        rb"AKIA[0-9A-Z]{16}|xox[abprs]-[A-Za-z0-9-]{10,}|"
        rb"AIza[0-9A-Za-z_-]{35}|glpat-[A-Za-z0-9_-]{20,})")),
    ("home path", re.compile(rb"/(?:home|Users)/[A-Za-z0-9_.-]+")),
    ("RFC 1918 address", re.compile(
        rb"\b(?:10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|192\.168\.[0-9]{1,3}"
        rb"\.[0-9]{1,3}|172\.(?:1[6-9]|2[0-9]|3[01])\.[0-9]{1,3}\.[0-9]{1,3})\b")),
    ("session identifier", re.compile(
        rb"Copilot-Session:[ \t]*\S+|session-state/[A-Za-z0-9_.-]+")),
    ("Codasip name", re.compile(rb"(?i:codasip)")),
)


class GateError(Exception):
    """A configuration, usage, Git, or visibility failure: fail closed."""


def say(message):
    print(f"publication-gate: {message}", flush=True)


# ------------------------------------------------------------- denylist

def config_dir():
    base = os.environ.get("XDG_CONFIG_HOME") or os.path.join(
        os.path.expanduser("~"), ".config")
    return os.path.join(base, "beryllium", "publication-gate")


def default_denylist():
    return os.path.join(config_dir(), "denylist")


def load_denylist(path=None):
    strict = path is None
    path = path or default_denylist()
    try:
        info = os.lstat(path)
    except FileNotFoundError:
        raise GateError(
            f"no denylist at {path}; install the gate with "
            "project-manager/scripts/publication-gate-setup.sh install "
            "(a public push fails closed without it)") from None
    if not stat.S_ISREG(info.st_mode):
        raise GateError(f"denylist is not a regular file: {path}")
    if info.st_uid != os.getuid():
        raise GateError(f"denylist is not owned by this user: {path}")
    if strict and info.st_mode & 0o077:
        raise GateError(f"installed denylist must have mode 0600: {path}")
    with open(path, "rb") as handle:
        raw = handle.read()
    entries = []
    for number, line in enumerate(raw.splitlines(), 1):
        text = line.strip()
        if not text or text.startswith(b"#"):
            continue
        try:
            entry = text.decode("ascii")
        except UnicodeDecodeError:
            raise GateError(f"denylist line {number} is not ASCII") from None
        if not entry.isprintable():
            raise GateError(f"denylist line {number} is not printable")
        if sum(char.isalnum() for char in entry) < 4:
            raise GateError(
                f"denylist line {number} has fewer than four letters or digits")
        entries.append(entry)
    if not entries:
        raise GateError(f"denylist holds no entry: {path}")
    return entries


# ------------------------------------------------------------- matching

def _alternatives(items):
    unique = sorted(set(items), key=lambda item: (-len(item), item))
    return b"(?:" + b"|".join(unique) + b")"


def _code_values(char):
    values = {ord(char)}
    if char.isalpha():
        values |= {ord(char.lower()), ord(char.upper())}
    return sorted(values)


def _tolerant(chars):
    return b"[^a-z0-9]{0,2}".join(re.escape(char.encode()) for char in chars)


def _base64_fragments(text):
    fragments = set()
    data = text.encode()
    for align in (0, 1, 2):
        first = 0 if align == 0 else 1
        last = (align + len(data)) // 3
        if last - first < 2:
            continue
        for encode in (base64.b64encode, base64.urlsafe_b64encode):
            encoded = encode(b"\0" * align + data)
            fragments.add(encoded[4 * first:4 * last])
    return fragments


class Matchers:
    """Every denylist entry as plain, separator-tolerant, reversed, ROT13,
    escaped, character-code, hex-byte, and base64 variants. Each variant is
    its own compiled regex: a combined alternation stops the regex engine
    from skipping to candidate first bytes and is many times slower."""

    def __init__(self, entries):
        self.lower, self.raw, self.literals = [], [], []
        for number, entry in enumerate(entries, 1):
            chars = [char for char in entry.lower() if char.isalnum()]

            def add(table, variant, pattern, number=number):
                table.append((number, variant, re.compile(pattern)))

            add(self.lower, "plain", _tolerant(chars))
            add(self.lower, "reversed", _tolerant(chars[::-1]))
            rotated = [codecs.encode(char, "rot13") for char in chars]
            if rotated != chars:
                add(self.lower, "rot13", _tolerant(rotated))

            tokens = {name: [] for name in (
                "octal", "hexesc", "unicode", "percent", "htmlhex",
                "htmldec", "ox", "dec", "hexbyte")}
            # Explicit case alternatives instead of scoped (?i:...) flags,
            # which would also stop the first-byte skip.
            for char in chars:
                values = _code_values(char)
                hex2 = _alternatives([form % value for value in values
                                      for form in (b"%02x", b"%02X")])
                dec = _alternatives([b"%d" % value for value in values])
                tokens["octal"].append(
                    rb"\\0?" + _alternatives([b"%03o" % v for v in values]))
                tokens["hexesc"].append(rb"\\[xX]" + hex2)
                tokens["unicode"].append(
                    rb"\\(?:[uU]00|u\{0{0,4}|U000000)" + hex2 + rb"\}?")
                tokens["percent"].append(rb"%" + hex2)
                tokens["htmlhex"].append(rb"&#[xX]0*" + hex2 + rb";?")
                tokens["htmldec"].append(rb"&#0*" + dec + rb";?")
                tokens["ox"].append(rb"0[xX]0{0,2}" + hex2)
                tokens["dec"].append(dec)
                tokens["hexbyte"].append(hex2)
            escape_gap = rb"[^0-9A-Za-z]{0,4}"
            list_gap = rb"[^0-9A-Za-z]{1,16}"
            for variant, key in (("octal-escape", "octal"),
                                 ("hex-escape", "hexesc"),
                                 ("unicode-escape", "unicode"),
                                 ("percent-encoding", "percent"),
                                 ("html-hex-entity", "htmlhex"),
                                 ("html-decimal-entity", "htmldec")):
                add(self.raw, variant, escape_gap.join(tokens[key]))
            # The numeric families start with their first token so that the
            # regex engine can skip to candidate bytes; the left boundary is
            # checked after the match (BOUNDARY).
            add(self.raw, "hex-code-list",
                list_gap.join(tokens["ox"]) + rb"(?![0-9A-Fa-f])")
            add(self.raw, "decimal-code-list",
                list_gap.join(tokens["dec"]) + rb"(?![0-9])")
            add(self.raw, "hex-bytes",
                rb"[ :,\-]?".join(tokens["hexbyte"]) + rb"(?![0-9A-Fa-f])")

            cases = {entry, entry.lower(), entry.upper(), entry.title(),
                     entry.capitalize()}
            for fragment in sorted(set().union(
                    *(_base64_fragments(case) for case in cases))):
                self.literals.append((number, "base64", fragment))

    def scan(self, data):
        """Return (entry number, variant, offset) tuples, at most a few."""
        hits = []
        for table, subject in ((self.lower, data.lower()), (self.raw, data)):
            for number, variant, regex in table:
                for match in regex.finditer(subject):
                    start = match.start()
                    if (variant in BOUNDARY and start > 0 and
                            subject[start - 1] in BOUNDARY[variant]):
                        continue
                    hits.append((number, variant, start))
                    if len(hits) >= FINDINGS_PER_OBJECT:
                        return hits
        for number, variant, fragment in self.literals:
            offset = data.find(fragment)
            if offset >= 0:
                hits.append((number, variant, offset))
                if len(hits) >= FINDINGS_PER_OBJECT:
                    return hits
        return hits


def line_of(data, offset):
    return data.count(b"\n", 0, offset) + 1


class Report:
    def __init__(self, matchers, advisory):
        self.matchers = matchers
        self.advisory = advisory
        self.findings = 0
        self.scanned = 0
        self.advice = {label: [] for label, _ in ADVISORY}

    def safe(self, text):
        """Text for output, withheld when it carries a denylisted term."""
        if self.matchers.scan(text.encode("utf-8", "surrogateescape")):
            return "(name withheld: it contains a denylisted term)"
        return text

    def scan(self, data, kind, name="", show_line=True):
        self.scanned += 1
        where = f"{kind} {self.safe(name)}" if name else kind
        for number, variant, offset in self.matchers.scan(data):
            self.findings += 1
            position = f" line {line_of(data, offset)}" if show_line else ""
            say(f"FINDING denylist entry #{number} ({variant}) in "
                f"{where}{position}")
        if self.advisory:
            for label, regex in ADVISORY:
                for match in regex.finditer(data):
                    self.advice[label].append(
                        f"{where} line {line_of(data, match.start())}")

    def finish(self, target, published=False):
        target = self.safe(target)
        if self.advisory:
            for label, places in self.advice.items():
                if places:
                    shown = "; ".join(places[:5])
                    more = f" (+{len(places) - 5} more)" if len(places) > 5 else ""
                    say(f"advisory: {label}: {len(places)} at {shown}{more}")
            say("advisory findings are for human review and do not block")
        if self.findings:
            remedy = ("These objects are already public; remediation is the "
                      "responsible human's decision." if published else
                      "Remove every finding; unpushed commits that carry one "
                      "must be rewritten.")
            say(f"BLOCKED: {self.findings} finding(s) in {target}. {remedy} "
                "Never encode, split, or otherwise disguise a denylisted "
                f"term to pass the gate ({RECORD}).")
            return FOUND
        say(f"PASS: {target}: {self.scanned} item(s) scanned; no denylisted "
            "term. Passing the gate is not publication approval.")
        return PASS


# ------------------------------------------------------------------ Git

def git_environment(sanitize):
    environment = dict(os.environ)
    if sanitize:
        for name in GIT_LOCATION_VARIABLES:
            environment.pop(name, None)
    environment["GIT_OPTIONAL_LOCKS"] = "0"
    environment["GIT_TERMINAL_PROMPT"] = "0"
    return environment


def git(repo, args, environment, data=None):
    result = subprocess.run(["git", "-C", repo, *args], input=data,
                            capture_output=True, env=environment)
    if result.returncode != 0:
        detail = result.stderr.decode("utf-8", "replace").strip()
        raise GateError(f"git {args[0]} failed in {repo}: {detail}")
    return result.stdout


def existing_objects(repo, ids, environment):
    ids = sorted(set(ids))
    if not ids:
        return []
    output = git(repo, ["cat-file", "--batch-check"], environment,
                 "".join(f"{value}\n" for value in ids).encode())
    present = []
    for value, line in zip(ids, output.decode().splitlines()):
        if not line.endswith(" missing"):
            present.append(value)
    return present


def objects_in_range(repo, tips, excludes, environment):
    """Object id -> path for everything reachable from tips but not from
    excludes, including annotated tag objects named as tips."""
    if not tips:
        return {}
    stdin = "".join(f"{tip}\n" for tip in tips)
    stdin += "".join(f"^{value}\n" for value in excludes)
    output = git(repo, ["rev-list", "--objects", "--stdin"], environment,
                 stdin.encode())
    objects = {}
    for line in output.splitlines():
        value, _, path = line.partition(b" ")
        objects.setdefault(value.decode(),
                           path.decode("utf-8", "surrogateescape"))
    excluded = set(excludes)
    for tip in tips:
        current = tip
        while current not in objects and current not in excluded:
            kind = git(repo, ["cat-file", "-t", current],
                       environment).decode().strip()
            if kind != "tag":
                break
            objects[current] = ""
            current = git(repo, ["rev-parse", "--verify", f"{current}^{{}}"],
                          environment).decode().strip()
    return objects


def read_objects(repo, ids, environment):
    process = subprocess.Popen(["git", "-C", repo, "cat-file", "--batch"],
                               stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                               env=environment)

    def feed():
        try:
            for value in ids:
                process.stdin.write(f"{value}\n".encode())
        finally:
            process.stdin.close()

    feeder = threading.Thread(target=feed, daemon=True)
    feeder.start()
    try:
        for value in ids:
            header = process.stdout.readline().split()
            if len(header) != 3:
                raise GateError(f"cannot read object {value} in {repo}")
            size = int(header[2])
            data = process.stdout.read(size)
            process.stdout.read(1)
            yield value, header[1].decode(), data
    finally:
        feeder.join()
        process.stdout.close()
        process.wait()


def scan_objects(report, repo, objects, environment):
    for value, kind, data in read_objects(repo, list(objects), environment):
        path = objects[value]
        if kind == "commit":
            report.scan(data, f"commit {value[:12]} (message, author, or "
                        "committer)")
        elif kind == "tag":
            report.scan(data, f"tag object {value[:12]}")
        elif kind == "tree":
            report.scan(data, f"tree {value[:12]} (a file or directory name)"
                        " under", path or "the root", show_line=False)
        else:
            report.scan(data, f"blob {value[:12]} path", path or "(unnamed)")


# ----------------------------------------------------------- visibility

class Remote:
    def __init__(self, kind, label, refs=None, detail=""):
        self.kind, self.label, self.detail = kind, label, detail
        # live is False when the remote's refs could not be read anonymously.
        self.live = refs is not None
        self.refs = list(refs or [])
        self.tips = [value for _, value in self.refs]


def treated_as_public(url):
    return any(prefix and url.startswith(prefix) for prefix in
               os.environ.get(TREAT_AS_PUBLIC_ENV, "").split(":"))


def probe(url):
    """Anonymous ls-remote with every credential source disabled."""
    with tempfile.TemporaryDirectory(prefix="publication-gate-probe.") as home:
        environment = {key: value for key, value in os.environ.items()
                       if not key.startswith("GIT_")}
        environment.pop("XDG_CONFIG_HOME", None)
        environment.update(
            HOME=home, GIT_TERMINAL_PROMPT="0", GIT_ASKPASS="",
            SSH_ASKPASS="", GIT_CONFIG_GLOBAL=os.devnull,
            GIT_CONFIG_NOSYSTEM="1",
            GIT_SSH_COMMAND="ssh -o BatchMode=yes")
        try:
            result = subprocess.run(
                ["git", "-c", "credential.helper=", "-c", "core.askPass=",
                 "ls-remote", url],
                cwd=home, capture_output=True, env=environment,
                timeout=PROBE_TIMEOUT)
        except subprocess.TimeoutExpired:
            return None, "anonymous ls-remote timed out"
    if result.returncode == 0:
        refs = []
        for line in result.stdout.decode("utf-8", "surrogateescape").splitlines():
            value, _, name = line.partition("\t")
            if re.fullmatch(r"[0-9a-f]{40}|[0-9a-f]{64}", value):
                refs.append((name, value))
        return refs, ""
    return None, result.stderr.decode("utf-8", "replace").strip()


def is_auth_failure(detail):
    lowered = detail.lower()
    return any(marker in lowered for marker in AUTH_FAILURE_MARKERS)


def is_local(url):
    if url.startswith("file://"):
        return True
    if "://" in url:
        return False
    return not SCP_LIKE.match(url) or os.path.exists(url)


def classify(url):
    if treated_as_public(url):
        refs, detail = probe(url)
        if refs is None:
            return Remote("public", url, detail="treated as public, but its "
                          f"refs cannot be read anonymously now: {detail}")
        return Remote("public", url, refs)
    match = GITHUB_URL.match(url)
    if match:
        slug = f"{match[1]}/{match[2]}".lower()
        refs, detail = probe(f"https://github.com/{slug}.git")
        if refs is not None:
            return Remote("public", slug, refs)
        if slug in KNOWN_PUBLIC:
            return Remote("public", slug, detail="recorded public, but not "
                          f"readable anonymously now: {detail}")
        if is_auth_failure(detail):
            return Remote("private", slug)
        return Remote("unknown", slug, detail=detail)
    if is_local(url):
        return Remote("local", url)
    if re.match(r"^(?:https?|git)://", url, re.IGNORECASE):
        safe = re.sub(r"^([a-z]+://)[^@/]+@", r"\1", url, flags=re.IGNORECASE)
        refs, detail = probe(safe)
        if refs is not None:
            return Remote("public", safe, refs)
        if is_auth_failure(detail):
            return Remote("private", safe)
        return Remote("unknown", safe, detail=detail)
    return Remote("unknown", url, detail="the visibility of an SSH remote "
                  "outside GitHub cannot be determined")


# ---------------------------------------------------------------- modes

def gate_push(repo, url, label, updates, remote_ids, denylist, advisory,
              environment):
    remote = classify(url)
    if remote.kind == "local":
        say(f"{label}: local path; not a public push")
        return PASS
    if remote.kind == "private":
        say(f"{label} ({remote.label}): not readable anonymously, so "
            "private; private pushes are outside the gate")
        return PASS
    if remote.kind == "unknown":
        say(f"{label} ({remote.label}): cannot determine whether it is "
            f"public ({remote.detail}); refusing, fail closed ({RECORD})")
        return ERROR
    if remote.live:
        say(f"{label} ({remote.label}) is public: scanning the push")
    else:
        scope = ("excluding only what the remote already holds for the "
                 "pushed refs" if remote_ids else
                 "over the whole history of the pushed refs")
        say(f"{label} ({remote.label}) is {remote.detail}; scanning the push "
            f"as public, {scope}")
    report = Report(Matchers(load_denylist(denylist)), advisory)
    names = sorted({name for name, _ in updates})
    for name in names:
        report.scan(name.encode(), "ref name", name, show_line=False)
    tips = sorted({value for _, value in updates if not ZERO_ID.match(value)})
    excludes = existing_objects(repo, list(remote.tips) + list(remote_ids),
                                environment)
    objects = objects_in_range(repo, tips, excludes, environment)
    scan_objects(report, repo, objects, environment)
    return report.finish(f"push to {remote.label}")


def repository(path, environment):
    top = git(path, ["rev-parse", "--absolute-git-dir"], environment)
    return path, top.decode().strip()


def cmd_pre_push(args):
    environment = git_environment(sanitize=False)
    updates, remote_ids = [], []
    for line in sys.stdin.read().splitlines():
        if not line.strip():
            continue
        fields = line.split()
        if len(fields) != 4:
            raise GateError("malformed pre-push input line")
        local_ref, local_id, remote_ref, remote_id = fields
        if not ZERO_ID.match(local_id):
            updates.append((local_ref, local_id))
            updates.append((remote_ref, local_id))
        if not ZERO_ID.match(remote_id):
            remote_ids.append(remote_id)
    if not updates:
        say(f"{args.remote}: nothing but deletions to push")
        return PASS
    return gate_push(".", args.url, args.remote, updates, remote_ids, None,
                     False, environment)


def cmd_check(args):
    environment = git_environment(sanitize=True)
    repo, _ = repository(args.repo, environment)
    remote = args.remote
    if not remote:
        try:
            upstream = git(repo, ["rev-parse", "--abbrev-ref",
                                  "--symbolic-full-name", "@{upstream}"],
                           environment).decode().strip()
            remote = upstream.split("/", 1)[0]
        except GateError:
            remote = "origin"
    url = git(repo, ["remote", "get-url", "--push", remote],
              environment).decode().strip()
    refs = args.refs or [git(repo, ["symbolic-ref", "HEAD"],
                             environment).decode().strip()]
    updates = []
    for ref in refs:
        value = git(repo, ["rev-parse", "--verify", ref],
                    environment).decode().strip()
        full = ref
        if not ref.startswith("refs/"):
            resolved = git(repo, ["rev-parse", "--symbolic-full-name", ref],
                           environment).decode().strip()
            full = resolved or ref
        updates.append((full, value))
    return gate_push(repo, url, remote, updates, [], args.denylist,
                     args.advisory, environment)


def cmd_audit(args):
    environment = git_environment(sanitize=True)
    repo, _ = repository(args.repo, environment)
    if args.remote:
        if args.refs or args.all_refs:
            raise GateError("audit --remote takes no ref and no --all-refs")
        return audit_remote(repo, args.remote, args.denylist, args.advisory,
                            environment)
    updates = []
    if args.refs:
        for ref in args.refs:
            value = git(repo, ["rev-parse", "--verify", ref],
                        environment).decode().strip()
            updates.append((ref, value))
    else:
        patterns = [] if args.all_refs else ["refs/heads", "refs/tags"]
        output = git(repo, ["for-each-ref",
                            "--format=%(objectname) %(refname)", *patterns],
                     environment).decode()
        updates = [tuple(reversed(line.split(" ", 1)))
                   for line in output.splitlines() if line]
    if not updates:
        raise GateError(f"no ref to audit in {repo}")
    report = Report(Matchers(load_denylist(args.denylist)), args.advisory)
    for name, _ in updates:
        report.scan(name.encode(), "ref name", name, show_line=False)
    tips = sorted({value for _, value in updates})
    scan_objects(report, repo, objects_in_range(repo, tips, [], environment),
                 environment)
    return report.finish(f"audit of {len(updates)} ref(s) in {repo}")


def audit_remote(repo, name, denylist, advisory, environment):
    """Audit what a public remote serves now: every live ref name it lists
    anonymously and everything reachable from its live tips, read from local
    objects. A live tip absent locally cannot be verified: fail closed."""
    url = git(repo, ["remote", "get-url", name], environment).decode().strip()
    remote = classify(url)
    if remote.kind == "unknown":
        say(f"{name} ({remote.label}): cannot determine whether it is "
            f"public ({remote.detail}); refusing, fail closed ({RECORD})")
        return ERROR
    if remote.kind != "public":
        say(f"{name} ({remote.label}): {remote.kind}, so nothing is served "
            "anonymously; audit every ref with --all-refs before it becomes "
            "public")
        return PASS
    if not remote.live:
        say(f"{name} ({remote.label}) is {remote.detail}; its live public view "
            "cannot be read, so fetch every ref and run audit --all-refs "
            f"instead; refusing, fail closed ({RECORD})")
        return ERROR
    say(f"{name} ({remote.label}) is public: auditing its {len(remote.refs)} "
        "live ref(s)")
    report = Report(Matchers(load_denylist(denylist)), advisory)
    for ref_name, _ in remote.refs:
        report.scan(ref_name.encode("utf-8", "surrogateescape"),
                    "live ref name", ref_name, show_line=False)
    tips = sorted(set(remote.tips))
    present = set(existing_objects(repo, tips, environment))
    missing = sorted({report.safe(ref_name) for ref_name, value in remote.refs
                      if value not in present})
    if missing:
        say(f"{len(missing)} live ref(s) of {remote.label} point at objects "
            f"not present locally ({', '.join(missing)}); fetch them, then "
            f"audit again; refusing, fail closed ({RECORD})")
        return FOUND if report.findings else ERROR
    scan_objects(report, repo, objects_in_range(repo, tips, [], environment),
                 environment)
    return report.finish(f"live public view of {remote.label}",
                         published=True)


def scan_file(report, path, label):
    if os.path.islink(path):
        report.scan(os.readlink(path).encode("utf-8", "surrogateescape"),
                    "symlink target of", label, show_line=False)
        return
    with open(path, "rb") as handle:
        report.scan(handle.read(), "file", label)


def cmd_scan_tree(args):
    report = Report(Matchers(load_denylist(args.denylist)), args.advisory)
    for path in args.paths:
        if path == "-":
            report.scan(sys.stdin.buffer.read(), "standard input")
            continue
        if not os.path.lexists(path):
            raise GateError("no such path to scan")
        if os.path.isdir(path) and not os.path.islink(path):
            for root, directories, files in os.walk(path):
                directories[:] = sorted(d for d in directories if d != ".git")
                for name in sorted(directories + files):
                    relative = os.path.relpath(os.path.join(root, name), path)
                    report.scan(relative.encode("utf-8", "surrogateescape"),
                                "file name", relative, show_line=False)
                for name in sorted(files):
                    full = os.path.join(root, name)
                    scan_file(report, full, os.path.relpath(full, path))
        else:
            report.scan(path.encode("utf-8", "surrogateescape"),
                        "file name", path, show_line=False)
            scan_file(report, path, path)
    return report.finish(", ".join(args.paths))


def cmd_scan_worktree(args):
    environment = git_environment(sanitize=True)
    repo, _ = repository(args.repo, environment)
    top = git(repo, ["rev-parse", "--show-toplevel"],
              environment).decode().strip()
    listing = git(top, ["ls-files", "-z", "--cached", "--others",
                        "--exclude-standard"], environment)
    report = Report(Matchers(load_denylist(args.denylist)), args.advisory)
    for raw in sorted(set(listing.split(b"\0"))):
        if not raw:
            continue
        relative = raw.decode("utf-8", "surrogateescape")
        report.scan(raw, "file name", relative, show_line=False)
        full = os.path.join(top, relative)
        if os.path.lexists(full) and not os.path.isdir(full):
            scan_file(report, full, relative)
    return report.finish(f"working tree {top}")


def cmd_validate_denylist(args):
    entries = load_denylist(args.denylist)
    Matchers(entries)
    say(f"denylist is valid: {len(entries)} entr"
        f"{'y' if len(entries) == 1 else 'ies'}")
    return PASS


def cmd_classify(args):
    remote = classify(args.url)
    detail = f" ({remote.detail})" if remote.detail else ""
    print(f"{remote.kind} {remote.label}{detail}")
    return ERROR if remote.kind == "unknown" else PASS


# ------------------------------------------------------------ self-test

def cmd_self_test(_args):
    """Detection, silence, and visibility checks with synthetic entries."""
    failures = []

    def expect(condition, message):
        if not condition:
            failures.append(message)

    synthetic = ["Blorptangle", "zork of quux-9.9"]
    word = "blorptangle"
    matchers = Matchers(synthetic)

    def detected(data, variant):
        return any(number == 1 and kind == variant
                   for number, kind, _ in matchers.scan(data))

    octal = "".join("\\%03o" % ord(c) for c in word).encode()
    samples = {
        "plain": b"see BlorpTangle here",
        "separated": b"blorp-tangle",
        "utf16": "x blorptangle y".encode("utf-16-le"),
        "reversed": word[::-1].encode(),
        "rot13": codecs.encode(word, "rot13").encode(),
        "octal-escape": b"printf '" + octal + b"'",
        "doubled-octal": b'"' + octal.replace(b"\\", b"\\\\") + b'"',
        "hex-escape": "".join("\\x%02X" % ord(c) for c in word).encode(),
        "unicode-escape": "".join("\\u%04x" % ord(c) for c in word).encode(),
        "doubled-unicode": "".join("\\\\u%04x" % ord(c) for c in word).encode(),
        "percent-encoding": "".join("%%%02x" % ord(c) for c in word).encode(),
        "html-decimal-entity": "".join("&#%d;" % ord(c) for c in word).encode(),
        "html-hex-entity": "".join("&#x%x;" % ord(c) for c in word).encode(),
        "hex-code-list": ", ".join("0x%02x" % ord(c) for c in word).encode(),
        "decimal-code-list": ("String.fromCharCode(\n    " + ",\n    ".join(
            str(ord(c)) for c in word.upper()) + ",\n)").encode(),
        "hex-bytes": word.encode().hex().encode(),
    }
    variant_of = {"separated": "plain", "utf16": "plain",
                  "doubled-octal": "octal-escape",
                  "doubled-unicode": "unicode-escape"}
    for name, data in samples.items():
        expect(detected(data, variant_of.get(name, name)),
               f"variant not detected: {name}")
    for align in range(3):
        blob = base64.b64encode(b"ab"[:align] + b"x Blorptangle x")
        expect(any(kind == "base64" for _, kind, _ in matchers.scan(blob)),
               f"base64 alignment {align} not detected")
    expect(any(number == 2 for number, _, _ in matchers.scan(
        b"a Zork  of quux-9.9 b")), "phrase entry not detected")
    for clean in (b"blorp tango", b"plain text 98 108 111", b"daylight",
                  b"zork of quux",
                  b"998, 108, 111, 114, 112, 116, 97, 110, 103, 108, 101"):
        expect(not matchers.scan(clean), "false positive on clean sample")

    with tempfile.TemporaryDirectory(prefix="publication-gate-self.") as work:
        environment = git_environment(sanitize=True)
        environment.update(HOME=work, GIT_CONFIG_GLOBAL=os.devnull,
                           GIT_CONFIG_NOSYSTEM="1",
                           GIT_AUTHOR_NAME="Fixture", GIT_COMMITTER_NAME="Fixture",
                           GIT_AUTHOR_EMAIL="fixture@example.invalid",
                           GIT_COMMITTER_EMAIL="fixture@example.invalid")
        repo = os.path.join(work, "repo")
        os.mkdir(repo)

        def run(*args, **kwargs):
            subprocess.run(["git", "-C", repo, *args], check=True,
                           capture_output=True, env=kwargs.pop("env", environment),
                           **kwargs)

        run("init", "-q", "-b", "main")
        with open(os.path.join(repo, "clean.txt"), "w") as handle:
            handle.write("nothing to see\n")
        run("add", "clean.txt")
        run("commit", "-q", "-m", "clean start")
        base = git(repo, ["rev-parse", "HEAD"], environment).decode().strip()
        named = os.path.join(repo, f"notes-{word}.md")
        with open(named, "w") as handle:
            handle.write("ordinary words\n")
        run("add", ".")
        run("commit", "-q", "-m", "add a file whose name carries the entry")
        run("commit", "-q", "--allow-empty", "-m", f"message names {word}")
        author = dict(environment, GIT_AUTHOR_NAME=f"{word} bot")
        run("commit", "-q", "--allow-empty", "-m", "identity", env=author)
        run("tag", "-a", "v1", "-m", f"tag text {word}")
        tip = git(repo, ["rev-parse", "v1"], environment).decode().strip()
        objects = objects_in_range(repo, [tip], [base], environment)
        kinds = {}
        for value, kind, data in read_objects(repo, list(objects), environment):
            if matchers.scan(data):
                kinds[kind] = kinds.get(kind, 0) + 1
        expect(kinds.get("tree"), "file name not detected in a tree object")
        expect(kinds.get("commit", 0) >= 2, "message and identity not detected")
        expect(kinds.get("tag"), "annotated tag text not detected")
        clean_objects = objects_in_range(repo, [base], [], environment)
        expect(not any(matchers.scan(data) for _, _, data in read_objects(
            repo, list(clean_objects), environment)),
            "clean history reported a finding")

        bare = os.path.join(work, "public.git")
        subprocess.run(["git", "init", "-q", "--bare", bare], check=True,
                       capture_output=True, env=environment)
        expect(classify(bare).kind == "local", "local path not classified local")
        saved = os.environ.get(TREAT_AS_PUBLIC_ENV)
        os.environ[TREAT_AS_PUBLIC_ENV] = bare
        try:
            expect(classify(bare).kind == "public",
                   "treat-as-public path not classified public")
        finally:
            if saved is None:
                os.environ.pop(TREAT_AS_PUBLIC_ENV, None)
            else:
                os.environ[TREAT_AS_PUBLIC_ENV] = saved
        expect(classify("git@gitlab.example.invalid:x/y.git").kind == "unknown",
               "non-GitHub SSH remote not refused")

        import io
        import contextlib
        captured = io.StringIO()
        report = Report(matchers, advisory=True)
        with contextlib.redirect_stdout(captured):
            report.scan(samples["plain"] + samples["octal-escape"], "file",
                        f"docs/{word}-notes.md")
            report.scan(b"ordinary", "ref name", f"refs/heads/{word}",
                        show_line=False)
            report.finish(f"self-test of {word}")
        text = captured.getvalue().lower()
        expect(report.findings >= 2, "report did not count findings")
        expect(word not in text and "blorp" not in text and octal.decode()
               not in text, "output printed matched text or a carrying name")

    if failures:
        for failure in failures:
            say(f"self-test FAIL: {failure}")
        return ERROR
    say("self-test passed")
    return PASS


def main(argv=None):
    parser = argparse.ArgumentParser(
        prog="publication-gate.py",
        description="Beryllium publication gate for public pushes "
                    f"({RECORD}).")
    modes = parser.add_subparsers(dest="mode", required=True)
    pre_push = modes.add_parser("pre-push")
    pre_push.add_argument("remote")
    pre_push.add_argument("url")
    for name in ("check", "audit", "scan-tree", "scan-worktree",
                 "validate-denylist"):
        sub = modes.add_parser(name)
        sub.add_argument("--denylist")
        if name != "validate-denylist":
            sub.add_argument("--advisory", action="store_true")
        if name in ("check", "audit", "scan-worktree"):
            sub.add_argument("--repo", default=".")
        if name == "check":
            sub.add_argument("--remote")
            sub.add_argument("refs", nargs="*")
        if name == "audit":
            sub.add_argument("--all-refs", action="store_true")
            sub.add_argument("--remote")
            sub.add_argument("refs", nargs="*")
        if name == "scan-tree":
            sub.add_argument("paths", nargs="+")
    classify_parser = modes.add_parser("classify")
    classify_parser.add_argument("url")
    modes.add_parser("self-test")
    args = parser.parse_args(argv)
    handlers = {
        "pre-push": cmd_pre_push, "check": cmd_check, "audit": cmd_audit,
        "scan-tree": cmd_scan_tree, "scan-worktree": cmd_scan_worktree,
        "validate-denylist": cmd_validate_denylist,
        "classify": cmd_classify, "self-test": cmd_self_test,
    }
    try:
        return handlers[args.mode](args)
    except GateError as error:
        say(f"ERROR: {error}; refusing, fail closed ({RECORD})")
        return ERROR


if __name__ == "__main__":
    sys.exit(main())
