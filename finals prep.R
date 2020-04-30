rm(list=ls())
setwd("~/Documents/SUTD/Term 5/ESA/Finals")

if(!require(ggplot2)){
  install.packages("ggplot2")
  library(ggplot2)
}
if(!require(rgl)){
  install.packages("rgl")
  library(rgl)
}
if(!require(GGally)){
  install.packages("GGally")
  library(GGally)
}
if(!require(fmsb)){
  install.packages("fmsb")
  library(fmsb)
}
if(!require(lpSolve)){
  install.packages("lpSolve")
  library(lpSolve)
}
if(!require(GA)){
  install.packages("GA")
  library(GA)
}
if(!require(nsga2R)){
  install.packages("nsga2R")
  library(nsga2R)
}


# import data
mydata <- read.csv(file="EngineDesign.csv")

# Pareto Sorting W9 L14

# use the source() function to load ParetoSorting.R 
source("ParetoSorting_adv.R")

# Prepare the input in the right format
input_adv <- matrix(c(mydata$Horsepower, mydata$Cost*(-1), mydata$Fuel.efficiency), nrow = nrow(mydata), ncol = ncol(mydata))

# Run the function -- FILL IN THE LINE BELOW
result_adv <- ParetoSorting_adv(input_adv, "MAX")
result_adv

# 1: dominated
# 0: not dominated

# dominated count
dominated_count <- length(which(result == 1))
dominated_count
# dominated count: 678

# not dominated count
notdominated_count <- length(which(result == 0))
notdominated_count
# non-dominated count: 475


# function to create list stating string "dominated" or "pareto-efficient"
d_function <- function(list_input) {
  result_list <- c()
  for (i in 1:length(list_input)) {
    if (list_input[i] == 1) {
      name <- "Dominated"
    } else {
      name <- "Non-dominated"
    }
    result_list <- c(result_list, name)
  }
  return(result_list)
}

domination_list <- d_function(result)
domination_list

# Add column to data table
mydata$Dominance <- domination_list


# Method 2 - prof's method
mydata$Dominance_adv <- as.character(result_adv)
# Then, we give a different colour to the points depending on the value in the column "Dominance"
# this plot has both by size and colour
a_plot6 <- ggplot(data = mydata, 
                  mapping = aes(x = Horsepower, y = Cost, size = Fuel.efficiency)) + 
  geom_point(aes(color = Dominance_adv)) + # Note that we removed "size = 3"
  coord_cartesian(xlim=c(0.2,0.8), ylim=c(0,0.2)) +
  labs(title = "Activity 1a Plot 6", x="Horsepower", y="Cost", caption = "EngineDesign.csv") +
  scale_colour_manual(values = c("Black","Red"),labels=c("Non-Dominated Alternatives","Dominated Alternatives"))


# Choosing a solution W9 L15

# Lexicographic method
# look for the minimum (or maximum) value of each objective
# Horsepower (to be maximized)
max(mydata[,1]) # 0.679458
# returns index
which.max(mydata[,1]) # 10
# Cost (to be minimized)
min(mydata[,2]) # 0.014658
which.min(mydata[,2]) # 43

# utopia point method
# identify the Pareto-efficient solutions (only carry out analysis for the non-dominated solution)
input <- matrix(c(mydata$Horsepower,mydata$Cost*(-1),mydata$Fuel.efficiency),nrow=43,ncol=3)
source("ParetoSorting_adv.R")
result <- ParetoSorting_adv(input,"MAX") # We use the ParetoSorting_adv function to identify the non-dominated solutions (denoted with 0)

# list of non-dominated solutions
index <- which(result==0) # We store in a vector the index of the Pareto-efficient solutions

# method 1
# Second, we find the coordinates of the Ideal (Utopia) and Nadir objective vector 
# (we look for the minimum and maximum value of the objective functions only for the efficient solutions)
Utopia <- c(max(input[index,1]),max(input[index,2]),max(input[index,3])) # 0.679458 -0.014658  0.744870
Nadir  <- c(min(input[index,1]),min(input[index,2]),min(input[index,3])) # 0.348350 -0.162701  0.709748

