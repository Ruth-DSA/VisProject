# Stream graph of app
# X-axis shows year
# Y-axis shows number of suicides
# each line shows a generation or a generation by region

get_streamgraph_data = function(data, byRegion, yrs, rates){
  
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
  
  if(byRegion){
    plot = data %>%
      mutate(text = paste("Region: ", region,
                          "\nYear: ", year,
                          "\nGeneration: ", generation,
                          "\nNum Suicides: ", suicides,
                          sep="")) %>%
      ggplot(aes(x = year, y = suicides, fill = region_gen, text=text)) +
      geom_stream(color = 1, lwd = 0.25) +
      scale_fill_viridis(discrete=TRUE, guide='none')+
      theme_ipsum() +
      xlab('Year') +
      ylab('Number of  Suicides') +
      scale_y_continuous(labels = comma) +
      scale_x_continuous(breaks = pretty_breaks())
  }else{
    plot = data %>%
      mutate(text = paste("\nYear: ", year,
                          "\nGeneration: ", generation,
                          "\nNum Suicides: ", suicides,
                          sep="")) %>%
      ggplot(data, aes(x = year, y = suicides, fill = generation, text=text)) +
      geom_stream(color = 1, lwd = 0.25) +
      scale_fill_viridis(discrete=TRUE, guide='none')+
      theme_ipsum() +
      xlab('Year') +
      ylab('Number of  Suicides') +
      scale_y_continuous(labels = comma) +
      scale_x_continuous(breaks = pretty_breaks())
  }
  
  interactive_plot = ggplotly(plot, tooltip = 'text')
  interactive_plot
}

