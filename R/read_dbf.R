#' Read a dbf file
#'
#' [read_dbf()] reads a dBase IV format file.
#'
#' @param dbf_file A path to a dbf file.
#' @param ar A path to an archive zip file if the dbf is contained in said zip
#'   file.
#'
#' @return A [tibble][tibble::tibble-package] of data from the DBF file.
#'
#' @export
read_dbf <- function(dbf_file, ar = NULL) {
  # If no archive (`ar`) is given, then read the file directly
  if (is.null(ar)) {
    return(foreign::read.dbf(dbf_file))
  }

  # Else, read from an archive
  temp_dir <- tempdir()
  utils::unzip(ar, files = dbf_file, exdir = temp_dir)
  dbf <- foreign::read.dbf(file.path(temp_dir, dbf_file))
  file.remove(file.path(temp_dir, dbf_file))

  tibble::as_tibble(dbf)
}
