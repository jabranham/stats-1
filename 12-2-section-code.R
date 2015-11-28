norris <- read.csv("./data/norris-data-subset.csv")

summary(norris$HDI2014)
summary(norris$GDP2014)

ggplot(norris, aes(GDP2014, HDI2014)) +
  geom_point() +
  theme_minimal()

# this is obviously nonlinear, which can be a problem for OLS
# taking the log solves this

nointeractionplot <- ggplot(norris, aes(log(GDP2014), HDI2014)) +
  geom_point() +
  theme_minimal()
nointeractionplot

summary(lm(HDI2014 ~ GDP2014,
           data = norris))

nointeractionplot + geom_smooth(method = "lm")

# But what about Africa?
norris$Africa <- factor(norris$Africa)

ggplot(norris, aes(log(GDP2014), HDI2014)) +
  geom_point(aes(color = Africa)) +
  theme_minimal()

themodel <- lm(HDI2014 ~ log(GDP2014) * Africa,
               data = norris)
summary(themodel)

library(effects)
plot(effect(term= "log(GDP2014):Africa", mod = themodel), multiline = TRUE)
