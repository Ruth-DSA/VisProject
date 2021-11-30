library(tidyverse) #data manipulation
library(dplyr)

data = read.csv("./data/master.csv")  # read csv file

glimpse(data)
colnames(data)[1] = gsub('^...','',colnames(data)[1]) # remove weird character at beinning
glimpse(data)

data = data %>% group_by(country)

regions = group_keys(data)
write.csv(regions,"./data/regions.csv", row.names = FALSE)

regions = read.csv("./data/regions.csv")

regions = regions %>% group_by(region)
n_groups(regions)

reg = group_keys(regions)
reg

reg1 = regions %>% filter(region == 'Africa')
reg2 = regions %>% filter(region  == 'Asia')
reg3 = regions %>% filter(region  == 'Caribbean')
reg4 = regions %>% filter(region  == 'Central America')
reg5 = regions %>% filter(region  == 'Europe')
reg6 = regions %>% filter(region  == 'Middle East')
reg7 = regions %>% filter(region  == 'North America')
reg8 = regions %>% filter(region  == 'Oceania')
reg9 = regions %>% filter(region  == 'South America')

data2 = data %>% mutate(region = if_else(country %in% reg1$country, 'Africa', NULL, missing = NULL))
data2 = data2 %>% mutate(region = if_else(country %in% reg2$country, 'Asia', region, missing = NULL))
data2 = data2 %>% mutate(region = if_else(country %in% reg3$country, 'Caribbean', region, missing = NULL))
data2 = data2 %>% mutate(region = if_else(country %in% reg4$country, 'Central America', region, missing = NULL))
data2 = data2 %>% mutate(region = if_else(country %in% reg5$country, 'Europe', region, missing = NULL))
data2 = data2 %>% mutate(region = if_else(country %in% reg6$country, 'Middle East', region, missing = NULL))
data2 = data2 %>% mutate(region = if_else(country %in% reg7$country, 'North America', region, missing = NULL))
data2 = data2 %>% mutate(region = if_else(country %in% reg8$country, 'Oceania', region, missing = NULL))
data2 = data2 %>% mutate(region = if_else(country %in% reg9$country, 'South America', region, missing = NULL))

data2 %>% filter(region == 'Middle East')

data2 = data2 %>% relocate(region, .after = country)

write.csv(data2,"./data/new_master.csv", row.names = FALSE)
