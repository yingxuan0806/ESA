rm(list=ls())
setwd("~/Documents/SUTD/Term 5/ESA/Homework/Homework 2")

if(!require(GA)) {
  install.packages("GA")
  library(GA)
}

# PROBLEM 3
# Task 1
# f <- function(x, y) {
#   - (cos(x) * cos(y) * exp(-( (x-pi)^2 + (y-pi)^2 )))
# }
# 
# f <- function(x[1], y) {
#   - ( cos(x) * cos(y) * exp(-(x-pi)^2 - (y-pi)^2) )
#   
# }

f <- function(x1, x2) {
  -cos(x1)*cos(x2)*exp(-((x1-pi)^2 + (x2-pi)^2))
  }

# 
g <- function(x) {
  -cos(x[1])*cos(x[2])*exp(-((x[1]-pi)^2 + (x[2]-pi)^2))
}



x <- seq(-100, 100, by = 0.1)
y <- seq(-100, 100, by = 0.1)

GA_3 <- ga(type = "real-valued",
           fitness = function(x) -f(x[1],x[2]),
           lower = c(-100, -100),
           upper = c(100, 100),
           popSize = 100,
           maxiter = 100)
GA_g <- ga(type = "real-valued",
           fitness = function(x) -g(x),
           lower = c(-100, -100),
           upper = c(100, 100),
           popSize = 100,
           maxiter = 100)


# x <- y <- seq(-100, 100, by = 0.1)
# f <- outer(x, y, f)

# GA <- ga(type = "real-valued", fitness = function(x) - f(x,y),
#          lower = c(-100, -100),
#          upper = c(100, 100),
#          popSize = 100,
#          maxiter = 100)


summary(GA_3)
plot(GA_3)

GA_3@solution
f(GA_3@solution[1,1], GA_3@solution[1,2])


