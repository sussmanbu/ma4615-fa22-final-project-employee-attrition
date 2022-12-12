library(tidyverse)
library(shiny)
library(leaflet)
library(sf)

coordinates <- read_csv(here::here("dataset","coordinates.csv"))
CO2_emissions <- read_csv(here::here("dataset","historical_emissions.csv"))


CO2_clean<-CO2_emissions %>% select(Country,34:6)
CO2_clean$`1990`<-as.double(CO2_clean$`1990`)

#df <- read_csv("dataset/annual_csv.RData")
df <- CO2_clean %>% pivot_longer(cols = c("1990":"2018"), names_to = "Year",values_to = "CO2emission")

# Client interface
ui <- fluidPage(
  # Application title
  titlePanel("CO2 Emissions"),
  
  #  Sidebar panel for input
  sidebarPanel(
    # User inputs year to query from
    selectInput(
      inputId = "year",
      label = "From which year:",
      choices = df$Year %>% unique()
    ),
    
    # User inputs country to query from
    selectInput(
      inputId = "country",
      selected = "World",
      label = "Which country are you are interested:",
      choices = df$Country%>% unique(),
      multiple = TRUE
    ),
    
    # User inputs year that map should query from
    sliderInput(
      inputId = 'mapYear', 
      label = 'Year', 
      min = 1990, 
      max = 2018, 
      value = c(2000)
    )
  ),
  
  
  mainPanel(
    plotOutput(outputId = "scatter"),
    leafletOutput(outputId = "map")
  )
)

# Defines server logic
server <- function(input, output) {
  output$scatter <- renderPlot({
    # Centers titles
    theme_update(plot.title = element_text(hjust = 0.5))
    
    # Plots a line for each country selected
    df %>% 
      filter(Country %in% input$country & Year >= input$year) %>% 
      ggplot() + 
      labs(x = "Year", y = "CO2 Emission", color = "Country", title = "Progression of CO2 Levels") +
      geom_line(mapping = aes(x = Year, y = CO2emission, group = Country, colour = as.factor(Country)))
  })
  
  map_df <- reactive({
    df %>%
      filter(Year == input$mapYear) %>%
      left_join(y = coordinates, by = c('Country' = 'coverage_city')) %>%
      filter(!is.na(lng) & !is.na(lat)) %>%
      st_as_sf(coords = c('lng', 'lat')) %>%
      st_set_crs(4326)
  })
  # Adds circle markers to map based on level of CO2 emission
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = -95.7, lat = 37, zoom = 2) %>%
      addCircleMarkers(data = map_df(), radius = ~sqrt(CO2emission))
  })
  
}

# Run the application
shinyApp(ui = ui, server = server)