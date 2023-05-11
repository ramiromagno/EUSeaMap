library(tidyverse)

map_files <- list_map_files("~/dwl")
metadata_files <- list_metadata_files(map_files)



foo <-
  map_files |>
  dplyr::filter(file_type == "url")

metadata <-
  map_files |>
  dplyr::filter(file_type == "url") |>
  dplyr::mutate(url = read_url(file, file.path("~/dwl/", archive))) |>
  dplyr::mutate(url = update_metadata_url(url))



bar2 <-
  bar |>
  dplyr::mutate(url_ok = url_exists(url))


bar$url[1:10]
url_exists(bar$url[1])
url_exists(bar$url[10])
url_exists(bar$url[1:10])
url_exists(bar$url[nrow(bar)])
url_exists("http://iduarte.eu")

writexl::write_xlsx(bar2, path = "~/dwl/metadata_urls.xlsx")
write_excel_csv(bar2, file = "~/dwl/metadata_urls.csv")

url_exists("http://gis.ices.dk/geonetwork/srv/eng/catalog.search#/metadata/1786b575-064d-43a1-9c0d-ff7943e4754a")


url_exists("http://gis.ices.dk/geonetwork/srv/eng/catalog.search#/metadata/094a0b14-7073-4822-a685-60040631d81e")

download.file("http://gis.ices.dk/geonetwork/srv/api/records/094a0b14-7073-4822-a685-60040631d81e/formatters/xml", destfile = "~/BE000142.xml")

"http://geo.ices.dk/geonetwork/srv/en/metadata.show?uuid=094a0b14-7073-4822-a685-60040631d81e"

bar |>
  dplyr::filter(grepl("geo\\.ices\\.dk", url)) |>
  View()

bar |>
  dplyr::mutate(uuid = create_geonetwork_linkextract_uuid(url)) |>
  View()


create_geonetwork_link("094a0b14-7073-4822-a685-60040631d81e")


update_metadata_url("http://gis.ices.dk/geonetwork/srv/eng/catalog.search#/metadata/094a0b14-7073-4822-a685-60040631d81e")

foo <- yaml::yaml.load_file("inst/EUSeaMap_phase5_rawdata.yml")

tibble::as_tibble(foo$sources)

purrr::list_rbind(purrr::map(foo$sources, tibble::as_tibble))

my_sources <- read_sources_list()

my_sources$url

read_sources_list()
download(url = my_sources$url[4], dir = "~/dwl/foomagic")

foo <- purrr::safely(download(url = "https://kjas.org/oiaskdada", dir = "~/dwl/foomagic"))

download2 <- purrr::safely(download)
foo <- download2(url = my_sources$url[4], dir = "~/dwl/foomagic")

my_sources2 <-
  bind_rows(
    my_sources[4:5, ],
    tibble(description = c("asd", "asda"), url = c("https://blahblah.com/cenaseafins.zip", "http://iduarte.eu"))
  )


foo <- download_sources(path = "~/dwl/foomagic2", sources = my_sources2)

tibble(path = purrr::map_chr(foo, "result", .default = NA_character_))

bar <- read_sources_list()

file.exists(file.path("~/dwl/multi_download", bar$file))


download_sources("~/dwl/multi_download")

foo <- eunis_biogenic_habitats() |>
  dplyr::filter(Level > 3)


filter(
  eunis_2022_benthic_habitats, grepl("Sabellaria", Name, ignore.case = TRUE)) |>
  View()
