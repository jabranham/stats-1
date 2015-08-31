##############################
## Intro to R demonstration ##
## for Stats 1 2 Sep 2015   ##
##############################

# note that in Rstudio you can see all keyboard shortcuts 
# Windows and Linux: alt+shift+K
# Mac: option+shift+K

# basic arithmetic
1+1
3-2
9^.5

# functions in R
sqrt(9) # square root
exp(3)  # raise e to some power
log(11)

# getting help
args(log) # seeing what arguments (options) the log function has
?log # seeing a more extensive manual entry for a function
# ...or try google or rseek.org

#So if we want base 10, we could do:
log(11, base=10)
log10(11)

# vectors
c(1,2,3)
1:3
seq(1, 3, by=1)
seq(1, 3, by=0.5)
c(9,11,-2)

# storing things
x <- c(1,2,3) # define a vector called x
x   # print x -also-  print(x)
x2 <- c(6,2,7) # creating another x2
x+1  # doing arithmetic with x
x <- x+1
y <- c(3,5,9) # creating a new vector

# plotting
plot(x, y)  # scatterplot of x vs y
abline(0, 1) # add line to plot with intercept 0, slope 1
abline(2, 2) # add line to plot with intercept 2, slope 2

# running a linear regression of y on x
reg1 <- lm(y ~ x ) 
reg1 # print estimates from regression
summary(reg1) # full report on regression
abline(reg1, col="green", lwd=3, lty="dashed") # adding line implied by reg1
             # green, thickness 3, dashed line

## Packages
install.packages("car") #only need to do this if you haven't installed it before 
library(car) #this loads the package into R's memory so you can use it 
dataURL <- "http://socserv.socsci.mcmaster.ca/jfox/Books/Companion/data/Duncan.txt"
Duncan <- read.table(dataURL, header=TRUE) 

names(Duncan)
income
Duncan$income

plot(Duncan$income, Duncan$education)

duncan.model <- lm(prestige ~ income, data=Duncan)
summary(duncan.model)
abline(duncan.model, col="black", lwd=3, lty=2)

# Useful R package of the week
# dplyr
# for data manipulation 

library(dplyr)
names(mtcars) # what're the names of the vars in mtcars
table(mtcars$cyl) # 4, 6, and 8 cyls
# What is mean mpg by cyl?
mtcars %>% # mtcars 'then'
  group_by(cyl) %>% # group by this var, "then"
  summarize(meanmpg = mean(mpg)) # summarize, returning mean mpg

# What if we don't want cars over 4 tons?
  # e.g. we need to subset by **row**
mtcars %>% 
  filter(wt < 4) %>% 
  group_by(cyl) %>% 
  summarize(meanmpg = mean(mpg))

# We can also subset by column:
mtcars %>% 
  select(mpg, cyl, wt) %>% 
  head()

# We can make new vars with "mutate": 
mtcars <- mtcars %>% 
	mutate(mpg_per_cyl = mpg/cyl)

mean(mtcars$mpg_per_cyl)
