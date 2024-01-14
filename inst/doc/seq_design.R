## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  echo = TRUE,
  eval = FALSE
)

## -----------------------------------------------------------------------------
#  library(tidyverse)
#  library(lhs)
#  library(ggplot2)
#  library(dgpsi)

## -----------------------------------------------------------------------------
#  f <- function(x) {
#   sin(1/((0.7*x[,1,drop=F]+0.3)*(0.7*x[,2,drop=F]+0.3)))
#   }

## -----------------------------------------------------------------------------
#  x1 <- seq(0, 1, length.out = 100)
#  x2 <- seq(0, 1, length.out = 100)
#  dat <- expand_grid(x1 = x1, x2 = x2)
#  dat <- mutate(dat, f = f(cbind(x1, x2)))
#  ggplot(dat, aes(x1, x2, fill = f)) + geom_tile() +
#    scale_fill_continuous(type = "viridis")

## -----------------------------------------------------------------------------
#  set_seed(99)

## -----------------------------------------------------------------------------
#  X <- maximinLHS(5,2)
#  Y <- f(X)

## -----------------------------------------------------------------------------
#  validate_x <- maximinLHS(200,2)
#  validate_y <- f(validate_x)

## -----------------------------------------------------------------------------
#  m <- dgp(X, Y)

## -----------------------------------------------------------------------------
#  lim_1 <- c(0, 1)
#  lim_2 <- c(0, 1)
#  lim <- rbind(lim_1, lim_2)

## -----------------------------------------------------------------------------
#  # 1st wave with 25 steps
#  m <- design(m, N = 25, limits = lim, f = f, x_test = validate_x, y_test = validate_y)

## -----------------------------------------------------------------------------
#  # 2nd wave with 10 steps
#  m <- design(m, N = 10, limits = lim, f = f, x_test = validate_x, y_test = validate_y)

## -----------------------------------------------------------------------------
#  # 2nd wave with 10 additional steps
#  m <- design(m, N = 10, limits = lim, f = f, x_test = validate_x, y_test = validate_y, new_wave = FALSE)

## -----------------------------------------------------------------------------
#  draw(m, 'design')

## -----------------------------------------------------------------------------
#  draw(m, 'rmse')

## -----------------------------------------------------------------------------
#  # DGP emulator with a LHD of size 10
#  X1 <- maximinLHS(10,2)
#  Y1 <- f(X1)
#  m1 <- dgp(X1, Y1, verb = F)

## -----------------------------------------------------------------------------
#  # DGP emulator with a LHD of size 20
#  X2 <- maximinLHS(20,2)
#  Y2 <- f(X2)
#  m2 <- dgp(X2, Y2, verb = F)

## -----------------------------------------------------------------------------
#  # DGP emulator with a LHD of size 30
#  X3 <- maximinLHS(30,2)
#  Y3 <- f(X3)
#  m3 <- dgp(X3, Y3, verb = F)

## -----------------------------------------------------------------------------
#  # DGP emulator with a LHD of size 40
#  X4 <- maximinLHS(40,2)
#  Y4 <- f(X4)
#  m4 <- dgp(X4, Y4, verb = F)

## -----------------------------------------------------------------------------
#  # DGP emulator with a LHD of size 50
#  X5 <- maximinLHS(50,2)
#  Y5 <- f(X5)
#  m5 <- dgp(X5, Y5, verb = F)

## -----------------------------------------------------------------------------
#  # validation of the DGP emulator with the LHD of size 10
#  m1 <- validate(m1, x_test = validate_x, y_test = validate_y, verb = F)
#  rmse1 <- m1$oos$rmse
#  # validation of the DGP emulator with the LHD of size 20
#  m2 <- validate(m2, x_test = validate_x, y_test = validate_y, verb = F)
#  rmse2 <- m2$oos$rmse
#  # validation of the DGP emulator with the LHD of size 30
#  m3 <- validate(m3, x_test = validate_x, y_test = validate_y, verb = F)
#  rmse3 <- m3$oos$rmse
#  # validation of the DGP emulator with the LHD of size 40
#  m4 <- validate(m4, x_test = validate_x, y_test = validate_y, verb = F)
#  rmse4 <- m4$oos$rmse
#  # validation of the DGP emulator with the LHD of size 50
#  m5 <- validate(m5, x_test = validate_x, y_test = validate_y, verb = F)
#  rmse5 <- m5$oos$rmse
#  # create a dataframe that stores the RMSEs of the four DGP emulators
#  rmse_static <- data.frame('N' = c(10, 20, 30, 40, 50), 'rmse' = c(rmse1, rmse2, rmse3, rmse4, rmse5), 'LHD' = c('lhd-10', 'lhd-20', 'lhd-30', 'lhd-40', 'lhd-50'))

## -----------------------------------------------------------------------------
#  draw(m, 'rmse', log = T) +
#    geom_point(data = rmse_static, mapping = aes(x = N, y = rmse, group = LHD, shape = LHD), color = '#E69F00', size = 1.5) +
#    scale_shape_manual(values = c(2, 3, 4, 8, 15))

