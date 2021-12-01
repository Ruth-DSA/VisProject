# function to filter data
get_bubble_data = function(data, decades){
  library(tidyverse)
  library(dplyr)
  
  if(is.null(decades)){
      decades = c('1985-1994', '1995-2004', '2005-2016')
  }
  
  new_data = data %>% 
    arrange(region, year) %>% # sort
    mutate(gdp_year = as.numeric(gsub(",","",gdp_for_year....))) %>% # convert gdp to numeric value
    group_by(region, country, year) %>% # group
    summarise(suicides = sum(suicides_no), gdp_yr = first(gdp_year)) %>%
    ungroup() %>%
    group_by(region,year) %>%
    summarise(suicides = sum(suicides), gdp_yr = sum(gdp_yr)) %>%
    ungroup() %>%
    mutate(decade = if_else(year >= 2005, '2005-2016', 'NA')) %>% # create decade 'bins'
    mutate(decade = if_else(year >= 1995 & year < 2005, '1995-2004', decade)) %>%
    mutate(decade = if_else(decade == 'NA', '1985-1994', decade)) %>%
    group_by(region, decade) %>%
    summarise(suicides = sum(suicides), ave_gdp_decade = mean(gdp_yr)) %>%
    arrange(desc(suicides)) %>%
    filter(decade %in% decades)
  new_data
}

# function to create bubble plot
get_bubble_plot = function(data){
  library(plotly)
  library(hrbrthemes)
  library(viridis)
  library(ggplot2)

  # prepare text for tooltip
  plot = data %>%
    mutate(text = paste("Region: ", region,
                        "\nNum Suicides: ", suicides,
                        "\nGdp per Decade: ", ave_gdp_decade,
                        sep="")) %>%

    # generate bubble plot
    ggplot(aes(x=decade, y=ave_gdp_decade, size=suicides, fill=region, text=text)) +
    geom_point(alpha=0.5, shape=21, color="black") +
    scale_size(range = c(.1, 24), name="Number of Suicides") +
    scale_fill_viridis(discrete=TRUE) +
    theme_ipsum() +
    theme(legend.position="bottom") +
    ylab("Gdp per Decade") +
    xlab("Decade") +
    theme(legend.position = "none")

  # interactive plot
  interactive_plot = ggplotly(plot, tooltip="text")
  interactive_plot

} # end function
