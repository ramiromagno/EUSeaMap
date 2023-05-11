hsize <- function(size) {
  purrr::map_chr(size, ~ format(x = structure(.x, class="object_size"), units="auto", standard="SI"))
}
