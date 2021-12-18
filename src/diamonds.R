rm(list=ls(all=T))
require(ggplot2)


str='https://r4ds.had.co.nz/data-visualisation.html'

data("diamonds")
attach(diamonds)
str(diamonds)

diamonds <- data.frame(diamonds)


#select those diamonds which are very good
diam.vg <- diamonds[diamonds$cut=='Very Good',]

#Start----
#' Start with a simple plot of diamonds. The syntaxfor ggplots follow some rules
#' Set the dataset you want to use, then use the aestetics which are the vabriable
#' to plot in x and y axis. You don't need to quote the variable. Also you don't need
#' to explict x and y, first agument is x the second is y. 

p0 <- ggplot(diamonds, aes(x=carat, y=price)) + geom_point()
p0

#Saving----
#' Save the plot. Note that you can save the plot as pdf, tiff, png and so on. 
#' Remember that you need to set the name of the format you want to store the plot 
#' both as function and extention. 
#' You can set widhth height, but also (depending on format), type of size (cm or pixel), resolution in dpi etc
jpeg('myplot.tiff',width = 1920,height =1080, res = 0)
p0
dev.off()

#' color the plot based on factor cut
p1 <- ggplot(diamonds, aes(x=carat, y=price, col=cut)) + geom_point(aes(shape=factor(clarity)))
p1
1
p2 <- ggplot(diamonds, aes(x=carat, y=price, shape=clarity)) + geom_point()
p2

#'We can change aestetics if we want to highlights the cut or another we would rather see how the quality of the color or cut of the diamond 
#'affects the price, we can change the aesthetic. 
#'Here in "aes" we change "clarity" to "color".

p3 <- ggplot(diamonds, aes(x=carat, y=price, color=color)) + geom_point()
p3


#'Now, what if we want to see the effect of both color and cut? 
#'We can use a fourth aesthetic, such as the size of the points. So here we 
#'have color representing the clarity. Let's add another aesthetic- let's say "size=cut."

p4 <- ggplot(diamonds, aes(x=carat, y=price, color=clarity, size=cut,shape = color)) + geom_point()
p4


#'Now the size of every point is determined by the cut even while the color is 
#'still determined by the clarity. Similarly, we could use the shape to represent the cut:
  
p5 <-  ggplot(diamonds, aes(x=carat, y=price, color=clarity, shape=cut)) + geom_point()
p5


#regression---- 
#smooth the trend of the price over the carat

p6 <- ggplot(diamonds, aes(x=carat, y=price)) + geom_point() + geom_smooth(se=T)
p6


#smooth with a general linear model
p7 <- ggplot(diamonds, aes(x=carat, y=price)) + geom_point() + geom_smooth(se=FALSE, method="glm")
p7


#'If you used a color aesthetic, ggplot will create one smoothing curve for each color. 
#'For example, if we add "color=clarity":
  
p8 <- ggplot(diamonds, aes(x=carat, y=price, color=clarity)) + 
  geom_point() + geom_smooth(se=FALSE)
p8
#' geom_smooth: method="auto" and size of largest group is >=1000,
#'  so using gam with formula: y ~ s(x, bs = "cs"). 
#' Use 'method = x' to change the smoothing method.


#'show this smoothing curve layer without showing your scatter plot layer, 
#'simply by removing the geom_point() layer:
  
p9 <- ggplot(diamonds, aes(x=carat, y=price, color=clarity)) + geom_smooth(se=FALSE)
p9


#faceting----

#'It allows you to wraps many plot togheter based on a particular variable. 
#'We add "facet_wrap" and we put a tilde (~) altgr+126 on windows, 
#'and then the attribute (variable) we would like to divide the plots by, here "clarity."
p10 <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point() + theme_classic() + facet_wrap(~ clarity) 
p10


mpg <- (mtcars)
str(mpg)
ggplot(mpg, aes(disp, hwy)) +
  geom_point() +
  facet_wrap(vars(cyl, gear))

