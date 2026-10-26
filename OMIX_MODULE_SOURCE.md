# Canonical OMIX Module Source

## Pinned source snapshot

| Item | Value |
| --- | --- |
| Canonical module | `OMIX-GSVA` |
| Canonical path | `modules/OMIX-GSVA/` |
| OMIX source commit | `79e27490a0521aa866af60ae5fa203e9e1516b42` |
| Module version | `1.0.0` |
| Interface version | `2` |
| Canonical tag | Pending; no tag exists for this snapshot |
| Runtime profile | `r-pathway` |

## Imported files

| Canonical file | Repository copy | SHA-256 |
| --- | --- | --- |
| `R/GSVA.R` | `R/GSVA.R` | `02c80e669a7e3f964b42997f23557de90af69dbd391e342a05096923da11a818` |
| `scripts/run_gsva.R` | `scripts/run_gsva.R` | `5fe626cdf3837820c53362f56e32d41418dd63e7dbf4128869573b9ec84ebca5` |
| `schemas/interface.yml` | `schemas/interface.yml` | `d308b7e86b6cd9ff83a9ff508a1fe723cf42cfc89796a6c51ded72ec5cb5a15f` |
| `module.yml` | `module.yml` | `72691f56d3b71614e2e7313ae4bcf4f3e193560b9faaedfa2e6f6a88ba47a2ae` |

The scientific implementation is a pinned OMIX export. Do not edit it in this
repository. Scientific or reusable-interface changes must be made, validated,
and versioned in OMIX before this export is refreshed.

The current export adds species-aware safe defaults: `gene_column = auto`
selects `Gene` and then `GeneName`; `collections_to_include = auto` selects
the Human or Mouse Hallmark collection for the selected pathway-database
species. Existing explicit values remain valid.

## Runtime source

The initial candidate base image is:

```text
ghcr.io/nidap-community/omix-r-pathway@sha256:25ad9f50df5a4d7f70a7e3debed13f8d5c9b07cbc46d57fdf5c3cf4f2e767ddc
```

Its copied lockfile is `renv.lock` with SHA-256
`520ffdb1c855bb5259731bc0069f78e1d2f7cb8846b86c629d7f5449c277e4a4`.
The derived application image must be validated independently and recorded by
its own immutable digest before use by OncoChat.
