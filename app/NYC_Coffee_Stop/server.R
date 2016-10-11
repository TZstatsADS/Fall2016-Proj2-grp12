library(shiny)
library(leaflet)
library(scales)
library(lattice)
library(dplyr)

geocodeAdddress <- function(address) {
        require(RJSONIO)
        url <- "http://maps.google.com/maps/api/geocode/json?address="
        url <- URLencode(paste(url, address, "&sensor=false", sep = ""))
        x <- fromJSON(url, simplify = FALSE)
        if (x$status == "OK") {
                out <- c(x$results[[1]]$geometry$location$lng,
                         x$results[[1]]$geometry$location$lat)
        } else {
                out <- NA
        }
        Sys.sleep(0.2)  # API only allows 5 requests per second
        out
}

wifi_data <- read.csv("/Fall2016-Proj2-grp12/data/NYC_Wi-Fi_Hotspot_Locations_Map.csv")
wifi_points <- cbind(wifi_data$Lat, wifi_data$Long_)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        
        cor <- geocodeAdddress(input$location)
        
        wifi_points <- cbind(wifi_data$Lat, wifi_data$Long_) # Need to be filtered acoording to inputs
        
        mapping <- leaflet() %>%
                setView(lng=-73.96884112664793,lat =40.78983730268673, zoom=13) %>%
                addTiles() %>%
                addMarkers(lng = wifi_data$Long_, lat = wifi_data$Lat)
        output$map_output <- renderLeaflet(mapping)
})

        