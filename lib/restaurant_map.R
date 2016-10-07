library(dplyr)
library(ggmap)
library(ggplot2)
library(DT)
library(readr)
library(data.table)
library(qmap)
#setwd("/Users/jgaci/Dropbox/2016_Fall/|") #put your own folder address here
restaurant.data <- read_csv("../data/DOHMH_New_York_City_Restaurant_Inspection_Results.csv") #load your data set here
names(restaurant.data) <- make.names(names(restaurant.data))

restaurant.data$full.address <- paste(tolower(restaurant.data$STREET), 
                                      restaurant.data$BUILDING,", NY, US")


restaurant.data.uniques <- restaurant.data[!duplicated(restaurant.data[,c('DBA','full.address')]),]
restaurant.data.uniques <- restaurant.data.uniques[,c('DBA', 'full.address')]


restaurant.data.uniques.1 <- restaurant.data.uniques[1:2500,]

restaurant.data.uniques.1 <- restaurant.data.uniques.1 %>%
  mutate(longtitude = geocode(full.address)[,1],latitude = geocode(full.address)[,2]) # The first var of the geocode function output 


restaurant.data.uniques.2 <- restaurant.data.uniques[2501:2600,]

restaurant.data.uniques.2 <- restaurant.data.uniques.2 %>%
  mutate(longtitude = geocode(full.address)[,1],latitude = geocode(full.address)[,2]) # The first var of the geocode function output 
