# Session Notes

This append-only record retains release and validation evidence without
changing the scientific source history.

## 2026-10-26 — v1.0.0 standalone release and checklist normalization

- Synced canonical OMIX GSVA 1.0.0 at commit
  `79e27490a0521aa866af60ae5fa203e9e1516b42`; exported scientific files and
  interface schema were checked byte-for-byte.
- Validated syntax, canonical regression cases, `linux/amd64` container build,
  container smoke test, canonical parity test, and hosted GitHub Actions.
- Published `ghcr.io/nidap-community/gsva-analysis` at immutable digest
  `sha256:c22d0fa50ea8af06e07d54fa8f03844191d5f47876e4cf72c058cba073d280f0`.
  Git tag and GitHub Release `v1.0.0` identify application source commit
  `d5723ac526cbb5b855701ef798a59dd44e056ade`.
- Added the digest-pinned adapter contract, a synthetic README output with
  provenance, executable CLI contract test, container contract, decision log,
  and release note.

### Outstanding external gates

- Run one target-HPC Apptainer/Singularity smoke test before claiming
  site-validated HPC portability.
- The OncoChat agent must stage approved inputs, invoke the pinned digest,
  collect the complete result bundle, retain provenance, and record an
  acceptance test before production integration is complete.
