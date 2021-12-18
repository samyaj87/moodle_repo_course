# R code snippets from slides
# Slide file:  Descriptive and Bivariate Statistics/Lesson7


# Load the data
# ==========
store.df <- read.csv("http://goo.gl/QPDdMl")
names(store.df)


# Load the data
# ==========
summary(store.df)


# Descriptives 1
# ==========
table(store.df$p1price)

prop.table(table(store.df$p1price))


# Table as an object
# ==========
p1.table <- table(store.df$p1price)
p1.table #view content

p1.table[3]


# Plotting a table (basic)
# ==========
plot(p1.table)


# Two-way tables
# ==========
table(store.df$p1price, store.df$p1prom)


# Core Descriptive Functions
# ==========
min(store.df$p1sales)
max(store.df$p2sales)
mean(store.df$p1prom)
median(store.df$p2sales)
var(store.df$p1sales)
sd(store.df$p1sales)


# Normal Distribution
# ==========
library(ggplot2)
ggplot(data = data.frame(x = c(-3, 3)), aes(x)) +
  stat_function(fun = dnorm, n = 101, args = list(mean = 0, sd = 1), size=1.5) + ylab("") + xlab("") +
  geom_vline(xintercept=0, color = "red", linetype="dotted", size=1) +
  geom_text(aes(x=0, label="\nmean = median = mode", y=0.1), colour="red", angle=90, text=element_text(size=18)) +
  scale_y_continuous(labels = NULL, breaks=NULL) +
  scale_x_continuous(labels = NULL, breaks=NULL) +
  theme_bw() + theme(panel.grid = element_blank())


# Skewed Distribution
# ==========
library(ggplot2)
ggplot(data = data.frame(x = c(0, 1)), aes(x)) +
  stat_function(fun = dbeta, n = 101, args = list(shape1 = 3, shape2 = 7), , size=1.5) + ylab("") + xlab("") +
  geom_vline(xintercept=3/10, color = "blue", linetype="dotted", size=1) + 
  geom_text(aes(x=3/10, label="\nmean", y=0.1), colour="blue", angle=90, text=element_text(size=18)) +
  geom_vline(xintercept=median(rbeta(5000, shape1 = 3, shape2 = 7)), color = "orange", linetype="dashed", size=1) + 
  geom_text(aes(x=median(rbeta(5000, shape1 = 3, shape2 = 7))-0.038, label="\nmedian", y=0.1), colour="orange", angle=90, text=element_text(size=18)) +
  geom_vline(xintercept=2/8, color = "green", linetype="dotdash", size=1) + 
  geom_text(aes(x=2/8-0.04, label="\nmode", y=0.1), colour="green", angle=90, text=element_text(size=18)) +
  scale_y_continuous(labels = NULL, breaks=NULL) +
  scale_x_continuous(labels = NULL, breaks=NULL) +
  theme_bw() + theme(panel.grid = element_blank())


# Percentile (Quantile) function
# ==========
quantile(store.df$p1sales)   # default: probs = c(0.25, 0.5, 0.75)


# Percentile (Quantile) function
# ==========
quantile(store.df$p1sales, probs=c(0.25, 0.75)) # Interquartile
quantile(store.df$p1sales, probs=c(0.025, 0.975)) # central 95%


# Let's look again at the data summary..
# ==========
summary(store.df)


# Summary of data frame elements
# ==========
summary(store.df$p1sales)
summary(store.df$p2sales)


# by()
# ==========
by(store.df$p1sales, store.df$storeNum, mean)


# aggregate()
# ==========
storeMean <- aggregate(store.df$p1sales, 
                       by=list(store=store.df$storeNum), mean)
storeMean


# Aggregate sales by country
# ==========
p1sales.sum <- aggregate(store.df$p1sales, 
               by=list(country=store.df$country), sum)
p1sales.sum

