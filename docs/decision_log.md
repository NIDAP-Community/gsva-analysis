# Decision Log

## 2026-10-26 — Canonical scientific source remains in `R/`

**Decision:** Retain `R/GSVA.R` and `scripts/run_gsva.R` as byte-identical
exports of the pinned canonical OMIX module. The standalone application does
not duplicate or independently modify scientific code under `src/`.

**Rationale:** Canonical ownership avoids scientific drift. `src/README.md`
records this intentional repository-layout exception, and CI compares every
exported scientific/interface file with the pinned OMIX source.

## 2026-10-26 — Production callers pin an OCI digest

**Decision:** Deploy with
`ghcr.io/nidap-community/gsva-analysis@sha256:c22d0fa50ea8af06e07d54fa8f03844191d5f47876e4cf72c058cba073d280f0`,
not a mutable image tag.

**Rationale:** A digest preserves a verifiable correspondence between the
validated runtime, source revision, result provenance, and OncoChat task.

## 2026-10-26 — Database access stays upstream

**Decision:** OncoChat materializes approved, request-scoped tabular inputs;
GSVA receives only those files under `/data` and writes results under
`/output`.

**Rationale:** This keeps database access, cohort selection, permissions, and
credential handling in the platform layer while preserving portable local and
HPC execution.
