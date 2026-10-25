#!/usr/bin/env bash
set -euo pipefail

script_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
project_dir="$(CDPATH= cd -- "${script_dir}/.." && pwd)"
image="${1:-gsva-analysis:local}"
smoke_root="$(mktemp -d "${TMPDIR:-/tmp}/gsva-analysis-smoke.XXXXXX")"
output_dir="${smoke_root}/output"

"${script_dir}/run_docker.sh" "${image}" "${project_dir}/test_data" "${output_dir}" \
  --normalized_data /data/normalized_expression.tsv \
  --sample_metadata /data/sample_metadata.tsv \
  --pathways_database /data/pathway_membership.tsv \
  --gene_column Gene \
  --sample_name_column Sample \
  --collections_to_include 'H: hallmark gene sets' \
  --output_dir /output

for artifact in gsva_results.csv gsva_heatmap.png gsva_run_summary.txt; do
  test -s "${output_dir}/${artifact}" || { printf 'Missing smoke artifact: %s\n' "${artifact}" >&2; exit 1; }
done
printf 'GSVA container smoke test passed: %s\n' "${output_dir}"
