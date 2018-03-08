library("shiny")
library(dplyr)
library("ggplot2")
library(maps)
library(mapproj)

my.data <- read.csv('data/globalterrorism.csv', 
                    stringsAsFactors=FALSE)
my.data <- arrange(my.data, country_txt)

server <- function(input, output) {
  
  # overview server code
  output$overview <- renderText({
    paste("overview of project, citations, etc.")
    
  })
  
  # justins server code
  
  user.data <- reactive({
    country.data <- my.data %>%
      filter(country_txt %in% input$country) %>%
      filter(iyear == input$year)
    return(country.data)
  })
  output$justin <- renderPlot({
    
    ggplot(data = user.data()) +
      geom_bar(mapping = aes(x = country_txt, fill = country_txt), show.legend = FALSE) +
      labs(
        x = "Countries",
        y = "Terrorist Attacks"
      )
  })
  output$justin.text <- renderText({
    print("It can be seen that in the year 1970,  the United States had an 
          unusually large amount of terrorism. Other countries with large
          amounts of terrorism include Argentina, Spain, and Uruguay. However, 
          the United States drastically overtakes these countries with a huge 
          500+ terrorist attacks in 1970. It seems that these countries, 
          especially the US, are the most prone to terrorism. In 1972, however, 
          the amount of terrorism drastically decreases with the amount in the 
          US being less than 100 attacks. Then in 1973 the amount of attacks in 
          Argentina surpasses the US. In 1977 the amount of terrorism in Spain 
          skyrockets and continues to increase until 1980 where it makes a slow
          decline, but increases again in 1982. Spain stays as the country with
          the most terrorism all this time up to 1994, where the US takes the 
          top spot again. At this point in time Russia makes a huge increase in 
          terrorist attacks in their country. From then on until 2016, 
          terrorism has declined in all 4 of these countries, but the US and 
          Russia still have large amounts of terrorism compared to other 
          countries. Although Argentina, Russia, Spain, the United States, 
          and Uruguay are generally more prone to terrorism than other 
          countries, different countries can also be chosen to be compared over 
          time.")
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