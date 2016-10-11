# Function to set wd
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('wifi_contour_leaflet_functions.R')

#setwd("/Users/zuonianyao/Documents/GR5243/Project2")
wifi <- read.csv("../data/NYC_Wi-Fi_Hotspot_Locations_Map.csv")
wifi.geodata <- create.wifi.geodata(wifi)
CL <- create.wifi.contour.lines(wifi.geodata)

m = leaflet() %>% setView(lng = -73.97, lat = 40.75, zoom = 12) %>% 
  addProviderTiles("CartoDB.Positron")

m <- add.wifi.points(m, wifi.geodata)
m <- add.wifi.contours(m, CL)

m
