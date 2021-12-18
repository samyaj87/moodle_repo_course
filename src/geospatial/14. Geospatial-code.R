# R code snippets from slides
# Slide file: . Geospatial/Lesson18


# From Scatter Plots to Maps
# ==========
berlin = read.csv("berlinBorderCrossing.csv", as.is=TRUE)
berlin


# From Scatter Plots to Maps
# ==========
cityCenterId = c(1:6,8)

par(mar=c(0,0,0,0))
plot(x=berlin$Longitude[cityCenterId],
     y=berlin$Latitude[cityCenterId],
     pch=19,
     axes=FALSE,
     xlim=range(berlin$Longitude[cityCenterId]) + c(0,0.015))
text(x=berlin$Longitude[cityCenterId],
     y=berlin$Latitude[cityCenterId],
     labels=berlin$Crossing[cityCenterId],
     pos=4,
     col="blue")
box()


# From Scatter Plots to Maps
# ==========
par(mar=c(0,0,0,0))
plot(x=berlin$Longitude[cityCenterId],
     y=berlin$Latitude[cityCenterId],
     pch=19,
     axes=FALSE,
     xlim=range(berlin$Longitude[cityCenterId]) + c(0,0.015))
text(x=berlin$Longitude[cityCenterId],
     y=berlin$Latitude[cityCenterId],
     labels=berlin$Crossing[cityCenterId],
     pos=4,
     col="blue")
box()


# From Scatter Plots to Maps
# ==========
install.packages("png")
install.packages("jpeg")
install.packages("snippets","http://rforge.net/")


# From Scatter Plots to Maps
# ==========
library(snippets)
par(mar=c(0,0,0,0))
plot(x=berlin$Longitude[cityCenterId],
     y=berlin$Latitude[cityCenterId],
     pch=19,
     axes=FALSE,
     xlim=range(berlin$Longitude[cityCenterId]))
osmap()
points(x=berlin$Longitude[cityCenterId],
       y=berlin$Latitude[cityCenterId],
       pch=19)
box()


# From Scatter Plots to Maps
# ==========
library(snippets)
par(mar=c(0,0,0,0))
plot(x=berlin$Longitude[cityCenterId],
     y=berlin$Latitude[cityCenterId],
     pch=19,
     axes=FALSE,
     xlim=range(berlin$Longitude[cityCenterId]))
osmap()
points(x=berlin$Longitude[cityCenterId],
       y=berlin$Latitude[cityCenterId],
       pch=19)
box()


# From Scatter Plots to Maps
# ==========
library(snippets)
par(mar=c(0,0,0,0))
plot(x=berlin$Longitude[cityCenterId],
     y=berlin$Latitude[cityCenterId],
     pch=19,
     axes=FALSE,
     asp=1/abs(cos(berlin$Latitude[1]*pi/180)),
     xlim=range(berlin$Longitude[cityCenterId]) + c(0,0.015))
osmap()
points(x=berlin$Longitude[cityCenterId],
       y=berlin$Latitude[cityCenterId],
       pch=19)
text(x=berlin$Longitude[cityCenterId],
     y=berlin$Latitude[cityCenterId],
     label=berlin$Crossing[cityCenterId],
     pos=4,
     col="blue")
box()


# From Scatter Plots to Maps
# ==========
library(snippets)
par(mar=c(0,0,0,0))
plot(x=berlin$Longitude[cityCenterId],
     y=berlin$Latitude[cityCenterId],
     pch=19,
     axes=FALSE,
     asp=1/abs(cos(berlin$Latitude[1]*pi/180)),
     xlim=range(berlin$Longitude[cityCenterId]) + c(0,0.015))
osmap()
points(x=berlin$Longitude[cityCenterId],
       y=berlin$Latitude[cityCenterId],
       pch=19)
text(x=berlin$Longitude[cityCenterId],
     y=berlin$Latitude[cityCenterId],
     label=berlin$Crossing[cityCenterId],
     pos=4,
     col="blue")
box()


# From Scatter Plots to Maps
# ==========
library(snippets)
par(mar=c(0,0,0,0))
plot(x=berlin$Longitude,
     y=berlin$Latitude,
     pch=19,
     axes=FALSE,
     asp=1/abs(cos(berlin$Latitude[1]*pi/180)),
     xlim=range(berlin$Longitude) + c(0,0.015))
osmap()
points(x=berlin$Longitude,
       y=berlin$Latitude,
       pch=19)
text(x=berlin$Longitude,
     y=berlin$Latitude,
     label=berlin$Crossing,
     pos=4,
     col="blue")
