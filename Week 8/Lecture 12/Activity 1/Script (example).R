

# Script -- example


######## Prepare the working environemnt

# Remove all variables from the R environment to create a fresh start
rm(list=ls())

# Set the working folder
setwd("~/Documents/SUTD/Term 5/ESA/Week 8/Lecture 12/Activity 1")

# Load one package
library(ggplot2)
## Install one package
# install.packages("ggplot2")


######## Load the data (Data frames)

# A data frame is a table or a two-dimensional array-like structure in which 
# each column contains values of one variable and each row contains one set of values from each column.
#
# Key characteristics:
# - The column names should be non-empty;
# - The row names should be unique;
# - The data stored in a data frame can be of numeric, factor, or character type;
# - Each column should contain the same number of data items.

# Create a data frame
n  <- c(2, 3, 5) 
s  <- c("aa", "bb", "cc") 
b  <- c(TRUE, FALSE, TRUE) 
df <- data.frame(n, s, b) 

# Built-in data frames
#
# Example: mtcars
data <- mtcars
head(data)
summary(data)
#
# Retrieve data
# --> use rows and columns
data[1,2] 
data["Mazda RX4", "cyl"]
# --> all elements within a column
data$cyl

