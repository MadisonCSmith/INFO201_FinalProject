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
  
  # overview server code
  output$overview <- renderText({
    paste("overview of project, citations, etc.")
    
  })
  
  # justins server code
  output$justin <- renderText({
    paste("justin- all of the things")
    
  })
  
  # zales server code
  output$zale <- renderText({
    paste("zale- all of things")
    
  })
  
  # hannahs server code
  output$hannah <- renderText({
    paste("hannah- all the things")
    
  })
  
  # madys server code
  output$mady <- renderText({
    paste("mady- all the things")
    
  })
  
}

shinyServer(server)