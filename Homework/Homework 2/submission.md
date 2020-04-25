Yeo Ying Xuan				1003835

40.014 Engineering Systems Architecture

Spring 2020

Homework 2

**Table of Contents**

[toc]

<div style="page-break-after: always;"></div>

# Problem 1

## Task 1

Single Objective Optimisation Problem

Let P<sub>1</sub>, P<sub>2</sub>, P<sub>3</sub> denote the units of three products produced by the company respectively. 

maximise 10 P<sub>1</sub> + 9 P<sub>2</sub> + 8 P<sub>3</sub>

subject to:

4 P<sub>1</sub> + 3 P<sub>2</sub> + 2 P<sub>3</sub> <= 1300		

3 P<sub>1</sub> + 2 P<sub>2</sub> + 2 P<sub>3</sub> <= 1000

P<sub>1</sub>, P<sub>2</sub>, P<sub>3</sub> >= 0



## Task 2

profits = $4300

P<sub>1</sub> = 0

P<sub>2</sub> = 300

P<sub>3</sub> = 200

pollution = 10 * 0 + 6 * 300 + 3 * 200 = 2400 kg of CO<sub>2</sub> 



## Task 3

Let P<sub>1</sub>, P<sub>2</sub>, P<sub>3</sub> denote the units of three products produced by the company respectively. 

maximise 10 P<sub>1</sub> + 9 P<sub>2</sub> + 8 P<sub>3</sub>

subject to:

4 P<sub>1</sub> + 3 P<sub>2</sub> + 2 P<sub>3</sub> <= 1300		

3 P<sub>1</sub> + 2 P<sub>2</sub> + 2 P<sub>3</sub> <= 1000

P<sub>1</sub>, P<sub>2</sub>, P<sub>3</sub> >= 0

10 P<sub>1</sub> + 6 P<sub>2</sub> + 3 P<sub>3</sub> <= $\epsilon$ 



## Task 4

Range of variability: 0 <= $\epsilon$ <= 2400

- values of P<sub>i</sub> where i = 1, 2, 3 cannot be negative, hence $\epsilon$ >= 0

- without taking into consideration of minimising pollution and only maximising profits, maximum total pollution is 2400 kg of CO<sub>2</sub>, hence $\epsilon$ <= 2400
- combining, 0 <= $\epsilon$ <= 2400

## Task 5

### $\epsilon$ = 0

- profits = $0
- pollution = 0 kg of CO<sub>2</sub>
- P<sub>1</sub> = 0
- P<sub>2</sub> = 0
- P<sub>3</sub> = 0

### $\epsilon$ = 500

- profits = $1333.33
- pollution = 500 kg of CO<sub>2</sub> 
- P<sub>1</sub> = 0
- P<sub>2</sub> = 0
- P<sub>3</sub> = 166.6667

### $\epsilon$ = 1000

- profits = $2666.67
- pollution = 1000 kg of CO<sub>2</sub> 
- P<sub>1</sub> = 0
- P<sub>2</sub> = 0
- P<sub>3</sub> = 333.3333

### $\epsilon$ = 1500

- profits = $4000
- pollution = 1500 kg of CO<sub>2</sub> 
- P<sub>1</sub> = 0
- P<sub>2</sub> = 0
- P<sub>3</sub> = 500

### $\epsilon$ = 2000

- profits = $4166.67
- pollution = 2000 kg of CO<sub>2</sub> 
- P<sub>1</sub> = 0
- P<sub>2</sub> = 166.6667
- P<sub>3</sub> = 333.3333

### $\epsilon$ = 2400

- proftits = $4300
- pollution = 2400 kg of CO<sub>2</sub> 
- P<sub>1</sub> = 0
- P<sub>2</sub> = 300
- P<sub>3</sub> = 200

![P1 T5 Plot 1](/Users/yingxuan/Documents/SUTD/Term 5/ESA/Homework/Homework 2/P1 T5 Plot 1.jpg)



## Task 6

The scatter plot above shows that as the profits increase, the amount of pollution increases.

