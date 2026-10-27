# Changelog

## Unreleased

- Normalized repository-standard documentation: an explicit container contract,
  decision log, append-only session notes, source-layout rationale, and
  synthetic README-example provenance.
- Added an executable container-boundary test to CI, covering CLI help and
  rejection of a missing staged input.
- Added a visually inspected, fully synthetic GSVA heatmap to the README and
  user-facing troubleshooting guidance. No study data were added.

## 1.0.0 - 2026-10-26

- Synchronized the standalone scientific export to canonical OMIX GSVA 1.0.0
  at commit `79e27490a0521aa866af60ae5fa203e9e1516b42`. This incorporates the
  canonical species-aware defaults: automatic `Gene`/`GeneName` feature-column
  selection and Human/Mouse Hallmark collection selection. Interface version
  2 is retained because existing explicit calls remain valid.

- Initialized a local standalone application derivation from OMIX GSVA 0.3.0,
  interface v2, at immutable OMIX commit
  `0ea6223129de6d98d69469027c19fa1887b59f6a`.
- Added the repository-owned root CLI, pinned shared-runtime container recipe,
  synthetic fixture, and canonical container smoke-test scaffold.

- Published the validated `linux/amd64` application image as
  `ghcr.io/nidap-community/gsva-analysis:sha-d5723ac526cb` with immutable
  digest `sha256:c22d0fa50ea8af06e07d54fa8f03844191d5f47876e4cf72c058cba073d280f0`.
  The image was built from application commit
  `d5723ac526cbb5b855701ef798a59dd44e056ade`; the source, container smoke,
  canonical-parity, and hosted validation checks passed. The matching `v1.0.0`
  Git tag and GitHub Release record the validated application source commit.
