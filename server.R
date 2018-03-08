library("shiny")
library(dplyr)
library("ggplot2")
library(maps)
library(mapproj)


# renders some text paragraphs and a line chart of data
server <- function(input, output) {
  
  # reads in csv data
  my.data <- read.csv('data/globalterrorism.csv', 
                      stringsAsFactors=FALSE)
  
  # reactive element that changes the data set everytime the widgets are changed
  d <- reactive({
    
    current.unit <- rlang::sym(input$unit)
    
    # filter data according to inputs in widgets
    the.data <- filter(my.data, iyear <= input$endyear) %>%
      filter(iyear >= input$startyear) %>%
      group_by(!!current.unit) %>%
      summarize(count = n())
    
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
    
    # shows year unit chart
    if (input$unit == "iyear") {
      print("year")
      return (ggplot(data = d()) +
        geom_line(mapping = aes(x=iyear, y=count)) +
          labs(
            x = "year",
            y = "count"
          ))
    } 
    
    # shows month unit chart
    if (input$unit == "imonth") {
      print("month")
      return (ggplot(data = d()) +
        geom_line(mapping = aes(x=imonth, y=count))
        +
          labs(
            x = "month",
            y = "count"
          ))
    }
    
    # shows day unit chart
    if (input$unit == "iday") {
      print("iday")
      return (ggplot(data = d()) +
        geom_line(mapping = aes(x=iday, y=count)) +
          labs(
            x = "day",
            y = "count"
          ))
    }
    
    
  })
  
  # creates a paragraph of text explaining the chart
  output$mady <- renderText({
    paste("This line plot shows the frequency of terrorist attacks
          over time. The frequency can be by year, month of the year, or day of the month. What
          unit is shown can be selected using the radio buttons on the left. The 
          plot can also show the data over a certain range of years, using the sliders
          on the left.")
    
  })
  
  # creates another paragraph of text explaining the chart
  output$anothermady <- renderText({
    paste("The plot above shows that while the frequency in terrorist attacks do not change much by month of the 
          year or day of the month. However, the frequency of terrorist attck do change a lot by year. The plot 
          shows that the number of terrorist attacks spiked dramatically after 2010.")
  })
}

shinyServer(server)