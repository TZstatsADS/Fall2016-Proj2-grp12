library(dplyr)
library(ggmap)
library(ggplot2)
library(DT)
library(readr)
library(data.table)
library(qmap)
source('restaurant_data_functions.R') # functions


setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Get Data ----
preliminary.data.job <- FALSE
get.geocode.data.flag <- FALSE
relevant.columns <- c('CAMIS','DBA','CUISINE.DESCRIPTION','full.address')
source.data.file <- "../data/DOHMH_New_York_City_Restaurant_Inspection_Results.csv"
output.route <- '../output/output_geodata/'
restaurant.data.uniques <- etl.input.data(FALSE, relevant.columns, source.data.file, output.route)

# Obtain geocode data ----
# We have to run this several times, because google only allows 2500 calls per day.
if(get.geocode.data.flag){
  # KEY PARAMETERS
  source.of.data <- "google"
  google.daily.max <- 2500
  fileNumber <- 6
  
  # Calculations of range to explore, from a to b
  a <- (fileNumber-1)*google.daily.max + 1
  b <- a + google.daily.max - 1
  # You can change a and b manually in the next two rows
  #a <- 10001
  #b <- 10100
  range.to.get.data <- a:b
  
  # Function Call
  geocode.data <- get.geocode.data(restaurant.data.uniques,
                                   range.to.get.data,
                                   fileNumber,
                                   source.of.data,
                                   output.route)
}

# Merge all files
restaurants.geocoded <- multimerge(output.route)
restaurants.geocoded <- cafe_marker(restaurants.geocoded)
write_csv(restaurants.geocoded, '../output/restaurants_unique_geocoded.csv')



