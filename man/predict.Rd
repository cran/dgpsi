% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prediction.R
\name{predict}
\alias{predict}
\alias{predict.dgp}
\alias{predict.lgp}
\alias{predict.gp}
\title{Prediction from GP, DGP, or linked (D)GP emulators}
\usage{
\method{predict}{dgp}(
  object,
  x,
  method = NULL,
  mode = "label",
  full_layer = FALSE,
  sample_size = 50,
  M = 50,
  cores = 1,
  chunks = NULL,
  ...
)

\method{predict}{lgp}(
  object,
  x,
  method = NULL,
  full_layer = FALSE,
  sample_size = 50,
  M = 50,
  cores = 1,
  chunks = NULL,
  ...
)

\method{predict}{gp}(
  object,
  x,
  method = NULL,
  sample_size = 50,
  M = 50,
  cores = 1,
  chunks = NULL,
  ...
)
}
\arguments{
\item{object}{an instance of the \code{gp}, \code{dgp}, or \code{lgp} class.}

\item{x}{the testing input data:
\itemize{
\item if \code{object} is an instance of the \code{gp} or \code{dgp} class, \code{x} is a matrix where each row is an input testing data point and each column is an input dimension.
\item \ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}} if \code{object} is an instance of the \code{lgp} class created by \code{\link[=lgp]{lgp()}} without specifying argument \code{struc} in data frame form, \code{x} can be either a matrix or a list:
\itemize{
\item if \code{x} is a matrix, its rows are treated as instances of the \code{Global} inputs. In this case, it is assumed that the only global input to the system is the input to the
emulators in the first layer and there is no global input to emulators in other layers.
\item if \code{x} is a list, it should have \emph{L} (the number of layers in an emulator system) elements. The first element
is a matrix that represents the global testing input data that feed into the emulators in the first layer of the system. The
remaining \emph{L-1} elements are \emph{L-1} sub-lists, each of which contains a number (the same number of emulators in
the corresponding layer) of matrices (rows being testing input data points and columns being input dimensions) that represent the
global testing input data to the emulators in the corresponding layer. The matrices must be placed in the sub-lists based on how
their corresponding emulators are placed in \code{struc} argument of \code{\link[=lgp]{lgp()}}. If there is no global input data to a certain emulator,
set \code{NULL} in the corresponding sub-list of \code{x}.
}

\strong{This option for linked (D)GP emulators is deprecated and will be removed in the next release.}
\item \ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#new}{\figure{lifecycle-new.svg}{options: alt='[New]'}}}{\strong{[New]}} If \code{object} is an instance of the \code{lgp} class created by \code{\link[=lgp]{lgp()}} with argument \code{struc} in data frame form,
\code{x} must be a matrix representing the global input, where each row corresponds to a test data point and each column represents a global input dimension.
The column indices in \code{x} must align with the indices specified in the \code{From_Output} column of the \code{struc} data frame (used in \code{\link[=lgp]{lgp()}}),
corresponding to rows where the \code{From_Emulator} column is \code{"Global"}.
}}

\item{method}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#updated}{\figure{lifecycle-updated.svg}{options: alt='[Updated]'}}}{\strong{[Updated]}} the prediction approach to use: either the mean-variance approach (\code{"mean_var"}) or the sampling approach (\code{"sampling"}).
The mean-variance approach returns the means and variances of the predictive distributions, while the sampling approach generates samples from predictive distributions
using the derived means and variances. For DGP emulators with a categorical likelihood (\code{likelihood = "Categorical"} in \code{\link[=dgp]{dgp()}}), \code{method} is only applicable
when \code{full_layer = TRUE}. In this case, the sampling approach generates samples from the GP nodes in all hidden layers using the derived means and variances,
and subsequently propagates these samples through the categorical likelihood. By default, the method is set to \code{"sampling"} for DGP emulators with Poisson, Negative Binomial, and
Categorical likelihoods, and to \code{"mean_var"} otherwise.}

