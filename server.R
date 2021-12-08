library(dplyr)
library(data.table)
library(leaflet)
library(shiny)
library(shinydashboard)
library(dygraphs)
library(xts)


# Server
# Customize crime type icons
AttackIcons <- iconList(
  `Attempted` = makeIcon(iconUrl = './icon/Attempted.png',iconWidth = 35,iconHeight = 35),
  `Boarded` = makeIcon(iconUrl = './icon/Boarded.png', iconWidth = 35, iconHeight = 35),
  `Detained` = makeIcon(iconUrl = './icon/Detained.png', iconWidth = 35, iconHeight = 35),
  `Explosion` = makeIcon(iconUrl = './icon/Explosion.png', iconWidth = 35, iconHeight = 35),
  `Fired Upon` = makeIcon(iconUrl = './icon/Fired Upon.png', iconWidth = 35, iconHeight = 35),
  `Hijacked` = makeIcon(iconUrl = './icon/Highjacked.png', iconWidth = 35, iconHeight = 35),
  `Suspicious` = makeIcon(iconUrl = './icon/Suspicious.png', iconWidth = 35, iconHeight = 35)
)
server <- function(input, output) {
  # Create a reactive expression to filter data set per user requests
  filteredData <- reactive({
    data %>%
      filter(parent_incident_type %in% input$attackType ) %>%
      filter(year > input$year[1] & incident_date < input$dates[2]) %>%
      filter(month %in% input$month) %>%
      filter(hour_of_day >= input$time_of_day & hour_of_day <= input$time_of_day)
  })
  # Use Leaflet to render crime map
  output$AttackMap <- renderLeaflet({
    leaflet(filteredData()) %>%
      addTiles(group = 'OSM') %>%
      addProviderTiles('Esri.WorldStreetMap', group = 'Esri') %>%
      addProviderTiles('CartoDB.Positron', group = 'CartoDB') %>%
      addMarkers(
        ~longitude, ~latitude, popup = ~content,
        icon = ~AttackIcons[incidentType],clusterOptions = markerClusterOptions()
      ) %>%
      addLayersControl(
        baseGroups = c('OSM', 'Esri', 'CartoDB'),
        options = layersControlOptions(collapsed = FALSE)
      )
  })