
<!-- README.md is generated from README.Rmd. Please edit that file -->

# EUSeaMap

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/EUSeaMap)](https://CRAN.R-project.org/package=EUSeaMap)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

`{EUSeaMap}` provides a suite of utilities to generate the EUSeaMap
(EMODnet Broad-Scale Seabed Habitat Map for Europe).

## Installation

You can install the development version of EUSeaMap like so:

``` r
# install.packages("remotes")
remotes::install_github("ramiromagno/EUSeaMap")
```

## Usage

Pedro and Luís, please test these functions and give me feedback! :)

``` r
library(EUSeaMap)
library(tidyverse)

# Set a download path of your liking
path <- "~/Downloads/EUSeaMap_Data/"

# read_sources(): reads a table of data sources.
# look at https://github.com/ramiromagno/EUSeaMap/blob/main/inst/EUSeaMap_phase5_rawdata.yml
read_sources()

# For downloading raw data from sources
download_sources(path = path)

# create_manifest(): for generating MD5 checksums (to control version of
# downloaded files)
(manifest <- create_manifest(path))
write_csv(x = manifest, file = file.path(path, "MANIFEST"))

#  ls_map_files(): for listing map-related files without uncompressing the zip
# archives
map_files <- ls_map_files(path = path)

# How many files per file type?
count(map_files, file_type)

# How many files per map (i.e. GUI)?
count(map_files, gui)

# Read map layers' attributes of two example files
zip_file1 <- file.path(path, "EMODnetSBH_EUNIS_surveymaps.zip")
read_dbf("BE000142.dbf", zip_file1)

zip_file2 <- file.path(path, "EMODnetSBH_Other_surveymaps.zip")
read_dbf("IE003090.dbf", zip_file2)

# eunis_biogenic_habitats(): EUNIS biogenic habitats following the criteria
# indicated in Section 2.1 of the EMODnet Seabed Habitats Data Product (2019)
eunis_biogenic_habitats()

# biogenic_substrates(): biogenic substrates as defined in Table 5 of the
# EMODnet Seabed Habitats Data Product (2019).
biogenic_substrates

```