#'Now let's zoom in on this. You can see that now we've divided it into eight subplots, 
#'each of which has a different "clarity" value, and you can see how the trend differs 
#'between each of those subplots. 
#'We can still see that the color is representing the quality of the cut of the diamond.

#'You can also facet yout plot for more than factor, for example we can split by color the clarity
#'and then facetwrap by cut and color using the following syntax
#' The syntax in facet means that left (~) right, with tilde means "is explained by" 

p11 <- ggplot(diamonds, aes(x=carat, y=price, color=clarity)) + geom_point() + geom_line()+
  facet_grid(color ~ cut)
p11
#Note that I also drawn a line for who connect every point on the grid, by clarity

# Add title and title and label----

#title
ggplot(diamonds, aes(x=carat, y=price)) + geom_point() + ggtitle("My scatter plot",subtitle = 'my wonderful scatter')

# label axis
ggplot(diamonds, aes(x=carat, y=price)) + geom_point() + ggtitle("My scatter plot") + ylab('this is my text "quoted"')

# set limits on the axis with the xlim, ylim
ggplot(diamonds, aes(x=carat, y=price)) + geom_point() + 
  ggtitle("My scatter plot") + xlab("Weight (carats)") + 
  xlim(0, 2) + ylim(500,2000)


#' We can do some simple manipulation on numerical data when we are drawing the plot
#' without the need of create a new field, or whatever. 
ggplot(diamonds, aes(x=carat, y=log(price)^2)) + geom_point() + ggtitle("My scatter plot") + xlab("Weight (carats)") 

diamonds$logprice <- log(diamonds$price)
str(diamonds)

#Histogram ----
#'You can easily plot the histogram of just one variable at the time, eg x or y
#'
ggplot(diamonds, aes(x=price, group=cut)) + geom_histogram()

#change the binwidth of each bin
ggplot(diamonds, aes(x=price)) + geom_histogram(binwidth=2000)

ggplot(diamonds, aes(x=price)) + geom_histogram(binwidth=200)

#you can also increase the number of bins, i.e. is quasi similar to plot a density
ggplot(diamonds, aes(x=price, color=cut)) + geom_histogram(bins = 1000)


ggplot(diamonds, aes(x=price, color=cut)) + geom_density() +geom_histogram(bins=2000)

#you can also change the size of the density 
ggplot(diamonds, aes(x=price, color=cut)) + geom_density(size=1.5)

# apply faceting to divide 
ggplot(diamonds, aes(x=price)) + geom_histogram(binwidth=10) + facet_wrap(~ cut)


#color the bin by filling the bins by the count of the price
ggplot(diamonds, aes(x=price, fill=cut)) + geom_histogram()


#'boxplot
#'
ggplot(diamonds, aes(x=cut, y=price)) + geom_boxplot()

#Plot the boxplot for cut type 
ggplot(diamonds, aes(x=cut, y=log(price,10))) + geom_boxplot()
ggplot(diamonds, aes(x=cut, y=price)) + geom_boxplot(outlier.colour = 'red') + scale_y_log10()

#'Please, note that you can scale the plot by scaling the value of the price or 
#'transformed the along the axis. Note that you can also color the outliers.
#'Try all the parameters that you can fill with the plot. 


#'The width at each point in this violin plot represents the frequency of that price. 
#'So these bumps show the prices that are more common, and we can see that indeed 
#'within some colors there 'is bimodality- there are multiple points that are common- 
#'that a boxplot did not represent.
ggplot(diamonds, aes(x=color, y=price)) + geom_violin() + scale_y_log10()

#Housing----
#' Try other analysis with another dataframe
#'
install.packages('housingData') #if non installed
require(housingData)
hh <- housingData::housing

?housing()

str(hh)
#' We have 3 factor variable, one of tipe Date, and three numerical, one with NA values
#' 
#' 
#' 


# (Scatterplot) ----

