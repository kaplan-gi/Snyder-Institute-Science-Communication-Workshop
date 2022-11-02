# Contributor: Lindsay Hracs
# Date: 02-Nov-22
# R version 4.1.2
# Running on macOS Monterey 12.1
# Inspecting data with data vis tools for Snyder Institute Science Communication Workshop



set.seed(123) # set seed to create reproducible results when generating random data

n <- 100 # set number of observations you want
x <- runif(n) # generate random values from a uniform distribtiion
obs <- rnorm(n, 0, 0.25) # generate a vector of normally distrubted observations

hist(x) # create histogram to inspect generated data
qqnorm(x) # Q-Q (quantile-quantile) fucntion to plot ordered sample against theoretical normal/Gaussian distribution
qqline(x, col = "blue", lwd = 2) # add line of best fit to Q-Q plot; lwd = line width