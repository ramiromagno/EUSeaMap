# Original XLSX downloaded from:
# https://www.eea.europa.eu/data-and-maps/data/eunis-habitat-classification-1/eunis-marine-habitat-classification-review-2022/eunis-marine-habitat-classification-2022/at_download/file
#
# More details in: https://www.eea.europa.eu/data-and-maps/data/eunis-habitat-classification-1

library(tidyverse)

file_path <- here::here("data-raw/EUNIS marine habitat classification 2022 including crosswalks.xlsx")
benthic_sheet <- readxl::read_xlsx(path = file_path, sheet = "Benthic habitats")

benthic_sheet01 <-
  benthic_sheet |>
  dplyr::rename(Comments = "...23") |>
  dplyr::mutate(Level = as.integer(Level))

eunis_2022_benthic_habitats <- benthic_sheet01

usethis::use_data(eunis_2022_benthic_habitats, overwrite = TRUE)
