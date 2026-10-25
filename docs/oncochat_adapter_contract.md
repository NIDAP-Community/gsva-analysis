# OncoChat Adapter Contract

The application integration stages approved database-derived files at `/data`
and invokes the pinned OCI image by digest. It validates bounded request fields
against `schemas/interface.yml`; it never forwards host paths, credentials, or
arbitrary shell arguments.

The required staging and release gates are defined by the canonical
[GSVA preflight record](https://github.com/NIDAP-Community/OMIX/blob/main/docs/derivations/gsva-analysis-preflight.md).
This document will be expanded only after the live pathway-catalog mapping is
reviewed.
