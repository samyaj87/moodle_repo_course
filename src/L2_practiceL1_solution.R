# Data Set Information:
# This dataset is a subset of the 1987 National Indonesia Contraceptive Prevalence Survey. 
# The samples are married women who were either not pregnant or do not know if they were at the time of interview. 
# The problem is to predict the current contraceptive method choice (no use, long-term methods, or short-term methods) 
# of a woman based on her demographic and socio-economic characteristics.
# 
# Attribute Information:
#   
# 1. Wife's age (wAGE,numerical)
# 2. Wife's education (wEDU,categorical) 1=low, 2, 3, 4=high
# 3. Husband's education (hEDU,categorical) 1=low, 2, 3, 4=high
# 4. Number of children ever born (CHD,numerical)
# 5. Wife's religion (wREL,binary) 0=Non-Islam, 1=Islam
# 6. Wife's now working? (wWORK,binary) 0=Yes, 1=No
# 7. Husband's occupation (hWORK,categorical) [1=manager, 2=public servant, 3=physician, 4=engineer]
# 8. Standard-of-living index (SOL,categorical) 1=low, 2, 3, 4=high
# 9. Media exposure (MEDIA,binary) 0=Good, 1=Not good
# 10. Contraceptive method used (CMET,class attribute) 1=No-use, 2=Long-term, 3=Short-term


## A.  Read data from file cmc.data.txt, store them in a variable (e.g.,
## 'mydata') and verify variable class, structure, and summary.
remove(list = ls())
#mydata <- read.table(http://archive.ics.uci.edu/ml/machine-learning-databases/cmc/cmc.data,sep=",")
mydata <- read.table("data/cmc.data.txt",sep=",")

str(mydata)


## B. Name the columns according to instructions above and transform
## categorical values into factors. Verify the new structure.
names(mydata) <- c("wAGE","wEDU","hEDU","CHD","wREL","wWORK","hWORK","SOL","MEDIA","CMET")
str(mydata)
mydata$wEDU <- factor(mydata$wEDU,levels=1:4,labels=c("low","medLow","medHigh","high"))
mydata$hEDU <- factor(mydata$hEDU,levels=1:4,labels=c("low","medLow","medHigh","high"))
mydata$wREL <- factor(mydata$wREL,levels=0:1,labels=c("noIS","IS"))
mydata$wWORK <- factor(mydata$wWORK,levels=0:1,labels=c("yes","no"))
mydata$hWORK <- factor(mydata$hWORK,levels=1:4,labels=c("manager","pubServ","physician","engineer"))
mydata$SOL <- factor(mydata$SOL,levels=1:4,labels=c("low","medLow","medHigh","high"))
mydata$MEDIA <- factor(mydata$MEDIA,levels=0:1,labels=c("good","bad"))
mydata$CMET <- factor(mydata$CMET,levels=1:3,labels=c("no-use","longTerm","shortTerm"))

str(mydata)
summary(mydata)

## C. Add a column called "ID" and containing a sequential
## index. Verify the structure of the updated variable.
mydata$ID <- paste("ID",1:nrow(mydata),sep="") 
str(mydata)
summary(mydata)

## D. Impute the na of our wAGE column.


mydata[5,"wAGE"] <- NA
mydata[6,"wAGE"] <- NA

#we can substitute the NA value with some value or basically impute the value from mean

nanvaluecol1 <- is.na(mydata$wAGE)

mean(mydata$wAGE,na.rm = T)
round(mean(mydata$wAGE,na.rm = T))

mydata[6,"wEDU"] <- NA
mydata$wAGE[nanvaluecol1] <- round(mean(mydata$wAGE, na.rm = T))
mydata$wAGE[nanvaluecol1] <- 0


mydata[is.na(mydata)] <- 0
# Warning message:
#   In `[<-.factor`(`*tmp*`, thisvar, value = 0) :
#   invalid factor level, NA generated

## E. Visualize all observations of attribute "wAGE". Assign the results
## to a new variable called AGE.
AGE <- mydata[,"wAGE"]

AGE>35


#' F. Find how many woman are older than 25 years and then also find how many had 
#' two or more child, store the results in a new dataset called mydata.f

sum(mydata[,'wAGE']>25)
str(mydata)
mtdata.f <- mydata['wAGE'>35 & mydata$CHD>2,]
mtdata.f <- mydata[mydata$wAGE<25 & mydata$CHD>2,]
mydata.f


mydata.f <- mydata[AGE>35,]
## G. Plot
library(ggplot2)
p1 <- ggplot(mydata, aes(CHD,wAGE, col=wWORK))+geom_point()
p1


p1 <- ggplot(mydata, aes(wEDU,CHD))+geom_boxplot()
p1

p1 <- ggplot(mydata, aes(hEDU,CHD))+geom_boxplot()
p1

p1 <- ggplot(mydata, aes(hEDU,wAGE))+geom_boxplot()
p1




