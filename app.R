# main file to load libraries and launch shiny
# launch with 'RunApp' green triangle in upper right coner of this window

library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(hrbrthemes)
library(viridis)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(shinythemes)
library(scales)
library(ggstream)

# Suppress summarize info
options(dplyr.summarise.inform = FALSE)
runApp("shiny")

