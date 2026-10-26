# OncoChat Adapter Contract

## Published application identity

| Field | Value |
| --- | --- |
| Application source commit | `d5723ac526cbb5b855701ef798a59dd44e056ade` |
| Runtime platform | `linux/amd64` |
| OCI reference for execution | `ghcr.io/nidap-community/gsva-analysis@sha256:c22d0fa50ea8af06e07d54fa8f03844191d5f47876e4cf72c058cba073d280f0` |
| Canonical OMIX module | `omix-gsva` version `1.0.0`, interface version `2` |
| Canonical OMIX source | `79e27490a0521aa866af60ae5fa203e9e1516b42` |

The digest is the only permitted production image reference. The
`sha-d5723ac526cb` tag is for human discovery and must not replace the digest
in an OncoChat task definition.

## Staged input contract

OncoChat prepares a fresh, request-scoped input directory and mounts it
read-only at `/data`. It must materialize exactly these three approved tables:

| Required CLI field | Staged example path | Required content |
| --- | --- | --- |
| `--normalized_data` | `/data/normalized_expression.tsv` | Normalized, continuous gene-by-sample expression. Raw integer counts are invalid. The feature-ID column is selected by `--gene_column` (`auto` prefers `Gene`, then `GeneName`). |
| `--sample_metadata` | `/data/sample_metadata.tsv` | One row per selected sample and a sample-ID column (default `Sample`) matching expression matrix sample columns. |
| `--pathways_database` | `/data/pathway_membership.tsv` | Long pathway-membership table containing `collection`, `gene_set_name`, `gene_symbol`, and `species`. |

The adapter validates filenames, tabular schema, requested metadata/sample
columns, and bounded interface parameters before starting the container. It
does not accept arbitrary host paths, shell fragments, user-supplied container
images, credentials, or study data embedded in the request payload.

## Invocation boundary

The task mounts `/data` read-only and a request-scoped output directory at
`/output`, then invokes the pinned image with explicit paths. A representative
command is:

```bash
docker run --rm --platform linux/amd64 \
  --mount type=bind,src=<staged-input-dir>,dst=/data,readonly \
  --mount type=bind,src=<request-output-dir>,dst=/output \
  ghcr.io/nidap-community/gsva-analysis@sha256:c22d0fa50ea8af06e07d54fa8f03844191d5f47876e4cf72c058cba073d280f0 \
  --normalized_data /data/normalized_expression.tsv \
  --sample_metadata /data/sample_metadata.tsv \
  --pathways_database /data/pathway_membership.tsv \
  --output_dir /output
```

All optional arguments must be generated from the allowlisted fields in
[`schemas/interface.yml`](../schemas/interface.yml). Defaults remain canonical:
`gene_column=auto` and `collections_to_include=auto` select compatible
Gene/GeneName and Human/Mouse Hallmark defaults. Explicit supported values
remain valid.

## Outputs and completion checks

On success, OncoChat collects only the request output directory. The expected
bundle includes:

```text
/output/
├── RUN_METADATA.md
├── run_manifest.json
├── tables/gsva_results.csv
├── figures/gsva_heatmap.png
└── logs/
    ├── gsva_run_summary.txt
    └── sessionInfo.txt
```

The adapter treats a run as complete only when `run_manifest.json` reports
`"status": "completed"` and all files above are nonempty. It records the OCI
digest, application source commit, canonical OMIX source commit, input asset
identities, resolved parameters, and output paths with the task provenance.

## Release evidence

The application source passed syntax checks, canonical regression cases
(including `GeneName`, Mouse defaults, explicit overrides, and expected
failures), a `linux/amd64` image build, container smoke test, canonical parity
test, and hosted GitHub Actions validation. The underlying OMIX derivation and
preflight requirements remain documented in the canonical
[GSVA preflight record](https://github.com/NIDAP-Community/OMIX/blob/main/docs/derivations/gsva-analysis-preflight.md).
