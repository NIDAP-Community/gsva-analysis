#!/usr/bin/env bash
set -euo pipefail

# This test covers the application boundary rather than GSVA's scientific
# implementation, which remains owned and tested by the canonical OMIX module.
script_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
project_dir="$(CDPATH= cd -- "${script_dir}/.." && pwd)"
image="${1:-gsva-analysis:local}"
test_root="$(mktemp -d "${TMPDIR:-/tmp}/gsva-analysis-contract.XXXXXX")"
help_output="${test_root}/help.txt"
failure_output="${test_root}/missing-input.txt"

cleanup() {
  rm -f "${help_output}" "${failure_output}"
  rmdir "${test_root}/output" "${test_root}" 2>/dev/null || true
}
trap cleanup EXIT

docker run --rm --platform "${DOCKER_PLATFORM:-linux/amd64}" "${image}" --help >"${help_output}"
grep -q -- '--normalized_data' "${help_output}"
grep -q -- '--sample_metadata' "${help_output}"
grep -q -- '--pathways_database' "${help_output}"

if "${project_dir}/container/run_docker.sh" "${image}" "${project_dir}/test_data" "${test_root}/output" \
  --normalized_data /data/does-not-exist.tsv \
  --sample_metadata /data/sample_metadata.tsv \
  --pathways_database /data/pathway_membership.tsv \
  --output_dir /output >"${failure_output}" 2>&1; then
  printf '%s\n' 'Expected a missing normalized-expression input to fail.' >&2
  exit 1
fi

printf '%s\n' 'GSVA CLI contract test passed.'
