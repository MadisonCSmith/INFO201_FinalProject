library(shiny) 
library(dplyr)
library(ggplot2)
library(maps)
library(mapproj)


server <- function(input, output) {
    my.data <- read.csv('./data/globalterrorism.csv', 
                        stringsAsFactors=FALSE) 
    #my.data <- my.data %>% na.omit() 
  
    # New data frame that has the year, country name, region, lat, long will get rid of the United States 
    # and only keep one of each 
    hl.q5.data <- select(my.data, iyear, country_txt, region, latitude, longitude)  %>% 
      filter(country_txt != "United States") %>%
      unique() 
    
    # This creates a vecotr of country names 
    hannah.vector <- sort(q5.data[, "country_txt"]) 
    
    hl.country <- reactive({
      new.data.frame <- filter(my.data, country_txt == "United States") %>% 
        filter(iyear == input$years)
      new.one <- filter(my.data, country_txt == input$country) %>%
        filter(iyear == input$years)
      combine <- full_join(new.data.frame, new.one)
    })
    
    h.code <- reactive ({
      count.united.states <- select(hl.country(), country_txt) %>% count(country_txt == "United States")  
      # gets the number of times United States is used in the dataframe 
      new <- count.united.states[,2:2]
      new.num <- new[-1,] # grabs the number of occurances of that dataframe
      new.num$name <- "United States"
      
      count.input <- select(hl.country(), country_txt) %>% count(country_txt == input$country)  
      input.count <- count.input[,2:2] 
      input.num <- input.count[-1,] # grabs the number of occurances of that dataframe
      input.num$name <- input$country
      
      combine.data <- full_join(input.num, new.num)
      combine.data
    })
    
    output$bar <- renderPlot({
      return(ggplot(data = h.code(), aes(x = name, y = n, fill = name), show.legend = FALSE) + 
               geom_bar(stat = "identity"))
    })
    
} 

shinyServer(server)
