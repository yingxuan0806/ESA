

# Script for Activity 1 and 2 -- Lecture 13


######## Activity 1

# Remove all variables from the R environment to create a fresh start
rm(list=ls())

# Set the working folder
setwd("/Volumes/DATA/Dropbox/Engineering Systems Architecture -- Spring 2020/Lectures/Lecture 13/Activity")

# Load ggplot2
library(ggplot2)

# Import data from SugarcaneProduction.csv
mydata <- read.csv(file="SugarcaneProduction.csv")

# Visualize the data with a scatter plot
ggplot(data = mydata, 
       mapping = aes(x = Profit, y = Biodiversity)) + 
  geom_point(size=3) +
  coord_cartesian(xlim=c(9,14), ylim=c(6,16)) +
  labs(x="Profit [Million SGD]", y="Biodiversity [-]")
#
# Add the name associated to each point (from the colum "Alternative")
ggplot(data = mydata, 
       mapping = aes(x = Profit, y = Biodiversity, label = Alternative)) + 
  geom_point(size=3) +
  geom_text(size=5, hjust=-1, vjust=-1) + 
  coord_cartesian(xlim=c(9,14), ylim=c(6,16)) +
  labs(x="Profit [Million SGD]", y="Biodiversity [-]")
#
# From a graphical analysis, it emerges that:
# - D dominates A 
# - D semi (dominates) E
# - C, B, and D are Pareto efficient

# Let's highlight the Pareto efficient solutions on the plot
#
# First, we create a new column in the data frame indicating which solutions are Pareto-efficient (and which ones are not)
mydata$Domination <- c("Dominated","Pareto-efficient","Pareto-efficient","Pareto-efficient","Dominated")
#
# Then, we give a different colour to the points depending on the value in the column "Domination"
ggplot(data = mydata, 
       mapping = aes(x = Profit, y = Biodiversity, label = Alternative)) + 
  geom_point(aes(color = Domination), size=3) +
  geom_text(size=5, hjust=-1, vjust=-1) + 
  coord_cartesian(xlim=c(9,14), ylim=c(6,16)) +
  labs(x="Profit [Million SGD]", y="Biodiversity [-]")


######## Activity 2

# First, we use the source() function to load ParetoSorting.R
source("ParetoSorting.R")

# Let's double-check the input (output) required (returned) by the function Pareto.Sorting.R
ParetoSorting

# Prepare the input in the right format
input <- matrix(c(mydata$Profit,mydata$Biodiversity),nrow=5,ncol=2)

# Run the function
result <- ParetoSorting(input)
result
# [1] 1 0 0 0 1
# The first and last alternatives (A and E) are dominated!

# Let's test the advanced version of paretoSorting
source("ParetoSorting_adv.R")
result <- ParetoSorting_adv(input,"MAX")
result
# [1] 1 0 0 0 1
# The first and last alternatives (A and E) are dominated!

