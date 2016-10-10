#plotting
library(dplyr)
library(ggmap)
library(ggplot2)
library(DT)
library(readr)
library(data.table)
library(qmap)
library(leaflet)

#setwd('C:/Users/Mengya/Desktop/Columbia Desk/GR5243/Project2/Fall2016-Proj2-grp12')
rest.plot.data <- read.csv('../output/restaurant_uniques_1.csv')
str(rest.plot.data)
rest.plot.data<-na.omit(rest.plot.data)

#draw the map
m<-leaflet() %>% setView(lng = -73.97, lat = 40.75, zoom = 12) %>% addProviderTiles("CartoDB.Positron") #%>% 
#  addTiles(
#    urlTemplate = "https://api.mapbox.com/v4/mapbox.streets/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiZnJhcG9sZW9uIiwiYSI6ImNpa3Q0cXB5bTAwMXh2Zm0zczY1YTNkd2IifQ.rjnjTyXhXymaeYG6r2pclQ",
#    attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
#  ) 
  
m <- addMarkers(m,rest.plot.data$lon,rest.plot.data$lat, popup=as.character(rest.plot.data$DBA))
m


# restrict to a certain area(if we need to)
# input.lon<-
# input.range<-
# nearby.restaurant <- subset(rest.plot.data,
#                             + input.lon-range.lon <= lon & lon <= input.lon+range.lon &
#                              + input.lat-range.lat <= lat & lat <= input.lat+range.lat)
