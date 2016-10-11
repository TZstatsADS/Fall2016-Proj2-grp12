library(shiny)
library(shinydashboard)
library(dplyr)
library(leaflet)
library(geosphere)
library(ggplot2)
library(ggmap)

# Define UI for application that draws a histogram

header <- dashboardHeader(title = 'Find a Coffee stop w/ Wifi!', 
                          titleWidth = 280)


sidebar <- dashboardSidebar(
        width = 280,
        sidebarMenu(
                menuItem('Find', tabName = 'map', icon = icon('map'), 
                         badgeLabel = 'New', badgeColor = 'orange'),
                menuItem('Info', tabName = 'info', icon = icon('info'),
                         menuSubItem('Shop Info', icon = icon('coffee')),
                         menuSubItem('Wifi Info', icon = icon('wifi'))
                         ),
                menuItem('Team', tabName = 'team', icon = icon('user'))
        )
)

dbody <- dashboardBody(
        tabItems(
                tabItem(tabName = 'map',
                 fluidRow(
                         column(width = 9,
                                box(width = NULL, solidHeader = TRUE, leafletOutput('map_output', height = 600))
                                ),
                         column(width = 3,
                                box(width = NULL, status = 'warning', background = 'yellow',
                                    textInput('location', 'Where am I?'),
                                    actionButton('search', 'Get!'),
                                    p('Enter your location to search for rest stops with Wifi near by!')
                                    ),
                                box(width = NULL, status = 'warning', background = 'yellow',
                                    selectInput('type','Are you a Coffee, Bakery or Bar person?',
                                                c('Any','Coffee', 'Bakery', 'Bar'), selected = 'Any',
                                                multiple = FALSE)),
                                box(width = NULL, status = 'warning', background = 'yellow',
                                    sliderInput('distance', 'Choose a distance', 1, 3000, 500),
                                    p('in feet')))
                 )
),
                tabItem(tabName = 'team',
                        box(title = 'Us', width = 400, height = 500, 'Zhao, Mengya mz2593@columbia.edu',
                            br(),
                            'Zuo, Nianyao nz2248@columbia.edu',
                            br(),
                            'Zhuang, Sen sz2536@columbia.edu',
                            br(),
                            'Gacitua, Jaime jg3499@columbia.edu'))))

dashboardPage(
        header,
        sidebar,
        dbody,
        skin = 'green'
        )