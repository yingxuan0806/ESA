#Homework 1
rm(list=ls())
setwd("~/Documents/SUTD/Term 5/ESA/Homework/Homework 1")
library(ggplot2)
library(GGally)

dataset <- read.csv(file="Tour_de_France.csv")

# Task 1: three 2D scatter plots

# Scatter Plot 1: Fatigue against Crashes
t1_plot1 <- ggplot(data = dataset, mapping = aes(x = Fatigue, y = Crashes)) +
  geom_point() +
  labs(title = "Task 1 Scatter Plot 1: Fatigue vs Crashes", x = "Fatigue", y = "Crashes", caption = "Tour_de_France.csv") +
  geom_smooth(method = 'lm', color = 'blue')
t1_plot1
ggsave("T1 Plot1.pdf", t1_plot1)

# Scatter Plot 2: Fatigue against Disruptions
t1_plot2 <- ggplot(data = dataset, mapping = aes(x = Fatigue, y = Disruptions)) +
  geom_point() +
  labs(title = "Task 1 Scatter Plot 2: Fatigue vs Disruptions", x = "Fatigue", y = "Disruptions", caption = "Tour_de_France.csv") +
  geom_smooth(method = 'lm', color = "blue")
t1_plot2  
ggsave("T1 Plot2.pdf", t1_plot2)

# Scatter Plot 3: Crashes against Disruptions
t1_plot3 <- ggplot(data = dataset, mapping = aes(x = Crashes, y = Disruptions)) +
  geom_point() +
  labs(title = "Task 1 Scatter Plot 3: Crashes vs Disruptions", x = "Crashes", y = "Disruptions", caption = "Tour_de_France.csv") +
  geom_smooth(method = 'lm', color = "blue")
t1_plot3
ggsave("T1 Plot3.pdf", t1_plot3)



# Task 3
# Plot: Fatigue vs Crashes, Disruptions (colour)
t3_plot1 <- ggplot(data = dataset, mapping = aes(x = Fatigue, y = Crashes, colour = Disruptions)) +
  geom_point() +
  labs(title = "Task 3 Scatter Plot: Fatigue (x-axis) vs Crashes (y-axis) vs Disruptions (colour)", x = "Fatigue", y = "Crashes", caption = "Tour_de_France.csv")
t3_plot1
ggsave("T3 Plot1.pdf", t3_plot1)



#Task 5
source("ParetoSorting_adv.R")

# data in matrix form to input into pareto sorting function
# N x M matrix with N alternatives (rows) and M objectives (columns)
matrix_input <- matrix(c(dataset$Fatigue, dataset$Crashes, dataset$Disruptions), nrow = nrow(dataset), ncol = ncol(dataset))

result <- ParetoSorting_adv(matrix_input, "MIN")
result

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



# Task 6
t6_plot1 <- ggparcoord(data = data.frame(Fatigue = dataset[,1], Crashes = dataset[,2], Disruptions = dataset[,3], Dominance = as.factor(result)),
                       columns = 1:3,
                       title = "Task 6 Plot 1: Parallel Plot",
                       scale = "uniminmax",
                       groupColumn = "Dominance")
t6_plot1
ggsave("T6 Plot1.pdf", t6_plot1)



# Task 7
# Utopia vector




# Nadir vector
