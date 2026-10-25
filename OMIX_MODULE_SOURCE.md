# Canonical OMIX Module Source

## Pinned source snapshot

| Item | Value |
| --- | --- |
| Canonical module | `OMIX-GSVA` |
| Canonical path | `modules/OMIX-GSVA/` |
| OMIX source commit | `0ea6223129de6d98d69469027c19fa1887b59f6a` |
| Module version | `0.3.0` |
| Interface version | `2` |
| Canonical tag | Pending; no tag exists for this snapshot |
| Runtime profile | `r-pathway` |

## Imported files

| Canonical file | Repository copy | SHA-256 |
| --- | --- | --- |
| `R/GSVA.R` | `R/GSVA.R` | `2ef7ab5d3726a89676ffb6e5e6b1bc42b41c4ef59093d3754252c8035b0fa7ad` |
| `scripts/run_gsva.R` | `scripts/run_gsva.R` | `5ed78b47ba2910d7b1b39102c4f2c2f003558e59e489265f473da7bdb09487ed` |
| `schemas/interface.yml` | `schemas/interface.yml` | `186c7a70b6bd60321257d448bc9666badb91cebd77036af0ecaab5dc4d324c6a` |
| `module.yml` | `module.yml` | `da9aa1676a3b2007328cef10e3f6753fda5557e6c4a1baa92aece9e38e7d0399` |

The scientific implementation is a pinned OMIX export. Do not edit it in this
repository. Scientific or reusable-interface changes must be made, validated,
and versioned in OMIX before this export is refreshed.

## Runtime source

The initial candidate base image is:

```text
ghcr.io/nidap-community/omix-r-pathway@sha256:25ad9f50df5a4d7f70a7e3debed13f8d5c9b07cbc46d57fdf5c3cf4f2e767ddc
```

Its copied lockfile is `renv.lock` with SHA-256
`520ffdb1c855bb5259731bc0069f78e1d2f7cb8846b86c629d7f5449c277e4a4`.
The derived application image must be validated independently and recorded by
its own immutable digest before use by OncoChat.