# Third, we normalize the data (since the objectives have a different range of variation). Let's normalize only the Pareto-efficient solutions -- FILL IN THE LINES BELOW 
obj1_norm <- (input[index,1]-min(input[index,1]))/(max(input[index,1])-min(input[index,1]))
obj2_norm <- (input[index,2]-min(input[index,2]))/(max(input[index,2])-min(input[index,2]))
obj3_norm <- (input[index,3]-min(input[index,3]))/(max(input[index,3])-min(input[index,3]))

# The coordinates of the Utopia point for the normalised data are 1 1 1. Let's double-check this ...
Utopia_norm <- c(max(obj1_norm),max(obj2_norm),max(obj3_norm)) # 1 1 1

# Ccalculate the distance between each solution and the Utopia point, and we find the point with the minimum distance
# Do this only for the Pareto-efficient solutions -- FILL IN THE LINES BELOW  
Distance <- rep(0,times=40)
for (i in 1:40){
  Distance[i] <- sqrt((obj1_norm[i] - Utopia_norm[1])^2 + (obj2_norm[i] - Utopia_norm[2])^2 + (obj3_norm[i] - Utopia_norm[3])^2)
}

plot(Distance)
min(Distance) # 0.4240861
which.min(Distance) # 28
index[28] # closet solution to the Utopia point: value of 30

# Finally, Let's visualize this solution, along with the set of all solutions and the Utopia point -- FILL IN THE LINES BELOW
#
# Load ggplot2
library(ggplot2)
#
# Create data frames for the visualization
newdata <- data.frame(Horsepower=obj1_norm,Cost=obj2_norm,Fuel.efficiency=obj3_norm)
newdata_utopia <- data.frame(Horsepower=1,Cost=1,Fuel.efficiency=1)
newdata_sel_point <- data.frame(Horsepower=obj1_norm[28],Cost=obj2_norm[28],Fuel.efficiency=obj3_norm[28])
newdata$cat <- "Pareto-eff. sol."
newdata_utopia$cat <- "Utopia point"
newdata_sel_point$cat <- "Selected sol."
df <- rbind(newdata, newdata_utopia, newdata_sel_point)


# clearer method 2 (minimisation)
# Utopia vector
utopia_fatigue <- min(dataset[index, 1])
utopia_crashes <- min(dataset[index, 2])
utopia_disruptions <- min(dataset[index, 3])
utopia_vector <- c(utopia_fatigue, utopia_crashes, utopia_disruptions)

# Nadir vector
nadir_fatigue <- max(dataset[index, 1])
nadir_crashes <- max(dataset[index, 2])
nadir_disruptions <- max(dataset[index, 3])
nadir_vector <- c(nadir_fatigue, nadir_crashes, nadir_disruptions)

# normalise non-dominated set of solutions
fatigue_norm <- (dataset[index, 1] - utopia_fatigue) / (nadir_fatigue - utopia_fatigue)
crashes_norm <- (dataset[index, 2] - utopia_crashes) / (nadir_crashes - utopia_crashes)
disruptions_norm <- (dataset[index, 3] - utopia_disruptions) / (nadir_disruptions - utopia_disruptions)

# check normality
utopia_norm <- c(min(fatigue_norm), min(crashes_norm), min(disruptions_norm))

distance <- rep(0, times = notdominated_count)
for (i in 1:notdominated_count) {
  distance[i] <- sqrt((fatigue_norm[i] - utopia_norm[1])^2 + (crashes_norm[i] - utopia_norm[2])^2 + (disruptions_norm[i] - utopia_norm[3])^2)
}
min_dist <- min(distance)
# min_dist 0.3555774
index_min_dist <- which.min(distance)
# 403th row value in the set of non-dominated solutions
index[403]
# 1065th solution in the entire dataset


new_norm_data <- data.frame(Fatigue = fatigue_norm, Crashes = crashes_norm, Disruptions = disruptions_norm)
utopia <- data.frame(Fatigue = 0, Crashes = 0, Disruptions = 0)
selected <- data.frame(Fatigue = fatigue_norm[403], Crashes = crashes_norm[403], Disruptions = disruptions_norm[403])

new_norm_data$cat <- "Pareto-efficient Solution"
utopia$cat <- "Utopia Point"
selected$cat <- "Selected Solution"

