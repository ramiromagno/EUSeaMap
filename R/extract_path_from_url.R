extract_path_from_url <- function(url) {
  path <- basename(httr::parse_url(url)$path)

  if (identical(path, ""))
    return(NA_character_)

  path
}
