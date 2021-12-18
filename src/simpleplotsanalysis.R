#===============================================================================
# 2021-06-15 -- MPIDR dataviz
# ggplot2 basics
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================

# load the packages
library(tidyverse)


# base --------------------------------------------------------------------


# autoplot example
mb_test <- microbenchmark::microbenchmark(
  a = sqrt(7),
  b = 7^.5
)
library(tidyverse)
autoplot(mb_test)





# ggplot2 -----------------------------------------------------------------

# The logic


ggplot()

view(swiss)

? swiss



# geom_point
ggplot(
  data = swiss,
  aes(x = Agriculture, y = Fertility)
) +
  geom_point()

gg <- last_plot()

# saving a plot
ggsave(filename = "data/test.png", plot = gg)

# saving a plot2
png('output.png', width=10, height = 10, units = 'cm', res=400)
gg
dev.off()

# we can also save a plot as an R object
save(gg, file = "out/gg_swiss.rda")


# basic geoms -------------------------------------------------------------

# line / path
airquality <- airquality

# create a day for airquality measurement
airquality$date <- seq.Date(as.Date('1971-2-10'), by='day', length.out = nrow(airquality))


p1 <- ggplot(airquality, aes(date,Temp)) +  geom_line()
p1

p1 <- ggplot(airquality, aes(date,Temp)) +  geom_path()
p1

#color each months on a time line

airquality$Month <- format(airquality$date,"%B")

airquality$Month <- format(airquality$date,"%m")


p1 <- ggplot(airquality, aes(date,Temp,color=Month)) +  geom_line()
p1

# faceting ----------------------------------------------------------------

# plot wind against temperature
names(airquality)
ggplot(airquality,aes(Wind, Temp))+geom_point()

  
# distinguish months by colors

ggplot(airquality,aes(Wind, Temp, color=Month))+geom_point()


# let's see them separately with faceting
ggplot(airquality,aes(Wind, Temp, color=Month))+geom_point()+
  facet_wrap(~ factor(Month), ncol = 3)


# more advanced -----------------------------------------------------------

# let's re-create the simplest plot
swiss <- swiss

ggplot(swiss,  aes(x = Agriculture, y = Fertility)) +
  geom_point()

# and save it in an object
gg <- last_plot()


# stat operations ---------------------------------------------------------

# stat_smooth
gg + stat_smooth()

# linear model
gg + stat_smooth(method = "lm")

# remove confidence intervals
gg + stat_smooth(method = "lm", se = F, col = "red")


# stat_ellipse
ggplot(swiss,aes(x = Agriculture, y = Fertility, color=Catholic>50))+
  geom_point()+
  stat_ellipse()


# more geoms --------------------------------------------------------------

# density / ecdf (airquality)

airquality$Month <- format(airquality$date,"%B")

ggplot(airquality,aes(x=Temp))+geom_density(aes(color=Month),size=1)+
  scale_color_viridis_d(option = 'D', end=.6)+theme(legend.position = c(.1, .8))



# boxplot


ggplot(airquality,aes(y=Temp, x=Month, color=Ozone>30))+geom_boxplot()

# violin
ggplot(airquality,aes(y=Temp, x=Month, fill=Month))+geom_violin()


# jitter
ggplot(airquality,aes(y=Temp, x=Month, color=Month))+geom_jitter()


