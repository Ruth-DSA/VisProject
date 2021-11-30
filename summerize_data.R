library(tidyverse) #data manipulation
library(dplyr)

file_data = read.csv("./data/new_master.csv")  # read csv file

glimpse(data)

data = file_data %>% 
  select(region, year, age, sex, suicides_no, population) %>%
  arrange(region, year, age, sex)

data2 = data %>% 
  group_by(region, year, age, sex) %>% 
  summarise(no_suicides = sum(suicides_no), population = sum(population))
glimpse(data2)

data3 = data2 %>%
  mutate(pop.per.100k = format(no_suicides*100000/population, digits = 3, nsmall = 2))
glimpse(data3)
