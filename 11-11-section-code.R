# J. Alexander Branham
# Section 2015-11-11

# create data
mydata <- data.frame(
  x = rnorm(300),
  y = rep(1:3),
  z = sample(1:6, replace = TRUE),
  x2 = rnorm(300, mean = 0.2)
)

# creating new variables
# want a var that is -1 if x < -1, 0 if -1 < x < 1 and 1 if x > 1
mydata$new_var <- with(mydata, ifelse(x < -1, -1,
                                      ifelse( x < 1, 0,
                                             ifelse(x > 1, 1, NA))))


# t-tests in R
# test the null that mean of x is 0.5
t.test(mydata$x, mu = 0.5)

# test the null that the difference in means is 0
t.test(mydata$x, mydata$x2)


# making tables
with(mydata, table(y, z))

# note that we can create our own functions
# useful if R doesn't have what you need already:
# for example, power calculation from class yesterday:
library(ggplot2)

my_power_function <- function(n){
  pnorm(((120 - 1.64 * sqrt(90/n)) - 118) / sqrt(90/n))
}

the_data <- data.frame(n = c(0, 1000))

the_plot <- ggplot(the_data, aes(n)) +
  stat_function(fun = my_power_function) +
  theme_minimal()

the_plot

# But what if we wanted to make this more general
# for example, different treatment effects?

my_power_function2 <- function(n, effect = 118){
  pnorm(((120 - 1.64 * sqrt(90/n)) - effect) / sqrt(90/n))
}

the_plot + stat_function(fun = my_power_function2,
                         linetype = "dashed",
                         arg=list(effect = 119.5))

# Reading data into R:
# Often we use data that isn't stored as an R object
# (e.g. stat files or excel spreadsheets)
# Here are some useful packages/functions for getting such data into R:

# Stata, spss
# foreign - read.dta() or read.spss() ## note only older Stata files
# haven - read_dta() or read_sav() ## works for all stata files


# other formats:
# https://support.rstudio.com/hc/en-us/articles/201057987-Quick-list-of-useful-R-packages
