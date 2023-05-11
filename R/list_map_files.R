#' List map files in archives
#'
#' `ls_map_files()` lists the map files contained within archives.
#'
#' This function loops over all archives in `path` whose file name matches the
#' `pattern` and lists files within each archive.
#'
#' @param path A path to a directory containing archives with map files.
#' @param pattern A pattern to filter archive file names.
#' @param exclusions A character vector of file names not to be included in the
#' listing.
#'
#' @return A [tibble][tibble::tibble-package] of seven variables comprising
#' the map files contained in the archives, one row per `file`:
#' \describe{
#' \item{ar_path}{Full path to the archive file.}
#' \item{ar}{Archive file name.}
#' \item{gui}{Global unique identifier.}
#' \item{file}{File name.}
#' \item{file_type}{File type.}
#' \item{size}{File size in bytes.}
#' \item{date}{File creation date.}
#' }
#'
#' @importFrom rlang .data
#' @export
ls_map_files <- function(path, pattern = "+\\.zip$", exclusions = "EMODnetSBH_Confidence.xlsx") {

  # `ar`: Archive file names (zip files)
  ar <- list.files(path = path, pattern = pattern)

  # `ar_path`: Archive files (zip files)
  ar_path <- file.path(path, ar)

  # `cs`: classification system
  # cs <- stringr::str_match(ar, "_(.+)_")[, 2]

  # `archive_files`: files within the zip archives
  archive_files <-
    purrr::map(.x = ar_path,
               .f = \(x) utils::unzip(zipfile = x, list = TRUE)) |>
    purrr::list_rbind(names_to = "archive_id") |>
    dplyr::transmute(
      ar_path = .data$ar_path[.data$archive_id],
      ar = .data$ar[.data$archive_id],
      file = .data$Name,
      size = .data$Length,
      date = .data$Date
    ) |>
    dplyr::mutate(gui = stringr::str_extract(file, "^[:alpha:]{2}[:digit:]{6}"), .before = file) |>
    tibble::as_tibble()

  map_files <-
    archive_files |>
    dplyr::filter(!(file %in% exclusions)) |>
    dplyr::mutate(file_type = tools::file_ext(file), .after = file)

  map_files
}
