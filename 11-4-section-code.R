## Code for Discussion Section 10/26/11


#################################################
## Simulating Estimates of the Mean of a Normal
## and 95% confidence intervals

# true model is iid N(5,3)
# (we don't know the mean, only var=1)
# we observe 100 data points

# setting values of true mu, sigma2, n
mu.true <- 5
sigma2.true <- 3
n <- 100

# setting up vector to store simulated mean estimates
xbar <- c()
# setting up matrix to store simulated 95% CIs
CI.95 <- matrix(NA, nrow = 10000, ncol = 2)

# running loop to estimate these things
for(i in 1:10000){
  simulated.data <- rnorm(n, mean=mu.true, sd=sqrt(sigma2.true))
  xbar[i] <- mean(simulated.data)
  CI.95[i, ] <- c(mean(simulated.data) - 1.96*sqrt(3/100),
                  mean(simulated.data) + 1.96*sqrt(3/100))
}

# what is the sampling distribution for xbar?
# (work this out before looking at the sims)
mean(xbar)
var(xbar)
sd(xbar)

# plotting histogram of simulated xbars
hist(xbar, freq=FALSE)
# overlaying curve of true sampling distribution for xbar
curve(dnorm(x, mean=mu.true, sd=sqrt(sigma2.true/n)), add=TRUE)

# creating a variable that says whether each
# CI contains true mu
mu.in.ci <- CI.95[ , 1] < mu.true & CI.95[ , 2] > mu.true

# plotting the first 100 CIs 
# and whether they conatin mu

plot(-99,xlim=c(4,6), ylim=c(0,100), bty="n",
     xlab="mu", ylab="sample", yaxt="n")
for(i in 1:100){
  segments(CI.95[i, 1], i, CI.95[i, 2], i,
           col=ifelse(mu.in.ci[i], "green", "red"))
  points(xbar[i], i, pch=19, cex=.2)
}
abline(v=mu.true, lty=3)

# calculating how many of the 95% CIs
# contain the true mean of 5
table(mu.in.ci)
mean(mu.in.ci)







#############################################################
## Testing null hypothesis in polling:
## poll of 1,500 Americans
## generic congressional ballot question for 2012
## get 801 saying they would vote for the Democrats
## (assume, unrealistically, that everyone picked D or R)
## want to test H0: Actually is tied (i.e. 50-50)

# test statistic: proportion of sample that supports Dems
# under null hypothesis of equal population support,
# what is sampling distribution of this statistic?

# simulate:
dem.null <- rbinom(n=10000, size=1500, prob=.5)

mean(dem.null)
var(dem.null)
sd(dem.null)


# plot histogram of simulated samples
hist(dem.null, freq=FALSE)
abline(v=mean(dem.null))
# overlay curve of actual (exact) sampling dist
points(600:900, dbinom(600:900, size=1500, prob=.5))
# overlaying curve of normal approximation to sampling dist
curve(dnorm(x, mean=1500*.5, sd=sqrt(1500*.5*.5)), add=TRUE)

# calculating p-value for our estimate, which is 801
# one-tailed test
mean(dem.null >= 801)
# two-tailed (probably more appropriate)
mean(dem.null >= 801 | dem.null <= (750-801)+750)
# under either type of test, our observed result
# would be extremely unlikely if the null hypothesis were true
