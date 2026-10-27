# Source layout

This application intentionally keeps its scientific source in `../R/` rather
than duplicating it under `src/`. `R/GSVA.R` is a byte-identical export of the
canonical OMIX module and is checked against its pinned source commit in CI.

The stable application entrypoint is `../entrypoint.R`; it wraps the canonical
CLI in `../scripts/run_gsva.R` only to standardize the result bundle and
runtime provenance. This directory documents the repository-shape exception
required to preserve that canonical scientific ownership.
