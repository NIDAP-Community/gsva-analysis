#!/usr/bin/env bash
set -euo pipefail

if [[ "$#" -ne 2 ]]; then
  printf '%s\n' 'Usage: container/parity_test.sh <application-image> <canonical-omix-module-dir>' >&2
  exit 2
fi

script_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
project_dir="$(CDPATH= cd -- "${script_dir}/.." && pwd)"
application_image="$1"
canonical_module_dir="$2"
runtime_image="${GSVA_CANONICAL_RUNTIME:-ghcr.io/nidap-community/omix-r-pathway@sha256:25ad9f50df5a4d7f70a7e3debed13f8d5c9b07cbc46d57fdf5c3cf4f2e767ddc}"

test -d "${canonical_module_dir}" || { printf 'Canonical module directory does not exist: %s\n' "${canonical_module_dir}" >&2; exit 2; }

parity_root="$(mktemp -d "${TMPDIR:-/tmp}/gsva-analysis-parity.XXXXXX")"
standalone_output="${parity_root}/standalone"
canonical_output="${parity_root}/canonical"
mkdir -p "${canonical_output}"

"${script_dir}/run_docker.sh" "${application_image}" "${project_dir}/test_data" "${standalone_output}" \
  --normalized_data /data/normalized_expression.tsv \
  --sample_metadata /data/sample_metadata.tsv \
  --pathways_database /data/pathway_membership.tsv \
  --gene_column Gene \
  --sample_name_column Sample \
  --collections_to_include 'H: hallmark gene sets' \
  --output_dir /output

docker run --rm \
  --platform "${DOCKER_PLATFORM:-linux/amd64}" \
  --user "$(id -u):$(id -g)" \
  --mount "type=bind,src=$(CDPATH= cd -- "${canonical_module_dir}" && pwd -P),dst=/omix/OMIX-GSVA,readonly" \
  --mount "type=bind,src=${project_dir}/test_data,dst=/data,readonly" \
  --mount "type=bind,src=${canonical_output},dst=/output" \
  --entrypoint Rscript \
  "${runtime_image}" \
  --vanilla /omix/OMIX-GSVA/scripts/run_gsva.R \
  --normalized_data /data/normalized_expression.tsv \
  --sample_metadata /data/sample_metadata.tsv \
  --pathways_database /data/pathway_membership.tsv \
  --gene_column Gene \
  --sample_name_column Sample \
  --collections_to_include 'H: hallmark gene sets' \
  --output_dir /output

cmp "${standalone_output}/tables/gsva_results.csv" "${canonical_output}/gsva_results.csv"
cmp "${standalone_output}/logs/gsva_run_summary.txt" "${canonical_output}/gsva_run_summary.txt"
printf 'Canonical/standalone GSVA parity passed: %s\n' "${parity_root}"
