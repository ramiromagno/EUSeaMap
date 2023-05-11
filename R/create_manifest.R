#' @importFrom rlang .data
create_manifest <- function(path, ignore = "MANIFEST") {

  files <- setdiff(list.files(path = path), ignore)
  files2 <- file.path(path, files)

  manifest <-
    tibble::tibble(
      file = files,
      date = file.info(files2)$ctime,
      size = hsize(file.size(files2)),
      md5sum = tools::md5sum(files2)
    ) |>
    dplyr::arrange(.data$date)

  manifest
}
