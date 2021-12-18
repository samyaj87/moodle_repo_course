remove(list = ls())
library(ggplot2)

mpg <- data.frame(mpg)
mpg


summary(mpg)
str(mpg)

#we have nominal variables which are in char type, so we convert them to factor


mpg$manufacturer <- as.factor(mpg$manufacturer)
mpg$model <- as.factor(mpg$model)
mpg$fl <- as.factor(mpg$fl)
mpg$class <- as.factor(mpg$class)

p1 <- ggplot(mpg, aes(displ, hwy))+geom_point()
p1


p1 <- ggplot(mpg, aes(displ, hwy, color=class))+geom_point()
p1

#change shape of cyl
p1 <- ggplot(mpg, aes(displ, hwy, color=class))+geom_point(shape=3)
p1

p1 <- ggplot(mpg, aes(displ, hwy, color=class))+geom_text(aes(label=cyl))
p1


#wrap around drive
p1 <- ggplot(mpg, aes(displ, hwy, color=class))+geom_text(aes(label=cyl))+
    facet_grid(~drv )
p1

#wrap around drive and
p1 <- ggplot(mpg, aes(displ, hwy, color=class))+geom_text(aes(label=cyl))+
    facet_grid(year~drv )
p1


#wrap around drive and
head(mpg)
p1 <- ggplot(mpg, aes(displ, hwy))+geom_smooth(method='lm')+geom_point()
p1

p1 <- ggplot(mpg, aes(displ, hwy, color=drv))+
  geom_smooth(aes(linetype=drv))+geom_point()
p1

