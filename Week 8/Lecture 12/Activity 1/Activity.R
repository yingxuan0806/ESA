

# Script for Activity 1 (ggplot2) -- Lecture 12


######## Prepare the working environemnt

# Remove all variables from the R environment to create a fresh start
rm(list=ls())

# Set the working folder
# setwd("/Volumes/DATA/Dropbox/Engineering Systems Architecture -- Spring 2020/Lectures/Lecture 12/2. Activity/R")
setwd("~/Documents/SUTD/Term 5/ESA/Week 8/Lecture 12/Activity 1")


# With this command, we check whether tidyverse is installed. If yes, we just need to load it
# through the command 'library()'. If not, we proceed with the installation.
# Tidyverse includes many useful packages, including ggplot2. So, we can either use the entire
# set of packages, or just load ggplot2 separately.
if(!require(tidyverse)){
  install.packages("tidyverse")
  library(tidyverse)
}
## With this function, you can check whether all packages within Tidyverse are up-to-date
# tidyverse_update()

# Install or load ggplot2
if(!require(ggplot2)){
  install.packages("ggplot2")
  library(ggplot2)
}


######## Load the data

# Let's start by loading the dataset for this session.
# We are going to use the midwest dataset, which is one of the default files of ggplot2.
#
# we can load it from the following link
midwest <- read.csv("http://goo.gl/G1K41K") 
# midwest contains county-level data for 5 states (IL, IN, MI, OH, WI). 
# For further details, see:
# https://ggplot2.tidyverse.org/reference/midwest.html
head(midwest)


######## Basic plots (1 variable)

# Basic template for any ggplot2:
# ggplot(data = <DATA>,
#   mapping = aes(<MAPPING>)) +
#   <GEOM_FUNCTION>(
#     stat = <STAT>,
#     position = <POSITION>) +
#   <COORDINATE_FUNCTION> +
#   <FACET_FUNCTION>
# Remember that only <DATA>, <MAPPING>, and <GEOM_FUNCTION> must be defined.  

# <DATA> --> this is a dataframe
#
# <MAPPING> --> an aesthetic mapping defines how variables in the dataset are connected 
# to visual properties or outputs. The terms “aesthetic” and “mapping” are often used interchangeably.
# Example: aes(x = var1, y = var2)
#
# <GEOM_FUNCTION> --> this is the plot type we want to use
# Example: geom_histogram, geom_point (for scatter plots), geom_boxplot, geom_line (for line plots), ...

# Let's now start with a basic plot
ggplot(data = midwest, 
       mapping = aes(x = percbelowpoverty)) # the variable on the x-axis is the population percentage below poverty
#  We see this axis properly defined, but because we did not pass any geom_function, no additional plot is created.

# Let’s create a histogram plot using geom_histogram
ggplot(data = midwest, 
       mapping = aes(x = percbelowpoverty)) + # The + must end this line, not begin the following
       geom_histogram()
# Let's change this to a density plot
ggplot(data = midwest, 
       mapping = aes(x = percbelowpoverty)) + 
       geom_density()
# By changing from geom_histogram to geom_density, we’ve inherited the same mapping information.
# So, there is no need to change anything else! By contrast, you will need to learn the details of several
# R functions, such as plot() or hist(), to make a histogram or a density plot.


######## Scatter plots (2 variable)

# This time, we plot percbelowpoverty vs percollege, where percollege is the percentage of college-educated people
ggplot(data = midwest, 
       mapping = aes(x = percbelowpoverty, y = percollege)) + 
       geom_point()
# Since we see a trend between x and y, let's add a trendline.
ggplot(data = midwest, 
       mapping = aes(x = percbelowpoverty, y = percollege)) + 
       geom_point() +
       geom_smooth()
# This is simply a new layer we add to the plot. The default trendline is done
# with the function LOESS (it is a smoothing function). Let's add another trendline:
# this time, we use the lm function (linear model).
ggplot(data = midwest, 
       mapping = aes(x = percbelowpoverty, y = percollege)) + 
       geom_point() +
       geom_smooth() +
       geom_smooth(method='lm',color='seagreen')


######## Zooming in/out

# Zoom in
ggplot(data = midwest, 
       mapping = aes(x = percbelowpoverty, y = percollege)) + 
       geom_point() +
       geom_smooth(method='lm',color='seagreen') +
       coord_cartesian(xlim=c(0,10), ylim=c(40, 50))

# Zoom out
ggplot(data = midwest, 
       mapping = aes(x = percbelowpoverty, y = percollege)) + 
  geom_point() +
  geom_smooth(method='lm',color='seagreen') +
  coord_cartesian(xlim=c(0,60), ylim=c(0, 60))


