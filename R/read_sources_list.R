#' Read data sources
#'
#' `read_sources()` reads a table of data sources.
#'
#' @param file A path to a YAML file with data sources. By default it reads
#' the most recent data sources' list shipped with `{EUSeaMap}`.
#'
#' @return A [tibble][tibble::tibble-package] of four variables:
#' \describe{
#' \item{`file`}{Data source file name.}
#' \item{`desc`}{Description of the data source.}
#' \item{`cs`}{Marine habitat classification system.}
#' \item{`url`}{The URL to the data source location.}
#' }
#'
#' @examples
#' read_sources()
#'
#' @export
#' @importFrom rlang .data
read_sources <-
  function(file = system.file("EUSeaMap_phase5_rawdata.yml", package = "EUSeaMap")) {

    yml <- yaml::yaml.load_file(file)

    sources <-
      purrr::list_rbind(purrr::map(yml$sources, tibble::as_tibble)) %>%
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~ dplyr::na_if(., "")))

    sources
  }
