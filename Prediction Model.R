library(ggplot2)
library(spatstat)
library(maptools)
library(ggmap)
library(scales)

#Set the path where the csv flie is stored.
setwd("ex - F:/GeoProfiling/model")
crimes <- read.csv("yorkshire.csv")

#Exploring the data
head(crimes)

#Visualizing only the data points
ggplot(crimes, aes(x,y)) + geom_point()

#The incidents which took place
incidents <-  crimes[1:21,]

#Incident which is to be tested
incidentTest <- crimes[22,]

#Point Pattern Analysis - applying density function on the data
pp = ppp(incidents$x, incidents$y, c(-2.5,-1.25), c(53.25, 54))
dp <- density.ppp(pp, sigma = 0.1)
plot(dp)
title(main="Density Function")

density <- data.frame(dp)

#Mapping out Coordinates of West Yorkshire
myLoc <- c(-2.5,53.25,-1.25,54)
myMap <- get_map(location=myLoc, source="google",
                 maptype="terrain",
                 color="bw", crop= T)

#Viusalization of the crime locations by combining all the variables defined above
ggmap(myMap, legend="topright") + 
  geom_tile(data = density,
            aes(x,y, fill=value),
            alpha=0.5,
            color =NA) +
  ggtitle("Map Base on First 21 Victims") +
  scale_fill_distiller(palette = "YlOrRd",
                       breaks = pretty_breaks(n=10),
                       direction=1) +
  geom_point(data=incidents, aes(x,y)) +
  geom_point(data=incidentTest, aes(x,y),
             shape="X", size=8,
             alpha=1, color="#0000FF") + 
  annotate("text", x=-1.5762, y=53.78,
           label="22nd Victim",
           color="#0000FF",
           size =3)

#Testing the model on the 22nd Victim
incidentTest_x <- incidentTest$x
incidentTest_y <- incidentTest$y

prediction <- subset(density,
               round(density$x,2)== round(incidentTest_x,2) &
                 round(density$y,2)==round(incidentTest_y,2))

mean(prediction$value)
