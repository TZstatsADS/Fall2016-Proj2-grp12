library(dplyr)
library(ggmap)
library(ggplot2)
library(DT)
library(readr)
library(data.table)
library(qmap)

#
# Preliminary calculations. Run everything until row 50 of code
#


etl.input.data <- function(do.preliminary.data = FALSE,
                           relevant.columns,
                           data.source.csv){
  
  if(preliminary.data.job){
    ## ---- Extract Data
    restaurant.data <- read_csv(data.source.csv) #load your data set here
    
    ## ---- Transform Data
    names(restaurant.data) <- make.names(names(restaurant.data))
    
    restaurant.data$full.address <- paste(tolower(restaurant.data$STREET), 
                                          restaurant.data$BUILDING,", NY, US")
    
    ## ---- Load Data
    restaurant.data.uniques <- restaurant.data[!duplicated(restaurant.data[,relevant.columns]),]
    restaurant.data.uniques <- restaurant.data.uniques[,relevant.columns]
    restaurant.data.uniques <- na.omit(restaurant.data.uniques)
    
    ## ---- Write CSV file with the table we need to geo locate
    write_csv(restaurant.data.uniques, '../output/restaurant_uniques_source.csv')
  } else {
    restaurant.data.uniques <- read_csv('../output/restaurant_uniques_source.csv')
  }
  return(restaurant.data.uniques)
}

    
# Function call for geolocation
get.geocode.data <- function(df, range.to.get.data, fileNumber, source.of.data, output.route){
  df.cut <- df[range.to.get.data,]
  geocode.data <- geocode(location = df.cut$full.address
                          ,source = source.of.data
                          )
  df.cut.output <- data.frame(df.cut, geocode.data)
  fileName <- paste0(output.route,'restaurant_uniques_',fileNumber,'.csv')
  write_csv(x = df.cut.output, path = fileName)
  geocodeQueryCheck("free")
  return(geocode.data)
}

# Function to merge all datafiles
multimerge <- function(mypath){
  filenames=list.files(path=mypath, full.names=TRUE)
  
  for (file in filenames){
    
    # if the merged dataset doesn't exist, create it
    if (!exists("dataset")){
      dataset <- read_csv(file)
    }
    
    # if the merged dataset does exist, append to it
    if (exists("dataset")){
      temp_dataset <- read_csv(file)
      dataset<-rbind(dataset, temp_dataset)
      rm(temp_dataset)
    }
    
  }
  dataset <- dataset[!duplicated(dataset),]
  dataset <- na.omit(dataset)
  return(dataset)
}  

cafe_marker <- function(dataset){
  dataset <- dataset %>%
    mutate(cafe=ifelse(grepl("CAFE",DBA),1,
                       ifelse(grepl("Cafe",DBA),1,
                              ifelse(grepl("cafe",DBA),1,0))))
  return(dataset)
}

