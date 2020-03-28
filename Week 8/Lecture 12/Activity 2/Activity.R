

# Script for Activity 2 (Shiny) -- Lecture 12


######## Prepare the working environemnt

# Remove all variables from the R environment to create a fresh start
rm(list=ls())

# Set the working folder
# setwd("/Volumes/DATA/Dropbox/Engineering Systems Architecture -- Spring 2020/Lectures/Lecture 12/2. Activity/RShiny")
setwd("~/Documents/SUTD/Term 5/ESA/Week 8/Lecture 12/Activity 2")

# Install or load shiny
if(!require(shiny)){
  install.packages("shiny")
  library(shiny)
}


######## Run the app.R ("Hello World")

# The first argument of runApp is the filepath from your working directory to the app’s directory.
runApp("App-1")







