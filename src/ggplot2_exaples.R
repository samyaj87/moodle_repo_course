rm(list=ls(all=T))
require(ggplot2)
require(tidyverse)

install.packages('housingData')
library(housingData)
hh=housingData::housing
str(hh)
#BoxPLot Example----
tg <- ToothGrowth
str(tg)

# Convert dose column from numeric to factor variable
tg$dose <- as.factor(tg$dose)

p <- ggplot(tg, aes(x=dose, y=len)) + geom_boxplot()+ theme_classic()




# Change the appearance and the orientation angle of axis tick labels
p + theme(axis.text.x = element_text(face="bold", color="#993333", 
                                     size=14, angle=45),
          axis.text.y = element_text(face="bold", color="#993333", 
                                     size=14, angle=45))


# Hide x an y axis tick mark labels
p + theme(
  axis.text.x = element_blank(),
  axis.text.y = element_blank())


#Choose which items to display
p + scale_x_discrete(limits=c("0.5", "2"))
# Solution 2 : same result as solution 1
p + xlim("0.5", "2")
p


#Example of Temporal Data----
# plot multiple time series using 'geom_line's
data(economics, package="ggplot2")  # init data
economics <- data.frame(economics)  # convert to dataframe+

p1 <- ggplot(economics (aes(x=date, y=pce), col='red')) + geom_line()+ 
  geom_line(aes(x=date, y=unemploy), col='blue') + 
  scale_color_discrete(name="Legend") + 
  labs(title="Economics") + ylab('ylab') + xlab=('Year')
p1

require(reshape)
df <- melt(economics[, c("date", "pce", "unemploy", "psavert")], id="date")
str(df)
p2 <- ggplot(df) + 
  geom_line(aes(x=date, y=value, color=variable))  + 
  facet_wrap( ~ variable, scales="free")
p2

#how to save a plot
png('8. Data Visualisation-20210723/plotp2.png', width = 19.5, height = 12.4, units = 'cm',res = 600)
p2
dev.off()
