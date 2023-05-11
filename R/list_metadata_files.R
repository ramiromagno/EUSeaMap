#' @importFrom rlang .data
list_metadata_files <- function(map_files) {

  metadata <-
    map_files |>
    dplyr::filter(.data$file_type == "url") |>
    dplyr::mutate(metadata_url = read_url(.data$file, .data$ar_path)) |>
    dplyr::mutate(metadata_url = update_metadata_url(.data$metadata_url))
}
