#Load Packages

library(Shiny)
library(Shinydashboard)
library(leaflet)
library(dplyr) #optional, data processing
library(data.table) #optional, for fast read data


#Dashboard Page
ui <- dashboardPage(header,
                    sidebar = dashboardSidebar(disable = T),
                    body)
header <- dashboardHeader(title = p("Piracy Incidence Over Time"), titleWidth = 400)
body <- dashboardBody(
  fluidRow(
    dashboard, map
  )
)

dashboard <- column(width =4,
                    # width set to NULL when use column-based layout
                    box(width = NULL , title =tagList(shiny::icon("filter",class = 'fa-lg'), "Filter Data") ,
                        solidHeader = T, collapsible = T, status = 'primary',
                        # create a select-input widget for crime type selection
                        selectizeInput('attackType','Attack Type', choices = type, width = 380,
                                       selected = c('Attempted', 'Boarded',
                                                    "Detained","Explosion","Fired Upon",
                                                    "Hijacked","Suspicious"),multiple = T),
                        # create a date-range-input widget
                        dateRangeInput('year', label = "Year",width = 380,
                                       start = '1993', end = '2021',
                                       min = "1993", max = "2021"
                        ),
                        # create a select-input widget for day of week selection
                        selectizeInput('month','Month', width = 380,
                                       choices = c('January','February','March','April','May','June','July', 'August', 'September','October','November','December'),
                                       selected = c('January','February','March','April','May','June','July', 'August', 'September','October','November','December'),
                                       multiple = T),
                        # create a slder-input widget for time of day selection
                        sliderInput('time_of_day','Time of Day', min = 0, max = 23,width = 380,
                                    value = c(0,23), step = 1),
                        # create a submit-button for user explicitly confirm data input
                        submitButton(text = "Submit",icon =icon('filter'))
                    )
)
map <- column(width =8,
              box(width = NULL, solidHeader = TRUE,
                  leafletOutput('AttackMap',height = 500)))