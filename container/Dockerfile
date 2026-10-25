# syntax=docker/dockerfile:1
# Repository-owned application image built from the reviewed shared pathway
# runtime. The base digest, not a mutable runtime tag, is the starting point.
ARG BASE_IMAGE=ghcr.io/nidap-community/omix-r-pathway@sha256:25ad9f50df5a4d7f70a7e3debed13f8d5c9b07cbc46d57fdf5c3cf4f2e767ddc
FROM ${BASE_IMAGE}

WORKDIR /app

COPY R/ R/
COPY scripts/ scripts/
COPY schemas/ schemas/
COPY test_data/ test_data/
COPY module.yml entrypoint.R OMIX_MODULE_SOURCE.md renv.lock ./

ARG VCS_REF=unknown
ARG BUILD_DATE=unknown
LABEL org.opencontainers.image.title="gsva-analysis" \
      org.opencontainers.image.description="Portable GSVA analysis component derived from OMIX GSVA" \
      org.opencontainers.image.source="https://github.com/NIDAP-Community/gsva-analysis" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.created="${BUILD_DATE}"

RUN mkdir -p /data /output \
    && useradd --create-home --uid 10001 --shell /usr/sbin/nologin gsva \
    && chown --recursive gsva:gsva /app /data /output

ENV GSVA_ANALYSIS_IMAGE_REVISION=${VCS_REF}
USER gsva
ENTRYPOINT ["Rscript", "--vanilla", "/app/entrypoint.R"]
CMD ["--help"]
