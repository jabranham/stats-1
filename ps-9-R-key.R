# Download and extract GSS data
# (you'll need to have made the data/ subfolder in your working dir)
download.file("http://publicdata.norc.org:41000/gss/documents//OTHR/2014_stata.zip",
              "./data/2014_stata.zip")
unzip("./data/2014_stata.zip", exdir = "./data")

GSS <- haven::read_dta("./data/GSS2014.DTA")

GSS$partyid <- as.numeric(GSS$partyid)
GSS$polviews <- as.numeric(GSS$polviews)

library(dplyr)
# obama received 51% of vote in 2012,
# test H0 - 51% of americans are democrats

# create pid3 variable
GSS$pid3 <- with(GSS, ifelse(partyid %in% 0:2, -1,
                             ifelse(partyid == 3, 0,
                                    ifelse(partyid %in% 4:6, 1, 99))))

GSS$democrat <- GSS$pid3 == -1

t.test(GSS$democrat, mu = .51)
# soundly reject H0 that 51% of americans demorats

# Are people's party IDs independent of their responses
# to questions about welfare spending
my_table <- with(GSS, table(pid3[pid3!=99], natfare[pid3!=99]))
chisq.test(my_table)
# almost definitely not!

# Are democrats' responses to the welfare question
# independent of their self-reported ideology?
democrat_table <- with(GSS, table(polviews[pid3 == -1], natfare[pid3 == -1]))
chisq.test(democrat_table)
# Nope! - note the warning message displayed indicates that X^2 may not
# be a good test because some of our cell sizes are so small

# produce a graph showing dist of partyid
# omit NAs
library(ggplot2)

party_labs <- c("Strong Democrat", "W-D",
                "I-D", "Independent", "I-R", "W-R", "Strong Republican", "Other")

GSS %>%
  mutate(partyid = factor(partyid, labels = party_labs)) %>%
  filter(!is.na(partyid)) %>%
ggplot(aes(partyid)) +
  geom_bar() +
  theme_minimal()
