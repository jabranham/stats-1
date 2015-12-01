library(effects)
library(ggplot2)

norris <- read.csv("./data/norris-data-subset.csv")

summary(norris$HDI2014)
summary(norris$GDP2014)


#########################
# Functional Forms
#########################

ggplot(norris, aes(GDP2014, HDI2014)) +
  geom_point() +
  theme_minimal()

# this is obviously nonlinear, which can be a problem for OLS
# taking the log solves this

nointeractionplot <- ggplot(norris, aes(log(GDP2014), HDI2014)) +
  geom_point() +
  theme_minimal()
nointeractionplot

summary(lm(HDI2014 ~ log(GDP2014),
           data = norris))

nointeractionplot + geom_smooth(method = "lm")

#########################
# Interactions
#########################
thedata <- data.frame(
  x = rnorm(1000),
  g = c(FALSE, TRUE))

thedata$y <- with(thedata, rnorm(1000, 0 + .33 * x + 4.5* g - .5 * x * g, 1.5))

nointeract <- ggplot(thedata, aes(x, y)) +
  geom_point() +
  theme_minimal()
nointeract

summary(lm(y ~ x, data = thedata))

nointeract + geom_smooth(method = "lm")


interact <- ggplot(thedata, aes(x,y, color = g)) +
  geom_point() +
  theme_minimal()
interact

summary(lm(y ~ x * g, data = thedata))

interact + geom_smooth(method = "lm")

# But what about Africa?
norris$Africa <- factor(norris$Africa,
                        levels = c(0, 1),
                        labels = c("Not Africa", "Africa"))

ggplot(norris, aes(log(GDP2014), HDI2014)) +
  geom_point(aes(color = Africa)) +
  theme_minimal()

themodel <- lm(HDI2014 ~ log(GDP2014) * Africa,
               data = norris)
summary(themodel)

plot(effect(term= "log(GDP2014):Africa", mod = themodel), multiline = TRUE)
