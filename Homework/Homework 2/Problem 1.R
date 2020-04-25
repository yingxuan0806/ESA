rm(list=ls())
setwd("~/Documents/SUTD/Term 5/ESA/Homework/Homework 2")

if(!require(lpSolve)) {
  install.packages("lpSolve")
  library(lpSolve)
}

if(!require(ggplot2)) {
  install.packages("ggplot2")
  library(ggplot2)
}

# PROBLEM 1
# Task 2 
f_obj <- c(10, 9 , 8)
constraint_1 <- c(4, 3, 2) # working hours
constraint_2 <- c(3, 2, 2) # raw material
constraint_3 <- c(1, 0, 0) # P1
constraint_4 <- c(0, 1, 0) # P2
constraint_5 <- c(0, 0, 1) # P3
f_constraint <- rbind(constraint_1, constraint_2, constraint_3, constraint_4, constraint_5)
f_dir <- c("<=", "<=", ">=", ">=", ">=")
f_rhs <- c(1300, 1000, 0, 0, 0)

result_1 <- lp(direction = "max", objective.in = f_obj, const.mat = f_constraint, const.dir = f_dir, const.rhs = f_rhs, all.int = FALSE)
result_1$objval
result_1$solution

env_pollution <- result_1$solution[1] * 10 + result_1$solution[2] * 6 + result_1$solution[3] * 3
env_pollution


# Task 5
constraint_eps <- c(10, 6, 3)
f_constraint_eps <- rbind(constraint_1, constraint_2, constraint_3, constraint_4, constraint_5, constraint_eps)
f_dir_eps <- c("<=", "<=", ">=", ">=", ">=", "<=")
epsilon <- c(0, 500, 1000, 1500, 2000, 2400)

# obj_val_eps <- matrix(c(rep(0, length(epsilon) * 2)), nrow = length(epsilon), byrow = TRUE)
obj_val_eps <- matrix(0, nrow = length(epsilon), ncol = 2)
# dec_var_eps <- matrix(c(rep(0, length(epsilon) * 3)), nrow = length(epsilon), byrow = TRUE)
dec_var_eps <- matrix(0, nrow = length(epsilon), ncol = length(f_obj))

for (i in 1:length(epsilon)) {
  f_rhs_eps <- c(1300, 1000, 0, 0, 0, epsilon[i])
  result_eps <- lp(direction = "max", objective.in = f_obj, const.mat = f_constraint_eps, const.dir = f_dir_eps, const.rhs = f_rhs_eps, all.int = FALSE)
  obj_val_eps[i, 1] <- result_eps$objval
  obj_val_eps[i, 2] <- epsilon[i]
  dec_var_eps[i,] <- result_eps$solution
}

obj_val_eps
dec_var_eps


p1_5_plot1 <- ggplot(data = data.frame(Profits = obj_val_eps[,1], Pollution = obj_val_eps[,2]),
                     mapping = aes(x = Profits, y = Pollution)) + geom_point() + labs(title = "Profits vs Pollution", x = "Profits", y = "Pollution")
p1_5_plot1
ggsave("P1 T5 Plot 1.jpg", p1_5_plot1)