\item{mode}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#new}{\figure{lifecycle-new.svg}{options: alt='[New]'}}}{\strong{[New]}} whether to predict the classes (\code{"label"}) or probabilities (\code{"proba"}) of different classes when \code{object} is a DGP emulator with a categorical likelihood.
Defaults to \code{"label"}.}

\item{full_layer}{a bool indicating whether to output the predictions of all layers. Defaults to \code{FALSE}. Only used when \code{object} is a DGP or a linked (D)GP emulator.}

\item{sample_size}{the number of samples to draw for each given imputation if \code{method = "sampling"}. Defaults to \code{50}.}

\item{M}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#new}{\figure{lifecycle-new.svg}{options: alt='[New]'}}}{\strong{[New]}} the size of the conditioning set for the Vecchia approximation in the emulator prediction. Defaults to \code{50}. This argument is only used if the emulator \code{object}
was constructed under the Vecchia approximation.}

\item{cores}{the number of processes to be used for prediction. If set to \code{NULL}, the number of processes is set to \verb{max physical cores available \%/\% 2}. Defaults to \code{1}.}

\item{chunks}{the number of chunks that the testing input matrix \code{x} will be divided into for multi-cores to work on.
Only used when \code{cores} is not \code{1}. If not specified (i.e., \code{chunks = NULL}), the number of chunks is set to the value of \code{cores}.
Defaults to \code{NULL}.}

