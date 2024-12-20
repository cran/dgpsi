% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{write}
\alias{write}
\title{Save the constructed emulator}
\usage{
write(object, pkl_file, light = TRUE)
}
\arguments{
\item{object}{an instance of the S3 class \code{gp}, \code{dgp}, \code{lgp}, or \code{bundle}.}

\item{pkl_file}{the path to and the name of the \code{.pkl} file to which
the emulator \code{object} is saved.}

\item{light}{a bool indicating if a light version of the constructed emulator
(that requires less disk space to store) will be saved. Defaults to \code{TRUE}.}
}
\value{
No return value. \code{object} will be saved to a local \code{.pkl} file specified by \code{pkl_file}.
}
\description{
This function saves the constructed emulator to a \code{.pkl} file.
}
\details{
See further examples and tutorials at \url{https://mingdeyu.github.io/dgpsi-R/}.
}
\note{
Since emulators built from the package are 'python' objects, \code{\link[=save]{save()}} from R will not work as it would for R objects. If \code{object}
was processed by \code{\link[=set_vecchia]{set_vecchia()}} to add or remove the Vecchia approximation, \code{light} should be set to \code{FALSE} to ensure
reproducibility after the saved emulator is reloaded by \code{\link[=read]{read()}}.
}
\examples{
\dontrun{

# See gp(), dgp(), lgp(), or pack() for an example.
}
}
