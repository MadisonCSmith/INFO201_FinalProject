library("shiny")
library(dplyr)
library("ggplot2")
library(maps)
library(mapproj)



server <- function(input, output) {
  
 
  d <- reactive({
    my.data <- read.csv('data/globalterrorism.csv', 
                        stringsAsFactors=FALSE)
    my.data <- my.data %>% na.omit()

  })
  
 
  
}

shinyServer(server)