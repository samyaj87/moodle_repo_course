# R code snippets from slides
# Slide file:  Intro to Data Analysis/Lesson3


# Running R Code
# ==========
1 + 2
(10 + 20) * 2
2 * pi


# Packages
# ==========
install.packages("ggplot2")

library("ggplot2")


# Basic objects
# ==========
a = 10  # equivalent to a <-10 - assign
a  # view

A


# Strings
# ==========
string1 <- "This is a string"
string2 <- 'If I want to include a "quote" inside a string, I use single quotes'

double_quote <- "\"" # or '"'
single_quote <- '\'' # or "'"


# String length
# ==========
library(stringr)
string1
str_length(string1)


# Combining strings
# ==========
str_c("x", "y")
str_c("x", "y", "z")

str_c("x", "y", sep = ", ")


# Subsetting strings
# ==========
string1
str_sub(string1, 1, 8)
str_sub(string1, 6, 7)


# Vectors
# ==========
x = c(7, 33, 12, 14, 2)
x


# Numeric Vectors
# ==========
xNum  = c(1, 3, 5, 7)
xNum
xNum  = c(1.29, 3.14, 54.51, 23.71)
xNum
xNum  = c(1, 7.53, 5, 7)
xNum



# Integers and Doubles
# ==========
typeof(1)
typeof(1L)


# Integers and Doubles
# ==========
x <- sqrt(2) ^ 2 # squared root
x
x - 2


# Infinite and Impossible numbers
# ==========
c(-1, 0, 1) / 0

sv = 1/0
is.finite(sv)


# Logical Vectors
# ==========
xLog  = c(TRUE, FALSE, TRUE, TRUE)
xLog
typeof(xLog)



# Character Vectors
# ==========
xChar = c("cat", "boo", "flower", "far") #xChar is a vector of strings
xChar
typeof(xChar)

require(stringr)
str_c(xChar, collapse = ", ")


# Subsetting Character Vectors
# ==========
s <- c("Apple", "Banana", "Pear")
str_sub(s, 1, 3)
str_sub(s, -3, -1) #negative numbers count backwards from end

str_sub(s, 1, 1) <- str_to_lower(str_sub(s, 1, 1)) #convert to lower case
s


# Vectors: Type Coercion
# ==========
xMix  = c(1, TRUE, 3, FALSE) 
xMix
xMix  = c(1, TRUE, 3, "Hello, world!") 
xMix


# More about Vectors
# ==========
x
x2 = c(x, x)
x2
y = c(1,3,5,7)
x3 = c(x, y)
x3


# More about Vectors
# ==========
c(x, 100)
c(x, "Hello")


# Forcing Coercion
# ==========
w = "7"
w; typeof(w)
z = as.numeric(w)   # forces it to "numeric"
z; typeof(z)


# Test Functions
# ==========
library(purrr)
w
is_integer(w)
is.character(w)


# Math on Vectors
# ==========
x
x + 1 # add
x - 2 # subtract


# Math on Vectors
# ==========
x
x * 2 # multiply
x / 2 # divide


# Length
# ==========
x
length(x)
length(c(x,x))


# Structure
# ==========
str(x)
str(xChar)


# Summary
# ==========
summary(xNum)
summary(xChar)

