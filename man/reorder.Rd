% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reorder.R
\name{reorder}
\alias{reorder}
\title{Reorder a vector by another}
\usage{
reorder(x, by)
}
\arguments{
\item{x}{Vector of elements to be reordered.}

\item{by}{Vector whose elements' order is to preserved in the output.}
}
\value{
A vector of the same type as \code{x} and \code{by}.
}
\description{
\code{\link[=reorder]{reorder()}} reorders vector \code{x} by vector \code{by}. If elements of \code{x} exist in
\code{by} then the order is that of \code{by}, remaining elements of \code{x} not present
in \code{by} follow next in the order of \code{x}.
}
