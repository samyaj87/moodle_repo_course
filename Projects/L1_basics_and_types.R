##------------
## How R works
##------------

## R is an interpreted language (not compiled):
## prompt '>' indicates that R is waiting for commands
## all commands typed in the R interpreter are directly executed
## If an expression is used as a complete command, the value is printed and lost
## e.g.

44+77
102.5-88.8
16*47
1/5

## when R is running, variables, data, functions, results, etc, are stored in
## the active memory of the computer in the form of objects which have a name





##--------------------------------
## how to handle objects in memory
##--------------------------------

##creating an object: assign a value into a variable
a <- 15
a              #printing on the (interpreter) screen the value of the
               #object a
## [1] 15
print(a)
## [1] 15

A <- (2+a)*5     #this is a diffent object from a: R is case sensitive

## user can do actions on these objects with OPERATORS (arithmetic,
## logical, comparison) or FUNCTIONS (which are themselves objects)
aA <- a+A
b <- sqrt(a)

## to execute a function write it with paretheses even if no arguments
## are passed through (default values are often defined) e.g.

ls() #function for listing objects in memory - executes the function
ls   ##prints the function code

##Note: object names can contain . or _
my.value <- 5+a

## Some special words CAN NOT be used as names for user objects, such
## as FALSE, TRUE, Inf, NA, NaN, NULL, break, else, for, function, if,
## in, next, repeat, while, ... These are needed for special
## programming structures which we will see later on.

## Object names c, q and t are by default used for built-in functions
## of R: they can be re-assigned but the corresponding functions will
## not be accessible; also, object names T and F are recognized as
## TRUE and FALSE unless they are re-assigned to variables
## (DANGEROUS!)

save.image("my.Rdata")  #saving all objects in memory (workspace
                        #image) into a file on disk called my.Rdata
                        #(into the working directory)

q() #quit the R program and usually you will be asked to save the
    #workspace image ('y' answer is equivalent to save.image(); 'c'
    #cancels quit request)

rm("A")   #erasing object A from workspace/memory (not from an .Rdata file)
rm(list=ls()) # erase all objects from workspace

load("my.Rdata")        #loading all objects previously saved into my.Rdata file (*)

getwd() #retrieving information about working directory: where the .RData file be saved
        #if you want to load data from file this is the starting directory for R




##----------------------------------
## how/where to find help!
##----------------------------------

?ls        #provide access to documentation of the ls function         
help("ls") #idem

args("rm")  #listing function arguments

help.search("normal") #! searching with keywords (alias, concept or title matching the keyword)
apropos("norm")    #finds all functions which name contains the character sting given as argument

help.start()     #loads help in html format (requires java)

##on the web: here are some useful links
##http://cran.r-project.org/manuals.html                 #list of R manuals
##http://cran.r-project.org/other-docs.html              #Contributed Documentation (English)
##http://cran.r-project.org/doc/manuals/R-intro.html     #html R manual
##http://addictedtor.free.fr/graphiques/                 #R graph gallery
##http://wiki.r-project.org/rwiki/doku.php               #R wiki
##http://www.mayin.org/ajayshah/KB/R/index.html          # R by examples




##--------------------------------
## Data types and data structures
##--------------------------------

## R Objects have type, mode, storage mode

## TYPE OR MODE
## -it is the basic type of the elements of the object.
## -there are 4 main modes: numeric, character, complex, logical (TRUE/FALSE)
num <- 1
char <- "Double quotes \" delimitate R's strings."


## STORAGE MODE:
## - generally used when calling functions written in another
##   language, such as C or FORTRAN, to ensure that R objects have the
##   data type expected by the routine being called

typeof(num) #Determine the type of an object
## [1] "double"
class(num)   #Get or set the storage mode of an object.
## [1] "numeric"
class(char)
## [1] "character"

##handling R objects: checking/changin data types and data structures
##*********************************************************************
num <- 1:15
is.numeric(num)
num <- "3"
class(num)
as.numeric(num)

char <- "Double quotes \" delimitate R's strings."
is.character(char)
char = 36
char
as.character(char)

a <- TRUE
is.logical(a)
a <- "TRUE"
is.logical(a) #FALSE
a <- as.logical(a)
is.logical(a)
as.numeric(a)

as.numeric(FALSE)




## A.VECTORS
##**********

new <- vector(mode="numeric", length=5)
new
new <- vector(mode="character", length=5)
new
new <- vector(mode="logical", length=5)
new

## IMPORTANT: c() concatenates arguments!!!
## Some examples:
##------------------
## 1. numeric
##************
x <- c(10.4, 5.6, 3.1, 6.4, 21.7) #concatenates objects in parenthesis