######## Change title and axis labels

# Title, sub-title, and axis labels
ggplot(data = midwest, 
       mapping = aes(x = percbelowpoverty, y = percollege)) + 
  geom_point() +
  geom_smooth(method='lm',color='seagreen') +
  labs(title="percbelowpoverty vs percollege", subtitle="From midwest dataset", x="Percentage below poverty", 
       y="Percentage of college-educated people", caption="...")

# Sometimes it can be useful to first transform the plot into a ggplot2 object
g <- ggplot(data = midwest, 
  mapping = aes(x = percbelowpoverty, y = percollege)) + 
  geom_point() +
  geom_smooth(method='lm',color='seagreen')
# plot(g)
g + labs(title="percbelowpoverty vs percollege", subtitle="From midwest dataset", x="Percentage below poverty", 
         y="Percentage of college-educated people", caption="...")


######## Change the color and size of points

# Let's make green (and larger) points
ggplot(data = midwest, 
  mapping = aes(x = percbelowpoverty, y = percollege)) + 
  geom_point(col="green", size=3) +
  geom_smooth(method='lm',color='seagreen') +
  labs(title="percbelowpoverty vs percollege", subtitle="From midwest dataset", x="Percentage below poverty", 
       y="Percentage of college-educated people", caption="...")
#
# We can also try with this command
ggplot(data = midwest, 
  mapping = aes(x = percbelowpoverty, y = percollege)) + 
  geom_point(aes(color = 'green')) +
  geom_smooth(method='lm',color='seagreen') +
  labs(title="percbelowpoverty vs percollege", subtitle="From midwest dataset", x="Percentage below poverty", 
       y="Percentage of college-educated people", caption="...")
# Remember, arguments inside a mapping should apply to variables. Since 'green' doesn’t exist as a variable, 
# a new variable is created which is constant. What if we pass a proper argument?
#
# In this case, we change the color of the points to reflect the category of another column.
# For example, we want to color the dots according to the state (IL, IN, MI, OH, WI).
ggplot(data = midwest, 
  mapping = aes(x = percbelowpoverty, y = percollege)) + 
  geom_point(aes(color=state)) +
  geom_smooth(method='lm',color='seagreen') +
  labs(title="percbelowpoverty vs percollege", subtitle="From midwest dataset", x="Percentage below poverty", 
       y="Percentage of college-educated people", caption="...")
#
# My favourite way would be this one:
ggplot(data = midwest, 
  mapping = aes(x = percbelowpoverty, y = percollege, color = state)) + 
  geom_point() +
  geom_smooth(method='lm',color='seagreen') +
  labs(title="percbelowpoverty vs percollege", subtitle="From midwest dataset", x="Percentage below poverty", 
       y="Percentage of college-educated people", caption="...")
# Note that ggplot2 creates a legend when the aesthetics are not constant.


######## Modify the legend position

# The legend’s position inside the plot is an aspect of the theme. So it can be modified using the theme() function. 
# If you want to place the legend inside the plot, you can additionally control the hinge point of the legend using legend.justification.
# The legend.position is the x and y axis position in chart area, where (0,0) is bottom left of the chart and (1,1) is top right. 
# Likewise, legend.justification refers to the hinge point inside the legend.

# Basic plot
gg <- ggplot(data = midwest, 
  mapping = aes(x = percbelowpoverty, y = percollege)) + 
  geom_point(aes(color=state)) +
  geom_smooth(method='lm',color='seagreen') +
  labs(title="percbelowpoverty vs percollege", subtitle="From midwest dataset", x="Percentage below poverty", 
       y="Percentage of college-educated people", caption="...")

# No legend
gg + theme(legend.position="None") + labs(subtitle="No Legend")

# Legend to the left
gg + theme(legend.position="left") + labs(subtitle="Legend on the Left")

# Legend at the bottom and horizontal
gg + theme(legend.position="bottom", legend.box = "horizontal") + labs(subtitle="Legend at Bottom")


######## Faceting: Draw multiple plots within one figure

# Facets create plots per grouping variable. This will produce a grid of plots. 
# For most general cases, use facet_wrap, with an argument being a formula where the right hand side is variables to group on.
ggplot(data = midwest, 
  mapping = aes(x = percbelowpoverty, y = percollege)) + 
  geom_point() +
  facet_wrap(~state)


######## Saving you plots

# To this purpose, we use the ggsave function.
# By default, ggsave saves the last plot displayed. Alternatively, we can request
# to save a plot that we first saved in the Environemnt
ggsave("2Dscatter_plot.pdf",g)
ggsave("2Dscatter_plot_with_state.pdf",gg)