As the values of decision variables (ie. production of products 1, 2 and 3) increase, both objective function values (profits and pollution) increase.

Producing P<sub>2</sub> leads to smaller increase in profits but greater increase in pollution, relative to producing P<sub>3</sub>.



## Task7

Two objective functions

- maximise profits: f<sub>1</sub>(P) = 10 P<sub>1</sub> + 9 P<sub>2</sub> + 8 P<sub>3</sub>
- minimise pollution: f<sub>2</sub>(P) = 10 P<sub>1</sub> + 6 P<sub>2</sub> + 3 P<sub>3</sub>

Let w denote the weight of f<sub>1</sub>(P).

weight of f<sub>2</sub>(P) = 1-w

profits range of variability: 0 <= profits <= 4300

pollution range of variability: 0 <= pollution <= 2400



**Weighting Method Problem Formulation (Normalised using range of variability)**

maximise	w * \[(10 P<sub>1</sub> + 9 P<sub>2</sub> + 8 P<sub>3</sub>) / 4300] - (1 - w) * \[(10 P<sub>1</sub> + 6 P<sub>2</sub> + 3 P<sub>3</sub>) / 2400]

subject to: 

4 P<sub>1</sub> + 3 P<sub>2</sub> + 2 P<sub>3</sub> <= 1300		

3 P<sub>1</sub> + 2 P<sub>2</sub> + 2 P<sub>3</sub> <= 1000

P<sub>1</sub>, P<sub>2</sub>, P<sub>3</sub> >= 0

<div style="page-break-after: always;"></div>

# Problem 2

## Task 1

x<sub>1</sub> = 7

x<sub>2</sub> = 10



## Task 2

G1, G3 and G4 are met. 

G2 is not met as there is 16 hours of overtime labour used.



## Task 3

x<sub>1</sub> = 7

x<sub>2</sub> = 2

G1 is not met, as profits made is only \$32, which deviates from the target of \$48 by falling short of \$16.

G2 and G3 are met.

G4 is not met, as only 2 units of Marvel is produced, which deviates from the target of producing 10 units of Marvel, falling short by 8 units of Marvel.



## Task 4

![P2 T4 Plot 1](/Users/yingxuan/Documents/SUTD/Term 5/ESA/Homework/Homework 2/P2 T4 Plot 1.jpeg)

<div style="page-break-after: always;"></div>

# Problem 3

## Task 1

x = 3.141649 

y = 3.141344

f(x, y) = -0.9999999 



## Task 2

Objective function value = -0.9999999 

fitness function value = 0.9999999 


The two values mentioned above do not correspond as they have different signs, although same magnitude.

## Task 3

`maxiter = 10`

- objective function value = -0.8049161

`maxiter = 25`

- objective function value = -0.9983527 

`maxiter = 50`

- objective function value = -0.998918 

`maxiter = 75`

- objective function value = -0.9997483

`maxiter = 100`

- objective function value = -0.9999999



Objective function value converges to -1 as the maximum number of interations is increased.

<div style="page-break-after: always;"></div>

# R Script

## Problem 1

```R
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
```

<div style="page-break-after: always;"></div>

## Problem 2

```R
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

```



<div style="page-break-after: always;"></div>

## Problem 3

```R
rm(list=ls())
setwd("~/Documents/SUTD/Term 5/ESA/Homework/Homework 2")

if(!require(GA)) {
  install.packages("GA")
  library(GA)
}

# PROBLEM 3
f <- function(x1, x2) {
  -cos(x1)*cos(x2)*exp(-((x1-pi)^2 + (x2-pi)^2))
  }

x <- seq(-100, 100, by = 0.1)
y <- seq(-100, 100, by = 0.1)

GA <- ga(type = "real-valued",
           fitness = function(x) -f(x[1],x[2]),
           lower = c(-100, -100),
           upper = c(100, 100),
           popSize = 100,
           maxiter = 100)


summary(GA)
plot(GA)

GA@solution
f(GA@solution[1,1], GA@solution[1,2])
```



## 