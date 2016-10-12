#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(shiny)
library(leaflet)
library(scales)
library(lattice)
library(dplyr)
source('../lib/wifi_contour_leaflet_functions.R')


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

# Define server logic required to draw a histogram
shinyServer(
  function(input, output) {
  output$ty <- reactive(input$type)
  cor <- reactive({
    cor <- geocodeAdddress(input$search.location)  
  })
  
  #output$location.text <- renderPrint({ geocodeAdddress(input$location)  }) 
  restaurant.data <- read_csv("../output/restaurants_unique_geocoded.csv")
  wifi.data <- read_csv("../data/NYC_Wi-Fi_Hotspot_Locations_Map.csv")
  ty = reactive(input$typy)
  
  restaurant.data <- restaurant.data[restaurant.data$type == 'cafe',]
  restaurant.data <- restaurant.data[1:100,]

  wifi.geodata <- create.wifi.geodata(wifi.data)
  CL <- create.wifi.contour.lines(wifi.geodata)
  
#  wifi.points <- cbind(wifi.data$Lat, wifi.data$Long_) # Need to be filtered acoording to inputs

  location.text.variable <- reactiveValues(data = c(-73.9688, 40.7898))
  
  observeEvent(input$go, {
    location.text.variable$data <- geocodeAdddress(input$search.location)
  })
  
  output$map_output <- renderLeaflet({
    mapping <- leaflet() %>%
      setView(lng=location.text.variable$data[1],lat=location.text.variable$data[2], zoom=15) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addMarkers(lng = restaurant.data$lon, lat = restaurant.data$lat
                 ,popup = restaurant.data$DBA)
    mapping <- add.wifi.points(mapping, wifi.geodata)
    mapping <- add.wifi.contours(mapping, CL)
    mapping
  })
  output$shoptable <- renderDataTable({restaurant.data[,c(2,3,4,7)]})
  output$wifitable <- renderDataTable({wifi.data})
  }
)
