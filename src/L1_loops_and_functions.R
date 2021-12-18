rm(list=ls())
#More formally definition of vector, list and array
#vectors can be of atomic type or list type

#hierarchy of R vectors type is 

## VECTORS                   
####################################
#  ATOMIC VECTORS                  #"""
#                                  #
####################################
#  #                   #          ##
#  #  LOGICAL          #          ##
#  #####################          ##
#  #  NUMERIC          #          ##
#  # ###|###############          ##
#  #    |              #          ##
#  # ###V###############          ##
#  #  INTEGER          #          ##
#  #  DOUBLE           #          ##
#  #                   #          ##
#  # ################# #          ##
#  #                   #          ##
#  #  CHARACTER        #          ##
#  #                   #  LIST    ##
#  #                   #          ##
####################################

# DATAFRAME are LIST of VECTORS with the same length

#'A vector is what a collection of cells with a fixed size where all cells hold the same type 
#'(integers or characters or reals or whatever).
#'Logical vector elements are initialized to FALSE, numeric vector elements to 0, 
#'character vector elements to "", raw vector elements to nul bytes and list/expression elements to NULL.


#vectors are unidimensional

a <- vector(mode='integer', length = c(10))
a
typeof(a)


a <- vector(mode='character', length = c(10))
a
type
a <- vector(mode='complex', length = c(10))
a


a <- vector(mode='logical', length = c(10))
a[9] <- T
a
a[2] <- '21'  #note that the type of vector changed to numerical
a


vect.lette <- letters
vect.lette[3] <- 2
vect.lette

#vector can only contain char or numerical or LOGICAL type NOT BOTH (SORRY!)
#'numerical we have 
#'INTEGERS, 
#'DOUBLE, floating points numbers
#'COMPLEX, Real part and Imaginary Part... 
#'CHARACTERS
#'LOGICAL
#'...


q <- complex(i)
typeof (q)
is.integer(q)
is.complex(q)
df <- data.frame(x = 1:3, y = 5:7)
typeof(df)
x <- c(a = 1, b = 2)
is.vector(x)
as.vector(x)
all.equal(x, as.vector(x)) ## FALSE


###-- All the following are TRUE:
is.list(df)
! is.vector(df)
! is.vector(df, mode = "list")

is.vector(list(), mode = "list")



#ARRAYS----

#'An array is a vector which can have one, two or more dimensions. 
#'It is simply a vector which is stored with additional 
#'attributes giving the dimensions (attribute "dim") 
#'and optionally names for those dimensions (attribute "dimnames").

b <- array(data=1, dim=c(2,2))
b
is.matrix(b)
is.array(b)

b <- array(data=runif(100,-10,10), dim=c(3,5,2))
b
is.matrix(b)
is.array(b)
is.list(b)

b[1,2,2]

#LIST----

#' Almost all lists in R internally are Generic Vectors, 
#' but rarely seen by users (except as formals of functions).
#' List size can be increased (decreased) arbitrary on the fly
c <- list()
d <-  vector("list", 5)
is.list(a)
is.list(b)
is.list(c)
is.list(d)

c <- list("a", "b", 1:10)
c

length(c)
length(c[[3]])

#> [1] 3
 

#Think a list like a combination of keys and values, 

# [[1]] <--- this is the name of the first element (key) of the list
# [1] "a"  <--- this is the element (value) or the variable associated with the key [[1]]

# Print the 3rd element of the list c
c[[3]]

#List indexed by a vector
c[c(1,3)]

#Modify an element of a list
c[[2]][2]  <-  "Z" 

c

# Moreover Indexes of the list can be renamed

names(c) <- c('alpha', 'beta', 'gamma')
c

#' now the [[1]] has been renamed with a char, you can also access directly 
#' to the list element alpha with $ operator
c$alpha
# same if
c[['alpha']]

# List allows to have different type for each elements:array, vector, data.frames, list 
c <- list("a", "b", 1:10, list("d", "e", array(1,dim=c(2,2))))
c
 c[[4]]