# rbind into df for ggplot
df <- rbind(new_norm_data, utopia, selected)
# use color to put legend in ggplot to identify the different types of solutions

# radar plot
max_val <- c(1, 1, 1)
min_val <- c(0, 0, 0)
selected_point <- selected[, 1:3]

radar_data <- rbind(max_val, min_val, selected[, 1:3])
t10_plot1 <- radarchart(df = radar_data, title = "Task 10 Plot 1: Best Alternative")
legend(1, 1, lty = c(1, 2), lwd = c(2.5, 2.5), col = c("black"), c("Best Alternative"), cex = 0.4)


# Generating multiple P solutions: A Posteriori W10 L16

# epsilon constraint method
# Define inputs for the function lp
f.obj_eps <- c(7750, 3250, 2250, 1050, 90)
con_1_eps <- c(248, 206.375, 102.9375, 62.2125, 18.045)
con_2_eps <- c(0, 2.6, 0.7875, 0, 0)
con_3_eps <- c(5.8125, 30.0625, 9.5625, 0.525, 0.045)
con_4_eps <- c(0, 1, 0, 0, 0)
con_5_eps <- c(0, 0, 1, 0, 0)
con_6_eps <- c(0, 0, 0, 1, 0)
con_7_eps <- c(0, 0, 0, 0, 1)
con_8_eps <- c(1, 0, 0, 0, 0)
f.con_eps <- rbind(con_1_eps, con_2_eps, con_3_eps, con_4_eps, con_5_eps, con_6_eps, con_7_eps, con_8_eps)
f.dir_eps <- c("<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=")
epsilon <- c(0:13)
#
# Create a for loop to solve all problems for the different values of epsilon 
# We initialise two matrices to store the values of objective functions and decision variables
# 2 columns, one for each objective, 14 rows for each instance of the objective to solve (epsilon 0 to 13)
# the two objectives are: maximise power production and minimise number of nuclear plants
objval_eps <- matrix( c(rep(0,14*2)), nrow =14, byrow=TRUE)
obj_val_eps <- matrix(0, nrow = length(epsilon), ncol = 2)


# to keep track of the value of each objective value of the 14 epsilon values
decvar_eps <- matrix( c(rep(0,14*5)), nrow =14, byrow=TRUE)
dec_var_eps <- matrix(0, nrow = length(epsilon), ncol = length(f_obj))

for (i in 1:14){
  # define the numerical value of the constraint epsilon -- FILL IN THE LINE BELOW
  f.rhs_eps <- c(3400, 20, 250, 20, 20, 30, 100, epsilon[i])
  # solve the optimization problem
  result <- lp ("max", f.obj_eps, f.con_eps, f.dir_eps, f.rhs_eps, all.int=TRUE)
  # save the value of objective functions and decision variables
  objval_eps[i,1] <- result$objval
  objval_eps[i,2] <- epsilon[i]
  decvar_eps[i,]  <- result$solution
}

# Plot objective space
b_plot1 <- ggplot(data = data.frame(Power.Generation=objval_eps[,1], Nuclear.Plants=objval_eps[,2]), 
                  mapping = aes(x = Power.Generation, y = Nuclear.Plants)) + 
  geom_point(size=3) +
  coord_cartesian(xlim=c(60*10^3,110*10^3), ylim=c(0,15)) +
  labs(x="Power generation [GWh]", y="Number of nuclear plants [-]")
b_plot1

# Plot decision space 
# It is difficult to use a scatter plot, because we have 5 decision variables. 
# use parallel coordinate plot
b_plot2 <- ggparcoord(data.frame(Nuclear=decvar_eps[,1],Coal=decvar_eps[,2],CCGT=decvar_eps[,3], Wind=decvar_eps[,4], Solar=decvar_eps[,5]), 
                      columns = 1:5, groupColumn = "Nuclear", scale = "uniminmax")
# constraint was on number of nuclear plants so the group column was used as visualisation aid


# weighting method