scatter <- ggplot(subset(hh, state %in% c("MA", "TX")),
                  aes(x=time,
                      y=nSold,
                      color=state))+
  geom_point() +theme_minimal()
scatter

#' we selected with the expression state %in% c(MA,TX) a subset of house, note 
#' that we made the selection before the aestetics. 
#' another option would have been to select in a new dataframe the two US States.
#' then do the same plot as before
ma.tx <- subset(hh, state %in% c("MA", "TX"))#

scatter.matx <- ggplot(ma.tx,
                  aes(x=time,
                      y=nSold,
                      color=state))+
  geom_point() +theme_minimal()
scatter.matx


## Aesthetic Mapping ----


##   In ggplot land /aesthetic/ means "something you can see". Examples
##   include:
##   - position (i.e., on the x and y axes)
##   - color ("outside" color)
##   - fill ("inside" color)
##   - shape (of points)
##   - linetype
##   - size

##   Each type of geom accepts only a subset of all aesthetics--refer to
##   the geom help pages to see what mappings each geom accepts. Aesthetic
##   mappings are set with the `aes()' function.

## Geometic Objects (`geom')----


##   Geofor scatter plots, dot plots, etc)
##   - lines (`geom_line', for time series, trend lines, etc)
##   - boxplot (`geom_boxplot', for, well, boxplots!)
##   A plot must have at least one geom; there is no upper limit. You can
##   add a geom to a plot using the `+' operatorz

##   You can get a list of available geometric objects using the code
##   below:
help.search("geom_", package = "ggplot2")
##   or simply type `geom_<tab>' in any good R IDE (such as Rstudio or ESS)
##   to see a list of functions starting with `geom_'.

#subset a portion of thmetric objects are the actual marks we put on a plot. Examples
##   include:
##   - points (`geom_point', e da.taset

hh.sub <- subset(hh, time> "2009-01-01" & time < "2009-06-30")
str(hh.sub)

p50 <- ggplot(hh.sub,
       aes(y = nSold, x = medListPriceSqft)) +
  geom_point()
p50

p50.log <- ggplot(hh.sub,
       aes(y = log(nSold), x = (medListPriceSqft))) +
  geom_point()
p50.log

#Add the name of the states for each house
#install.packages('g.subgrapel)
require(ggrepel)

ss.hh.sub <- hh.sub[sample(100),]
pp51 <- ggplot(ss.hh.sub, (aes(medListPriceSqft, nSold, col=state))) + 
  geom_point() +
  geom_label_repel(label=ss.hh.sub$state,size = 6, max.overlaps = 100) +
  theme(legend.position="none") #we don't need the legend 
 
#'geom_label_rapel from ggrepel library allows you to write a value of factor (in our case)
#'variable exactly near the points you want to draw, you can change the size and then
pp51


p52 <- ggplot(ss.hh.sub, aes(x = log(medListPriceSqft), y = nSold)) + geom_line(aes(y = medSoldPriceSqft))
p52 +
  geom_point(aes(color = medListPriceSqft)) +
  geom_smooth()


p52 +
  geom_point(aes(color=medSoldPriceSqft, shape = state))



p3 <- ggplot(hh.sub,
             aes(x = state,
                 y = medSoldPriceSqft)) + 
  theme(legend.position="top",
        axis.text=element_text(size = 6))
p3
(p4 <- p3 + geom_point(aes(color = time),
                       alpha = 0.5,
                       size = 1.5,
                       position = position_jitter(width = 0.25, height = 0)))



##   Now modify the breaks for the x axis and color scales

p4 + scale_x_discrete(name="State Abbreviation") +
  scale_color_continuous(name="",
                         breaks = c(1976, 1994, 2013),
                         labels = c("'76", "'94", "'13"))
p4 +
  scale_x_discrete(name="State Abbreviation") +
  scale_color_continuous(name="",
                         breaks = c(1976, 1994, 2013),
                         labels = c("'76", "'94", "'13"),
                         low = "blue", high = "red")
