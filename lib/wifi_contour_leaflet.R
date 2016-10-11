library(dplyr)
library(ggmap)
library(ggplot2)
library(DT)
library(readr)
library(data.table)
library(qmap)
library(maps)
library(leaflet)
library(raster)
library(sp)
library(rgdal)
library(maptools)
library(KernSmooth)

# Function to set wd
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
#setwd("/Users/zuonianyao/Documents/GR5243/Project2")
wifi <- fread("../data/NYC_Wi-Fi_Hotspot_Locations_Map.csv")
wifi_1 <- wifi %>% 
  dplyr::select(Type,Location,Lat,Long_,Location_T,City) %>%
  filter(Type=="Free"|Type=="Limited Free")
wifi.geodata <- na.omit(wifi_1)



X=cbind(wifi.geodata$Long_,wifi.geodata$Lat)


x <- kde2d$x1
y <- kde2d$x2
z <- kde2d$fhat
CL=contourLines(x , y , z)
m = leaflet() %>% setView(lng = -73.97, lat = 40.75, zoom = 12) %>% 
  addProviderTiles("CartoDB.Positron")
contour <- m %>% addCircles(wifi.geodata$Long_,wifi.geodata$Lat, radius = 0.1,opacity=0.4,col="orange") %>%
  addPolygons(CL[[1]]$x,CL[[1]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[2]]$x,CL[[2]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[3]]$x,CL[[3]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[4]]$x,CL[[4]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[5]]$x,CL[[5]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[6]]$x,CL[[6]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[7]]$x,CL[[7]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[8]]$x,CL[[8]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[9]]$x,CL[[9]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[10]]$x,CL[[10]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[11]]$x,CL[[11]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[12]]$x,CL[[12]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[13]]$x,CL[[13]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[14]]$x,CL[[14]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[15]]$x,CL[[15]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[17]]$x,CL[[17]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[18]]$x,CL[[18]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[19]]$x,CL[[19]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[20]]$x,CL[[20]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[21]]$x,CL[[21]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[22]]$x,CL[[22]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[23]]$x,CL[[23]]$y,fillColor = "red", stroke = FALSE) %>%
  addPolygons(CL[[24]]$x,CL[[24]]$y,fillColor = "red", stroke = FALSE) 

contour

#wifi.contour.plot <- plot.wifi.contours(wifi_1)
#wifi.contour.plot

