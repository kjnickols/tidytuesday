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