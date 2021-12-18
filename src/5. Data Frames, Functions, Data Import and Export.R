# R code snippets from slides
# Slide file:  Data Frames, Functions, Data Import and Export/Lesson5


# Data frames
# ==========
xNum  = c(1, 3, 5, 7)
xLog  = c(TRUE, FALSE, TRUE, TRUE)
xChar = c("cat", "boo", "flower", "far")


# Data frames
# ==========
x.df = data.frame(xNum, xLog, xChar)
x.df

x.df[2,1]
x.df[1,3]


# Data frames
# ==========
x.df
x.df[1,3]
x.df = data.frame(xNum, xLog, xChar, stringsAsFactors=FALSE)
x.df[1,3]


# Indexing data frames
# ==========
x.df
x.df[2, ]  # row 2
x.df[ ,3]  # column 3


# Indexing data frames
# ==========
x.df
x.df[2:3, ] # rows from 2 to 3
x.df[1, 1:2] # row 1 AND columns from 1 to 2


# Indexing data frames
# ==========
x.df
x.df[c(1,3), ] # rows 1 AND 3


# Negative indexing data frames
# ==========
x.df[-3, ]  # omit the third row
x.df[, -2]  # omit the second column


# When Should you Write a Function?
# ==========
df = data.frame(a = rnorm(5),
                b = rnorm(5),
                c = rnorm(5))
str(df)


# When Should you Write a Function?
# ==========
df$a = (df$a - min(df$a, na.rm = TRUE)) / 
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))
df$b = (df$b - min(df$b, na.rm = TRUE)) / 
  (max(df$b, na.rm = TRUE) - min(df$a, na.rm = TRUE))
df$c = (df$c - min(df$c, na.rm = TRUE)) / 
  (max(df$c, na.rm = TRUE) - min(df$c, na.rm = TRUE))
str(df)


# When Should you Write a Function?
# ==========
(df$a - min(df$a, na.rm = TRUE)) /
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))


# When Should you Write a Function?
# ==========
(df$a - min(df$a, na.rm = TRUE)) /
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))

(x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))


# When Should you Write a Function?
# ==========
my_rescale <- function(x){
  (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
}
my_rescale(df$a)
my_rescale(df$b)
my_rescale(df$c)


# When Should you Write a Function?
# ==========
my_rescale2 <- function(x) {
  rng <- range(x, na.rm = TRUE) # returns a vector containing the minimum and maximum
  (x - rng[1]) / (rng[2] - rng[1])
}

my_rescale2(df$a)
my_rescale2(df$b)
my_rescale2(df$c)


# Writing Basic Functions
# ==========
se = function(x) { sd(x) / sqrt(length(x)) } #standard error


# Document your functions inline!
# ==========
se = function(x) {
  # computes standard error of the mean
  tmp.sd = sd(x)      # standard deviation
  tmp.N  = length(x)  # sample size
  tmp.se = tmp.sd / sqrt(tmp.N)   # std error of the mean
  return(tmp.se)       # return() is optional but clear
}


# How to Set the Working Directory
# ==========
setwd("~/CM0579/Coding")

getwd()


# Reading From a File
# ==========
read.csv(<path>) # reads comma delimited files
read.csv2(<path>) # reads semicolon delimited files
read.table(<path>) # reads files in table format

students = read.csv("students.csv", stringsAsFactors = F) # the file is in the working directory
str(students)


# Reading From a File
# ==========
students = read.table("students.csv", sep = ",", header = T)
str(students)


# Writing to a CSV File
# ==========
write.csv(students, "students_from_R.csv", row.names = F)


# Writing to a Tab-delimited File
# ==========
write.table(students, "students_from_R.txt", row.names = FALSE, sep = "\t")

