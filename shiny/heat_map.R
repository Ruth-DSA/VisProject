get_heatmap_data = function(data){
  library(tidyverse)
  library(dplyr)
  
  new_data = data %>%
    arrange(region, year) %>%
    group_by(region, generation, sex) %>%
    summarise(suicides = sum(suicides_no)) %>%
    mutate(region_sex = paste(region, sex))
  new_data
}

get_heatmap_plot = function(data){
  library(plotly)
  library(hrbrthemes)
  library(viridis)
  library(ggplot2)

  plot = ggplot(data, aes(x=as.factor(region_sex), y=as.factor(generation), fill=as.factor(suicides))) +
    geom_tile() +
    scale_fill_viridis(discrete=TRUE, guide=none) +
    theme_ipsum() +
    theme(legend.position="bottom") +
    ylab("Generation") +
    xlab("Region & Sex") +
    theme(axis.text.x = element_text(angle = 305, hjust = -.15)) +
    theme(legend.position = "none")
  
  # interactive plot
  interactive_plot = ggplotly(plot)
  interactive_plot
}