# First, we have to normalize them. To simplify the algebraic operations, we simply divide each objective by the range of variability.
# --> lambda*((7750 X1 + 3250 X2 + 2250 X3 + 1050 X4 + 90 X5)/(104,050-67,150)) + (1-lambda)((-X1)/(13-0)) =
#     lambda*((7750 X1 + 3250 X2 + 2250 X3 + 1050 X4 + 90 X5)/(36,900)) + (1-lambda)((-X1)/13) =
# Then, we rewrite the equation in order to make it suitable for the lp function
# --> X1*(lambda*(7750/36900)+lambda/13-1/13) + X2*lambda*(3250/36900) + X3*lambda*(2250/36900) + X4*lambda*(1050/36900) + X5*lambda*(90/36900)

# Define inputs for the function lp
f.con_weight <- f.con_1
f.dir_weight <- f.dir_1
f.rhs_weight <- f.rhs_1
lambda <- c(0:10/10)
#


# We create a for loop to solve all problems for the different values of lambda and
# we initialise two matrices to store the values of objective functions and decision variables
objval_weight <- matrix( c(rep(0,2*11)), nrow =11, byrow=TRUE)
decvar_weight <- matrix( c(rep(0,5*11)), nrow =11, byrow=TRUE)
for (i in 1:11){
  # define the coeffcients of the objective function (as a function of lambda) -- FILL IN THE LINE BELOW
  f.obj_weight <- c(lambda[i] * (7750/36900) + lambda[i]/13-1/13, lambda[i] * (3250/36900), lambda[i] * (2250/36900), lambda[i] * (1050/36900), lambda[i] * (90/36900))
  # solve the optimization problem
  result <- lp ("max", f.obj_weight, f.con_weight, f.dir_weight, f.rhs_weight, all.int=TRUE)
  # save the value of objective functions and decision variables
  objval_weight[i,1] <- sum(result$solution*c(7750, 3250, 2250, 1050, 90))
  objval_weight[i,2] <- result$solution[1]
  decvar_weight[i,]  <- result$solution
}
#
# Finally, we plot the solutions in both objective and decision space
#
# Objective space
c_plot1 <- ggplot(data = data.frame(Power.Generation=objval_weight[,1], Nuclear.Plants=objval_weight[,2]), 
                  mapping = aes(x = Power.Generation, y = Nuclear.Plants)) + 
  geom_point(size=3) +
  coord_cartesian(xlim=c(60*10^3,110*10^3), ylim=c(0,15)) +
  labs(x="Power generation [GWh]", y="Number of nuclear plants [-]")

# most upper right data point represents lambda = 1
# ie. giving entire weight to power generation
# most lower left data point represents lambda = 0
# ie. giving entire weight to number of nuclear of power plants
# middle data point some lambda value representingng the trade-off between the two objectives
# ie. different weights giving same objective value function

# Decision space 
# It is difficult to use a scatter plot, because we have 5 decision variables. 
# Let's try with a parallel coordinate plot
c_plot2 <- ggparcoord(data.frame(Nuclear=decvar_weight[,1],Coal=decvar_weight[,2],CCGT=decvar_weight[,3], Wind=decvar_weight[,4], Solar=decvar_weight[,5]), 
                      columns = 1:5, groupColumn = "Nuclear", scale = "uniminmax")



# Generating multiple P solutions: A Priori W10 L17

# lexicographic goal programming (priority levels)

# Rewrite the problem formulation to account for the relative importance of all goals
# ie. rewrite the same objective twice but with two deviation variables to split up the priority of one single objective 
# (becomes 2 partial objectives)

# Minimize [5 n1, 4 n2, 3 p3, 2 p4]
# subject to:
# 12 P1 + 9 P2 + 15 P3 - p1 + n1 = 125
# 5 P1 + 3 P2 + 4 P3 - p2 + n2 = 40
# 5 P1 + 7 P2 + 8 P3 - p3 + n3 = 55
# 5 P1 + 3 P2 + 4 P3 - p4 + n4 = 40
# P1, P2, P3 >= 0
# n1, n2, n3, n4 >= 0
# p1, p2, p3, p4 >= 0

