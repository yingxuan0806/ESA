

# Script for Activity 1 and 2 -- Lecture 13


######## Activity 1

# Remove all variables from the R environment to create a fresh start
rm(list=ls())

# Set the working folder -- FILL IN THE LINE BELOW
setwd("~/Documents/SUTD/Term 5/ESA/Week 8/Lecture 13")

# Load ggplot2
library(ggplot2)

# Import data from SugarcaneProduction.csv
mydata <- read.csv(file="SugarcaneProduction.csv")

# Visualize the data with a scatter plot -- FILL IN THE LINE BELOW
ggplot(data = mydata, 
       mapping = aes(x=Profit, y = Biodiversity)) + 
  geom_point(size=3) +
  coord_cartesian(xlim=c(9,14), ylim=c(6,16)) +
  labs(x="Profit [Million SGD]", y="Biodiversity [-]")

# Add the name associated to each point (from the column "Alternative") -- FILL IN THE LINE BELOW
ggplot(data = mydata, 
       mapping = aes(x = Profit, y=Biodiversity, label=Alternative)) + 
  geom_point(size=3) +
  geom_text(nudge_y = 0.3) + 
  coord_cartesian(xlim=c(9,14), ylim=c(6,16)) +
  labs(x="Profit [Million SGD]", y="Biodiversity [-]")

# alternative code to above, separating the aesthetic functions
# convention is to chunk all aesthetic functions together in mapping
# ggplot(data = mydata, 
#        mapping = aes(x = Profit, y=Biodiversity, label=Alternative)) + 
#   geom_point(size=3) +
#   geom_text(aes(label=Alternative), nudge_y = 0.3) + 
#   coord_cartesian(xlim=c(9,14), ylim=c(6,16)) +
#   labs(x="Profit [Million SGD]", y="Biodiversity [-]")

#
# From a graphical analysis, it emerges that:
# - C, B and D are efficient
# - D dominates A
# - D semi-dominates E

# Let's highlight the Pareto efficient solutions on the plot
#
# First, we create a new column in the data frame indicating which solutions are Pareto-efficient (and which ones are not) -- FILL IN THE LINE BELOW
mydata$Domination <- c("Dominated", "Pareto efficient", "Pareto efficient", "Pareto efficient", "Semi-dominated")
#
# Then, we give a different colour to the points depending on the value in the column "Domination" -- FILL IN THE LINE BELOW
g <- ggplot(data = mydata, 
       mapping = aes(x = Profit, y = Biodiversity, label = Alternative)) + 
  geom_point(aes(color=Domination), size=3) +
  geom_text(nudge_y = 0.3) + 
  coord_cartesian(xlim=c(9,14), ylim=c(6,16)) +
  labs(x="Profit [Million SGD]", y="Biodiversity [-]")

ggsave("Activity 1 Plot.pdf", g)

######## Activity 2

# First, we use the source() function to load ParetoSorting.R
source("ParetoSorting (student version).R")

# Let's double-check the input (output) required (returned) by the function ParetoSorting.R
ParetoSorting

# Prepare the input in the right format
input <- matrix(c(mydata$Profit,mydata$Biodiversity),nrow=5,ncol=2)

# Run the function -- FILL IN THE LINE BELOW
result <- ParetoSorting(input)
result
# output: [1] 1 0 0 0 1
# A and E are dominated

# Let's test the advanced version of paretoSorting -- FILL IN THE LINE BELOW
source("ParetoSorting_adv.R")
result <- ParetoSorting_adv(...)
result
# ...
# ...


