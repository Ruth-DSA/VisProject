library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(hrbrthemes)
library(viridis)
library(tidyverse)
library(dplyr)
library(ggplot2)

server = function(input, output, session) {
    
    options(shiny.maxRequestSize = 50*1024^2)
    
    # close shiny app session when user exists browser
    session$onSessionEnded(function() {
        stopApp()
    })
    
    data = reactive({
        file_path = "../data/new_master.csv"
        data = read.csv(file_path)  # read csv file
        data
    })
    
    output$bubble = renderPlotly({
        source('./bubble_plot.R')
        plot = bubble_plot(data())
        plot
    })
    
    output$heatmap = renderPlotly({
        source('./heat_map.R')
        plot = heat_map(data())
        plot
    })
    
    output$timeline = renderPlotly({
        source('./timeline.R')
        plot = timeline(data())
        plot
    })

} # end server

