#Load Packages

library(leaflet)
library(shiny)
library(shinydashboard)
library(dygraphs)

type <- c("Attempted" = "Attempted", "Boarded"= "Boarded",
          "Detained" =  "Detained", "Explosion" = "Explosion",
          "Fired Upon" = "Fired Upon", "Hijacked" = "Hijacked",
          "Suspicious" =  "Suspicious")
header <- dashboardHeader(title = p("Attacks on Maritime Vessels"),
                          titleWidth = 400)


body <- dashboardBody(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
  fluidRow(
    column(width =4,
           box(width = NULL, title =tagList(shiny::icon("filter",class = 'fa-lg'), "Filter Data"),
               solidHeader = T, collapsible = T, status = 'primary',
               selectizeInput('attack_type','Attack Type', choices = type, width = 380,
                              selected = c('Attempted', 'Boarded',"Detained",
                                           "Explosion","Fired Upon","Hijacked",
                                           "Suspicious"),multiple = T),
               sliderInput('Year', 'Years', min=1994, max=2020, width=380, 
                           value = c(1993,2020), step=1, sep=""),
            # dateRangeInput('Year', label = "Year",width = 380,
               #            start = '1993', end = '2021',
               #              min = "1993", max = "2021"
             # ),
               # create a select-input widget for day of week selection
               selectizeInput('Month','Month', width = 380,
                              choices = c('January','February','March','April','May','June','July', 'August', 'September','October','November','December'),
                              selected = c('January','February','March','April','May','June','July', 'August', 'September','October','November','December'),
                              multiple = T),
             # sliderInput('time','Time of Day', min = 0, max = 23,width = 380,
             #             value = c(0,23), step = 1),
             #sliderInput('time', 'Time of Day', min= 00:00, max = 23:59, width = 380, 
              #           value = c(00:00, 23:59), step = .5), 
               submitButton(text = "Submit",icon =icon('filter'))
           ),
           box(width = NULL,title = tagList(shiny::icon("info-circle",class = 'fa-lg'), "About Attacks on Maritime Vessels"), solidHeader = T, collapsible = T, status = 'info',
               strong("Attacks on Maritime Vessels"),"is an interactive map built on shiny, allowing you to customize the 
                         time range and attack types to filter pirate attack reports. Piracy remains a major threat to global shipping and international trade, 
                        resulting in an estimated US$16 billion a year in economic losses per year."
                          ),),
        column(width =8,
           box(width = NULL, solidHeader = TRUE,
               leafletOutput('AttackMap',height = 500)),
           box(width = NULL, 
               plotOutput('plot1')
           )
    )
    )
    )


ui <- dashboardPage(skin = 'purple',
                    header,
                    dashboardSidebar(disable = T),
                    body
)