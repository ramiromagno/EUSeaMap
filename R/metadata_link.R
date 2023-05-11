create_geonetwork_link <- function(uuid) {
  base_url <- "http://gis.ices.dk/geonetwork/srv/eng/catalog.search#/metadata/"
  paste0(base_url, uuid)
}
