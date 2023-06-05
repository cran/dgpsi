## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  echo = TRUE,
  eval = FALSE
)

## -----------------------------------------------------------------------------
#  library(lhs)
#  library(ggplot2)
#  library(patchwork)
#  library(dgpsi)
#  init_py()

## -----------------------------------------------------------------------------
#  f <- function(x) {
#    y1 = sin(30*((2*x-1)/2-0.4)^5)*cos(20*((2*x-1)/2-0.4))
#    y2 = 1/3*sin(2*(2*x - 1))+2/3*exp(-30*(2*(2*x-1))^2)+1/3
#    y3 = (sin(7.5*x)+1)/2
#    return(cbind(y1, y2, y3))
#  }

## -----------------------------------------------------------------------------
#  dense_x <- seq(0, 1, length = 200)
#  dense_y <- f(dense_x)
#  output1 <- data.frame('x' = dense_x, 'y' = dense_y[,1])
#  output2 <- data.frame('x' = dense_x, 'y' = dense_y[,2])
#  output3 <- data.frame('x' = dense_x, 'y' = dense_y[,3])
#  p1 <- ggplot(data = output1, aes(x = x, y = y)) + geom_line(color = 'dodgerblue2') + ggtitle('Output 1') + theme(plot.title = element_text(size = 10))
#  p2 <- ggplot(data = output2, aes(x = x, y = y)) + geom_line(color = '#E31A1C') + ggtitle('Output 2') + theme(plot.title = element_text(size = 10))
#  p3 <- ggplot(data = output3, aes(x = x, y = y)) + geom_line(color = 'green4') + ggtitle('Output 3') + theme(plot.title = element_text(size = 10))
#  wrap_plots(list(p1, p2, p3)) + plot_annotation(title = 'Synthetic Simulator')

## -----------------------------------------------------------------------------
#  set_seed(99)

## -----------------------------------------------------------------------------
#  X <- maximinLHS(5, 1)
#  Y <- f(X)

## -----------------------------------------------------------------------------
#  validate_x <- maximinLHS(200, 1)
#  validate_y <- f(validate_x)

## -----------------------------------------------------------------------------
#  m1 <- dgp(X, Y[,1], connect = F)

## -----------------------------------------------------------------------------
#  m2 <- dgp(X, Y[,2], connect = F)

## -----------------------------------------------------------------------------
#  m3 <- dgp(X, Y[,3])

## -----------------------------------------------------------------------------
#  m <- pack(m1, m2, m3)

## -----------------------------------------------------------------------------
#  lim <- c(0, 1)

## -----------------------------------------------------------------------------
#  target <- 0.01

## -----------------------------------------------------------------------------
#  # 1st wave of the sequential design with 10 steps
#  m <- design(m, N = 10, limits = lim, f = f, x_test = validate_x, y_test = validate_y, target = target)

## -----------------------------------------------------------------------------
#  g <- function(x, weight){
#    x[,1] <- x[,1]*weight[1]
#    x[,2] <- x[,2]*weight[2]
#    x[,3] <- x[,3]*weight[3]
#    return(rowSums(x))
#  }

## -----------------------------------------------------------------------------
#  weight <- c(0.8, 0.2, 0)

## -----------------------------------------------------------------------------
#  # 2nd wave with 15 steps
#  m <- design(m, N = 15, limits = lim, f = f, x_test = validate_x, y_test = validate_y, aggregate = g, target = 0.01, weight = weight)

## -----------------------------------------------------------------------------
#  draw(m, 1, 'design') + draw(m, 2, 'design') + draw(m, 3, 'design') +
#    plot_layout() & theme(legend.position = 'bottom')

## -----------------------------------------------------------------------------
#  # DGP emulators with a LHD of size 10
#  X1 <- maximinLHS(10, 1)
#  Y1 <- f(X1)
#  m11 <- dgp(X1, Y1[,1], connect = F, verb = F)
#  m12 <- dgp(X1, Y1[,2], connect = F, verb = F)
#  m13 <- dgp(X1, Y1[,3], verb = F)

