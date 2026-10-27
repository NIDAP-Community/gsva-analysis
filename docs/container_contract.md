# Container Contract

## Execution model

GSVA Analysis follows the Container-as-a-Function model: it is a
non-interactive command that consumes explicit file paths and parameters and
writes all job artifacts to one requested output directory. It is not a
development shell and never connects directly to PostgreSQL, cloud services,
or study-data stores.

## Immutable runtime

Production callers use this `linux/amd64` OCI digest:

```text
ghcr.io/nidap-community/gsva-analysis@sha256:c22d0fa50ea8af06e07d54fa8f03844191d5f47876e4cf72c058cba073d280f0
```

The image is built from a pinned OMIX `r-pathway` base digest, runs as the
non-root `gsva` user, and carries OCI source/revision/base-image labels. No R
packages are installed and no network access is required at runtime.

## Filesystem boundary

| Mount | Permission | Contents |
| --- | --- | --- |
| `/data` | read-only | The normalized-expression, sample-metadata, and pathway-membership tables approved for one request. |
| `/output` | read-write | The complete GSVA result bundle for that request only. |

The user/container process must not receive database credentials, host paths,
or write access outside `/output`. Callers map their request-scoped directories
to these fixed paths and pass only `/data/...` input paths plus `/output` as
the output path.

## Completion and provenance

A successful run emits `RUN_METADATA.md`, `run_manifest.json`, enrichment
scores, heatmap, canonical summary, and R session information. The caller must
require `"status": "completed"` in the manifest and nonempty expected files
before presenting results. It should retain the image digest, application and
canonical source commits, input checksums, parameters, and result locations.

## Local and HPC use

Use `container/run_docker.sh` for Docker and `container/run_apptainer.sh` for
Apptainer/Singularity conversion and execution. The latter preserves the same
`/data` and `/output` contract; a site-specific target-HPC smoke test remains
the final portability gate before representing HPC execution as validated.
