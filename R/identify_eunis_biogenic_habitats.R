#' EUNIS biogenic habitats
#'
#' @description
#' [eunis_biogenic_habitats()] returns a data set of EUNIS biogenic habitats
#' following the criteria indicated in Section 2.1 of the EMODnet Seabed
#' Habitats Data Product (2019):
#'
#' - Exclusion of those classes from the littoral zone --- that is any
#' class in which the second value in the alphanumeric habitat code is "A". This
#' is because EUSeaMap is only concerned with sublittoral and deep-sea zones.
#'
#' - Kept only those classes where "biogenic habitat" is the given substrate
#' type in the level 2 parent class. That is any class in which the third value
#' in the alphanumeric habitat code is "2".
#'
#' TODO: Remaining criteria remain to be implemented.
#'
#' @param cs EUNIS classification version, either `"EUNIS_M_2019"` or
#'   `"EUNIS_M_2022"`. Default is `"EUNIS_M_2019"`.
#'
#' @return A subset [tibble][tibble::tibble-package] of the
#'   [eunis_habitats][eunis.habitats::eunis_habitats] matching the criteria
#'   indicated above.
#'
#' @source \url{https://archimer.ifremer.fr/doc/00736/84820/}
#'
#' @examples
#' # By default EUNIS Marine Habitats are returned
#' eunis_biogenic_habitats()
#'
#' # Alternatively request EUNIS Marine 2022
#' eunis_biogenic_habitats("EUNIS_M_2022")
#'
#' @importFrom rlang .data
#' @export
eunis_biogenic_habitats <- function(cs = c("EUNIS_M_2019", "EUNIS_M_2022")) {

  cs <- match.arg(cs)

  # Exclude those habitats from the littoral zone, i.e. when the second value in
  # the alphanumeric habitat code is "A", and keep those habitats where
  # "biogenic habitat" is the given substrate type in the level 2 parent class.
  # That is any class in which the third value in the alphanumeric habitat code
  # is "2".
  dplyr::filter(
    eunis.habitats::eunis_habitats,
    .data$classification == cs &
      grepl("^M[^A]2", .data$code) & .data$group == "benthic"
  )
}
