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


