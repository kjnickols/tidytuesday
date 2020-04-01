#filtering exercises
#1. Find all flights that
#   1. Had an arrival delay of two or more hours
library(nycflights13)
library(tidyverse)

h2delay <- filter(flights, arr_delay >= 120)

#   2. Flew to Houston (IAH or HOU)
houston <-filter(flights, dest == "IAH" | dest == "HOU")

#   3. Were operated by United, American, or Delta
stpdcomps <- filter(flights, carrier == "AA" | carrier == "DL" | carrier == "UA")

#   4. Departed in summer (July, August, and September)
summtime <- filter(flights, month %in% c(7, 8, 9))

#   5. Arrived more than two hours late, but didn't leave late
turbs <- filter(flights, arr_delay > 120 & dep_delay <= 0)

#   6. Were delayed by at least an hour, but made up over 30 min in flight
fasttrack <- filter(flights, dep_delay >=60 & arr_delay <=30)

#   7. Departed between midnight and 6 am (inclusive)
earlymorn <- filter(flights, dep_time >= 0 & dep_time <= 600)

#2. another filtering helper is between(). What does it do?
# find values between things between(x, left, right)
#which ones above could you change? Number 7
earlymorn2 <- filter(flights, between(flights$dep_time, 0, 600))
# or
earlymorn2 <- dplyr::filter(flights, between(flights$dep_time, 0, 600))

#3. How many flights have a missing dep_time? 
nodeptime <- filter(flights, is.na(dep_time))
#8255, that's a lot!
#What other variables are missing? 
#dep_delay, arr_time, arr_dely, maybe others. These are probably cancelled flights.

#4. Why is NA ^ 0 not missing? Why is NA | TRUE not missing? Why is FALSE & NA not 
#missing? Can you figure out the general rule? (NA * 0 is a tricky counterexample!)
#I don't care enough to answer this. 

#learn about arrange - arrange rows
arrange(flights, year, month, day)
#this looks exactly the same as flights so I don't know what the hell it did.

# Use desc() to re-order by a column in descending order:
arrange(flights, desc(dep_delay))
#missing values always sorted at end

df <- tibble(x = c(5, 2, NA))
arrange(df, x)
#> # A tibble: 3 x 1
#>       x
#>   <dbl>
#> 1     2
#> 2     5
#> 3    NA
arrange(df, desc(x))
#> # A tibble: 3 x 1
#>       x
#>   <dbl>
#> 1     5
#> 2     2
#> 3    NA

#left off on exercises 5.3.1