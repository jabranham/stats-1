## flip a coin 10 times,
## record proprtion of H,
## repeat process 10,000 times

# true (unknown) p
p <- .5

# setting up vector to hold outcomes
phatmle <- c()
# looping 10,000 times, each recording 10 flips
for (i in 1:10000){
  nheads <- rbinom(1, size=10, prob=p)
  phatmle[i] <- nheads / 10
}

# histogram of results
hist(phatmle, breaks=seq(-.05,1.05, by=.1), freq=FALSE)
# putting vertical line at true p
abline(v=.5, col="green", lwd=3)

# what's the normal approximation here?
curve(dnorm(x, mean=.5, sd = sqrt(.25/10)), add=TRUE)

  # repeat whole thing with other values of p
  # (e.g. .1, .7, etc.)


## What about if we take the mean of 100 draws from a Poisson?
## What distribution should that have?

# let true lambda equal 5
lambda.true <- 5

# setting up 
lambdahat <- c()
# loop
for(i in 1:10000){
  lambdahat[i] <- mean(rpois(100, lambda = lambda.true))
}

hist(lambdahat, freq=FALSE)
abline(v=lambda.true, col="green", lwd=3)
curve(dnorm(x, mean=5, sd=sqrt(lambda.true/100)), add=TRUE)
