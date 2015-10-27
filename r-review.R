# J. Alexander Branham
# This is a quick R review

# Functions
# R knows very common functions out of the box
# e.g. sqrt, max, min, etc
rnorm(5, mean = 3, sd = 2) # random draws from a dist
pnorm(-1.96) # cdf evaluated at -1.96 (what are the defaults?)
?pnorm


# Vectors
my_vector <- c(-1.96, 0, 1.96) # use <- for assignment
pnorm(my_vector)

# length() is an important function
# gives you the length of a vector
# this usually represents 'n' in our work
length(my_vector)

## What is R remembering?
ls()

# Data often comes in data.frame objects
# use read commands to load data into R
# May need to install/load a package (see below)
# Depending on data type (R can read most data types)

# get some data on grad school apps for Stats students
# the :: makes R look in the package brewdata for the function bredata()
# without loading the brewdata package (see below)
stat <- brewdata::brewdata()
dim(stat)
head(stat)


# summary() produces a summary of most object types
summary(stat)
hist(stat$gpa)

# Subsetting data.frame objects can be accomplished via []
hist(stat$gpa[stat$gpa != 0])

# Let's look @ harvard & yale
ivy <- c("harvard univ", "yale univ")
summary(stat$gpa[stat$school_name %in% ivy & stat$gpa != 0])


# Packages extend R's capabilities
# Need to be installed first via install.packages()
library(dplyr) # loads the package to make its functions available to R
stat %>%
  filter(school_name %in% ivy) %>%
  filter(gpa != 0) %>%
  select(gpa) %>%
  summary(.)

library(ggplot2)
stat %>%
  filter(gpa != 0) %>%
  filter(gre_q != 0) %>%
  ggplot(aes(gpa, gre_q, color = decision)) +
  geom_point() +
  theme_minimal()