length(x) 
x

## another way to define vectors: sequences
x1 <- seq(from=1,to=5,by=0.4)
x1 <- seq(from=5,to=1,by=-1)
x2 <- 1:10
x2 <- 10:1
x3 <- rep(x2, times=5)
x4 <- rep(x2, each=5)

## !!! operations between vectors are made element by element
x + x1

## CAUTION!!!: if vectors have different lengths, they may be
## recycled (longer vector needs to be multiple of longer one)

XX <- c(x, x1)
length(XX)
Z <- (1:5)
length(Z)

XX+Z

XX+10
XX*5



##Note:indexing

labs <- c(seq(1,10, by=1.5), 7:2, rep(3.7, 2))
length(labs)

##***************
#index vectors can be any of four distinct types:

##   1. vector of positive integral quantities. 
labs[1]   #first element
labs[1:2] #first two elements
labs[c(1:2,5)] #element 1, 2, and 5 of the vector labs
labs[13:16]   ##adds an NA since labs has only 15 elements

##   2. vector of negative integer quantities
labs[-5]           #all elements of labs but the 5th
y <- labs[-(1:5)]  #all but the first five elements of labs
y

##   3. logical vector.
x <- c(1:5,NA,7:9)
x
y <- x[!is.na(x)]
y
!is.na(x)
z <- x[(!is.na(x)) & x>4]
z

x <- c(7, 14, 2, 8, 4.6)
which(x<5) #indexes corresponding to x < 5
x[which(x<5)] #values of x < 5
x[x<5]        #same result, but different way of indexing


##   4. vector of character strings.
##      ONLY applies where an object has a names attribute to identify its components
fruit <- c(5, 10, 1, 20)
names(fruit) <- c("orange", "banana", "apple", "peach")
lunch <- fruit[c("apple","orange")]
lunch
##see dataframes!



##Note: ARITMETIC OPERATORS
##*****************************
2+2   ##addition
2+x2  ##addition (vectorized)
x2+x2 ##addition (vectorized)

2-2   ##subtraction
2-x2  ##subtraction (vectorized)
x2-x2 ##subtraction (vectorized)

2*2   ##multiplication
2*x2  ##multiplication (vectorized)
x2*x2 ##multiplication (vectorized)

2^2   ##power
x2^x2 ##power (vectorized)

6/4   ##division

6%/%4 ##integer division
6%%4  ##module

##Note: COMPARISON OPERATORS
##*****************************
6<8   ##less than
x2<5  ##less than (vectorized)

x2>5  ##greater than (vectorized)

x2<=5  ##less than or equal to (vectorized)

x2>=5  ##less than or equal to (vectorized)

x2==5  ##equal (vectorized)

x2!=5  ##different (vectorized)

## other useful functions
A <- sum(x1)
A1 <- x1[1]+x1[2]+x1[3]+x1[4]+x1[5]
A==A1

y <- c(10, 30, 50, 20, 40) 
order(y)    ## permutation rearranging y into ascending order: return idexes
y[order(y)] ## equivalent to sort(y)
sort(y)
sort(y, decreasing=TRUE)


## basic statistical functions
x1 <- rnorm(100) # sample 100 elements from a normal distribution with
                 # mu=0 and sigma=1
summary(x1) 
mean(x1)
median(x1)
min(x1)
max(x1)
range(x1)
sd(x1)
var(x1)
quantile(x1, probs = c(0.25, 0.75))
## Note:
## The 2-quantile is called the median.
## The 4-quantiles are called quartiles: probs = seq(0, 1, 0.25)
quantile(x1, probs = c(0.16, 0.81, 0.95))


x1[2] <- NA # Handling missing values
summary(x1) 
mean(x1) #NA
mean(x1,na.rm=T)
#the same holds for median(), min(), max(), range(), sd(), var(), quantile()

## 3. logical
##*************
x5 <- c(FALSE,TRUE,FALSE,FALSE)
x6 <- c(rep(T,2),rep(F,2))
x7 <- x > 6

##Note: LOGICAL OPERATORS
##************************
!x5           #logical NOT
x5 & x6       #logical AND (vectorized)
x5 | x6       #logical OR (vectorized)





## B. FACTOR
##***************
factor.example <- factor(c("high","medium","low","low","medium","high"))
summary(factor.example)
##   high    low medium 
##      2      2      1
factor.example == factor(c(3,2,1,1,2,3),levels=3:1,labels=c("high","medium","low"))
factor.example <- factor(c("high","low","low","medium","high")) ##change levels ordering

levels(factor.example)

