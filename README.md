
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

## Example (very much still work in progress)

``` r
library(EUSeaMap)

# Set download path
path <- "~/Downloads/EUSeaMap_Data/"

# Download sources
download_sources(path = path)

# Create MANIFEST file
manifest <- create_manifest(path = path)
write_csv(x = manifest, file = file.path(path, "MANIFEST"))

# Data source map files
map_files <- ls_map_files(path = path)


count(map_files, file_type)
count(map_files, gui)


zip_file <- "~/dwl/multi_download/EMODnetSBH_EUNIS_surveymaps.zip"
read_dbf("BE000142.dbf", zip_file)
zip_file <- "~/dwl/multi_download/EMODnetSBH_Other_surveymaps.zip"
read_dbf("IE003090.dbf", zip_file)
```
