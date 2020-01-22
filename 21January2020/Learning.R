#Working on R Day 1! Using the R for Data Science book
#first have to instal the tidyverse
install.packages("tidyverse")
library(tidyverse)
#to update tidyverse, use
tidyverse_update()

#we need more packages outside the tidyverse
install.packages(c("nycflights13","gapminder","Lahman"))

#if you have a problem and need help to reproduce need required packages, data, and code
#load packages at the top of the script, check that using latest version of each package

#work with mpg data in tidyverse
# to find out about the dataset
?mpg
#plot mpg data
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

#in general for making plots, do
ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

#scatterplot of hwy vs cyl
ggplot(data = mpg) + geom_point(mapping = aes(x = hwy, y = cyl))

#scatterplot of class vs drv
ggplot(data = mpg) + geom_point(mapping = aes(x = class, y = drv))

#add different colors to different points to tell types of cars apar
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class))

#try classifying types of cars by size instead of color (not a really good idea)
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, size = class))

#Left off here in book