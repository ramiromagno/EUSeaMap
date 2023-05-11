library(tidyverse)

biogenic_substrates <- readxl::read_xls(here::here("data-raw/bs_types.xls")) |>
  dplyr::mutate(bs_level = as.integer(bs_level))

usethis::use_data(biogenic_substrates, overwrite = TRUE)
