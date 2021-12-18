#Author: Samantha Ajovalasit
# 
#'  0)Preliminary
#'  create a date of your choice and set as date
#'  
x <- "1970-01-01"
y <- as.Date(x)
print(y)
class(x)
#'  format the date with the following formats 
#'  
#'  (year-month-day)
#'  (year/day/month)

as.Date("11/03/2020", format = "%m/%d/%Y")

y <- as.Date("November 3, 2020", format = "%B %e, %Y")
#'  create a vector of dates and get the year then get the months
#'  
#'  
y[1]

year(y)
day(y)

x <- c(20090101, "2009-01-02", "2009 01 03", "2009-1-4",
       "2009-1, 5", "Created on 2009 1 6", "200901 !!! 07", "2020/11/20" ,'1638438200')


ymd(x)


dmy('20/1/2020')

#'  1)Clean all data from your Global Environments
#'  
#'  
#'  2)Get from the library(nycflights13) the flights dataset. 
#'  Note that you may need to install the library
#'  
#'  3)Load library tidyverse, and type 
#'  
#'  Type set.seed(1)
#'  
#'  4)Load the dataset "flights" and subset 5000 random observations, without
#'  replacement ()
names(flights)
set.seed(1)
names(flights)
flights.ss <- sample_n(as.data.frame(flights),5000,replace = F)
names(flights.ss)
#'  5)Since it is a tibble (dataframe structure of tidyverse library) convert it
#'  as a standard data.frame
flights.ss <- as.data.frame(flights.ss)
#'  6)Remove the NA rows from flights dataset
#'  
#'  
flights.ss <- na.omit(flights.ss)
#'  7)Subset the column from the dataset in the follwing order
#'  
#'  [1] "carrier"   "year"      "month"     "day"       "hour"      "minute"   
#'  [7] "air_time"  "dep_delay" "arr_delay"
names(flights.ss)
flights.ss <- flights.ss[,c(10,1,2,3,17,18,15,6,9)]

flights.ss.2 <- subset(flights.ss,select=c("carrier","year",
                                           "month","day","hour",
                                           "minute","air_time", 
                                           "dep_delay", "arr_delay"))

#'  8) Create a new column dep_time from the column year, month, day, hour,
#'  minute (use make_datetime)
#'  

flights.ss$dep_time <- make_datetime(year = flights.ss$year,
                                     month= flights.ss$month,
                                     day= flights.ss$day,
                                     hour= flights.ss$hour,
                                     min= flights.ss$minute)
                                     
#'  8.1) get the day of week of departure time and store in a new column
#'  hint(search ?wday)

flights.ss$day_of_week <- wday(flights.ss$dep_time, label = T)

#'  9) Create the column arrival time (add to dep_time minutes) use minutes(...)

flights.ss$arrival_time <- flights.ss$dep_time+minutes(flights.ss$air_time)


#'  10) Create the column real_departure time (add to dep_delay minutes) use minutes(...)

flights.ss$real_departure <- flights.ss$dep_time+minutes(abs(flights.ss$dep_delay))
  
#'  11) Create the column real_arrival time (add to arr_delay minutes) use minutes(...)

flights.ss$real_arrival <- flights.ss$arrival_time+minutes(abs(flights.ss$dep_delay))+
  minutes((flights.ss$arr_delay))



#'  12) Plot the histogram of the count of day flights and fill the bar by carrier

p3 <- ggplot(flights.ss, aes(day_of_week, fill=carrier)) + 
  geom_histogram(stat = 'count')
p3+scale_fill_viridis_d()
#'  13) Plot the frequency polygons (hint search geom_freqpoly) of the 
#'  departure time

p4 <- ggplot(flights.ss, aes(dep_time, color=carrier)) + geom_freqpoly()
p4
#'  13.1) Plot the above with two different themes
#'  
#'  13.2) differentiate by color the carrier of the flights
#'  
#'  14) Plot the boxplot of carrier flights over the arrival time, 
#'  rotate the x labels by 45 degrees
p2 <- ggplot(flights.ss, aes(carrier, arrival_time))+ geom_boxplot() + 
theme(axis.text.x = element_text(angle = 45, vjust = .5 ))
p2

#'  