## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  echo = TRUE,
  eval = FALSE
)

## -----------------------------------------------------------------------------
#  library(ggplot2)
#  library(patchwork)
#  library(dgpsi)

## -----------------------------------------------------------------------------
#  # Model 1
#  f1 <- function(x) {
#    (sin(7.5*x)+1)/2
#  }
#  # Model 2
#  f2 <- function(x) {
#    2/3*sin(2*(2*x - 1))+4/3*exp(-30*(2*(2*x-1))^2)-1/3
#  }
#  # Model 3
#  f3 <- function(x) {
#    x[1]*x[2]^2
#  }
#  # Linked Model
#  f123 <- function(x) {
#    f3(c(f1(x),f2(f1(x))))
#  }

## -----------------------------------------------------------------------------
#  set_seed(200)

## -----------------------------------------------------------------------------
#  # Training data for Model 1
#  X1 <- seq(0, 1, length = 10)
#  Y1 <- sapply(X1, f1)
#  # Training data for Model 2
#  X2 <- seq(0, 1, length = 15)
#  Y2 <- sapply(X2, f2)
#  # Training data for Model 3
#  X3 <- cbind(X2, Y2)
#  Y3 <- apply(X3, f3, MARGIN = 1)

## -----------------------------------------------------------------------------
#  m1 <- gp(X1, Y1, name = "matern2.5")

## -----------------------------------------------------------------------------
#  plot(m1)

## -----------------------------------------------------------------------------
#  m1 <- set_linked_idx(m1, c(1))

## -----------------------------------------------------------------------------
#  m2 <- dgp(X2, Y2, depth = 2, name = "matern2.5", linked_idx = c(1))

## -----------------------------------------------------------------------------
#  plot(m2)

## -----------------------------------------------------------------------------
#  m3 <- dgp( X3, Y3, depth = 3, name = "matern2.5", linked_idx = list( c(1), c(1) ) )

## -----------------------------------------------------------------------------
#  plot(m3)

## -----------------------------------------------------------------------------
#  struc <- combine(list(m1), list(m2), list(m3))
#  m_link <- lgp(struc)

## -----------------------------------------------------------------------------
#  summary(m_link)

## -----------------------------------------------------------------------------
#  X_gp <- seq(0, 1, length = 15)
#  Y_gp <- sapply(X_gp, f123)
#  m_gp <- gp(X_gp, Y_gp, name = 'matern2.5')

## -----------------------------------------------------------------------------
#  # Testing input
#  test_x <- seq(0, 1, length = 300)
#  # Testing output
#  test_y <- sapply(test_x, f123)
#  # Validate GP emulator
#  m_gp <- validate(m_gp, x_test = test_x, y_test = test_y, verb = F)
#  # Validate linked emulator
#  m_link <- validate(m_link, x_test = test_x, y_test = test_y, verb = F)

## -----------------------------------------------------------------------------
#  # GP emulator
#  plot(m_gp, x_test = test_x, y_test = test_y, type = 'line', verb = F) +
#    plot_annotation(title = 'GP Emulator', theme = theme(plot.title = element_text(hjust = 0.5)))

## -----------------------------------------------------------------------------
#  # Linked emulator
#  plot(m_link, x_test = test_x, y_test = test_y, type = 'line', verb = F) +
#    plot_annotation(title = 'Linked Emulator', theme = theme(plot.title = element_text(hjust = 0.5)))

## -----------------------------------------------------------------------------
#  # OOS testing input
#  test_x_oos <- sample(seq(0, 1, length = 300), 20)
#  # OOS testing output
#  test_y_oos <- sapply(test_x_oos, f123)

## -----------------------------------------------------------------------------
#  plot(m_gp, test_x_oos, test_y_oos, style = 2)

## -----------------------------------------------------------------------------
#  plot(m_link, test_x_oos, test_y_oos, style = 2)

