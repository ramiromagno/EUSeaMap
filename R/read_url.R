read_url <-
  function(file,
           zip = NULL,
           tmp = tempfile(),
           unzip = ifelse(os() == "linux", "/usr/bin/unzip", "internal")) {

  purrr::map2_chr(.x = file, .y = zip, .f = read_url_, tmp = tmp, unzip = unzip)
}

# Non-vectorized version of `read_url()`
read_url_ <-
  function(file,
           zip = NULL,
           tmp = tempfile(),
           unzip = ifelse(os() == "linux", "/usr/bin/unzip", "internal")) {


  file <- if (!is.null(zip)) {
    utils::unzip(
      zipfile = zip,
      files = file,
      exdir = tmp,
      unzip = unzip
    )

    file.path(tmp, file)
  }
  lines <- readr::read_lines(file)
  url_string <- grep("^URL", lines, value = TRUE)
  url <- gsub("^URL[[:space:]]*=[[:space:]]*", "", url_string)

  url
}

# `url_exists()` is a courtesy of Bob Rudis:
# https://stackoverflow.com/questions/52911812/check-if-url-exists-in-r

#' Check whether URL exists
#'
#' @param url A character vector of URLs.
#' @param non_2xx_return_value what to do if the site exists but the
#'        HTTP status code is not in the `2xx` range. Default is to return `FALSE`.
#' @param quiet if not `FALSE`, then every time the `non_2xx_return_value` condition
#'        arises a warning message will be displayed. Default is `FALSE`.
#' @param ... other params (`timeout()` would be a good one) passed directly
#'        to `httr::HEAD()` and/or `httr::GET()`
#'
#' @return A logical.
#' @export
url_exists <- function(url,
                       non_2xx_return_value = FALSE,
                       quiet = TRUE,
                       ...) {

  purrr::map_lgl(url,
                 url_exists_,
                 non_2xx_return_value = FALSE,
                 quiet = TRUE,
                 ...)

}

url_exists_ <-
  function(x,
           non_2xx_return_value = FALSE,
           quiet = TRUE,
           ...) {

    sHEAD <- safely(httr::HEAD)
    sGET <- safely(httr::GET)

    # Try HEAD first since it's lightweight
    res <- sHEAD(x, ...)

    if (is.null(res$result) ||
        ((httr::status_code(res$result) %/% 200) != 1)) {
      res <- sGET(x, ...)

      if (is.null(res$result))
        return(FALSE) # return value on hard errors

      if (((httr::status_code(res$result) %/% 200) != 1)) {
        if (!quiet)
          warning(
            sprintf(
              "Requests for [%s] responded but without an HTTP status code in the 200-299 range",
              x
            )
          )
        return(non_2xx_return_value)
      }

      return(TRUE)

    } else {
      return(TRUE)
    }

  }

capture_error <- function(code,
                          otherwise = NULL,
                          quiet = TRUE) {
  tryCatch(
    list(result = code, error = NULL),
    error = function(e) {
      if (!quiet)
        message("Error: ", e$message)

      list(result = otherwise, error = e)
    },
    interrupt = function(e) {
      stop("Terminated by user", call. = FALSE)
    }
  )
}

safely <- function(.f,
                   otherwise = NULL,
                   quiet = TRUE) {
  function(...)
    capture_error(.f(...), otherwise, quiet)
}
