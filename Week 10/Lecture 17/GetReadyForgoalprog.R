rm(list=ls())
setwd("~/Documents/SUTD/Term 5/ESA/Week 10/Lecture 17")

# Script for Goal Programming -- in preparation for Lecture 17


######## Install/Load goalprog

# The "goalprog" package is not hosted on CRAN. Instead, it is hosted on GitHub.
# To install "goalprog", we can use either the "devtools" or the "remotes" package.
#
# Option 1: "devtools"
install.packages("devtools")
library(devtools)
# Then, install goalprog from GitHub
install_github("cran/goalprog")
#
# Option 2: "remotes" 
install.packages("remotes")
library(remotes)
install_url('https://cran.r-project.org/src/contrib/Archive/goalprog/goalprog_1.0-1.tar.gz')

# After having installed "goalprog", we must obviously load it
library(goalprog)


######## Run the example

# We want to solve the following problem
#
# Minimize n1 + 2p2 + n2 + 5n3 + 5n4
# subject to:
# 4x1 + 2x2 + n1 - p1 = 48  
# 4x1 + 2x2 + n2 - p2 = 32  
# x1 + n3 - p3        = 7
# x2 + n4 - p4        = 10
# x1, x2, x3, x4 >= 0
# n1, n2, n3, n4 >= 0
# p1, p2, p3, p4 >= 0

# To set up the problem with goalprog, we must define three variables
#
# A matrix of coefficients for the linear objective functions
coefficients <- matrix (c(4, 2, 4, 2, 1, 0, 0, 1), nrow=4, byrow=TRUE)
# A vector of target values for the objective functions
targets <- c(48, 32, 7, 10)
# A data frame with the deviation variables for each objective together with the priority level
objective <- c(1, 2, 3, 4)  # index for a particular problem object
priority <- c(1, 2, 3, 4)   # level to which the row (i.e. objective) is assigned
p <- c(0, 2, 0, 0)          # weight associated with the positive deviation variable
n <- c(1, 1, 5, 5)          # weight associated with the negative deviation variable
achievements <- data.frame(objective=objective, priority=priority, p=p, n=n)

# To solve the problem, we use the function llgp
soln <- llgp(coefficients, targets, achievements)

# Finally, we pull out the most interesting aspect of the solution
out <- llgpout(soln$tab, coefficients, targets)
out
# Decision variables
# X
# X1   7.000000e+00
# X2   1.000000e+01
# 
# Summary of objectives
# Objective           Over          Under         Target
# G1   4.800000e+01   0.000000e+00   0.000000e+00   4.800000e+01
# G2   4.800000e+01   1.600000e+01   0.000000e+00   3.200000e+01
# G3   7.000000e+00   0.000000e+00   0.000000e+00   7.000000e+00
# G4   1.000000e+01   0.000000e+00   0.000000e+00   1.000000e+01
# 
# Achievement function
# A
# P1   0.000000e+00
# P2   3.200000e+01
# P3   0.000000e+00
# P4   0.000000e+00

# The package 'goalprog' has many interesting examples. Uncomment the following lines to try them (or refer to the package manual) 
#
# Ignizio - Example 3.1
# data(ignizio.example.3.1)
# soln <- llgp(coefficients, targets, achievements)
# out <- llgpout(soln$tab, coefficients, targets)
# out

