remove(list = ls())
library("tidyverse")
library("lubridate")
library("nycflights13")

#0)
x <- "1970-01-01"
y <- as.Date(x)
print(y)


as.Date("2020-11-03")


as.Date("11/03/2020", format = "%m/%d/%Y")

as.Date("November 3, 2020", format = "%B %e, %Y")


x <- c(20090101, "2009-01-02", "2009 01 03", "2009-1-4",
       "2009-1, 5", "Created on 2009 1 6", "200901 !!! 07", "2020/11/20")
ymd(x)

dmy('20/1/2020')

myd(c('11/02/2020','November 12,2020'))

dates  <- c("04/10/1964", "06/18/1965", "09/21/1966")


ndates <- as.Date(dates, format="%m/%d/%Y")

strftime(ndates, format="%Y")

#4)
names(flights)
flights.ss <- sample_n(as.data.frame(flights),5000,replace = F)
names(flights.ss)

#5)
flights.ss <- as.data.frame(flights.ss)

#6)
flights.ss <- na.omit(flights.ss)

#7)
flights.ss <- flights.ss[,c(10,1,2,3,17,18,15,6,9)]

flights.ss.2 <- subset(flights.ss,select=c("carrier","year",
                                               "month","day","hour",
                                               "minute","air_time", 
                                               "dep_delay", "arr_delay"))

#8)
flights.ss$dep_time <- make_datetime(year = flights.ss$year, 
                                   month = flights.ss$month,
                                   day = flights.ss$day,
                                   hour = flights.ss$hour,
                                   min = flights.ss$minute)


#8.1)
flights.ss$day_of_week <- wday(flights.ss$dep_time, label = T)

str(flights.ss)


#9) create the column arrival time
flights.ss$arrival_time <- flights.ss$dep_time+minutes(flights.ss$air_time)

#10) create the column arrival time
flights.ss$real_departure <- flights.ss$date_time+minutes(flights.ss$dep_delay)


#11) create the column 
flights.ss$real_arrival <- flights.ss$arrival_time+minutes(flights.ss$arr_delay)
names(flights.ss)


#12)
p3 <- ggplot(flights.ss, aes(day_of_week, fill=carrier))+ geom_histogram(stat = 'count') + 
  theme(axis.text.x = element_text(angle = 35, vjust = .5 ))

p3+ theme_classic()+theme(axis.text.x = element_text(angle = 35, vjust = .5 ))

#13)
p1 <- ggplot(flights.ss, aes(dep_time, color=carrier))+ geom_freqpoly()
p1 + theme_classic()

p1+theme_minimal()


#14)
p2 <- ggplot(flights.ss, aes(carrier, arrival_time))+ geom_boxplot() + 
  theme(axis.text.x = element_text(angle = 35, vjust = .5 ))

p2

