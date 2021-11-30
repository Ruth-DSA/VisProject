# function to filter data set and create bubble plot
bubble_plot = function(data){
  library(plotly)
  library(hrbrthemes)
  library(viridis)
  library(tidyverse)
  library(dplyr)
  library(ggplot2)

  # data = read.csv('/Users/Owner/Desktop/OU classes/Fall 2021/Visual Analytics/Project/2021VisualAnalyticsProject/data/new_master.csv')

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

  # prepare text for tooltip
  plot = data %>%
    mutate(text = paste("Region: ", region,
                        "\nNum Suicides: ", suicides,
                        "\nGdp per Captia: ", gdp,
                        sep="")) %>%

    # generate bubble plot
    ggplot(aes(x=decade, y=gdp, size=suicides, fill=region, text=text)) +
    geom_point(alpha=0.5, shape=21, color="black") +
    scale_size(range = c(.1, 24), name="Number of Suicides") +
    scale_fill_viridis(discrete=TRUE, guide=FALSE) +
    theme_ipsum() +
    theme(legend.position="bottom") +
    ylab("Gdp per Capita") +
    xlab("Decade") +
    theme(legend.position = "none")

  # interactive plot
  interactive_plot = ggplotly(plot, tooltip="text")
  interactive_plot

} # end function
