# Timeline of app
# X-axis shows year
# Y-axis shows number of suicides
# each line shows a gender or a gender by region

get_timeline_data = function(data, byRegion, yrs, rates){
  
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
  
  if(byRegion){
    plot = data %>%
      mutate(text = paste("Region: ", region,
                          "\nYear: ", year,
                          "\nGender: ", sex,
                          "\nNum Suicides: ", suicides,
                          sep="")) %>%
      
      ggplot(aes(x=year, y=suicides, group=region_sex, color=region_sex, text=text)) +
      geom_line() +
      scale_color_viridis(discrete = TRUE) +
      theme_ipsum() +
      ylab("Number of Suicides") + 
      xlab('Year') +
      scale_x_continuous(breaks = pretty_breaks())
  }else{
    plot = data %>%
      mutate(text = paste("\nYear: ", year,
                          "\nGender: ", sex,
                          "\nNum Suicides: ", suicides,
                          sep="")) %>%
      ggplot(aes(x=year, y=suicides, group=sex, color=sex, text=text)) +
      geom_line() +
      scale_color_viridis(discrete = TRUE) +
      theme_ipsum() +
      ylab("Number of Suicides") + 
      xlab('Year') +
      scale_x_continuous(breaks = pretty_breaks())
  } 
  
  interactive_plot = ggplotly(plot, tooltip = 'text')
  interactive_plot
  
}