c[[4]][[1]]
# [1] "d"

#rename the list's keys
names(c) <- c('alpha', 'beta', 'gamma', 'list')
c

#access to the first element of the sublist
c$list[[1]]

# Rename the list of list element

names(c$list) <- c('delta','eta','kappa')

c

c$list$kappa

#R packages----
# R has many many many packages, functions and data structures for specific areas of study.
# library() (or require)  # it  lists all available packages (installed in the libraries specified by 'lib.loc', usually R_HOME/library/)
library() 
# search()   # it lists all packages loaded in the current section
search()


#library(help = lattice) #help for the lattice package: function list with short description
library(MASS) 


## CONDITIONAL INSTRUCTIONS and LOOPS ----


## IF CLAUSE ----

##(A)
## if (condition is true)
##        then do this

## Note: curly brackets are needed for instructions which are written
## on more than one line

x<-6
y<-2

#if x is less than or equal to y then add them to get xy
if(x>y) {
  res<-x+y
  }  
res
#one line condition do not require brackets
##condition is not true so nothing happens
res
## Error: Object "xy" not found

#if the reverse relational operator is used
#then the condition is true and z is assigned x+y
if(x>=y) res<-x+y
res
## [1] 8

#ELSE CLAUSE----
## (B) 
## if (condition is true)
##        {then do this}
## else
##        {do this}

if(x<=y){
  print("x is less or equal than y")
}else{
  print("x is greater than y: create res")
  res <- x+y
}

res

dat1 <- UScereal
fat_over_protein <- dat1$fat / dat1$protein
ind <- which.min(fat_over_protein)
#the element is the third

if(dat1[ind] > 1.4){
  print(dat1$vitamins[ind]) 
} else{
  print("There are no proteins with this ratio")
}

## LOOPING:
## A. 
## WHILE (condition controlling flow is true)----
##        {perform task}


#set initial condition
x <- 0

#enter the while loop
while(x <= 5){
#condition is set x less equal 5  
  x<-x+1
#updating variable condition
  y <-(x)
#when condition is false exit from loop
}
y
## [1] 6


#while example 2
i <- 1
while (i <= 6) {
  print(i)
  i = i+1
}


#while example 3
count <- -10
while(count < 10) {
        print(count)
        count <- count + 1
}


#while example 4
#but what if we do something like this?
count <- -10

while(count < 10) {
  print(count)
  count <- count - 1
}


##B. FOR loops----
## for (i in start:finish)
##        {execute task}

df <- data.frame("a"=rnorm(10),
                 "b"=rnorm(10),
                 "c"=rnorm(10),
                 "d"=rnorm(10))
df

output <- vector("double", ncol(df))  # 1. output
dim(df)

for (i in seq_along(df)) {            # 2. sequence
  output[[i]] <- median(df[[i]])      # 3. body
}
output

for (i in 1:ncol(df)) {            # 2. sequence
  output[[i]] <- median(df[[i]])      # 3. body
}
output
#> [1] -0.24576245 -0.28730721 -0.05669771  0.14426335


## For example 1
x = array()
for(i in 1:10){
  x[i]<-i
}
x


##  [1] 1 2 3 4 5 6 7 8 9 10

## For example 2
x <- c(2,5,3,9,8,11,6)
count <- 0
for (val in x) {
  print(val)
  if(val %% 2 == 0)  {
    count = count+1
    }
}
print(count)


## For example 3 : nested loops

#create an empty matric
z<-matrix(nrow=2,ncol=4)
z
for(i in 1:2){
  for(j in 1:4){
    z[i,j]<-i+j #you assign to each row i, col j element the value which sum 
    #the row and col of that element, 
    #the element 1,1 is 2 the 1,2 is 3 etc etc
  }
  }
z
##      [,1] [,2] [,3] [,4]
## [1,]    2    3    4    5
## [2,]    3    4    5    6

##Note: you can always nest loops (using for, while) and nest if
##clauses too: be careful in using brackets!

# BREAK a loop----

