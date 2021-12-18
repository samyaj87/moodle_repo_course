remove(list = ls())
library(MASS)
library(ggplot2)
uscereal <- UScereal


str(uscereal)
summary(uscereal)

#check for all attributes
dim(uscereal)
nrow(uscereal)
ncol(uscereal)
rownames(uscereal)

names(uscereal)

## check if NA are present

sum(is.na(uscereal))
uscereal[7,3] <- NA

## check if nan are present column by column
#sapply is a user-friendly version and wrapper of lapply by default returning a vector,
sapply(uscereal, function(x){sum(is.na(x))})

#we can also see the correlation between the variables
cor(uscereal[,c("calories","protein","fat","sodium","fibre","potassium")])

cor(uscereal[,c("calories","protein","fat","sodium","fibre","potassium","vitamins")])


#' Subset for particular variable
#' 
uscereal.subset <- subset(uscereal, select = c('calories','protein','fat','sugar','potassium'))
# Error in `[.data.frame`(x, r, vars, drop = drop) : 
#   undefined columns selected





names(uscereal)
#how to solve the error
# 1) check  the name
uscereal.subset <- subset(uscereal, select = c('calories','protein','fat','sugars','potassium'))
# 2) indexing the columns
uscereal.subset <- subset(uscereal, select=names(uscereal[c(2,3)]))

summary(uscereal.subset)


## Filter for all cereals with less calories than the mean of calories

m.calories <- round(mean(uscereal$calories, na.rm = T))
# > m.calories
# [1] 149

my.low.calories <- uscereal[uscereal$calories<  m.calories,]

summary(my.low.calories)

#You can also use subset to filter with conditions

my.low.calories_2 <- subset(uscereal, calories< m.calories & sodium>200)

#also you can select particular columns
my.low.calories_2_2 <- subset(uscereal, calories< m.calories & sodium>200, 
                              select = names(uscereal[c(1,2,3,4,6,7,9)]))

#Some simple plot

p1 <- ggplot(uscereal, aes(potassium, protein))+geom_point()
p1

p2 <- ggplot(uscereal, aes(mfr, protein))+geom_point()
p2
###wrong
### What is the right plot you need to type


p2 <- ggplot(uscereal, aes(mfr, protein))+geom_boxplot()
p2


p3 <- ggplot(uscereal, aes(mfr, protein, color=vitamins))+geom_boxplot()
p3



#'suppose you want also set a new variable which divide calories 
#'by number and create a categorical variabl


uscereal$typecalories <- ifelse(uscereal$calories <=100, 'low', 
                                ifelse(uscereal$calories >101 & uscereal$calories<=250 , 'mid', 
                                       ifelse(uscereal$calories>251, 'high', NA)))

uscereal$typecalories <- as.factor(uscereal$typecalories)

p2 <- ggplot(uscereal, aes(mfr, calories, color=typecalories))+geom_boxplot()
p2


#histogram
p4 <- ggplot(uscereal, aes(calories))+geom_histogram(binwidth  = 20)
p4


