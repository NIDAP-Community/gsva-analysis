# README Synthetic Example Provenance

The README heatmap at `docs/images/gsva_synthetic_heatmap.png` is generated
solely from the committed `test_data/` fixture. The data contain four artificial
samples, two artificial pathway labels, and no patient, donor, cohort, or
clinical information. It is a layout and execution demonstration only.

## Generation record

- Application source: `d5723ac526cbb5b855701ef798a59dd44e056ade`
- Image used: local `gsva-analysis:d5723ac`, whose published digest is
  `sha256:c22d0fa50ea8af06e07d54fa8f03844191d5f47876e4cf72c058cba073d280f0`
- Output image SHA-256:
  `bd04696705dc7e97f41e593b0437aa757535969aa1e6ca93b81af96acec6894f`
- Commands:

```bash
container/run_docker.sh gsva-analysis:d5723ac test_data <output-dir> \
  --normalized_data /data/normalized_expression.tsv \
  --sample_metadata /data/sample_metadata.tsv \
  --pathways_database /data/pathway_membership.tsv \
  --output_dir /output
```

The generated `<output-dir>/figures/gsva_heatmap.png` was copied without visual
alteration to `docs/images/gsva_synthetic_heatmap.png` after visual inspection.
