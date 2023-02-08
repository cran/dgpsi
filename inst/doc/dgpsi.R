## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  echo = TRUE,
  eval = FALSE
)

## -----------------------------------------------------------------------------
#  library(dgpsi)
#  init_py()

## -----------------------------------------------------------------------------
#  f <- function(x) {
#    if (x < 0.5) return(-1)
#    if (x >= 0.5) return(1)
#  }

## -----------------------------------------------------------------------------
#  X <- seq(0, 1, length = 10)
#  Y <- sapply(X, f)

## -----------------------------------------------------------------------------
#  m <- dgp(X, Y, depth = 3)

## -----------------------------------------------------------------------------
#  summary(m)

## -----------------------------------------------------------------------------
#  plot(m)

## -----------------------------------------------------------------------------
#  oos_x <- sample(seq(0, 1, length = 200),10)
#  oos_y <- sapply(oos_x, f)

## -----------------------------------------------------------------------------
#  plot(m,oos_x,oos_y)

## -----------------------------------------------------------------------------
#  test_x <- seq(0, 1, length = 200)
#  test_y <- sapply(test_x, f)

## -----------------------------------------------------------------------------
#  m <- predict(m, x = test_x)

## -----------------------------------------------------------------------------
#  mu <- m$results$mean # extract the predictive means
#  sd <- sqrt(m$results$var) # extract the predictive variance and compute the predictive standard deviations
#  # compute predictive bounds which are two predictive standard deviations above and below the predictive means
#  up <- mu + 2*sd
#  lo <- mu - 2*sd
#  
#  plot(test_x, mu, type = 'l', lty = 2, lwd = 1.5, col = 'black', xlab = 'x', cex.axis = 1.3, cex.lab = 1.3, ylab = 'y', ylim = c(-1.5,1.5))  # predictive means
#  polygon(c(test_x, rev(test_x)), c(up,rev(lo)), col = 'grey80', border = F) # credible interval
#  lines(test_x, test_y, type = 'l', col = "#D55E00", lwd = 2) # Underlying truth
#  lines(test_x, mu, type = 'l', lty = 2, lwd = 1.5, col = 'black')
#  lines(X, Y, type = 'p', pch = 16, cex = 1, col = "#0072B2") # Training data points

