#left off on exercises 5.3.1
library(nycflights13)
library(tidyverse)

#Exercise 1: How could you use arrange() to sort all missing values to the start? 
#(Hint: use is.na()).
df <- tibble(x = c(5, 2, NA))
arrange(df,!is.na(x))


#Exercise 2: Sort flights to find the most delayed flights. Find the flights that 
#left earliest.
arrange(flights, desc(dep_delay))
arrange(flights, dep_delay)

#Exercise 3: Sort flights to find the fastest (highest speed) flights.
arrange(flights,air_time)
arrange(flights,distance/air_time)

#Exercise 4: Which flights travelled the farthest? Which travelled the shortest?
arrange(flights,desc(distance))
arrange(flights, distance)

#5.4, selecting columns
#select a few columns
select(flights, year, month, day)

#select aall columns between year and day (inclusive) 
#I don't get this one
select(flights, year:day)
#Oh it's becuase that's the order of the columns

# Select all columns except those from year to day (inclusive)
select(flights, -(year:day))

#Within select()
#starts_with("abc") matches names that begin with "abc"
#ends_with("xyz") matches names that end with "xyz"
#contains ("ijk") matches that contain "ijk"
#matches() selects variables that match an expression
#num_range("x",1:3) matches x1, x2 and x3

#See ?select for more details

#can rename variables but keep all other variables the same
#rename(flights, tail_num = tailnum)

#Another option is to use select() in conjunction with the everything() helper. This 
#is useful if you have a handful of variables you’d like to move to the start of the 
#data frame.
#select(flights, time_hour, air_time, everything())

#Exercise 1: Brainstorm as many ways as possible to select dep_time, dep_delay, 
#arr_time, and arr_delay from flights.
#use select and the matches, starts_with, ends_with, contains

#Exercise 2: What happens if you include the name of a variable multiple times in a 
#select() call?
select(flights, year, year)
#it ignores it

#Exercise 3: What does the one_of() function do? Why might it be helpful in 
#conjunction with this vector?
vars <- c("year", "month", "day", "dep_delay", "arr_delay")

?one_of
#one-of doesn't exist anymore? I don't get this shit

#Exercise 4
#Does the result of running the following code surprise you? How do the select helpers
#deal with case by default? How can you change that default?
select(flights, contains("TIME"))
#looks like it doesn't care about exact case

#mutate adds new variables and such
flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time)
mutate(flights_sml, gain = dep_delay - arr_delay, speed = distance / air_time * 60)

#Note that you can refer to columns that you’ve just created:
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours)

#If you only want to keep the new variables, use transmute():
transmute(flights,
            gain = dep_delay - arr_delay,
            hours = air_time / 60,
            gain_per_hour = gain / hours)

#I kept going in the book then got really overwhelmed
