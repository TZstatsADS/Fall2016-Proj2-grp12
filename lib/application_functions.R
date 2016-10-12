library(dplyr)
library(DT)
library(readr)
library(data.table)
library(sp)
library(rgdal)
library(rgeos)
library(RANN)
library(geosphere)
library(ggmap)


find_wifi_and_cafe <- function(x, wifi_1, restaurant, distance){
  address <- paste("'",x,",New York City,NY,US'")
  coor <- geocode(address) 
  dist_wifi <- distm(wifi_1[,3:4],coor,fun = distHaversine)
  index_wifi <- which(dist_wifi<distance)
  dist_cafe <- distm(restaurant[,5:6],coor,fun = distHaversine)
  index_cafe <- which(dist_cafe<distance)
  result <- rbind(dplyr::select(wifi_1[index_wifi,],lon,lat,type),restaurant[index_cafe,5:7]) 
  return(result)
  }
