library(shiny)
library(maps)
library(mapproj)
library(rsconnect)
library(dplyr)

my.data <- read.csv('./data/globalterrorism.csv', 
                    stringsAsFactors=FALSE)
my.data <- arrange(my.data, country_txt)
year.range <- range(my.data$iyear)
hl.q5.data <- select(my.data, iyear, country_txt)  %>% 
  filter(country_txt != "United States") %>%
  unique() 

hannah.vector <- sort(hl.q5.data[, "country_txt"]) 

ui <- navbarPage("Global Terrorism",
  
  # code for the overview tab
  tabPanel("Overview",
    titlePanel("Trends in Global Terrorism Over Time"),
    textOutput("overview")
  ),
  
  # all justin's ui code
  tabPanel("Country Comparison",
    sidebarLayout(
             
      sidebarPanel(

          sliderInput("year",
              "Year:",
              value = year.range[1],
              min = year.range[1],
              max = year.range[2],
              step = 1),
          
          selectInput("countries",
            "Countries:",
            my.data[, "country_txt"],
            multiple = TRUE,
            selected = c("United States", "Spain", "Uruguay", "Argentina", 
                         "Russia", "Iraq"))
      ),
             
      mainPanel(
        plotOutput("justin"),
        textOutput("justin.text")
      )
    )
  ),          

  # all zale's ui code
  tabPanel("Zale",
    sidebarLayout(
             
      sidebarPanel(

          sliderInput("year",
                "Year:",
                value = 0,
                min = 5,
                max = 10)
      ),
      mainPanel(
        textOutput("zale")
      )
    )
  ),
  tabPanel("Hannah",               
    sidebarLayout(
      sidebarPanel(
        selectInput('country', "Select the country you would like to compare to",
                    choice = hannah.vector),
        sliderInput("years", "Select the desired year", 
                    min=1970, max=2016, value = 1991, step = 1)
      ),
      
      mainPanel( 
        br(),
        p("The bar plot below will answer the question above depending on the country
          and year that is picked. The bar graph will always show the United States data 
          however, the compared country will change."),
        plotOutput("bar"),
        br(),
        p("As you can see, the data is always change according to the year and country. 
          It is interesting to see the frequency of terrorist attack across country and year 
          compared to the United States. There are trends of terrorist attack depending on 
          year and country that reflect the state of country.")
      )
    )
  ),
  
  # all Mady's ui code
    tabPanel("Change in Frequency",
      h2(" Have terrorist attacks increased in frequency over the past forty-some years?"),
    
    # creates two columns 
      sidebarLayout(
        
        # creates left columns with widgets       
        sidebarPanel(
          
          # creates a radio buttom widget
          radioButtons("unit", "Group attacks by unit of time:",
                      c("year" = "iyear",
                        "month" = "imonth",
                        "day" = "iday")),
          
          br(),
        
        # creates a text input widget
        textInput("startyear", 
                  "Start year (1970 - 2016)", 
                  value = "1970", 
                  width = NULL, 
                  placeholder = NULL),
        
        br(),
        
        # creates another text input widget
        textInput("endyear", 
                  "End year (1970 - 2016)", 
                  value = "2016", 
                  width = NULL, 
                  placeholder = NULL),
        br()
        
      ),
        # creates the right column with the chart       
      mainPanel(
        textOutput("mady"),
        plotOutput("alsomady"),
        textOutput("anothermady")
      )
    )
  )
)

  

shinyUI(ui)
