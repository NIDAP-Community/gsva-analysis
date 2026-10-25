# Architecture

`gsva-analysis` is an application-layer component derived from canonical OMIX
GSVA. The byte-identical `R/GSVA.R` export owns scientific behavior. The root
CLI and container only provide stable invocation, provenance, and portable
execution.

OncoChat will materialize a normalized `counts_tpm` matrix, aligned sample
metadata, and a pathway-membership table under `/data`; the container writes
scores, a heatmap, summaries, and provenance to `/output`. It never connects
to PostgreSQL directly.

See the canonical [GSVA preflight record](https://github.com/NIDAP-Community/OMIX/blob/main/docs/derivations/gsva-analysis-preflight.md)
for source, runtime, catalog-mapping, and release gates.