factor.example1 <- factor(1:5, labels=toupper(letters[c(1:3,5)]),exclude=4)
summary(factor.example1)
table(factor.example1)
a <- factor(c(3,2,1,1,2,3),levels=3:1,labels=c("short","medium","tall"))
b <- factor(c(1,3,2,3,1,1),levels=1:3,labels=c("light","medium","heavy"))
table(a, b)



## C. MATRICES
##**************
## matrix()
## 1st arg: c(2,3,-2,1,2,2) the values of the elements filling the columns
## 2nd arg: 3 the number of rows
## 3rd arg: 2 the number of columns

mat <- matrix(data=1:6, nrow=2,ncol=3)
mat2 <- matrix(data=1:6, nrow=2,ncol=3, byrow=T)
mat
mat2

##Other ways to create a matrix starting from vectors:
##(1)
x <- 1:15
dim(x)
dim(x) <- c(5,3)
x

##(2) use
##rbind(): combine R objects (vectors) by rows
##cbind()  combine R objects (vectors) by columns

z <- seq(2,3,0.5)
y <- 1:length(z)

mat2 <- rbind(y,z)

##check that is a matrix:
is.matrix(mat2) #TRUE

##matrix attributes:
dim(mat)
nrow(mat)
ncol(mat)
colnames(mat) <- c("A","B","C")
rownames(mat) <- c("r1","r2")

#indexing matrices
mat[1,]   #first row
mat[,1]   #first column
mat[,"A"] #column named A
mat[2,"A"]#second elemnt of the A column
mat["r2", c("A","C")] # row r2, elements A and C

                                       #matrix operations
3*mat #Multiplication by a Scalar
mat+mat2 #Matrix Addition 
mat-mat2 #Matrix Subtraction
m <- mat*mat2 #Multiplication element wise
mat^2

tmat <- t(mat) #Transpose of a Matrix
tmat
t(tmat)


##other functions:
colSums(mat) #Computing Column Sums
rowSums(mat)   #Computing Row Sums
sum(mat) # sum of all elements
range(mat) # min and max of all elements
colMeans(mat) #Computing Column Means
rowMeans(mat) #Computing Row Means
mean(A)



## D.DATAFRAMES
##**************

dat1 <- data.frame(position=1:24, evaluation=runif(24,min = -10, max = 10), test=rep(c(T,T,F), 8))
dat1


##dataframe attributes:
dim(dat1)
nrow(dat1)
ncol(dat1)
names(dat1)

##indexing dataframes:
dat1[1,]        #first row

dat1[,1]        #first column
dat1[[1]]       #first column #not used often
dat1[,"position"] #columnn named "position" (the first)
dat1$position     #columnn named "position" (the first)

dat1[2,3] #second element of the third column

dat1[dat1$test==TRUE,] ##all rows of the dataframe having "test" equal to TRUE
dat1[dat1$test==TRUE,1] ##all "position" element having "test" equal to TRUE

##other useful functions:
summary(dat1)  #"summary" info per column
str(dat1)      #dataframe structure
head(dat1)     #the first rows of the data frame

##default datasets
data()         #lists all available example datasets

data(airquality)
?airquality
summary(airquality)
summary(iris)



##another example
##------------------
n <- c("Name","Height","Weight","Age","Gender","Glasses")
length(n)
c1 <- c("Michael","Mark","Robert","Joseph","Shirley","Laura","George","David")
length(c1)
c2 <- c(1.68,1.83,1.82,1.77,1.72,1.63,1.68,1.74)
length(c2)
c3 <- c(61,65,83,72,62,55,62,71)
length(c3)
c4 <- c(27,32,26,39,37,29,31,29)
length(c4)
c5 <- c("m","m","m","m","f","f","m","m")
length(c5)
table(c5)
c6 <- c(F,T,T,T,F,F,F,F)
length(c6)

lab <- data.frame(cbind(c1,c2,c3,c4,c5,c6))
names(lab) <- n
summary(lab)
str(lab)

lab <- data.frame(cbind(c1,c2,c3,c4,c5,c6),stringsAsFactors=F)
names(lab) <- n
str(lab)
lab$Height <- as.numeric(lab$Height)
lab$Weight <- as.numeric(lab$Weight)
lab$Age <- as.numeric(lab$Age)
lab$Gender <- as.factor(lab$Gender)
lab$Glasses <- as.logical(lab$Glasses)
str(lab)
summary(lab)

lab[lab$Gender=="f","Height"]
lab[lab$Gender=="m","Height"]
mean(lab[lab$Gender=="f","Height"])
mean(lab[lab$Gender=="m","Height"])

lab[lab$Gender=="f","Weight"]
lab[lab$Gender=="m","Weight"]
mean(lab[lab$Gender=="f","Weight"])
mean(lab[lab$Gender=="m","Weight"])
