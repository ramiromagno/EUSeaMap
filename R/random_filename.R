random_filename <- function() {

  prefix <- random_str()
  timestamp <- format(Sys.time(), "_%Y%m%d_%H%M%S")

  paste0(prefix, timestamp)
}
