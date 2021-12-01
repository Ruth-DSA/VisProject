get_streamgraph_data = function(data, byRegion, yrs, rates){
  library(tidyverse)
  
  if(byRegion){
    new_data = data %>%
      arrange(region, year) %>%
      group_by(region, year, generation) %>%
      summarise(suicides = sum(suicides_no)) %>%
      mutate(region_gen = paste(region, generation)) %>%
      filter(year >= yrs[1] & year <= yrs[2])
  }else{
    new_data = data %>%
      arrange(region, year) %>%
      group_by(year, generation) %>%
      summarise(suicides = sum(suicides_no)) %>%
      filter(year >= yrs[1] & year <= yrs[2])
  }
  new_data
}

get_streamgraph_plot = function(data, byRegion){
  library(ggstream)
  library(hrbrthemes)
  library(viridis)
  library(plotly)
  
  if(byRegion){
    plot = ggplot(data, aes(x = year, y = suicides, fill = region_gen)) +
      geom_stream(color = 1, lwd = 0.25) +
      scale_fill_viridis(discrete=TRUE, guide='none')+
      theme_ipsum() 
  }else{
    plot = ggplot(data, aes(x = year, y = suicides, fill = generation)) +
      geom_stream(color = 1, lwd = 0.25) +
      scale_fill_viridis(discrete=TRUE, guide='none')+
      theme_ipsum() 
  }
  
  interactive_plot = ggplotly(plot)
  interactive_plot
}

