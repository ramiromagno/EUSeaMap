#' Create a manifest of downloaded files
#'
#' [create_manifest()] creates a [tibble][tibble::tibble-package] that lists
#' downloaded files, along with download date, file size and respective MD5
#' checksums.
#'
#' @param path A path to the directory containing the downloaded archives.
#' @param ignore A character vector of file names to be ignored in the
#'   generation of the manifest.
#'
#' @return A [tibble][tibble::tibble-package] of four columns:
#' \describe{
#' \item{`file`}{File name.}
#' \item{`date`}{Download date.}
#' \item{`size`}{File size.}
#' \item{`md5sum`}{MD5 checksum.}
#' }
#'
#' @importFrom rlang .data
#' @export
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
