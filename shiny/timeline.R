get_timeline_data = function(data, byRegion, yrs, rates){
  library(tidyverse)
  
  if(byRegion){
    new_data = data %>%
      arrange(region, year) %>% # sort
      group_by(region, year, sex) %>%
      summarize(suicides = sum(suicides_no)) %>%
      mutate(region_sex = paste(region, sex)) %>%
      filter(year >= yrs[1] & year <= yrs[2]) 
  
  }else{
    new_data = data %>%
      group_by(year, sex) %>%
      summarize(suicides = sum(suicides_no)) %>%
      filter(year >= yrs[1] & year <= yrs[2]) 
  }
  new_data
}

get_timeline_plot = function(data, byRegion){
  library(ggplot2)
  library(hrbrthemes)
  library(viridis)
  
  if(byRegion){
    plot = data %>%
      ggplot(aes(x=year, y=suicides, group=region_sex, color=region_sex)) +
      geom_line() +
      scale_color_viridis(discrete = TRUE) +
      theme_ipsum() +
      ylab("Number of Suicides") + 
      xlab('Year')
  }else{
    plot = data %>%
      ggplot(aes(x=year, y=suicides, group=sex, color=sex)) +
      geom_line() +
      scale_color_viridis(discrete = TRUE) +
      theme_ipsum() +
      ylab("Number of Suicides") + 
      xlab('Year')
  } 
  
  interactive_plot = ggplotly(plot)
  interactive_plot
  
}