# user interface of shiny app

ui = fluidPage(theme = shinytheme("cosmo"),
  
  #display the title
  titlePanel("Team01 - Visual Analytics Project"),
  
  sidebarPanel(width=3, height=12,
    
      fluidRow(
        # column(width = 3,
               h4("Query Controls:"),
               checkboxGroupInput(
                 'decade',
                 'Decade:',
                 choices = c('1985-1994' = '1985-1994',
                             '1995-2004' = '1995-2004',
                             '2005-2016' = '2005-2016')

               ),

               checkboxInput(
                 'byRegion',
                 'By Region',
                 value = TRUE
               ),

               sliderInput('years', 'Years:', min=1985, max=2016, value=c(1990, 2000), sep='')

              # ),
        ) # end fluid control
    
  ),
  mainPanel(
    fluidRow(
      
      column(width = 6,
             h5("Bubble Graph"),
             plotlyOutput("bubble")
      ),
      column(width = 6,
             h5("Heatmap"),
             plotlyOutput("heatmap")
      )
    ),
    
    fluidRow(
      column(width = 6,
             h5('Time Line'),
             plotlyOutput('timeline')
      ),
      column(width = 6,
             h5('Stream Graph'),
             plotlyOutput('streamgraph')
      )
      
    ), 
    
  )
  
  
  
  # Sidebar with "query" controls
  # sidebarPanel(
  #   fluidRow(
  #     column(width = 10,
  #            h4("Query Controls:"),
  #            checkboxGroupInput(
  #              'decade',
  #              'Decade:',
  #              choices = c('1985-1994' = '1985-1994',
  #                          '1995-2004' = '1995-2004',
  #                          '2005-2016' = '2005-2016')
  #              
  #            ),
  #             
  #             textOutput('decade_text'),
  #            # checkboxInput(inputId, label, value = FALSE, width = NULL)
  #            checkboxInput(
  #              'byRegion',
  #              'By Region'
  #            ),
  #            
  #            sliderInput('years', 'Years:', min=1985, max=2016, value=c(1990, 2000), sep='')
  #            
  #           ),
  #     ) # end fluid control
  # ), # end sidebar
  # 
  # mainPanel(
  #   
  #   fluidRow(
  #     
  #     column(width = 12,
  #            h5("Bubble Graph"),
  #            plotlyOutput("bubble")
  #     ),
  #     column(width = 12,
  #            h5("Heatmap"),
  #            plotlyOutput("heatmap")
  #     ),
  #     column(width = 12,
  #            h5('Time Line'),
  #            plotlyOutput('timeline')
  #     ),
  #     column(width = 12,
  #            h5('Stream Graph'),
  #            plotlyOutput('streamgraph'))
  #     
  #   ) # end fluidRow
  #   
  # ) # end main panel
  
) # end ui