#' break breaks out of a for, while or repeat loop; 
#' control is transferred to the first statement outside
#' the inner-most loop. next halts the processing of the 
#' current iteration and advances the looping index. 

for(i in 1:100) {
  print(i)
  
  if(i > 20) {
    ## Stop loop after 20 iterations
    break  
  }		
}

count <- -10
while(count < 10) {
  print(count)
  if (count==4){
    count <- count + 1
    break
  }
}


## Functions----

sqrt(2)
##Some useful functions:
## sqrt(x)                Square root of x
## abs(x)                 Absolute value
## exp(x)                 Exponential
## log(x)                 Natural logarithm
## log10(x)               Base 10 logarithm
## ceiling(x)             Closest integer not less than x
## floor(x)               Closest integer not greater x
## round(x)               Closest integer to the elemen


## NOTE: functions to avoid loops----
#' these are best option to do something that you'd do with a loop


## APPLY---- 
## applies a function to sections of a data frame (and matrices)
## and returns the results in an array

dat1 <- airquality

apply(X=airquality,MARGIN=2,FUN=mean)

# MARGIN assignment matrix 1 indicates rows, 2 indicates columns, c(1, 2) both rows and columns

##     Ozone   Solar.R      Wind      Temp     Month       Day 
##        NA        NA  9.957516 77.882353  6.993464 15.803922

## same as:
colMeans(airquality)
colMeans(airquality,na.rm=TRUE)

# takes Data frame or matrix as an input and gives output in vector, list or array.

m1 <- matrix(runif(30,0,1),nrow=5, ncol=6)
m1
a_m1 <- apply(m1, MARGIN=2, sum) #sum of columns
a_m1
sum(m1[,1])
a_m2 <- apply(m1, MARGIN=1, sum) #sum of rows
a_m2
sum(m1[1,])


#LAPPLY----
#'lapply returns a list of the same length as X, 
#'each element of which is the result of applying FUN to the corresponding element of X.


dat1 <- airquality

sum.dat.1 <- (lapply(airquality, median))

#to convert a list into vector use UNLIST function
unlist(sum.dat.1)

##you can write you own function, that will have the same properties of all R functions:

## functionName<-function(arg1, arg2){
##        do this using arg1 and arg2
##      }
  
## Note: as in other programming language "arg1" is a local variable
##       (variable scope) and "exist" only within the function code
## Note2 You can specify many arguments, but you don't need to use all
## the arguments when you call your function (LAZY EVALUATION)


f <- function(a, b = 1, c = 2, d = 0) {
  return(a+b+d)
  
}
f(2)
f(1,2,3,1)

f(b=1, a=2, d=1, c=3)

#LAZY EVALUATION #2
f <- function(a, b) {
  a^2
}
f('2')

#LAZY EVALUATION #3
f <- function(a, b) {
  print(a)
  print(b)
}
f(45)
#in this case you need to set all the arguments

#LAZY EVALUATION #4
f <- function(a, b) {
  return(a+b)
}
f(3)
#it's like you are dividing(adding) by nothing this case all arguments are 
#mandatory because tou are using them


f <- function(num) {
  for(i in seq_len(num)) {
      cat("Hello, world!\n")
  }
}
f(3)
ggplot2()
## To be executed, your function must be loaded in memory
## ways to load you function in memory:
## 1. typed directly the function code on the keyboard in the R interpreter
##    or copy and paste them from an editor.
## 2. if the function has been saved in a text file, it can be loaded with source("FileName") (see ?source)

source('src/nesting_function.R')
ctok(ftoc(160))


#another function
y <- 10
f <- function(x) {
  y <- 2
  #print(y)
  y^2 + g(x)
}

f(3)

g <- function(x) {
  x * y
}

f(3)
# [1] 2 (print y)
# [1] 34

# Another way to write correctly the two above is use nested function

f <- function(x) {
  y <- 2
  g <- function(x) {
    return(x * y)
  }
  y^2 + g(x)
  
}
f(3)
#[1] 10

# Why this? **

