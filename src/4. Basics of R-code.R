# R code snippets from slides
# Slide file:  Basics of R/Lesson4


# Sequences
# ==========
xSeq = 1:10
xSeq
ySeq = 20:30
ySeq


# Combining Operators
# ==========

zSeq = 1:5*2
zSeq

zSeq = 1:(5*2)
zSeq


# Other ways to make sequences
# ==========
seq(from=-5, to=28, by=4)
seq(from=-5, to=28, length=6)


# Indexing a vector
# ==========
xNum  = c(1, 7.53, 5, 7)
xNum[3]
xNum[2:4]


# Indexing a vector
# ==========
xNum[c(1,3)]

i = 2
xNum[i]
xNum[i:4]


# Negative indexing
# ==========
xSeq
xSeq[-1]
xSeq[-c(5,7)]


# Indexing with Boolean
# ==========
xNum
xNum[c(FALSE, TRUE, TRUE, TRUE)]

xNum[c(F, T, T, T)]


# Indexing with Boolean
# ==========
xNum
xNum > 5
xNum[xNum > 5]


# Missing values
# ==========
my.test.scores = c(91, 93, NA, NA)

mean(my.test.scores)
max(my.test.scores)


# Missing values
# ==========
my.test.scores
mean(my.test.scores, na.rm=TRUE)
max(my.test.scores, na.rm=TRUE)


# Other ways to omit
# ==========
my.test.scores
na.omit(my.test.scores)
mean(na.omit(my.test.scores))


# Other ways to omit
# ==========
my.test.scores
is.na(my.test.scores) # Is the element = NA?
my.test.scores[!is.na(my.test.scores)] # '!' is the negation operator


# Lists
# ==========
lst <- list(1, 2, 3)
lst


# Lists
# ==========
str(lst)
lst_named <- list(a = 1, b = 2, c = 3)
str(lst_named)


# Lists
# ==========
lst_mix <- list("a", 1L, 1.5, TRUE)
str(lst_mix)


# Lists
# ==========
lst_lst <- list(list(1, 2), list(3, 4))
str(lst_lst)


# Visual Representation of Lists
# ==========
x1 <- list(c(1, 2), c(3, 4))
x2 <- list(list(1, 2), list(3, 4))
x3 <- list(1, list(2, list(3)))


# Subsetting Lists
# ==========
lst_named = list(a = 1:3, b = "a string", c = pi, d = list(-1, -5))

lst_named[1:2]


# Subsetting Lists
# ==========
lst_named[[1]]
lst_named[[4]]


# Subsetting Lists
# ==========
lst_named$a
lst_named[["a"]]


# Creating Factors
# ==========
x1 <- c("Dec", "Apr", "Jan", "Mar")

x2 <- c("Dec", "Apr", "Jam", "Mar")

sort(x1) # Sort (or order) a vector or factor into ascending or descending order


# Creating Factors
# ==========
month_levels <- c( "Jan", "Feb", "Mar", 
                   "Apr", "May", "Jun", 
                   "Jul", "Aug", "Sep", 
                   "Oct", "Nov", "Dec")

y1 <- factor(x1, levels = month_levels)
y1
sort(y1)


# Creating Factors
# ==========
y2 <- factor(x2, levels = month_levels)
y2


# Factors
# ==========
data = c(1,2,2,3,1,2,3,3,1,2,3,3,1)
fdata = factor(data)
fdata

levels(fdata) = c('I','II','III')
fdata


# Factors
# ==========
weekdays = c("Thursday", "Friday", "Thursday", "Monday", "Monday", "Friday", "Tuesday", "Saturday", "Thursday", "Sunday", "Friday")
weekdays = factor(weekdays)
table(weekdays)


# Prerequisites
# ==========
library(lubridate)


# Current Date
# ==========
today()
now()


# Current Date
# ==========
as_datetime(today())
as_date(now())


# Date from a String
# ==========
ymd("2017-01-31")
mdy("January 31st, 2017")
dmy("31-Jan-2017")


# Date from a String
# ==========
ymd(20170131) 
mdy(07312017)
dmy(31072017)


# Date/Time from a String
# ==========
ymd_hms("2017-01-31 20:11:59")
mdy_hm("01/31/2017 08:01")

ymd(20170131, tz = "UTC")


# Getting components
# ==========
datetime <- ymd_hms("2016-07-08 12:34:56")
year(datetime)
month(datetime)
mday(datetime)
wday(datetime)


# Getting components
# ==========
datetime
month(datetime, label = TRUE)
wday(datetime, label = TRUE, abbr = FALSE)


# Setting components
# ==========
datetime
year(datetime) <- 2020
datetime
month(datetime) <- 01
datetime
hour(datetime) <- hour(datetime) + 1
datetime


# Setting components
# ==========
datetime
update(datetime, year = 2020, month = 2, mday = 2, hour = 2)
update(datetime, year = 2017, month = 7)


# Durations
# ==========
# How old is Leonardo Di Caprio?
h_age <- today() - ymd(19741111)
h_age

as.duration(h_age)


# Durations
# ==========
dseconds(15)
dminutes(10)
dhours(c(12, 24))
ddays(1:5)
dweeks(3)
dyears(1)


# Unexpected results..
# ==========
one_pm <- ymd_hms("2016-03-12 13:00:00", tz = "America/New_York")
one_pm
one_pm + ddays(1)


# Periods
# ==========
one_pm
one_pm + days(1) # now it's fine!


# Periods
# ==========
seconds(15)
minutes(10)
hours(c(12, 24))
days(7)
months(1:6)
weeks(3)
years(1)

