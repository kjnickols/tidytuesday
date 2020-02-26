#Week4 working through the book
#Geom stuff 3.6.1 exercise 6
#Recreate the R code necessary to generate the graphs in the example
library(tidyverse)
#Plot of displ on x axis, hwy on y axis, scatter plot with line with no SE
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se=FALSE)

#Plot of displ on x axis, hwy on y axis, scatter plot with line with no SE, but three 
#different lines
ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point() +
  geom_smooth(mapping = aes(x = displ, y= hwy, group = drv), se = FALSE)

#same plot as above, but now groups (drv) are different colors
ggplot(data = mpg, mapping =aes(x = displ, y=hwy, color = drv)) +
  geom_point() +
  geom_smooth(se=FALSE)

#same plot as above, but now the geom_smooth is all the data
ggplot(data = mpg, mapping =aes(x = displ, y=hwy)) +
  geom_smooth(se=FALSE)+
    geom_point(mapping = aes(x=displ, y=hwy,color=drv)) 

#same plot, but now different points are drv colors, different smooth linestyles 
#are drv
ggplot(data = mpg) +
  geom_point(mapping =aes(x = displ, y=hwy, color = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv), se=FALSE)

#same plot with no lines and with halos around the points
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy), color = "white", stroke=4)+
  geom_point(mapping = aes(x =displ, y = hwy, color = drv),  stroke=1) 
# I DID IT!

#moving onto diamonds and statistical transformations
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))
#makes a bar chart that includes counts, but that's not in the data set, it gets it 
#automatically from making a bar chart in geom_bar. Can look up what stat gets used
#like "count" by looking at ?geom_bar and then stat = "count", once reading about it

#you can also do the same thing but opposite, use the stat to do the count and the 
#default makes a bar plot
ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut))

#Do proportion instead of count
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))

ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

#EXERCISES
#1 what is default geom associated with stat_summary? 
?stat_summary
#default geom is pointrange
#rewrite previous plot to use geom function instead of the stat function
ggplot(data = diamonds) +
  geom_pointrange(mapping = aes(ymin = lower, ymax = upper))

diamonds %>%
  group_by(cut) %>% #group to get summary / do stats
  summarize(meandepth = mean(depth), 
            mindepth = min(depth),
            maxdepth = max(depth)) %>%
  ggplot(aes(x=cut,y=meandepth))+
  geom_pointrange(aes (ymin=mindepth, ymax=maxdepth))

#2 What does geom_col() do? I GIVE UP!!!!!!!!!
ggplot(data = diamonds) +
  geom_col(mapping = aes(y = cut))
#The above didn't work

#Adding on starting 2/25/20
ggplot() + geom_col(data = diamonds, aes(x = cut, y = depth))
#geom_col does not histogram - it does stuff based on stats/summary, like a normal 
#bar chart

#3 - geoms and stats come in pairs, what do they have in common? (I got lazy and 
#didn't do this)
# stat_bin(geom="bar") does the same as geom_bar(stat="bin") 

#4 What variables does stat_smooth() compute? What parameters control its behaviour?
#smooths data using different methods. needs a formula and a method

#5 In our proportion bar chart, we need to set group = 1. Why? In other words what 
#is the problem with these two graphs?

#graph 1
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop..))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))
#need group to show that they are all part of the same group

#graph 2
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut,  y = ..prop.., group = 1, fill = color))
#I think for both of these they were showing each as a group, but I couldn't figure 
#what to do about the second one with color.

#you can color a bar chart with color or with fill
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
#the one above does an outline

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut)) #this one is solid fill
#add another dimension by setting fill to another thing
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

#if you don't want stacked bars:
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity") #here they overlap w/transparency 
# (weird)
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity") #here they overlap with just outlines

#if want to compare proportions and not values:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

#if you want to compare values:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

#R won't plot all the points if they overlap - there's a limit, so if you want to see
#all the data points you can add some random noise using jitter
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

#Exercise 1: What is the problem with this plot? How could you improve it?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()
#overlapping points
ggplot(data = mpg) +
  geom_point(mapping = aes(x = cty, y = hwy), position = "jitter") 

#Exercise 2: What parameters to geom_jitter() control the amount of jittering?
#width and height

#Exercise 3: Compare and contrast geom_jitter() with geom_count()
#Maps to area corresponding with number of points
ggplot(data = mpg) +
  geom_jitter(mapping = aes(x = cty, y = hwy))
ggplot(data = mpg) +
  geom_count(mapping = aes(x = cty, y = hwy))
#I like geom_count WAY better

#Exercise 4: What’s the default position adjustment for geom_boxplot()? Create a 
#visualisation of the mpg dataset that demonstrates it.
#dodge2
ggplot(mpg, aes(x = class, y = hwy)) +
  geom_boxplot()

ggplot(mpg, aes(x = class, y = hwy)) +
  geom_boxplot(aes(color=drv))