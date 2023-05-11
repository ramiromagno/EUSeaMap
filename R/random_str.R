random_str <- function(size = 5) {
  paste0(sample(letters, size, replace = TRUE), collapse = "")
}
