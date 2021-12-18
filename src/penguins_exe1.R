#Solution to exercise with penguins dataset

#1) Clean all data from your Global Environment
remove(list = ls())


#'  2)Get from the library(palmerpenguins) the penguins dataset. 
#'  Note that you may need to install the library
#'  
#'  3)Load library ggplot2, and type set.seed(1)
library(dplyr)
library(ggplot2)
library(palmerpenguins)

## Set some 

theme_set(theme_minimal())

set.seed(1)

## Load the dataset
peng <- as.data.frame(penguins)


## Summary Statistics
head(peng)
str(peng)
summary(peng)
nrow(peng)
ncol(peng)
names(peng)

#format the year as factor
peng$year <- as.factor(peng$year)

#remove the data with NA
peng <- na.omit(peng)


aggregate(.~sex, peng, mean) 

#calculate the mean for male and female penguins of flipper length

male_peng <- subset(peng,sex=='male')
female_peng <- subset(peng,sex=='female')

mean(male_peng$flipper_length_mm)
mean(female_peng$flipper_length_mm)

#second smarter way
aggregate(.~sex, peng, mean) 

# plot the histogram of the bill depth in mm and fill it by species
ggplot(peng, aes(x = bill_depth_mm, fill = species)) +
  geom_histogram(position='identity', alpha=0.5)+
  ggtitle('Distribution for bill depth in mm')+
  xlab('Bill Depth in mm')


# plot the bar of the body mass and divide it by sex, choice an appropriate width
ggplot(peng, aes(x = body_mass_g, fill=sex)) +
  geom_bar(position='identity',width = 20)+
  ggtitle('Distribution for bill depth in mm')+
  xlab('Bill Depth in mm')

# plot the bar of the species and bill length, fill the bar by sex
ggplot(peng, aes(x = species, y=bill_length_mm, fill=sex)) +
  geom_col(position = f)+
  ggtitle('Distribution for bill depth in mm')+
  xlab('Bill Depth in mm')

# plot the points of bill lenght in x axis and bill dept in y axis, 
# then color it by species and add shapes for island
# put the x axis element at 45 degrees
ggplot(peng, aes(x = bill_length_mm, y=bill_depth_mm, color = species,shape=island)) +
  geom_point()+ggtitle('Scatterplot of Bill length and depth in mm')+
  theme(axis.text.x = element_text(angle = 35, vjust = .5 ))



# Now use a color scale gradient2 for the body mass, choose a color lower and high 
meanbody <- mean(peng$body_mass_g)
ggplot(peng,aes(bill_length_mm, bill_depth_mm, color=body_mass_g,shape=sex))+ geom_point()+
  scale_color_gradient2(midpoint=meanbody, low="blue",
                        high="red")+ggtitle('Scatterplot of Bill length and depth in mm',
                                            subtitle = 'Divided by mass and sex')+
  theme(axis.text.x = element_text(angle = 35, vjust = .5 ))

# plot the boxplot of the body mass by sex and color it by island, 
# then facet by the species
box.plot <- ggplot(peng, aes(x=sex, y=body_mass_g, color=island)) +
  geom_boxplot()+facet_grid(~species)
box.plot

# add points to the boxplot
box.plot+ geom_jitter(width = 0.1, alpha = 0.2)


#' create a new factor variable called weight based on body mass of penguins where under the mean
#' each sex is underweight and overweight then redo a box plot by chosing appropriate variables

male.weight <- mean(male_peng$body_mass_g)
female.weight <- mean(female_peng$body_mass_g)

peng$weight <- factor(ifelse(peng$body_mass_g <= male.weight & peng$sex=='male', 'underweight', 
                                ifelse(peng$body_mass_g > male.weight & peng$sex=='male' , 'overweight', 
                                       ifelse(peng$body_mass_g <= female.weight &peng$sex=='female', 
                                              'underweight', 'overweight')))) 

box.plot <- ggplot(peng, aes(x=weight, y=body_mass_g, color=sex)) +
  geom_boxplot()+facet_grid(~species)
box.plot
