##List of selected high-level plotting functions:
##***********************************************
## plot(x)        basic x-y plot
## boxplot(x)     "Box and whiskers" plot
## hist(x)        Histogram of the frequencies of x
## barplot(x)     Histogram of the values of x


require(ggplot2)
## A. BASIC PLOTS

x <- seq(0, 3, length.out=30)
y <- exp(-x)
df <- data.frame(x,y)
df

p1 <- ggplot(df, aes(x,y)) + geom_point()
p1
p1+geom_point(colour='red', shape=15)
p1+geom_point(colour='blue', shape=7)
p1+geom_point(colour='blue', shape=7, size=10) #add size to point generator

# you can also change theme 

p1+ theme_test()
p1+ theme_dark(base_line_size = .10,base_size = 10)
p1+ theme_dark(base_line_size = .10,base_size = 50)

#draw a line passing throught all points
p1 + geom_line(col='pink') +geom_point()

#write the label
p1 + geom_line(col='pink') +ggtitle('My exponential plot',subtitle = 'with points and square')
p1 + geom_line(col='pink') +ggtitle('My exponential plot',subtitle = 'with points and square') +
  xlab('the x lab')+
  ylab('the y lab')

#flip the coordinates

p1 + geom_line(col='pink') +ggtitle('My exponential plot',subtitle = 'with points and square') +
  xlab('the x lab')+
  ylab('the y lab')+ 
  coord_flip()
  

  

#plot two plots side by side  
require(gridExtra)

p2 <- p1+ theme_dark(base_line_size = .10,base_size = 10)
p3 <- p1+ theme_dark(base_line_size = .10,base_size = 50)

grid.arrange(p2,p1)

grid.arrange(p2,p1,ncol = 2)





## B. BOXPLOT
##
##  outliers whisker      median         whisker
##              |           |                |
##              V           V                V
##                  +-----------+
##      o oo  |-----|       |   |------------|   ooo oo o
##                  +-----------+
##                 /\          /\
##                 ||   (box)  ||
##                hinge        hinge
##
## The hinges equal the quartiles for odd n (where n <- length(x)) and
## differ for even n.
insect.sprays <- InsectSprays
str(insect.sprays)

bp1 <- ggplot(insect.sprays, aes(x=spray, y=count)) + geom_boxplot()
bp1 +coord_flip()

bp1+geom_text(inherit.aes = T, label='point')

bp1+facet_grid(~spray) + theme_bw()



boxplot.info <- boxplot(count ~ spray, data = InsectSprays, col = "lightgray")
boxplot.info$stats

## log 

orchards.sprays <- OrchardSprays

bp2 <- ggplot(orchards.sprays, aes(x=decrease, y=treatment)) + geom_boxplot() +coord_flip()
bp2
#'Sometimes is difficult to read boxplot especially if there are high values or
#'you want to rescale 
bp2

#solution is
bp2.l <- ggplot(orchards.sprays, aes(x=log(decrease), y=treatment)) + geom_boxplot() +coord_flip()
bp2.l

bp2.s <- ggplot(orchards.sprays, aes(x=(decrease/1005), y=treatment)) + geom_boxplot()
bp2.s

bp2.s <- ggplot(orchards.sprays, aes(y=(decrease), x=treatment)) + geom_boxplot()+
  scale_y_log10()
bp2.s


## C. HISTOGRAMS

pl.hist <- ggplot(orchards.sprays, aes(x=decrease)) + geom_histogram()
pl.hist


pl.hist <- ggplot(orchards.sprays, aes(x=decrease)) + geom_histogram(binwidth = 10)
pl.hist


## D. BARPLOTS
expenses <- data.frame(cost=c(350, 150, 100, 120, 140),
                      descr=c("rent", "utilities", "fuel", "food", "leisure"))

p.bar<-ggplot(data=expenses, aes(x=cost, y=descr)) +
  geom_bar(stat="identity")

p.bar
p.bar +coord_flip()

p.bar<-ggplot(data=expenses, aes(x=descr, y=cost)) +
  geom_bar(stat="identity", width=0.5)

p.bar<-ggplot(data=expenses, aes(x=descr, y=cost)) +
  geom_bar(stat="identity", width=0.5)
p.bar

p.bar<-ggplot(data=expenses, aes(x=descr, y=cost)) +
  geom_bar(stat="identity", color="blue", fill="white")
p.bar

p.bar<-ggplot(data=expenses, aes(x=descr, y=cost)) +
  geom_bar(stat="identity", fill="steelblue")+
  theme_minimal()
p.bar

