library(dplyr)
library(ggmap)
library(ggplot2)
library(DT)
library(readr)
library(data.table)
library(qmap)
#setwd("/Users/jgaci/Dropbox/2016_Fall/|") #put your own folder address here
resturant_data <- read_csv("../data/DOHMH_New_York_City_Restaurant_Inspection_Results.csv") #load your data set here
#names(sat) <- c("DBN","name","Num","AvgReading","AvgMath","AvgWriting") #rename the variables for your dataset 
# by your preference
#sat <- sat %>% 
#  mutate(address = paste(tolower(name),", NY, US")) %>%  # To specify your address, indicate its in NY
#  mutate(longtitude = geocode(address)[,1],latitude = geocode(address)[,2]) # The first var of the geocode function output 
# is the longtitude and the second var is the latitude

