library(EUSeaMap)
library(tidyverse)

# Set a download path of your liking
path <- "~/dwl/EUSeaMap_Data/"

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

foo <- read_dbf(dbf_file = dbf_files_small$file, ar = dbf_files_small$ar_path)
foo <- read_dbf(dbf_file = dbf_files$file, ar = dbf_files$ar_path)

dplyr::distinct(foo, gui, polygon)
foo |>
  select(c("gui", "polygon")) %>%
  filter(duplicated(.)) |>
  pull(gui) |>
  unique()

"GB003021" "GB001494" "ES000001" "FR003016" "IT004009" "FR004036" "FR003076" "IE000009" "IT003001" "FR003028" "GB001104" "IE001005"

bar <-
  foo |>
  filter(gui == "GB003021")
