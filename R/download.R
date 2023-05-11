# To download file with server suggested file name
download <- function(url, file, dir = getwd(), overwrite = FALSE, quiet = TRUE) {

  destfile <- file.path(dir, file)

  if (!(!overwrite && file.exists(destfile))) {
    curl::curl_download(url = url, destfile = destfile, quiet = quiet)
  }

  return(destfile)
}

#' Download sources
#'
#' `download_sources()` downloads data sources.
#'
#' @param path A path to a directory where the files are to be saved.
#' @param sources A list or data frame containing (at least) the elements `file`
#'   and `url`. The `file` should contain the name of the destination file on
#'   disk, and `url` the source URL. By default, it takes the output of
#'   [read_sources()].
#' @param overwrite Whether to overwrite existing files.
#' @param progress Whether to print download progress.
#' @param timeout Timeout in seconds.
#'
#' @return A [tibble][tibble::tibble-package] providing a log on the downloaded
#'   files.
#'
#' @importFrom rlang .data
#' @export
download_sources <-
  function(path,
           sources = read_sources(),
           overwrite = FALSE,
           progress = TRUE,
           timeout = 60) {


  if (!rlang::has_name(sources, "url"))
    stop("`url` column is required", call. = FALSE)

  if (!rlang::has_name(sources, "file"))
    stop("`file` column is required", call. = FALSE)

  fs::dir_create(path = path)
  destfiles <- file.path(path, sources$file)

  # If not overwriting then download only those files that do not exist yet.
  if (!overwrite) {
    non_existant_files <- !file.exists(destfiles)
    destfiles2 <- destfiles[non_existant_files]
    sources2 <- sources[non_existant_files, ]
  } else {
    destfiles2 <- destfiles
    sources2 <- sources
  }

  if (length(destfiles2) > 0L) {
    downloads <-
      curl::multi_download(
        urls = sources2$url,
        destfiles = destfiles2,
        resume = FALSE,
        progress = progress,
        timeout = timeout
      )
  } else {
    # TODO: Warn that no file was downloaded
    downloads <- NULL
  }

  downloads
}