# To set up the problem with goalprog, we must define three variables
#
# A matrix of coefficients for the linear objective functions
# without coefficients of positive and negative deviation variables
coefficients_1a <- matrix (c(12, 9, 15, 5, 3, 4, 5, 7, 8, 5, 3, 4), nrow=4, byrow=TRUE)
# A vector of target values for the objective functions
# ie. RHS value of constraints
targets_1a <- c(125, 40, 55, 40)
# A data frame with the deviation variables for each objective together with the priority level
objective_1a <- c(1, 2, 3, 4)     # index for a particular problem object
priority_1a <- c(1, 2, 3, 4)      # level to which the row (i.e. objective) is assigned 
# priority level based on objective: first value of vector referring to first objective (goal)
# based on coefficient of objective function
p_1a <- c(0, 0, 3, 2)             # penalty associated with the positive deviation variable
n_1a <- c(5, 4, 0, 0)             # penalty associated with the negative deviation variable

priority_1a2 <- c(1, 2, 3, 2) # giving second priority to both second and fourth goal

# if penalty value is not given, use binary 0 and 1 to indicate existence of penalty
achievements_1a <- data.frame(objective=objective_1a, priority=priority_1a, p=p_1a, n=n_1a)

# To solve the problem, we use the function llgp
soln_1a <- llgp(coefficients_1a, targets_1a, achievements_1a)

# Finally, we retrieve the most interesting aspect of the solution 
out_1a <- llgpout(soln_1a$tab, coefficients_1a, targets_1a)
#
# Decision variables
# X
# X1   8.333333e+00
# X2   0.000000e+00
# X3   1.666667e+00
# 
# Summary of objectives
# Objective           Over          Under         Target
# G1   1.250000e+02   0.000000e+00   0.000000e+00   1.250000e+02
# G2   4.833333e+01   8.333333e+00   0.000000e+00   4.000000e+01
# G3   5.500000e+01   0.000000e+00   0.000000e+00   5.500000e+01
# G4   4.833333e+01   8.333333e+00   0.000000e+00   4.000000e+01
# 
# 
# G1: exactly hit the target (both over and under are 0)
# G2: go slightly over but did not go under, which is the most important thing (did not go under)
# (because goal was to minimise negative deviation n2)
# G3: exactly hit targets
# G4: went over target slightly
# 
# able to meet the first three goals, and not the last one
# ie. only paying penalty for the fourth goal (shown in achievements below)

# Achievement function
# indicates the penalty we are paying
# A
# P1   0.000000e+00
# P2   0.000000e+00
# P3   0.000000e+00
# P4   1.666667e+01
# amount of penalty paying for P4: 2 * the deviation 8.333333e+00 (from summary above) = 1.666667e+01

# Finally, we do a graphical comparison of the decisions and objective functions for all problems
#
# Load the package for radar charts 
library(fmsb)   

# Objective functions -- FILL IN THE LINES BELOW
# b represents the target values
# f represents objective value functions obtained
# x represnts value of decision variables
# n represents values of negative deviation variables
# p represents values of positive deviation variables
# a represents value of achievement functions

# Decision variables
mydata_sol_1a <- data.frame(X1=c(out_1a$x[1],out_1a2$x[1],out_1a3$x[1]), 
                            X2=c(out_1a$x[2],out_1a2$x[2],out_1a3$x[2]), 
                            X3=c(out_1a$x[3],out_1a2$x[3],out_1a3$x[3]))
# To use the fmsb package, we have to add 2 lines to the dataframe: the max and min of each topic to show on the plot!
mydata_sol_1a =  rbind(c(8.5,3,6),c(0,0,0),mydata_sol_1a)
radarchart(mydata_sol_1a)
legend(1,1,lty=c(1,1),lwd=c(2.5,2.5),col=c("black","green","red"),c("Alternative 1","Alternative 2","Alternative 3"),cex=0.8)

# compare values of objective functions
# absolute difference between target value and attained objective value function
mydata_obj_1a <- data.frame(J1=c(abs(out_1a$b[1]-out_1a$f[1]),
                                 abs(out_1a2$b[1]-out_1a2$f[1]),
                                 abs(out_1a3$b[1]-out_1a3$f[1])), 
                            J2=c(abs(out_1a$b[2]-out_1a$f[2]),
                                 abs(out_1a2$b[2]-out_1a2$f[2]),
                                 abs(out_1a3$b[2]-out_1a3$f[2])), 
                            J3=c(abs(out_1a$b[3]-out_1a$f[3]),
                                 abs(out_1a2$b[3]-out_1a2$f[3]),
                                 abs(out_1a3$b[3]-out_1a3$f[3])))
