#Working on R Day 2, working from home with pugs
#added a folder for today:28January2020 in R, saved this script to that folder.
# in terminal sent: git add 28January2020/
#                   git commit -a -m "added folder for new week"
#                   git push

library(tidyverse)
#to update tidyverse, use
tidyverse_update()

#we need more packages outside the tidyverse
install.packages(c("nycflights13","gapminder","Lahman"))
#these wouldn't install, not sure why

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

#exercise 1
#What's wrong with the code? Color is supposed to be blue
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
#color needs to go outside of aes / misplaced  parantheses, needs to be outside aes

#Exercise 2: Which variables in mpg are categorical? Which are continuous? 
?mpg
# categotical: manufacturer, model, trans, drv, fl, class
# continuous: displ, year, cyl, cty, hwy
mpg
# can see this by indication under variable <chr> <int> <dbl>

#Exercise 3: Map a continuous variable to color, size, and shape. 
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y=hwy, color=year, size=cty, shape = cyl))
#continuous variable cannot be mapped to shape
#Just do color
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color=year))
#Do color and size
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = year, size = cty))
#change the shape one to a cateogorical variable
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y=hwy, color=year, size=cty, shape = drv))

#Exercise 4: What happens if you map the same variable to multiple aesthetics?
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = year, size = year))
#it looks weird.
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = year, size = displ))
#it's redundant but it lets you

#Exercise 5: What does the stroke aesthetic do? What shapes does it work with? 
?geom_point
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), color = "blue", stroke = 5)
ggplot(data = mpg) + geom_point(mapping = aes(x=displ, y = hwy), shape = 21, stroke = 5)
ggplot(data = mpg) + geom_point(mapping = aes(x=displ, y = hwy), shape = 21)
#stroke is thickness of border of point

#Exercise 6: What happens if you map an aesthetic to something other than a variable name?
#aes(colour = displ < 5)
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))
#that gives true of false for each point about if displ is <5

#facets = subplots, work on that for next time!