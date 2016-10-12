setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

source('application_functions.R')
#setwd("/Users/zuonianyao/Documents/GR5243/Project2")

wifi <- fread("../data/NYC_Wi-Fi_Hotspot_Locations_Map.csv")
restaurant <- read_csv('../output/restaurants_unique_geocoded.csv')
distance <- 500

wifi_1 <- wifi %>% 
  dplyr::select(Type,Location,Lat,Long_,Location_T,City) %>%
  filter(Type=="Free"|Type=="Limited Free")
wifi_1 <- na.omit(wifi_1)
wifi_1 <- data.frame(wifi_1[,1:2],wifi_1[,4],wifi_1[,3],wifi_1[,5:6])
names(wifi_1) <- c("type","location","lon","lat","belong","city")
wifi_1$type <- paste(wifi_1$type,"wifi")



find_wifi_and_cafe('Columbia University', wifi_1, restaurant, distance)

