library("shiny")
library(dplyr)
library("ggplot2")
library(maps)
library(mapproj)


server <- function(input, output) {
  #d <- reactive({
    my.data <- read.csv('data/globalterrorism.csv', 
                        stringsAsFactors=FALSE)
    my.data <- my.data %>% na.omit() 
  #})
  
    h.data <- select(my.data, iyear, country_txt, region, latitude, longitude)  %>% 
      filter(country_txt != "United States") %>%
      unique()

    
  #vector <- reactive({
    vector.country.names <- h.data[, "country_txt"] 
  #})
  
  # hannahs server code
  output$comparisonPlot <- renderPlot({
 
  })

}

shinyServer(server)