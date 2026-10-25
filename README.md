# GSVA Analysis

`gsva-analysis` is a portable application component for sample-level pathway
enrichment from normalized continuous expression. It is derived from the
canonical [OMIX GSVA](https://github.com/NIDAP-Community/OMIX/tree/main/modules/OMIX-GSVA)
module at a pinned source commit; see [OMIX_MODULE_SOURCE.md](OMIX_MODULE_SOURCE.md).

## Status

This repository is an unpublished local derivation. It is not yet an
OncoChat-enabled analysis or a published OCI image.

## Input contract

The canonical GSVA interface requires three tables:

- normalized continuous gene-by-sample expression, with `Gene` by default;
- sample metadata, with `Sample` by default; and
- pathway membership with `collection`, `gene_set_name`, `gene_symbol`, and
  `species` columns.

Raw integer counts are not valid GSVA input. For OncoChat, the stage-in layer
will materialize a normalized matrix from the approved `counts_tpm` database
relation and a membership table from the approved pathway catalog; users do
not provide arbitrary file paths.

## Local CLI

```bash
Rscript entrypoint.R \
  --normalized_data test_data/normalized_expression.tsv \
  --sample_metadata test_data/sample_metadata.tsv \
  --pathways_database test_data/pathway_membership.tsv \
  --gene_column Gene \
  --sample_name_column Sample \
  --collections_to_include 'H: hallmark gene sets' \
  --output_dir results/example
```

The canonical interface and output definitions are in
[schemas/interface.yml](schemas/interface.yml). The primary outputs are
`gsva_results.csv`, `gsva_heatmap.png`, and `gsva_run_summary.txt`.

## Container status

The application image will build from the pinned OMIX `r-pathway` runtime for
`linux/amd64`. It will use the standard read-only `/data` and writable
`/output` mount contract. Image publication is intentionally deferred until
container, source-parity, representative-data, and OncoChat acceptance gates
have passed.
