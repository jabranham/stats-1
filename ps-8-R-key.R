## democracy <- haven::read_dta("data/norris-data.dta")

## democracy$ElecFam2012 <- haven::as_factor(democracy$ElecFam2012)

## democracy <- democracy %>%
##   filter(Politystand2014 > 50)

## write.csv(democracy, file = "data/norris-data-subset.csv")

democracy <- read.csv("https://raw.githubusercontent.com/jabranham/stats-1/master/data/norris-data-subset.csv")

# GDP2014 - per capita
# Asia - dummy
# Politystand2014 - Policy IV 2014
# Elec -
library(ggplot2)
library(dplyr)

democracy %>%
  group_by(ElecFam2012) %>%
  summarize(mean = mean(Turnout2000, na.rm = TRUE))

t.test(democracy$Turnout2000, mu = 63)

t.test(democracy$Turnout2000[democracy$ElecFam2012 == "Majoritarian"],
       democracy$Turnout2000[democracy$ElecFam2012 == "List PR"])

democracy %>%
  ggplot(., aes(GDP2014, Turnout2000, color=ElecFam2012)) +
  geom_point() +
  theme_minimal()