# RETURN in FUNCTIONS

#' If there are no returns from a function, 
#' the value of the last evaluated expression is returned automatically in R.

check <- function(x) {
  if (x > 0) {
    result <- "Positive"
  }
  else if (x < 0) {
    result <- "Negative"
  }
  else {
    result <- "Neither positive or negative"
  }
  return(c((paste('the result is', result)),x))
}

x <- check(0) 
x
#the return is the last expression evaluated

#'Write a function that find the maximum value of a vector 
#'(there is a built in function)

find.max <- function(x)
{
   n <- length(x)  #to n is assigned the lenght of the vector x
   x.m <- x[1]     #assign to this the first element
   ix.m <- 1       #and assign this the index of the first element
   if(n > 1)       #if condition n>1 then
   {
      for( i in seq(2,n,by=1) )  #loop over the sequence of the length of the vector by 1
      {
         if(x[i] > x.m)          #if condition of i^th element gr than xm
         {
            x.m <- x[i]          #xm take the element i
            ix.m <- i            #update also the index
         }
      }
   }
   #return the maximum value and the index
   return(c(x.m,ix.m))
}

x <- runif(12)
x

find.max(x)
?runif
# Nesting Function----
#function which take the degree in F and convert into C
ftoc <- function (f){
  temp.c = ((f-32)*5)/9
  return (temp.c)
}
ss=ftoc(32)
ss
#function which take the degree in C and convert into K

ctok <- function (c){
  temp.k = c + 273.15
  return (temp.k)
}

#what if want to change directly from F to K?
ctok(ftoc(160))

### SOLVE EQUATIONS

quadraticRoots <- function(a, b, c) {
  #print first a messages with a paste message
  print(paste0("You have chosen the quadratic equation ", a, "x^2 + ", b, "x + ", c, "."))
  #calculate the discriminants
  discriminant <- (b^2) - (4*a*c)
  #but first apply some rules
  if(discriminant < 0) {
    return(paste0("This quadratic equation has no real numbered roots."))
  }
  else if(discriminant > 0) {
    x_int_plus <- (-b + sqrt(discriminant)) / (2*a)
    x_int_neg <- (-b - sqrt(discriminant)) / (2*a)
    #return the results
    return(paste0("The two x-intercepts for the quadratic equation are ",
                  format(round(x_int_plus, 5), nsmall = 5), " and ",
                  format(round(x_int_neg, 5), nsmall = 5), "."))
  }
  #but what if remaining case... discriminant(DELTA) =0?
  else #discriminant = 0  case
    x_int <- (-b) / (2*a)
  return(paste0("The quadratic equation has only one root. This root is ",
                x_int))
}


##----------------------------------
## Reading/writing data from files  INPUT--OUTPUT----


library (MASS)
library(tidyverse)
data()
df <- sleep
args(write.table)
uscereal
write.table(uscereal,file="data/cereal.txt",quote=FALSE,sep="\t",row.names=F) #col.names=TRUE
write.csv(df,file="data/lab.csv",quote=FALSE,row.names=FALSE) #col.names=TRUE


args(read.table)
lab.data <- read.delim("5. Data Frames, Functions, Data Import and Export-20210723/students.csv",header=F, sep=',')
lab.data
lab.data <- read.delim("data/lab.txt",header=TRUE, sep='\t')
lab.data <- read.csv("data/lab.csv", sep=',')
lab.data
##read.csv
##read.delim
lab.data


#IFELSE clause 
lab.data$exambin <- ifelse(lab.data$exam=="YES",1,0)
lab.data
#you need to correct a value why?

lab.data$exam[5] <- 'YES'


#**---- 
#*because y = 10 is assigned, but to the global not inside
#*the function variable
#* With lexical scoping the value of y in the function g is looked
#* up in the environment in which the function was defined, in
#* this case the global environment, so the value of y is 10.
#* With dynamic scoping, the value of y is looked up in the
#* environment from which the function was called (sometimes
#* referred to as the calling environment).

#*Introduction to the R Language - Functions
