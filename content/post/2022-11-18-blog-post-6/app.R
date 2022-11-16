library(tidyverse)
library(shiny)
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
      label = "Choose a year:",
      choices = df$Year %>% unique(),
    ),
    
    # User inputs country to query from
    textInput(
      inputId = "country",
      label = "Choose a country:",
      value = "World"
    )
    
  ),
  
  mainPanel(
    plotOutput(outputId = "scatter")
  )
  
)

# Defines server logic
server <- function(input, output) {
  output$scatter <- renderPlot({
    ggplot(data = df %>% filter(Country == input$country)) +
      geom_point(aes(x = Year, y = CO2emission)) +
      geom_line(aes(x = Year, y = CO2emission))
  })
}

# Run the application
shinyApp(ui = ui, server = server)

