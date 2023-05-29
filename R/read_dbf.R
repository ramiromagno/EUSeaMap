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

  lst <- purrr::map2(
    .x = dbf_file,
    .y = ar,
    .f = ~ tibble::add_column(
      read_dbf_(.x, .y),
      .ar = basename(.y),
      .file = .x,
      .before = 1L
    )
  )

  tbl <- purrr::list_rbind(lst)

  tbl
}


#' @importFrom rlang .data
read_dbf_ <- function(dbf_file, ar = NULL) {
  # If no archive (`ar`) is given, then read the file directly
  if (is.null(ar)) {
    return(foreign::read.dbf(dbf_file))
  }

  # Else, read from an archive
  temp_dir <- tempdir()
  utils::unzip(ar, files = dbf_file, exdir = temp_dir, unzip = getOption("unzip"))
  dbf <- foreign::read.dbf(file.path(temp_dir, dbf_file), as.is = TRUE)
  file.remove(file.path(temp_dir, dbf_file))

  colnames(dbf) <- tolower(colnames(dbf))
  new_col_order <- reorder(colnames(dbf), by = c("gui", "polygon", "orig_hab", "hab_type", "version"))

  tibble::as_tibble(dbf) |>
    dplyr::select(dplyr::all_of(new_col_order)) |>
    dplyr::mutate(dplyr::across(-dplyr::one_of("polygon"), ~ as.character(.))) |>
    dplyr::mutate(polygon = as.integer(.data$polygon)) |>
    dplyr::mutate(dplyr::across(dplyr::where(is.character), ~ dplyr::if_else(. %in% c("Na", "NA", ""), NA_character_, .)))

}