\item{...}{N/A.}
}
\value{
\itemize{
\item If \code{object} is an instance of the \code{gp} class:
\enumerate{
\item if \code{method = "mean_var"}: an updated \code{object} is returned with an additional slot called \code{results} that contains two matrices named \code{mean}
for the predictive means and \code{var} for the predictive variances. Each matrix has only one column with its rows
corresponding to testing positions (i.e., rows of \code{x}).
\item if \code{method = "sampling"}: an updated \code{object} is returned with an additional slot called \code{results} that contains a matrix whose rows correspond
to testing positions and columns correspond to \code{sample_size} number of samples drawn from the predictive distribution of GP.
}
\item If \code{object} is an instance of the \code{dgp} class:
\enumerate{
\item if \code{method = "mean_var"} and  \code{full_layer = FALSE}: an updated \code{object} is returned with an additional slot called \code{results} that contains two
matrices named \code{mean} for the predictive means and \code{var} for the predictive variances respectively. Each matrix has its rows corresponding to testing
positions and columns corresponding to DGP global output dimensions (i.e., the number of GP/likelihood nodes in the final layer).
\item if \code{method = "mean_var"} and  \code{full_layer = TRUE}: an updated \code{object} is returned with an additional slot called \code{results} that contains two
sub-lists named \code{mean} for the predictive means and \code{var} for the predictive variances respectively. Each sub-list contains \emph{L} (i.e., the number of layers)
matrices named \verb{layer1, layer2,..., layerL}. Each matrix has its rows corresponding to testing positions and columns corresponding to
output dimensions (i.e., the number of GP/likelihood nodes from the associated layer).
\item if \code{method = "sampling"} and  \code{full_layer = FALSE}: an updated \code{object} is returned with an additional slot called \code{results} that contains \emph{D} (i.e., the number
of GP/likelihood nodes in the final layer) matrices named \verb{output1, output2,..., outputD}. Each matrix has its rows corresponding to testing positions and
columns corresponding to samples of size: \code{B * sample_size}, where \code{B} is the number of imputations specified in \code{\link[=dgp]{dgp()}}.
\item if \code{method = "sampling"} and  \code{full_layer = TRUE}: an updated \code{object} is returned with an additional slot called \code{results} that contains \emph{L} (i.e., the number
of layers) sub-lists named \verb{layer1, layer2,..., layerL}. Each sub-list represents samples drawn from the GP/likelihood nodes in the corresponding layer,
and contains \emph{D} (i.e., the number of GP/likelihood nodes in the corresponding layer) matrices named \verb{output1, output2,..., outputD}. Each matrix gives samples
of the output from one of \emph{D} GP/likelihood nodes, and has its rows corresponding to testing positions and columns corresponding to samples
of size: \code{B * sample_size}, where \code{B} is the number of imputations specified in \code{\link[=dgp]{dgp()}}.
}
\item \ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#new}{\figure{lifecycle-new.svg}{options: alt='[New]'}}}{\strong{[New]}} If \code{object} is an instance of the \code{dgp} class with a categorical likelihood:
\enumerate{
\item if \code{full_layer = FALSE} and \code{mode = "label"}: an updated \code{object} is returned with an additional slot called \code{results} that contains one matrix named \code{label}.
The matrix has rows corresponding to testing positions and columns corresponding to sample labels of size: \code{B * sample_size}, where \code{B} is the number
of imputations specified in \code{\link[=dgp]{dgp()}}.
\item if \code{full_layer = FALSE} and \code{mode = "proba"}, an updated \code{object} is returned with an additional slot called \code{results}. This slot contains \emph{D} matrices (where
\emph{D} is the number of classes in the training output), where each matrix gives probability samples for the corresponding class with its rows corresponding to testing
positions and columns containing probabilities. The number of columns of each matrix is \code{B * sample_size}, where \code{B} is the number of imputations
specified in the \code{\link[=dgp]{dgp()}} function.
\item if \code{method = "mean_var"} and \code{full_layer = TRUE}: an updated \code{object} is returned with an additional slot called \code{results} that contains \emph{L} (i.e., the number
of layers) sub-lists named \verb{layer1, layer2,..., layerL}. Each of first \code{L-1} sub-lists contains two matrices named \code{mean} for the predictive means and \code{var}
for the predictive variances of the GP nodes in the associated layer. Rows of each matrix correspond to testing positions.
\itemize{
\item when \code{mode = "label"}, the sub-list \code{LayerL} contains one matrix named \code{label}. The matrix has its rows corresponding to testing positions and columns
corresponding to label samples of size: \code{B * sample_size}. \code{B} is the number of imputations specified in \code{\link[=dgp]{dgp()}}.
\item when \code{mode = "proba"}, the sub-list \code{LayerL} contains \emph{D} matrices (where \emph{D} is the number of classes in the training output), where each matrix gives probability
samples for the corresponding class with its rows corresponding to testing positions and columns containing probabilities. The number of columns of each matrix
is \code{B * sample_size}. \code{B} is the number of imputations specified in \code{\link[=dgp]{dgp()}}.
}
\item if \code{method = "sampling"} and \code{full_layer = TRUE}: an updated \code{object} is returned with an additional slot called \code{results} that contains \emph{L} (i.e., the number
of layers) sub-lists named \verb{layer1, layer2,..., layerL}. Each of first \code{L-1} sub-lists represents samples drawn from the GP nodes in the
corresponding layer, and contains \emph{D} (i.e., the number of GP nodes in the corresponding layer) matrices named \verb{output1, output2,..., outputD}. Each matrix
gives samples of the output from one of \emph{D} GP nodes, and has its rows corresponding to testing positions and columns corresponding to samples
of size: \code{B * sample_size}.
\itemize{
\item when \code{mode = "label"}, the sub-list \code{LayerL} contains one matrix named \code{label}. The matrix has its rows corresponding to testing positions and columns
corresponding to label samples of size: \code{B * sample_size}.
\item when \code{mode = "proba"}, the sub-list \code{LayerL} contains \emph{D} matrices (where \emph{D} is the number of classes in the training output), where each matrix gives probability
samples for the corresponding class with its rows corresponding to testing positions and columns containing probabilities. The number of columns of each matrix
is \code{B * sample_size}.
}

\code{B} is the number of imputations specified in \code{\link[=dgp]{dgp()}}.
}
\item \ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#updated}{\figure{lifecycle-updated.svg}{options: alt='[Updated]'}}}{\strong{[Updated]}} If \code{object} is an instance of the \code{lgp} class:
\enumerate{
\item if \code{method = "mean_var"} and  \code{full_layer = FALSE}: an updated \code{object} is returned with an additional slot called \code{results} that
contains two sub-lists named \code{mean} for the predictive means and \code{var} for the predictive variances respectively. Each sub-list
contains \emph{K} (same number of emulators in the final layer of the system) matrices named using the \code{ID}s of the corresponding emulators in the final layer.
Each matrix has rows corresponding to global testing positions and columns corresponding to output dimensions of the associated emulator
in the final layer.
\item if \code{method = "mean_var"} and  \code{full_layer = TRUE}: an updated \code{object} is returned with an additional slot called \code{results} that contains
two sub-lists named \code{mean} for the predictive means and \code{var} for the predictive variances respectively. Each sub-list contains \emph{L}
(i.e., the number of layers in the emulated system) components named \verb{layer1, layer2,..., layerL}. Each component represents a layer
and contains \emph{K} (same number of emulators in the corresponding layer of the system) matrices named using the \code{ID}s of the corresponding emulators in that layer.
Each matrix has its rows corresponding to global testing positions and columns corresponding to output dimensions of the associated
GP/DGP emulator in the corresponding layer.
\item if \code{method = "sampling"} and  \code{full_layer = FALSE}: an updated \code{object} is returned with an additional slot called \code{results} that contains
\emph{K} (same number of emulators in the final layer of the system) sub-lists named using the \code{ID}s of the corresponding emulators in the final layer. Each
sub-list contains \emph{D} matrices, named \verb{output1, output2,..., outputD}, that correspond to the output
dimensions of the GP/DGP emulator. Each matrix has rows corresponding to testing positions and columns corresponding to samples
of size: \code{B * sample_size}, where \code{B} is the number of imputations specified in \code{\link[=lgp]{lgp()}}.
\item if \code{method = "sampling"} and  \code{full_layer = TRUE}: an updated \code{object} is returned with an additional slot called \code{results} that contains
\emph{L} (i.e., the number of layers of the emulated system) sub-lists named \verb{layer1, layer2,..., layerL}. Each sub-list represents a layer
and contains \emph{K} (same number of emulators in the corresponding layer of the system) components named using the \code{ID}s of the corresponding emulators in that layer.
Each component contains \emph{D} matrices, named \verb{output1, output2,..., outputD}, that correspond to
the output dimensions of the GP/DGP emulator. Each matrix has its rows corresponding to testing positions and columns corresponding to
samples of size: \code{B * sample_size}, where \code{B} is the number of imputations specified in \code{\link[=lgp]{lgp()}}.
}

If \code{object} is an instance of the \code{lgp} class created by \code{\link[=lgp]{lgp()}} without specifying the \code{struc} argument in data frame form, the \code{ID}s, that are used as names of sub-lists or
matrices within \code{results}, will be replaced by \code{emulator1}, \code{emulator2}, and so on.
}

The \code{results} slot will also include:
\itemize{
\item \ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#new}{\figure{lifecycle-new.svg}{options: alt='[New]'}}}{\strong{[New]}} the value of \code{M}, which represents the size of the conditioning set for the Vecchia approximation, if used, in the emulator prediction.
\item the value of \code{sample_size} if \code{method = "sampling"}.
}
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#updated}{\figure{lifecycle-updated.svg}{options: alt='[Updated]'}}}{\strong{[Updated]}}

This function implements prediction from GP, DGP, or linked (D)GP emulators.
}
\details{
See further examples and tutorials at \url{https://mingdeyu.github.io/dgpsi-R/}.
}
\examples{
\dontrun{

# See gp(), dgp(), or lgp() for an example.
}
}
