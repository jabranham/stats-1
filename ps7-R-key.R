## ## Used to clean data from CDC's website
## CDC <- read.csv("data/cdc-smoking.csv", stringsAsFactors = FALSE)
## dim(CDC)
## names(CDC)
## table(CDC$Year)
## library(dplyr)
## CDC <- CDC %>%
##   filter(State != "Guam") %>%
##   filter(State != "District of Columbia") %>%
##   filter(State != "Puerto Rico") %>%
##   filter(State != "Virgin Islands") %>%
##   filter(State != "Nationwide (States and DC)") %>%
##   filter(State != "Nationwide (States, DC, and Territories)")

## cdc <- CDC %>%
##   mutate(smoke.everyday = as.numeric(sub("%", "", Smoke.everyday))/100) %>%
##   mutate(smoke.some.days = as.numeric(sub("%", "", Smoke.some.days))/100) %>%
##   mutate(former.smoker = as.numeric(sub("%", "", Former.smoker))/100) %>%
##   mutate(never.smoked = as.numeric(sub("%", "", Never.smoked))/100)

## cdc <- cdc %>% filter(Year==2010)

## cdc <- cdc %>%
##   select(State, smoke.everyday,
##           smoke.some.days, former.smoker, never.smoked)

## write.csv(cdc, file = "data/cdc-smoking-data.csv")

## cdc2 <- read.csv("data/cdc-smoking-data.csv")


## Read in data
cdc2 <- read.csv("https://raw.githubusercontent.com/jabranham/stats-1/master/data/cdc-smoking-data.csv")

## means of variables
summary(cdc2)

## Highest prop of people who have never smoked:
max.never <- max(cdc2$never.smoked)
cdc2[cdc2$never.smoked== max.never, ]


## histogram of smokers
library(ggplot2)

ggplot(cdc2, aes(smoke.everyday)) +
  geom_histogram(binwidth = 0.01) +
  theme_minimal()

# or, alternatively:
## hist(cdc2$smoke.everyday, breaks = seq(0.05, .3, 0.01))

## comparing south vs nonsouth
thesouth <- c("Alabama", "Mississippi", "Georgia", "South Carolina",
              "Tennessee", "Louisiana")
cdc2$southern <- with(cdc2, State %in% thesouth)
mean(cdc2$smoke.everyday[cdc2$State %in% thesouth])
mean(cdc2$smoke.everyday[!cdc2$State %in% thesouth])

## Computing confidence intervals
## For the nonsouth
n <- length(cdc2$smoke.everyday[!cdc2$State %in% thesouth])
s <- sd(cdc2$smoke.everyday[!cdc2$State %in% thesouth])
SE <- s/sqrt(n)
error <- qt(.975, df=n-1) * SE
mean(cdc2$smoke.everyday[!cdc2$State %in% thesouth]) + c(-error, error)

## For the south
n <- length(cdc2$smoke.everyday[cdc2$State %in% thesouth])
s <- sd(cdc2$smoke.everyday[cdc2$State %in% thesouth])
SE <- s/sqrt(n)
error <- qt(.975, df=n-1) * SE
mean(cdc2$smoke.everyday[cdc2$State %in% thesouth]) + c(-error, error)
