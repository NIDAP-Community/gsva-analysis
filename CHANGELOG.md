# Changelog

## Unreleased

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

No OCI image, semantic version, Git tag, or public repository has been
published.
