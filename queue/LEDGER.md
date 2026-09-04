# Project Manager queue ledger

Ledger-only dispositions of rows pulled from component `outbox/pm-queue.md`
files. Read [`README.md`](README.md) for the protocol, column meanings, and the
status mapping used by `scripts/pull-queues.sh edits`. Rows are append-only;
a correction adds a superseding note rather than deleting history.

## Ledger

| Ledger ID | Source component | Source ID | Raised on | Title | Suggested owner | PM status | Source status applied | Decided on | Note |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PML-0001 | analysis-workbook | PMQ-001 | 2026-08-29 | Xen XSA-286 stale TLB advisory | xrv-research-repo | pending | no | Not applicable | Pulled on 2026-09-04 during the Project Manager consolidation; awaiting triage against the suggested owner's own index. |
| PML-0002 | analysis-workbook | PMQ-002 | 2026-08-29 | Xen XSA-321 VT-d cache writeback advisory | xrv-research-repo | pending | no | Not applicable | Pulled on 2026-09-04 during the Project Manager consolidation; awaiting triage against the suggested owner's own index. |
| PML-0003 | analysis-workbook | PMQ-003 | 2026-08-29 | Xen XSA-302 in-flight DMA advisory | xrv-research-repo | pending | no | Not applicable | Pulled on 2026-09-04 during the Project Manager consolidation; awaiting triage against the suggested owner's own index. |
| PML-0004 | analysis-workbook | PMQ-004 | 2026-08-29 | Xen XSA-148 writable mapping advisory | xrv-research-repo | pending | no | Not applicable | Pulled on 2026-09-04 during the Project Manager consolidation; awaiting triage against the suggested owner's own index. |
| PML-0005 | analysis-workbook | PMQ-005 | 2026-08-29 | Xen XSA-304 page-size machine-check advisory | xrv-research-repo | pending | no | Not applicable | Pulled on 2026-09-04 during the Project Manager consolidation; awaiting triage against the suggested owner's own index. |
| PML-0006 | analysis-workbook | PMQ-006 | 2026-08-29 | RFC 9334 RATS Architecture | xrv-research-repo | pending | no | Not applicable | Pulled on 2026-09-04 during the Project Manager consolidation; awaiting triage against the suggested owner's own index. |
| PML-0007 | analysis-workbook | PMQ-007 | 2026-08-29 | Copilot coprocessor kernel integrity monitor | formal-verification-research | pending | no | Not applicable | Pulled on 2026-09-04 during the Project Manager consolidation; awaiting triage against the suggested owner's own index. |
| PML-0008 | analysis-workbook | PMQ-008 | 2026-08-29 | Project Zero Rowhammer PTE privilege escalation | cheri-riscv-notes-repo | pending | no | Not applicable | Pulled on 2026-09-04 during the Project Manager consolidation; awaiting triage against the suggested owner's own index. |
| PML-0009 | analysis-workbook | PMQ-009 | 2026-08-29 | Thunderclap IOMMU and malicious peripheral research | xrv-research-repo | pending | no | Not applicable | Pulled on 2026-09-04 during the Project Manager consolidation; awaiting triage against the suggested owner's own index. |
| PML-0010 | analysis-workbook | PMQ-010 | 2026-08-29 | NIST SP 800-193 Platform Firmware Resiliency Guidelines | formal-verification-research | pending | no | Not applicable | Pulled on 2026-09-04 during the Project Manager consolidation; awaiting triage against the suggested owner's own index. |
| PML-0011 | analysis-workbook | PMQ-011 | 2026-08-29 | Starbleed FPGA configuration-interface counter-source | cheri-riscv-notes-repo | pending | no | Not applicable | Pulled on 2026-09-04 during the Project Manager consolidation; awaiting triage against the suggested owner's own index. |
| PML-0012 | analysis-workbook | PMQ-012 | 2026-08-29 | OSLO trusted-computing measurement-chain research | formal-verification-research | pending | no | Not applicable | Pulled on 2026-09-04 during the Project Manager consolidation; awaiting triage against the suggested owner's own index. |
| PML-0013 | analysis-workbook | PMQ-013 | 2026-08-29 | CVE-2022-1158 KVM wrong-PFN technical disclosure | xrv-research-repo | pending | no | Not applicable | Pulled on 2026-09-04 during the Project Manager consolidation; awaiting triage against the suggested owner's own index. |
| PML-0014 | analysis-workbook | PMQ-014 | 2026-08-29 | IEC 61508-2:2010 functional-safety standard | formal-verification-research | pending | no | Not applicable | Pulled on 2026-09-04 during the Project Manager consolidation; awaiting triage against the suggested owner's own index. |
| PML-0015 | analysis-workbook | PMQ-015 | 2026-08-29 | SWATT software-based attestation paper | formal-verification-research | pending | no | Not applicable | Pulled on 2026-09-04 during the Project Manager consolidation; awaiting triage against the suggested owner's own index. |
| PML-0016 | analysis-workbook | PMQ-016 | 2026-08-29 | Svvptc Extension, Version 1.0 | xrv-research-repo | pending | no | Not applicable | Pulled on 2026-09-04 during the Project Manager consolidation; awaiting triage against the suggested owner's own index. |
