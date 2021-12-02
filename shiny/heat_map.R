# Heatmap of app
# X-axis shows gender and region
# Y-axis shows generation
# color of box shows number of suicides

get_heatmap_data = function(data){
  
  new_data = data %>%
    arrange(region, year) %>%
    group_by(region, generation, sex) %>%
    summarise(suicides = sum(suicides_no)) %>%
    mutate(region_sex = paste(region, sex))
  new_data
}

get_heatmap_plot = function(data){

  plot = data %>%
    mutate(text = paste("Region: ", region,
                        "\nGender: ", sex,
                        "\nNum Suicides: ", suicides,
                             sep="")) %>%
    ggplot(aes(x=as.factor(region_sex), y=as.factor(generation), fill=as.factor(suicides), text=text)) +
    geom_tile() +
    scale_fill_viridis(discrete=TRUE, guide=none) +
    theme_ipsum() +
    theme(legend.position="bottom") +
    ylab("Generation") +
    xlab("Region & Sex") +
    theme(axis.text.x = element_text(angle = 305, hjust = -.15)) +
    theme(legend.position = "none")
  
  # interactive plot
  interactive_plot = ggplotly(plot, tooltip="text")
  interactive_plot
}

