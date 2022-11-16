library(tidyverse)
library(shiny)
df <- read_csv("dataset/annual_csv.RData")

# Client interface
ui <- fluidPage(
  # Application title
  titlePanel("CO2 Emissions")
  
)