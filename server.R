library("shiny")
library(dplyr)
library("ggplot2")
library(maps)
library(mapproj)



server <- function(input, output) {
  
 
  d <- reactive({
    my.data <- read.csv('data/globalterrorism.csv', 
                        stringsAsFactors=FALSE)
    #my.data <- my.data %>% na.omit() # doesn't like that

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
  output$alsomady <- renderPlot({
    #the.data <- group_by(d(), iyear)
    #the.data <- filter(d(), iyear < input$year)
    #the.data <- group_by(d(), iyear) %>%
     # filter(iyear <= 2000) %>%
      #summarize(count = n())
    
    #current.year <- rlang::sym(input$year)
    current.year <- rlang::sym(input$unit)
    print(current.year)
    
    the.data <- filter(d(), iyear <= 2000) %>%
      group_by(!!current.year) %>%
      summarize(count = n())
    
    View(the.data)
    
    print(input$year)
    print(input$unit)
    
    #ggplot(data = the.data) +
      #geom_line(mapping = aes(x=iyear, y=count))
    
    if (input$unit == "iyear") {
      print("year")
      return (ggplot(data = the.data) +
        geom_line(mapping = aes(x=iyear, y=count)))
    } 
    
    if (input$unit == "imonth") {
      print("month")
      return (ggplot(data = the.data) +
        geom_line(mapping = aes(x=imonth, y=count)))
    }
    
    if (input$unit == "iday") {
      print("iday")
      return (ggplot(data = the.data) +
        geom_line(mapping = aes(x=iday, y=count)))
    }
    
    
  })
  
  output$mady <- renderText({
    paste("mady- all the things")
    
  })
  
}

shinyServer(server)