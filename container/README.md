# Container Build and Runtime

This image is a Container-as-a-Function wrapper around the pinned OMIX GSVA
implementation. It reads staged input files from `/data` and writes a complete
run to `/output`; it contains no database, cloud, or study-data credentials.

## Published runtime

The validated `linux/amd64` release image is:

```text
ghcr.io/nidap-community/gsva-analysis@sha256:c22d0fa50ea8af06e07d54fa8f03844191d5f47876e4cf72c058cba073d280f0
```

Use the digest for automated execution. The readable `v1.0.0` tag identifies
the same image for users, but is not an immutable deployment reference.

Build and validate locally after the initial source commit exists:

```bash
container/build_docker.sh gsva-analysis:local
container/smoke_test.sh gsva-analysis:local
```

The target is `linux/amd64`. The base runtime is pinned in
[OMIX_MODULE_SOURCE.md](../OMIX_MODULE_SOURCE.md). The application image is
non-root, carries OCI labels, installs no packages at runtime, and has no
network dependency during a run. See the complete bind-mount and provenance
rules in [docs/container_contract.md](../docs/container_contract.md).
