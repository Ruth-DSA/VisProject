# Suppress summarise info
options(dplyr.summarise.inform = FALSE)

file_path = "./data/new_master.csv"
data = read.csv(file_path)  # read csv file
min(data$year)
max(data$year)

# heatmap
data5 = data %>%
  arrange(region, year) %>%
  group_by(region, generation, sex) %>%
  summarise(suicides = sum(suicides_no)) %>%
  mutate(region_sex = paste(region, sex))

plot = ggplot(data5, aes(x=as.factor(region_sex), y=as.factor(generation), fill=as.factor(suicides))) +
  geom_tile() +
  scale_fill_viridis(discrete=TRUE, guide=none) +
  theme_ipsum() +
  theme(legend.position="bottom") +
  ylab("Generation") +
  xlab("Region & Sex") +
  theme(axis.text.x = element_text(angle = 305, hjust = -.15)) +
  theme(legend.position = "none")
plot


# stream graph
# not by region
data4 = data %>%
  arrange(region, year) %>%
  group_by(year, generation) %>%
  summarise(suicides = sum(suicides_no))

# not by region
plot = ggplot(data4, aes(x = year, y = suicides, fill = generation)) +
  geom_stream(color = 1, lwd = 0.25) +
  scale_fill_viridis(discrete=TRUE)+
  theme_ipsum()
plot

# by region
data4 = data %>%
  arrange(region, year) %>%
  group_by(region, year, generation) %>%
  summarise(suicides = sum(suicides_no)) %>%
  mutate(region_gen = paste(region, generation))

plot = ggplot(data4, aes(x = year, y = suicides, fill = region_gen)) +
  geom_stream(color = 1, lwd = 0.25) +
  scale_fill_viridis(discrete=TRUE, guide='none')+
  theme_ipsum()
plot

# line graph
#byRegion = true
data3 = data %>%
  arrange(region, year) %>% # sort
  group_by(region, year, sex) %>%
  summarize(suicides = sum(suicides_no)) %>%
  mutate(region_sex = paste(region, sex)) %>%
  filter(year >= 1990 & year <= 2000) %>%
  filter(suicides >= 100 & suicides <= 15000) %>%
  arrange(year)


#byRegion = true
plot = data3 %>%
  
  ggplot(aes(x=year, y=suicides, group=region_sex, color=region_sex)) +
  geom_line() +
  scale_color_viridis(discrete = TRUE) +
  theme_ipsum() +
  ylab("Number of Suicides") + 
  xlab('Year')
plot

# byRegion = false
data3 = data %>%
  group_by(year, sex) %>%
  summarize(suicides = sum(suicides_no))


# byRegion = false
plot = data3 %>%
  
  ggplot(aes(x=year, y=suicides, group=sex, color=sex)) +
  geom_line() +
  scale_color_viridis(discrete = TRUE) +
  theme_ipsum() +
  ylab("Number of Suicides") + 
  xlab('Year')
plot


# bubble plot
data2 = data %>% 
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
  arrange(desc(suicides))
  


glimpse(data)
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
  summarize(suicides = sum(suicides), gdp = sum(gdp)) # sum by decade
if(decades != 'all'){
  print(typeof(decades))
  data = data %>% filter(decade == decades)
}



















