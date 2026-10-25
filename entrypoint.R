#!/usr/bin/env Rscript

# Stable application-level CLI. The copied OMIX script owns the GSVA
# scientific interface; this wrapper only standardizes the result bundle and
# records runtime provenance after a successful canonical run.
args <- commandArgs(trailingOnly = TRUE)
script_path <- file.path("scripts", "run_gsva.R")

if (!file.exists(script_path)) {
  stop("Canonical GSVA CLI is missing: ", script_path)
}

option_value <- function(option_name, values) {
  exact_match <- which(values == option_name)
  if (length(exact_match) == 1L && exact_match < length(values)) {
    return(values[[exact_match + 1L]])
  }

  prefix <- paste0(option_name, "=")
  inline_match <- values[startsWith(values, prefix)]
  if (length(inline_match) == 1L) {
    return(substring(inline_match, nchar(prefix) + 1L))
  }

  NULL
}

write_result_bundle <- function(output_dir, arguments) {
  artifacts <- data.frame(
    role = c("GSVA score table", "GSVA heatmap", "Canonical run summary"),
    source = file.path(output_dir, c(
      "gsva_results.csv", "gsva_heatmap.png", "gsva_run_summary.txt"
    )),
    destination = file.path(c("tables", "figures", "logs"), c(
      "gsva_results.csv", "gsva_heatmap.png", "gsva_run_summary.txt"
    )),
    stringsAsFactors = FALSE
  )

  if (!all(file.exists(artifacts$source))) {
    stop("Canonical run completed without all expected GSVA artifacts.")
  }

  for (directory in unique(dirname(artifacts$destination))) {
    dir.create(file.path(output_dir, directory), recursive = TRUE, showWarnings = FALSE)
  }
  for (index in seq_len(nrow(artifacts))) {
    if (!file.rename(artifacts$source[[index]], file.path(output_dir, artifacts$destination[[index]]))) {
      stop("Could not place result artifact: ", artifacts$role[[index]])
    }
  }
  capture.output(sessionInfo(), file = file.path(output_dir, "logs", "sessionInfo.txt"))

  input_options <- c("--normalized_data", "--sample_metadata", "--pathways_database")
  input_paths <- vapply(input_options, option_value, character(1L), values = arguments)
  input_manifest <- data.frame(
    option = input_options,
    path = input_paths,
    md5 = unname(tools::md5sum(input_paths)),
    stringsAsFactors = FALSE
  )

  runtime_versions <- c(
    R = R.version.string,
    GSVA = as.character(utils::packageVersion("GSVA")),
    jsonlite = as.character(utils::packageVersion("jsonlite"))
  )
  application_revision <- Sys.getenv("GSVA_ANALYSIS_IMAGE_REVISION", "unknown")
  omix_source_commit <- Sys.getenv("GSVA_ANALYSIS_OMIX_SOURCE_COMMIT", "unknown")
  base_image <- Sys.getenv("GSVA_ANALYSIS_BASE_IMAGE", "unknown")
  timestamp <- format(Sys.time(), tz = "UTC", usetz = TRUE)

  metadata_lines <- c(
    "# GSVA Run Metadata",
    "",
    "## Status",
    "",
    "Completed successfully.",
    "",
    "## Provenance",
    "",
    paste("- Application revision:", application_revision),
    paste("- Canonical OMIX source commit:", omix_source_commit),
    "- Canonical OMIX module: OMIX-GSVA (version 0.3.0; interface 2)",
    paste("- Pinned base image:", base_image),
    paste("- Completed UTC:", timestamp),
    "",
    "## Runtime",
    "",
    paste("-", names(runtime_versions), runtime_versions),
    "",
    "## Declared input artifacts",
    "",
    "| Option | Container path | MD5 |",
    "| --- | --- | --- |",
    paste0("| ", input_manifest$option, " | `", input_manifest$path, "` | `", input_manifest$md5, "` |"),
    "",
    "## Parameters",
    "",
    paste0("`", paste(arguments, collapse = " ` `"), "`"),
    "",
    "## Interpretation",
    "",
    "This is an exploratory research analysis, not clinical decision support."
  )
  writeLines(metadata_lines, file.path(output_dir, "RUN_METADATA.md"))

  manifest <- list(
    status = "completed",
    completed_utc = timestamp,
    application_revision = application_revision,
    canonical_omix_source_commit = omix_source_commit,
    base_image = base_image,
    artifacts = c(
      lapply(seq_len(nrow(artifacts)), function(index) {
        list(role = artifacts$role[[index]], path = artifacts$destination[[index]])
      }),
      list(list(role = "R session information", path = "logs/sessionInfo.txt"))
    ),
    input_artifacts = lapply(seq_len(nrow(input_manifest)), function(index) {
      list(
        option = input_manifest$option[[index]],
        path = input_manifest$path[[index]],
        md5 = input_manifest$md5[[index]]
      )
    }),
    arguments = arguments,
    runtime = as.list(runtime_versions)
  )
  jsonlite::write_json(manifest, file.path(output_dir, "run_manifest.json"), auto_unbox = TRUE, pretty = TRUE)
}

rscript <- file.path(R.home("bin"), "Rscript")
status <- system2(rscript, args = c("--vanilla", shQuote(script_path), shQuote(args)))

output_dir <- option_value("--output_dir", args)
if (identical(as.integer(status), 0L) && !is.null(output_dir)) {
  write_result_bundle(output_dir, args)
}

quit(save = "no", status = as.integer(status))
