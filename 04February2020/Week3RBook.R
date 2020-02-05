#It's Week threeeeee! Time for facets! 

library(tidyverse)
#This creates two rows of plots, each plot is by class of car, highway miles per gallon 
#as a function of engine displacement 
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

#This creates a grid of plots, each column is cylinder, each row is drive, highway miles
# per gallon as a function of engine displacement 
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

#This creates a grid of plots, each column is cylinder, highway miles
# per gallon as a function of engine displacement 
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

#What happens if you facet on a continuous variable? Pick year
#year ony had two, so not that interesting, try it with cty

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_wrap(~ cty, nrow = 2)
#That's a lot of plots

#What do the empty cells in plot with facet_grid(drv ~ cyl) mean? How do they relate 
#to this plot?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)
#some combos are not available
ggplot(data = mpg) +
  geom_point(mapping = aes(x = drv, y = cyl))
#Areas where you don't have a dot in the above plot are ones where you don't have a 
#plot in the facet_grid

#What plots does the following code make? What does . do?
#this plot is just organized by drive. The dot makes it 1d and not 2d
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
#If you put the . in the beginning, you end up with plots as columns. If you put the .
#at the end, you end up with plots as row. 

#Take the first faceted plot in this section:
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~class, nrow = 2)
#What are the advantages to using faceting instead of the colour aesthetic? What are 
#the disadvantages? How might balance change if you had larger dataset?
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color=class))
#advantages: If have overlapping data, hard to see apart, if scales were different? 
# also if have few data points for one versus others
#disadvantages: hard to compare exactly. Not that pretty. Takes up a lot of space and
#makes things tiny. 
#With more classes you couldn't have more subplots, but also you couldn't really have 
#more colors. If you have lots of points for each one, seems like facets better. 

#Read ?facet_wrap
#What does nrow do? 
#state number of rows
#What does ncol do? State number of columns
#What other options control the layout of the panels? 
#Direction -> horizontal or vertical
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~class, nrow = 2, dir = "v")
#Why doesn't facet_grid have ncol or nrow?
#columns and rows set by variables
#When using facet_gird() you should usually put the variable with more uniques levels 
#in the columns. Why? 
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(cyl ~ drv)
#Depends on if you want long thin plots, or more square plots 

#move beyond scatter plots!
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))
#Here's all the data displ and hwy
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x=displ, y=hwy))

#Here's the displ and hwy lines with separate lines for drv
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
#similar to the one before this one, but they all have same linestyle

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv), show.legend = FALSE)

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv))

#add multiple geoms in the same plot! weeeeee!
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

#you can do the mappings first, then do the plots as well
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

#if you add more things you can just do it to that layer
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth()

#you can also just add lines to certain parts within a line 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = filter(mpg, class == "subcompact"))

#3.6.1 Exercises
#What geom would you use to draw a line chart? geom_lin
#a boxplot? geom_bloxplot
#histogram? geom_histogram
#area plot? geom_area

#predict what this will look like
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)

#Will the following two things look the same? I think so
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#LEFT OFF on exercise number 6 in 3.6.1! 