# Container Build and Runtime

This image is a Container-as-a-Function wrapper around the pinned OMIX GSVA
implementation. It reads staged input files from `/data` and writes a complete
run to `/output`; it contains no database, cloud, or study-data credentials.

Build and validate locally after the initial source commit exists:

```bash
container/build_docker.sh gsva-analysis:local
container/smoke_test.sh gsva-analysis:local
```

The target is `linux/amd64`. The base runtime is pinned in
[OMIX_MODULE_SOURCE.md](../OMIX_MODULE_SOURCE.md); the final application image
will receive its own digest only after validation and explicit publication
approval.
