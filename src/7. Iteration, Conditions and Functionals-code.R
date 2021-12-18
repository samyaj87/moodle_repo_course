# R code snippets from slides
# Slide file:  Iteration/Lesson6


# Iteration
# ==========
df = data.frame(a = rnorm(5),
                b = rnorm(5),
                c = rnorm(5))
str(df)


# Iteration
# ==========
mean(df$a)
mean(df$b)
mean(df$c)


# Iteration
# ==========
dim(df)
N = dim(df)[2]  # Take the 2nd dimension of df  
output = vector("double", N)    # 1. Initialize output
for (i in 1:N) {                # 2. Define sequence
  output[i] <- mean(df[, i])    # 3. Iteration body
}
output


# Question 1
# ==========
data(mtcars)
str(mtcars)


# Answer 1
# ==========
N1 = dim(mtcars)[2]  
output1 = vector("double", N1)    
for (i in 1:N1) {             
  output1[i] <- median(mtcars[, i])  
}
output1


# Question 2
# ==========
data(iris)
str(iris) #hint: ?unique


# Answer 2
# ==========
N2 = dim(iris)[2]  
output2 = vector("integer", N2)    
for (i in 1:N2) {             
  output2[i] <- length(unique(iris[, i])) #unique returns a vector or data frame without duplicate elements/rows  
}
output2


# Modifying an existing object
# ==========
str(df)

my_rescale2 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

df$a <- my_rescale2(df$a)
df$b <- my_rescale2(df$b)
df$c <- my_rescale2(df$c)


# Modifying an existing object
# ==========
for (i in seq_along(df)) {
  df[i] <- my_rescale2(df[i])
}


# How to get a random vector?
# ==========
rnorm(3, 0) # random generation for the normal distribution with mean equal to the 2nd argument
rnorm(5, 1)


# Unknown output length
# ==========
n = sample(100, 1) #random sample of the 1st argument of the size of the 2nd argument
n
n = sample(100, 2)
n


# Unknown output length
# ==========
means = c(0, 1, 2)
output = double()
N = length(means)
for (i in 1:N) {
  n = sample(100, 1)
  output = c(output, rnorm(n, means[i])) # vector concatenation
}
str(output)


# Unknown output length
# ==========
out = vector("list", length(means))
for (i in seq_along(means)) {
  n = sample(100, 1)
  out[[i]] <- rnorm(n, means[i])
}
str(out)
str(unlist(out)) # unlist() flattens a list of vectors into a single vector


# Unknown sequence length
# ==========
while (condition) {
  # body
}

for (i in seq_along(x)){
  # body
}
# ..is equivalent to..
i <- 1
while (i <= length(x)){
  # body
  i <- i + 1 
}


# Conditions: if statement 
# ==========
if (condition){
   statement
}

x <- 5
if(x > 0){
   print("Positive number")
}


# Conditions: if-else statement 
# ==========
if (condition){
   statement1
} else{
  statement2
}

x <- -5
if(x > 0){
   print("Positive number")
} else{
   print("Negative number")
}


# Conditions: nested if-else statement 
# ==========
if (condition1) {
   statement1
} else if (condition2) {
   statement2
} else
   statement3

x <- 0
if (x < 0) {
   print("Negative number")
} else if (x > 0) {
   print("Positive number")
} else
   print("Zero")


# Unknown sequence length
# ==========
flip <- function() sample(c("T", "H"), 1)

flips <- 0
nheads <- 0
while (nheads < 3) {
  if (flip() == "H") { # we're testing a condition
    nheads <- nheads + 1
  } else {
    nheads <- 0
  }
  flips <- flips + 1
}
flips; nheads


# For Loops VS. Functionals 
# ==========
data("mtcars")
head(mtcars)


# apply() 
# ==========
apply(mtcars, 2, mean) 


# apply() 
# ==========
head(apply(mtcars,2,function(x) x%%2))


# lapply() 
# ==========
l = list(a = 1:10, b = 11:20)  
lapply(l, mean) # mean of of the values in each element
lapply(l, sum) # sum of the values in each element 


# sapply() 
# ==========
sapply(l, mean)
sapply(l, sum)


# plyr::ddply()
# ==========
library(plyr) # install.packages("plyr")
ddply(mtcars, .(cyl), summarise, count = length(mpg))

ddply(mtcars, .(cyl), summarise, count = length(mpg),
      mean_mpg = mean(mpg), mean_disp = mean(disp))


# Other (Very) Useful Packages
# ==========
library(dplyr) # for readability and convenience

library(data.table) # for speed!


install.packages('tictoc')
require(tictoc)
tic("total")
tic("data generation")
X <- matrix(rnorm(50000*1000), 50000, 1000)
b <- sample(1:1000, 1000)
y <- runif(1) + X %*% b + rnorm(50000)
toc()

aaa = list(c(1:100),c(2:2000), ciao=c(1:12), d=list())

lapply(aaa, median)