## -----------------------------------------------------------------------------
#  # DGP emulator with a LHD of size 20
#  X2 <- maximinLHS(20, 1)
#  Y2 <- f(X2)
#  m21 <- dgp(X2, Y2[,1], connect = F, verb = F)
#  m22 <- dgp(X2, Y2[,2], connect = F, verb = F)
#  m23 <- dgp(X2, Y2[,3], verb = F)

## -----------------------------------------------------------------------------
#  # DGP emulator with a LHD of size 30
#  X3 <- maximinLHS(30, 1)
#  Y3 <- f(X3)
#  m31 <- dgp(X3, Y3[,1], connect = F, verb = F)
#  m32 <- dgp(X3, Y3[,2], connect = F, verb = F)
#  m33 <- dgp(X3, Y3[,3], verb = F)

## -----------------------------------------------------------------------------
#  # validations of the first DGP emulator
#  m11 <- validate(m11, x_test = validate_x, y_test = validate_y[,1], verb = F)
#  m21 <- validate(m21, x_test = validate_x, y_test = validate_y[,1], verb = F)
#  m31 <- validate(m31, x_test = validate_x, y_test = validate_y[,1], verb = F)
#  rmse_static_1 <- data.frame('N' = c(10, 20, 30), 'rmse' = c(m11$oos$rmse, m21$oos$rmse, m31$oos$rmse), 'LHD' = c('lhd-10', 'lhd-20', 'lhd-30'))
#  # validations of the second DGP emulator
#  m12 <- validate(m12, x_test = validate_x, y_test = validate_y[,2], verb = F)
#  m22 <- validate(m22, x_test = validate_x, y_test = validate_y[,2], verb = F)
#  m32 <- validate(m32, x_test = validate_x, y_test = validate_y[,2], verb = F)
#  rmse_static_2 <- data.frame('N' = c(10, 20, 30), 'rmse' = c(m12$oos$rmse, m22$oos$rmse, m32$oos$rmse), 'LHD' = c('lhd-10', 'lhd-20', 'lhd-30'))
#  # # validations of the third DGP emulator
#  m13 <- validate(m13, x_test = validate_x, y_test = validate_y[,3], verb = F)
#  m23 <- validate(m23, x_test = validate_x, y_test = validate_y[,3], verb = F)
#  m33 <- validate(m33, x_test = validate_x, y_test = validate_y[,3], verb = F)
#  rmse_static_3 <- data.frame('N' = c(10, 20, 30), 'rmse' = c(m13$oos$rmse, m23$oos$rmse, m33$oos$rmse), 'LHD' = c('lhd-10', 'lhd-20', 'lhd-30'))

## -----------------------------------------------------------------------------
#  p1 <- draw(m, emulator = 1, type = 'rmse', log = T) +
#    geom_point(data = rmse_static_1, mapping = aes(x = N, y = rmse, group = LHD, shape = LHD), color = '#E69F00', size = 1.5) +
#    scale_shape_manual(values = c(3, 4, 8))
#  p2 <- draw(m, emulator = 2, type = 'rmse', log = T) +
#    geom_point(data = rmse_static_2, mapping = aes(x = N, y = rmse, group = LHD, shape = LHD), color = '#E69F00', size = 1.5) +
#    scale_shape_manual(values = c(3, 4, 8))
#  p3 <- draw(m, emulator = 3, type = 'rmse', log = T) +
#    geom_point(data = rmse_static_3, mapping = aes(x = N, y = rmse, group = LHD, shape = LHD), color = '#E69F00', size = 1.5) +
#    scale_shape_manual(values = c(3, 4, 8))
#  p1 + p2 + p3 + plot_layout(guides = 'collect') & theme(legend.position = 'bottom')

