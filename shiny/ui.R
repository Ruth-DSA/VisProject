library(ggplot2)
library(plotly)
library(shiny)
library(shinythemes)

ui = fluidPage(theme = shinytheme("darkly"),
  
  #display the title
  titlePanel("Team01 - Visual Analytics Project"),
  
  # Sidebar with "query" controls
  sidebarPanel(
    fluidRow(
      column(width = 10,
             h4("Query Controls:"),
             checkboxGroupInput("checkGroup",
                                h5("Checkbox group"),
                                choices = list("Choice 1" = 1,
                                               "Choice 2" = 2,
                                               "Choice 3" = 3),
                                selected = 1),
             sliderInput("slider", h5("Years"),
                         min = 0, max = 100, value = 50),
             actionButton("run_button"," Run Analysis",icon=icon("play"))
      )
    )
  ), # end sidebar
  
  mainPanel(
    
    fluidRow(
      
      column(width = 12,
             h5("Time x GDP"),
             plotlyOutput("bubble")
      ),
      column(width = 12,
             h5("Suicides x Year"),
             plotlyOutput("heatmap")
      ),
      column(width = 12,
             h5('Time Line'),
             plotlyOutput('timeline')
             )
      
    ) # end fluidRow
    
  ) # end main panel
  
) # end ui



