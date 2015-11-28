norris <- read.csv("./data/norris-data-subset.csv")

# Chi-squared tests
# are electoral system and
# level of democracy independent?
table(norris$ElecFam2012)
table(norris$Politystand2014)

# What if we want polity as three levels for democracies?
# Create new variable
# -1 if politystand2014 <  80
# 0 if >80 and < 100
# 1 if == 100

norris$democracylevel <- with(norris, ifelse(Politystand2014 < 80, -1,
                                             ifelse(Politystand2014 < 100, 0, 1)))

my_table <- with(norris, table(ElecFam2012, democracylevel))
my_table
chisq.test(my_table)

norris <- norris[norris$ElecFam2012 != "None", ]
dim(norris)
my_table2 <- with(norris, table(ElecFam2012, democracylevel))
my_table2

norris$ElecFam2012 <- factor(norris$ElecFam2012)
my_table2 <- with(norris, table(ElecFam2012, democracylevel))
my_table2
chisq.test(my_table2)

library(ggplot2)

ggplot(norris, aes(GDP2002, Turnout2000)) +
  geom_point() +
  theme_minimal()

# Looks like we can draw a line through this,
# but what should slope and intercept be?

my_linear_model <- lm(Turnout2000 ~ GDP2002, data = norris)
summary(my_linear_model)

ggplot(norris, aes(GDP2002, Turnout2000)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_minimal()
