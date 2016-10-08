library(dplyr)
library(ggmap)
library(ggplot2)
library(DT)
library(readr)
library(data.table)
library(qmap)

#
# Preliminary calculations. Run everything until row 50
#

preliminary.data.job <- FALSE
relevant.columns <- c('CAMIS','DBA','CUISINE.DESCRIPTION','full.address')

if(preliminary.data.job){
  ## ---- Extract Data
  restaurant.data <- read_csv("../data/DOHMH_New_York_City_Restaurant_Inspection_Results.csv") #load your data set here
  
  ## ---- Transform Data
  names(restaurant.data) <- make.names(names(restaurant.data))
  
  restaurant.data$full.address <- paste(tolower(restaurant.data$STREET), 
                                        restaurant.data$BUILDING,", NY, US")
  
  ## ---- Load Data
  restaurant.data.uniques <- restaurant.data[!duplicated(restaurant.data[,relevant.columns]),]
  restaurant.data.uniques <- restaurant.data.uniques[,relevant.columns]
  
  ## ---- Write CSV file with the table we need to geo locate
  write_csv(restaurant.data.uniques, '../output/restaurant_uniques_source.csv')
} else {
  restaurant.data.uniques <- read_csv('../output/restaurant_uniques_source.csv')
}

# Function call for geolocation
get.geocode.data <- function(df, range.to.get.data, fileNumber, source.of.data){
  df.cut <- df[range.to.get.data,]
  geocode.data <- geocode(location = df.cut$full.address
                          ,source = source.of.data
                          )
  df.cut <- cbind(df.cut, geocode.data)
  fileName <- paste0('../output/restaurant_uniques_',fileNumber,'.csv')
  write_csv(x = df.cut, path = fileName)
  geocodeQueryCheck("free")
}







# End Preliminary calculations and definitions

#
# KEY PARAMETERS
#
source.of.data <- "google"
google.daily.max <- 2500
fileNumber <- 2


# Calculations of range to explore, from a to b
a <- (fileNumber-1)*google.daily.max + 1
b <- a + google.daily.max - 1
# You can change a and b manually in the next two rows
#a <- 501
#b <- 2500

range.to.get.data <- a:b

# Function Call
get.geocode.data(restaurant.data.uniques,
                 range.to.get.data,
                 fileNumber,
                 source.of.data)


