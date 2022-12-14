% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{summary}
\alias{summary}
\alias{summary.gp}
\alias{summary.dgp}
\alias{summary.lgp}
\title{Summary of a constructed GP, DGP, or linked (D)GP emulator}
\usage{
\method{summary}{gp}(object, ...)

\method{summary}{dgp}(object, ...)

\method{summary}{lgp}(object, ...)
}
\arguments{
\item{object}{can be one of the following:
\itemize{
\item the S3 class \code{gp}.
\item the S3 class \code{dgp}.
\item the S3 class \code{lgp}.
}}

\item{...}{N/A.}
}
\value{
A table summarizing key information contained in \code{object}.
}
\description{
This function summarizes key information of a GP, DGP or linked (D)GP emulator.
}
\details{
See further examples and tutorials at \url{https://mingdeyu.github.io/dgpsi-R/}.
}
\examples{
\dontrun{

# See gp(), dgp(), or lgp() for an example.
}
}
