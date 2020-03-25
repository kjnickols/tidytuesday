#back to book. Ain't no virus gonna hold me down
#Weird-ass coordinate shit
library(tidyverse)
#coord_flip - flipping x and y
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()  #flips it!

#coord_quickmap - correct data aspect ratio for maps
#couldn't do this example because didn't have the data

#coord_polar() uses polar coordinates
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

#Exercises: 
#Ex. 1: Turn a stacked bar chart into a pie chart using coord_polar()
ggplot(mpg,aes(fl,fill=drv)) +
  geom_bar(position = "fill")

ggplot(mpg,aes(fl,fill=drv)) + 
  geom_bar(position = "fill") +
  coord_polar()

#Ex. 2: What does labs() do? Read the documentation
?labs
#Way to add labels

#Ex. 3: What's the difference between coord_quickmap() and coord_map()?
#coord_map projects a portion of the earth, which is approximately spherical, onto a 
#flat 2D plane using any projection defined by the mapproj package. Map projections do
#not, in general, preserve straight lines, so this requires considerable computation. 
#coord_quickmap is a quick approximation that does preserve straight lines. It works 
#best for smaller areas closer to the equator.

#Ex. 4: What does the plot below tell you about the relationship between city and 
#highway mpg? Why is coord_fixed() important? What does geom_abline() do?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed()
#hwy and cty mileage increase with each other, but it's not a 1:1 relationship. hwy 
#mpg increases at a faster rate. Or, more hwy mpg for a given cty mpg
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  coord_fixed()
#coord_fixed fixes the coordinates to a certain ratio, default is 1, so the units are
#the same across the axes
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed()
#geom_abline adds a reference line, default is 1:1

#CODE TEMPLATE:
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(
    mapping = aes(<MAPPINGS>),
    stat = <STAT>, 
    position = <POSITION>
  ) +
  <COORDINATE_FUNCTION> +
  <FACET_FUNCTION>
  
  # I FINISHED CHAPTER 3!!!!!!!
  
  #Chapter 4 = workflow basics
  #Use as calculator
  1 / 200 * 30
#> [1] 0.15
(59 + 73 + 2) / 3
#> [1] 44.7
sin(pi / 2)
#> [1] 1

#Create objects with <-
x <- 3 * 4
2*x
#use alt + - to get <- (option + -)
x
#[1] 12
this_is_a_really_long_name <- 2.5
#then to recall this can just type the beginning and tab to get the full name
#to go back to that piece of code, type the beginning, then option + up arrow

r_rocks <- 2 ^ 3
#typos matter, try r_rock or R_rocks, you get nothing

#time for functions
#omg type tab to complete, tab again to get parantheses when using functions
seq(1,10)
#[1]  1  2  3  4  5  6  7  8  9 10

#if make an assignment don't see value, tempted to see it
y <- seq(1, 10, length.out = 5)
y
#this prints to screen
(y <- seq(1, 10, length.out = 5))

#Exercises!
#Ex. 1: Why does this code not work?
my_variable <- 10
my_varıable #doesn't work, there's a weird typo, not an i (that was dumb)
#> Error in eval(expr, envir, enclos): object 'my_varıable' not found

#Ex. 2: Tweak each of the following R commands so that they run correctly:
library(tidyverse)

ggplot(dota = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

#typo! need
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

fliter(mpg, cyl = 8)
#typo! need
filter(mpg, cyl == 8)

filter(diamond, carat > 3)
#hmmm ---- TYPO!
filter(diamonds, carat > 3)

#Ex. 3 Press Alt + Shift + K. What happens? How can you get to the same place using 
#the menus?
#gives you short cuts! It's also in the help menu!

#Chapter 5: Data Transformation
library(nycflights13)
library(tidyverse)
#going to use flights - data for all flights that departed NYC in 2013
#use dplyr functions, they are:
#filter
#arrange
#select
#mutate
#summarise
#group_by

filter(flights, month == 1, day == 1)
#doesn't save it though
jan1 <- filter(flights, month == 1, day == 1)
(dec25 <- filter(flights, month == 12, day == 25)) #assign print

#add more filtering stuff - | is for or, & is and, ! is not
filter(flights, month == 11 | month == 12)

# %in% is used for anything x in y (x for months, y for 11 and 12)
nov_dec <- filter(flights, month %in% c(11, 12))
#also !(x & y) is the same as !x | !y, and !(x | y) is the same as !x & !y

#here's a couple different coding options
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

#If you want to determine if a value is missing, use is.na():
is.na(x)

#see how to preserve NAs 
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
#> # A tibble: 1 x 1
#>       x
#>   <dbl>
#> 1     3
filter(df, is.na(x) | x > 1)
#> # A tibble: 2 x 1
#>       x
#>   <dbl>
#> 1    NA

#LEFT OFF ON FILTERING EXERCISES, 5.2.4
#> 2     3