box()


# Map Projections and Input Formats
# ==========
install.packages('rgdal')
library(rgdal)
state<- readOGR(dsn = path.expand("State_2010Census_DP1/"), layer = "State_2010Census_DP1")


# Map Projections and Input Formats
# ==========
class(state); dim(state) # ; -> two commands in the same row


# Map Projections and Input Formats
# ==========
index <- (as.data.frame(state)$STUSPS10 %in% c("AK", "HI"))
state <- state[!index,]
dim(state)


# Map Projections and Input Formats
# ==========
plot(state)


# Map Projections and Input Formats
# ==========
library(rgdal)
stateTrans <- spTransform(x=state, CRSobj=CRS("+proj=utm +zone=14"))
plot(stateTrans)


# Map Projections and Input Formats
# ==========
library(rgeos)
centroid = gCentroid(spgeom=stateTrans, byid=TRUE)
plot(stateTrans)
text(x=centroid$x, y=centroid$y,
     label=stateTrans@data$NAME10, cex=0.7)


# Map Projections and Input Formats
# ==========
stateTransData <- as.data.frame(state)
perHouseRec = stateTransData$DP0180008 / stateTransData$DP0180001

bins = quantile(perHouseRec, seq(0,1,length.out=8))
binId = findInterval(perHouseRec, bins)


# Map Projections and Input Formats
# ==========
densityVals <- seq_len(length(bins)) * 5
plot(stateTrans, density=densityVals[binId])


# Enriching Tabular Data with Geospatial Data
# ==========
z = read.csv(file="photoDatasetAllRaw.csv", as.is=TRUE)
z = z[, c(1,4,6,15,16)] #subset columns
z = z[!is.na(z$latitude) & !is.na(z$longitude) & !is.na(z$pname),]
pnameSet <- names(sort(table(z$pname),TRUE))[1:20]
z = z[z$pname %in% pnameSet,]


# Enriching Tabular Data with Geospatial Data
# ==========
head(z)


# Enriching Tabular Data with Geospatial Data
# ==========
pts <- SpatialPointsDataFrame(coords=cbind(z$longitude, z$latitude), data=z)


# Enriching Tabular Data with Geospatial Data
# ==========
library(rgdal)
cnty <- readOGR(dsn = path.expand("County_2010Census_DP1/"), layer = "County_2010Census_DP1")


# Enriching Tabular Data with Geospatial Data
# ==========
joinedDataF = pts %over% cnty

dim(pts)
dim(cnty)


# Enriching Tabular Data with Geospatial Data
# ==========
joinedDataF$popDen <- joinedDataF$DP0010001 / joinedDataF$ALAND10
joinedDataF$popDen <- joinedDataF$popDen * 1000^2
medianPerc <- tapply(joinedDataF$popDen, z$pname, median, + na.rm=TRUE)
index <- order(medianPerc)
joinedDataF$pnameFactor <- factor(z$pname, levels=names(medianPerc)[index])
boxplot(pnameFactor, log(popDen),
         data=joinedDataF, axes=FALSE,
         horizontal=TRUE, las=1,
         outline=FALSE,
         col="grey")

# 
# # <!-- Enriching Geospatial Data with Tabular Data -->
# # ==========
# <!-- centroidS <- gCentroid(state, byid=TRUE) -->
# <!-- state <- state[centroidS$x > -79.3 & centroidS$y > 37 & + centroidS$x < -71.0 & centroidS$y < 44,] -->
# <!-- cnty$GEOID10 <- as.character(cnty$GEOID10) -->
# 
# 
# # <!-- Enriching Geospatial Data with Tabular Data -->
# # ==========
# <!-- load("joinedDataF.Rdata") -->
# <!-- load("matchIndex.Rdata") -->
# 
# <!-- matchIndex = cnty %over% state -->
# 
# <!-- cnty = cnty[!is.na(matchIndex$GEOID10),] -->
# <!-- tab = table(joinedDataF$GEOID10) -->
# <!-- index = match(as.character(cnty$GEOID10), names(tab)) -->
# 
# 
# # <!-- Enriching Geospatial Data with Tabular Data -->
# # ==========
# <!-- cnty$photoCount <- as.numeric(over(cnty,pts,fn=length)[,1]) -->
# <!-- head(cnty$photoCount) -->
# 


require(rgdal)
shape <- readOGR(dsn = "14. Geospatial Data-20210723/prov2011/prov2011.shp")
plot(shape)
shape$COD_PRO
