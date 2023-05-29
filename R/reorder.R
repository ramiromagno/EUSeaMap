#' Reorder a vector by another
#'
#' [reorder()] reorders vector `x` by vector `by`. If elements of `x` exist in
#' `by` then the order is that of `by`, remaining elements of `x` not present
#' in `by` follow next in the order of `x`.
#'
#' @param x Vector of elements to be reordered.
#' @param by Vector whose elements' order is to preserved in the output.
#'
#' @return A vector of the same type as `x` and `by`.
#'
reorder <- function(x, by) {

  union(intersect(by, x), setdiff(x, by))
}
