heat_map = function(data){
  library(tidyverse)
  library(plotly)
  
  # collect and aggregate data for chart
  data = data %>%
    arrange(region, year) %>% # sort
    mutate(gdp = as.numeric(gsub(",","",gdp_per_capita....))) %>% # convert gdp to numeric value
    group_by(region, year) %>% # group
    summarize(suicides = sum(suicides.100k.pop), gdp = first(gdp)) %>% # sum suicides by region
    ungroup() %>% # ungroup
    mutate(decade = if_else(year >= 2005, '2005-2016', 'NA')) %>% # create decade 'bins'
    mutate(decade = if_else(year >= 1995 & year < 2005, '1995-2004', decade)) %>%
    mutate(decade = if_else(decade == 'NA', '1985-1994', decade)) %>%
    group_by(region, decade) %>% # group
    summarize(suicides = sum(suicides), gdp = sum(gdp)) %>% # sum by decade
    arrange(desc(suicides))
  
  fig <- plot_ly(x = data$suicides, y = data$year, z = volcano, type = "heatmap")
  fig
}