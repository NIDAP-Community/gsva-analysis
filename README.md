# GSVA Analysis

`gsva-analysis` is a portable application component for sample-level pathway
enrichment from normalized continuous expression. It is derived from the
canonical [OMIX GSVA](https://github.com/NIDAP-Community/OMIX/tree/main/modules/OMIX-GSVA)
module at a pinned source commit; see [OMIX_MODULE_SOURCE.md](OMIX_MODULE_SOURCE.md).

## Input contract

The canonical GSVA interface requires three tables:

- normalized continuous gene-by-sample expression, where `--gene_column auto`
  selects `Gene` and then `GeneName`;
- sample metadata, with `Sample` by default; and
- pathway membership with `collection`, `gene_set_name`, `gene_symbol`, and
  `species` columns.

Raw integer counts are not valid GSVA input. Supply a normalized matrix and a
compatible pathway-membership table.

With `--collections_to_include auto` (the default), GSVA selects
`H: hallmark gene sets` for a Human pathway database and
`MH: orthology-mapped hallmark gene sets` for a Mouse pathway database.
Explicit collection names are preserved unchanged.

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
[schemas/interface.yml](schemas/interface.yml). A successful application run
writes a self-describing bundle:

```text
<output_dir>/
├── RUN_METADATA.md
├── run_manifest.json
├── tables/gsva_results.csv
├── figures/gsva_heatmap.png
└── logs/
    ├── gsva_run_summary.txt
    └── sessionInfo.txt
```

## Container status

The application image will build from the pinned OMIX `r-pathway` runtime for
`linux/amd64`. The container helper requests that platform explicitly (with
Apple Silicon emulation when necessary). It uses a read-only `/data` and
writable `/output` mount contract.