# To use the fmsb package, we have to add 2 lines to the dataframe: the max and min of each topic to show on the plot!
mydata_obj_1a =  rbind(c(2, 9, 8), c(0, 0, 0), mydata_obj_1a) 
radarchart(mydata_obj_1a)
legend(1,1,lty=c(1,1),lwd=c(2.5,2.5),col=c("black","green","red"),c("Alternative 1","Alternative 2","Alternative 3"),cex=0.8)


# weighted goal programming
# code differences with lexicographic method:
# 1. assign same priority to all goals as there will be weights introduced
priority_1b <- c(1, 1, 1, 1)      # level to which the row (i.e. objective) is assigned

# 2. assign weights
# weight associated with the specific priority level
w_1b <- c(4, 3, 1, 2)             

# 3. add weight component to achievement function
achievements_1b <- data.frame(objective=objective_1b, priority=priority_1b, p=p_1b, n=n_1b, w=w_1b)

# To solve the problem, we use the function llgp
soln_1b <- llgp(coefficients_1b, targets_1b, achievements_1b)

# Finally, we retrieve the most interesting aspect of the solution
out_1b <- llgpout(soln_1b$tab, coefficients_1b, targets_1b)


# Genetic Algorithm W11 L19

# binary genetic algorithm

# Define data 
p <- c(6, 5, 8, 9, 6, 7, 3) # Value 
w <- c(2, 3, 6, 7, 5, 9, 4) # Weights 
W <- 9                      # Knapsack ’s capacity 
n <- length(p)              # Number of items

# Define the fitness function. Note that we add a penalty to account for the constraint on the Knapsack capacity. 
# in this case, fitness is the sum of each decision variable (0 or 1) * the corresponding value
# calculate the fitness given a value of the decision variable
knapsack <- function(x) { 
  f <- sum(x * p) 
  # abs portion is to account for the fact that the capacity of knapsack may be violated
  penalty <- sum(w) * abs(sum(x * w) - W) 
  f - penalty 
}

# Run SGA
SGA <- ga(type="binary",     # We use this option for binary decision variables
          fitness=knapsack,  # We use the function'knapsack' to calculate the fitness value
          nBits=n,           # Length of the bit string
          maxiter=100,       # The maximum number of iterations to run before the GA search is halted. 
          popSize=100)      # The population size

# best represents the best out of all finished iterations

# Use this function to analyze the results and the main settings of the GA
summary(SGA)


# 1D real-valued function optimisation

# Define the function and the range of variability
f <- function(x)  (cos(x) + x^3) * sin(x)
min <- 0; max <- 20

# Solve with GA and analyze the solution. Note that the GA function maximizes by default!
# To solve the problem, we use 50 individuals and 100 generations
GA_1a <- ga(type = "real-valued", fitness = function(x) -f(x), lower = min, upper = max, popSize = 50, maxiter = 100)

# after 10 iterations or so it converges (ie. optimised)
# Use this function to analyze the results and the main settings of the GA
summary(GA_1a)
# Graphical illustration of the search process
plot(GA_1a)

# Solution
GA_1a@solution # 17.4492    
f(GA_1a@solution)        # -5236.023
# Note that the solution varies slightly if we re-run the GA. That's because some steps of the search process are randomized.

# Graphically check the optimality of the solution
curve(f, min, max, n = 1000)
points(GA_1a@solution, -GA_1a@fitnessValue, col = 2, pch = 19)


# 2D real-valued function opmisation (no constraint)


# Define the function
# bivariate 2D function
Rastrigin <- function(x1, x2)
{ 20 + x1^2 + x2^2 - 10 * (cos(2*pi*x1) + cos(2*pi*x2)) }

# Visualize the function (3D view)
x1 <- x2 <- seq(-5.12, 5.12, by = 0.1)
f <- outer(x1, x2, Rastrigin)
persp3D(x1, x2, f, theta = 50, phi = 20, color.palette = bl2gr.colors)
# lots of local minima and maxima, hence finding an optimised value is not trivial

# Visualize the function (2D view)
filled.contour(x1, x2, f, color.palette = bl2gr.colors)
# there is plenty of local minima and maxima

