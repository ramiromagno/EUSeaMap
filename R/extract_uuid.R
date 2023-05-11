extract_uuid <- function(x, ignore_case = TRUE) {
  pattern <- "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}"
  regex <- stringr::regex(pattern, ignore_case = ignore_case)
  stringr::str_extract(x, pattern = regex)
}
