rm(list=ls())
setwd("~/Documents/SUTD/Term 5/ESA/Homework/Homework 2")

if(!require(goalprog)) {
  install.packages("goalprog")
  library(goalprog)
}

if(!require(fmsb)) {
  install.packages("fmsb")
  library(fmsb)
}

# PROBLEM 2
# Task 1

coefficients <- matrix(c(4, 2, 4, 2, 1, 0, 0, 1), nrow = 4, byrow = TRUE)
targets <- c(48, 32, 7, 10)

objective_index <- c(1:4)
priority <- c(1:4)
p <- c(0, 2, 0, 0)
n <- c(1, 1, 5, 5)

achievements <- data.frame(objective = objective_index, priority = priority, p = p, n = n)

solution <- llgp(coefficients = coefficients, targets = targets, achievements = achievements)
solution
summary <- llgpout(solution$tab, coefficients = coefficients, targets = targets)
summary


# Task 3
priority_new <- c(1, 1, 2, 3)
achievements_new <- data.frame(objective = objective_index, priority = priority_new, p = p, n = n)

solution_new <- llgp(coefficients = coefficients, targets = targets, achievements = achievements_new)
solution_new
summary_new <- llgpout(solution_new$tab, coefficients = coefficients, targets = targets)
summary_new


# Task 4
g1 <- c(abs(summary$b[1] - summary$f[1]), abs(summary_new$b[1] - abs(summary_new$f[1])))
max(g1) # 16
g2 <- c(abs(summary$b[2] - summary$f[2]), abs(summary_new$b[2] - abs(summary_new$f[2])))
max(g2) # 16
g3 <- c(abs(summary$b[3] - summary$f[3]), abs(summary_new$b[3] - abs(summary_new$f[3])))
max(g3) # 0
g4 <- c(abs(summary$b[4] - summary$f[4]), abs(summary_new$b[4] - abs(summary_new$f[4])))
max(g4) # 8
df <- data.frame(G1 = g1, G2 = g2, G3 = g3, G4 = g4)

max_range <- c(20, 20, 4, 12)
min_range <- c(0, 0, 0, 0)

df <- rbind(max_range, min_range, df)
radarchart(df)
legend(x = 1, y = 1, lty = c(1, 1), lwd = c(2.5, 2.5), col = c("black", "red"), c("Task 1", "Task 3"), cex = 0.4)
