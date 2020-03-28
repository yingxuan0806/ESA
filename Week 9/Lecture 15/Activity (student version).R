

# Script for Activity -- Lecture 15 (student's version)


######## Load data and packages

# Remove all variables from the R environment to create a fresh start
rm(list=ls())

# Set the working folder -- FILL IN THE LINE BELOW
setwd("~/Documents/SUTD/Term 5/ESA/Week 9/Lecture 15")

# Import data from EngineDesign.csv
mydata <- read.csv(file="EngineDesign.csv", head=TRUE)


######## Activity 

# Determine the 'best' solution according to the Lexicographic method
# -> we simply have to look for the minimum (or maximum) value of each objective -- FILL IN THE LINES BELOW 
# Horsepower (to be maximized)
max(mydata[,1]) # 0.679458
which.max(mydata[,1]) # 10
# Cost (to be minimized)
min(mydata[,2]) # 0.014658
which.min(mydata[,2]) # 43
# Fuel.efficiency (to be maximized)
max(mydata[,3]) # 0.74487
which.max(mydata[,3]) # 4


# Determine the best solution according to the Utopia point method

# First, we identify the Pareto-efficient solutions (we want to carry out the analysis only for the non-dominated solution)
input <- matrix(c(mydata$Horsepower,mydata$Cost*(-1),mydata$Fuel.efficiency),nrow=43,ncol=3)
source("ParetoSorting_adv.R")
result <- ParetoSorting_adv(input,"MAX") # We use the ParetoSorting_adv function to identify the non-dominated solutions (denoted with 0)
index <- which(result==0) # We store in a vector the index of the Pareto-efficient solutions

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

# We calculate the distance between each solution and the Utopia point, and we find the point with the minimum distance
# We have to do this only for the Pareto-efficient solutions -- FILL IN THE LINES BELOW  
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
#
# Plot
ggplot(data = df, 
       mapping = aes(x=Horsepower, y = Cost, size = Fuel.efficiency)) + 
  geom_point(aes(colour=cat)) + 
  coord_cartesian(xlim=c(0,1), ylim=c(0,1)) +
  labs(x="Horsepower", y="Cost")

