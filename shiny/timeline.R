timeline = function(data){
  library(tidyverse)
  library(ggplot2)
  library(hrbrthemes)
  library(viridis)
  
  data = data %>% 
    arrange(region, year) %>% # sort
    group_by(region, year) %>% # group
    summarize(suicides = sum(suicides.100k.pop)) %>% # sum suicides by region
    ungroup() # ungroup
  
  plot = data %>%
  
    ggplot( aes(x=year, y=suicides, group=region, color=region)) +
    geom_line() +
    scale_color_viridis(discrete = TRUE) +
    theme_ipsum() +
    ylab("Number of Suicides") + 
    xlab('Year')
  
  # interactive plot
  interactive_plot = ggplotly(plot)
  interactive_plot
  
}