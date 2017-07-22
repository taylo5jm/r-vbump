#!/usr/bin/Rscript
# r-vbump.R
# Increment the major, minor, or patch version of
# an R package by modifying the DESCRIPTION file
# Justin Taylor <taylor@hemoshear.com>
# 2017-07-22
#
# dependencies:
#   none
#
# usage:
#   # cd to top-level package directory with DESCRIPTION file
#    ./r-vbump.R [major|minor|patch]

args <- commandArgs(trailingOnly = TRUE)
desc <- readLines("DESCRIPTION")

# get version field
version <- strsplit(desc[grep("Version: ", desc)], split=": ")[[1]][2]

# semantic versioning
increments <- 1:3
names(increments) <- c("major", "minor", "patch")

# increment version
version_split <- as.integer(strsplit(version, split = "\\.")[[1]])
version_split[increments[args[1]]] <- version_split[increments[args[1]]] + 1
new_version <- paste(version_split, collapse=".")
new_version_field <- paste("Version:", new_version)

# create new file
new_description_file <- gsub(desc[grep("Version: ", desc)], new_version_field, desc)
cat(new_description_file, file="DESCRIPTION", sep="\n")
out_msg <- paste("Bumped", names(increments[args[1]]), "version in DESCRIPTION from", version, "to", new_version, "\n")
cat(out_msg)
