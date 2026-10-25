#!/usr/bin/env Rscript

# Stable application-level CLI. The canonical OMIX script owns the GSVA
# scientific interface; this wrapper deliberately adds no statistical defaults
# or platform path discovery.
args <- commandArgs(trailingOnly = TRUE)
script_path <- file.path("scripts", "run_gsva.R")

if (!file.exists(script_path)) {
  stop("Canonical GSVA CLI is missing: ", script_path)
}

rscript <- file.path(R.home("bin"), "Rscript")
status <- system2(rscript, args = c("--vanilla", shQuote(script_path), shQuote(args)))
quit(save = "no", status = as.integer(status))
