library(dplyr)
library(data.table)
library(leaflet)
library(shiny)
library(shinydashboard)
library(dygraphs)
library(xts)
library(ggplot2)

PirateAttacks <- read.csv("C:/Users/19139/Desktop/Final/Pirate_Attacks.csv",1)
PirateAttacks$Month = factor(PirateAttacks$Month,levels = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"), ordered = TRUE)

# Server
# Customize crime type icons
AttackIcons <- iconList(
  `Attempted` = makeIcon(iconUrl = './icon/Attempted.png',iconWidth = 25,iconHeight = 35),
  `Boarded` = makeIcon(iconUrl = './icon/Boarded.png', iconWidth = 25, iconHeight = 35),
  `Detained` = makeIcon(iconUrl = './icon/Detained.png', iconWidth = 25, iconHeight = 35),
  `Explosion` = makeIcon(iconUrl = './icon/Explosion.png', iconWidth = 25, iconHeight = 35),
  `Fired Upon` = makeIcon(iconUrl = './icon/Fired Upon.png', iconWidth = 25, iconHeight = 35),
  `Hijacked` = makeIcon(iconUrl = './icon/Highjacked.png', iconWidth = 25, iconHeight = 35),
  `Suspicious` = makeIcon(iconUrl = './icon/Suspicious.png', iconWidth = 25, iconHeight = 35)
)
server <- function(input, output) {
  # Create a reactive expression to filter data set per user requests
  filteredData <- reactive({
    PirateAttacks %>%
      filter(attack_type %in% input$attack_type) %>%
      filter(Year >= input$Year[1] & Year <= input$Year [2]) %>%
      filter(Month %in% input$Month)
   #   filter(time >= input$time[1] & time <= input$time[2])
  })
  # Use Leaflet to render Attack map
  output$AttackMap <- renderLeaflet({
    leaflet(filteredData()) %>%
      addTiles(group = 'OSM') %>%
      addProviderTiles('Esri.WorldStreetMap', group = 'Esri') %>%
      addProviderTiles('CartoDB.Positron', group = 'CartoDB') %>%
      addMarkers(
        ~longitude, ~latitude, popup = ~content,
        icon = ~AttackIcons[attack_type],clusterOptions = markerClusterOptions()
      ) %>%
      addLayersControl(
        baseGroups = c('OSM', 'Esri', 'CartoDB'),
        options = layersControlOptions(collapsed = FALSE)
      )
  })
  
  output$plot1 <- renderPlot({
      ggplot(filteredData(), aes(x = Month, fill = attack_type)) + 
          geom_bar(stat = "Count") + 
          theme(axis.text.x = element_text(angle=65, vjust = 0.6)) +
          labs(title = "Attack Type by Month", fill = "Attack Type")
  })
  
}