# Solve with GA and analyze the solution. Note that the GA function maximizes by default! -- FILL IN THE LINE BELOW
GA_1b <- ga(type = "real-valued", 
            fitness =  function(x) - Rastrigin(x[1], x[2]), # - in front of Rastrigin because by default GA runs maximisation
            lower = c(-5.12, -5.12), 
            upper = c(5.12, 5.12), 
            popSize = 50,      
            maxiter = 1000)   # Let's increase the number of generations

# Use this function to analyze the results and the main settings of the GA
summary(GA_1b)
# Graphical illustration of the search process
plot(GA_1b)

# Solution
GA_1b@solution            
# x1            x2
# -1.15633e-05 -2.980232e-05
Rastrigin(GA_1b@solution[,1], GA_1b@solution[,2]) 
# x1 
# 2.027346e-07 

# Note that the solution varies slightly if we re-run the GA. That's because some steps of the search process are randomized.
GA_1b <- ga(type = "real-valued", fitness =  function(x) -Rastrigin(x[1], x[2]), 
            lower = c(-5.12, -5.12), upper = c(5.12, 5.12), 
            popSize = 50, maxiter = 1000,
            seed = 10)

# Reproducibility of simulation: set seed
# seed to ensure results are reproducible


# 2D constrained function optimisation (real-valued)

# Define the function and the constraints
# objective functions and all constraints are defined as individual functions
f <- function(x)
{100 * (x[1]^2 - x[2])^2 + (1 - x[1])^2}

c1 <- function(x) 
{ x[1]*x[2] + x[1] - x[2] + 1.5 }
c2 <- function(x) 
{ 10 - x[1]*x[2] }


# Define a penalized fitness function to handle the constraints
fitness <- function(x) 
{ 
  f <- -f(x)                         # we need to maximize -f(x)
  pen <- sqrt(.Machine$double.xmax)  # penalty term
  penalty1 <- max(c1(x),0)*pen       # penalisation for 1st inequality constraint
  penalty2 <- max(c2(x),0)*pen       # penalisation for 2nd inequality constraint
  f - penalty1 - penalty2            # fitness function value
}

# Solve with GA and analyze the solution. Note that the GA function maximizes by default!
GA_1c <- ga("real-valued", fitness = fitness, 
            lower = c(0,0), upper = c(1,13), 
            maxiter = 1000, seed = 10)

# Use this function to analyze the results and the main settings of the GA
summary(GA_1c)
# Graphical illustration of the search process
plot(GA_1c)

# Solution
GA_1c@solution            
# x1       x2
# [1,] 0.8121198 12.31369

f(c(0.8121198, 12.32369))
# 13605.28


# two different ways of defining multivariate objective functions
f <- function(x1, x2) {
  -cos(x1)*cos(x2)*exp(-((x1-pi)^2 + (x2-pi)^2))
}

g <- function(x) {
  -cos(x[1])*cos(x[2])*exp(-((x[1]-pi)^2 + (x[2]-pi)^2))
}

GA_f <- ga(type = "real-valued",
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

summary(GA_3)
plot(GA_3)

GA_3@solution
f(GA_3@solution[1,1], GA_3@solution[1,2])



# Genetic Algorithm NSGA-II   W12 L20
# Define the objective function 
Viennet  <- function(x){
  f1 <- 0.5*(x[1]^2+x[2]^2)+sin(x[1]^2+x[2]^2)
  f2 <- ((3*x[1]-2*x[2]+4)^2)/8 + ((x[1]-x[2]+1)^2)/27 + 15
  f3 <- (1/(x[1]^2+x[2]^2+1)) - 1.1*exp(-(x[1]^2+x[2]^2)) 
  return(c(f1,f2,f3))
}

# Set number of individuals and generations
numIndividuals <- 100
totalGen <- 100

# Note: NSGA2 minimizes all objective functions!

# Run NSGA2 
results <- nsga2R(fn = Viennet, varNo = 2, objDim = 3, 
                  lowerBounds = rep(-3, 2), upperBounds = rep(3, 2), 
                  popSize = numIndividuals, generations = totalGen)

# Analyze the results
results$parameters        # Value of the decision variables
results$objectives        # Objective function values
results$paretoFrontRank   # Index denoting whether one solution is efficient (1 -> Pareto efficient; 0 -> otherwise)