p.bar<-ggplot(data=expenses, aes(x=descr, y=cost)) +
  geom_bar(stat="identity", fill="steelblue")+
  geom_text(aes(label=descr), vjust=-0.3, size=6.5)+
  theme_minimal()
p.bar

p.bar<-ggplot(data=expenses, aes(x=descr, y=cost)) +
  geom_bar(stat="identity", fill="steelblue")+
  geom_text(aes(label=descr), vjust=1.6, color="white", size=3.5)+
  theme_minimal()
p.bar


## EXAMPLE UScereal
## ---------------
library(MASS)
uscereal <- UScereal

dim(UScereal)
str(UScereal)
summary(UScereal)

## EG1: plot(xdata,ydata) - the standard x-axis vs. y-axis plot

p1 <- ggplot(uscereal,aes(potassium, protein, color=mfr))+
  geom_point()
p1


p1 <- ggplot(uscereal,aes(potassium, protein, color=mfr))+
  geom_boxplot()
p1

png('data/output.png', width=10, height = 10, units = 'cm', res=400)
p1
dev.off()


plot(UScereal$potassium, UScereal$protein)
plot(UScereal$mfr,UScereal$potassium) ## mfr is a factor -> plot
                                      ## defaults to boxplot
plot(as.numeric(UScereal$mfr),UScereal$potassium) ## convert factor to
                                                  ## numbers and this
                                                  ## is what happens



## Histograms:
##---------------

hist(UScereal$potassium)

## Boxplots:
##---------------
##box and whiskers plot
boxplot(UScereal$potassium)
boxplot(UScereal$potassium[UScereal$mfr=="Q"], UScereal$potassium[UScereal$mfr=="R"])
boxplot(UScereal$potassium,UScereal$mfr)



##List of selected low-level plotting functions:
##***********************************************
## points(x,y)             Adds points
## lines(x,y)              Adds lines (Note: just connects points in the given order)
## abline(a,b)             Draws a line of slope a and intercept b;
## text(x, y, label="")    Adds text (label="text") at coordinates (x,y)
## title("")               Adds a main title to the plot; also can add
## legend(x,y,legend=,...) Adds a legend at coordinate x,y; see
## axis()                  Adds additional axis to the current plot

## NOTE:
## You must have already set up a plotting command with a function
## such as plot or hist to use these commands!!
## (You can set up the coordinates/axes/range without actually
## plotting anything using the option type="n")

x <- seq(0, 3, length.out=30)
y <- exp(-x)
y2 <- exp(-2*x)
y3 <- exp(-3*x)

plot(x, y, type='l', ylim=c(0, 1)) ## Initial high-level function
lines(x, y2, col="green")
lines(x, y3, col="blue")
points(rep(x[3],3), c(y[3], y2[3], y3[3]), pch=19)
abline(v=x[3], col='gray')
abline(h=y[3], col='gray', lty=3)
abline(h=y2[3], col='gray', lty=3)
abline(h=y3[3], col='gray', lty=3)
text(x[3], y3[3], "lowest")
text(x[3], y[3], "highest")

abline(v=x[10], col='pink')
abline(h=y[10], col='pink', lty=3)
abline(h=y2[10], col='pink', lty=3)
abline(h=y3[10], col='pink', lty=3)
text(x[10], y3[10], "lowest", pos=1) #bottom
text(x[10], y[10], "highest", pos=3) #top
text(x[10], y2[10], "middle", pos=2) #left
text(x[10], y2[10], "middle", pos=4) #right

legend("topright", c("rate=1","rate=2","rate=3"), col=c("black", "green", "blue"), lty=1)


## another example
hist(UScereal$sodium,breaks=20,freq=F) ## initial high-level function
abline(v=mean(UScereal$sodium),lty=3)
lines(density(UScereal$sodium))

## multiple graphs in one figure
num.rows <- 2
num.cols <- 3

par(mfrow=c(num.rows, num.cols))
for(i in 1:6)
  hist(UScereal[,i+1], col=terrain.colors(6)[i])

## a colorful function
colors() ##list of all available colors



##------------------------
##Printing plot to file
##------------------------

##EPS format
postscript("picture.eps",height=8,width=8) #open the connection
plot(UScereal$mfr,UScereal$potassium)
dev.off() #close the connection

##pdf
pdf("picture.pdf",height=8,width=8, onefile=FALSE) #open the connection
pairs(UScereal)
dev.off() #close the connection

#JPG format
jpeg("picture.jpg",height=480,width=480, quality=100)
hist(UScereal$sugar)
dev.off()

##same thing for tiff, bmp, png
