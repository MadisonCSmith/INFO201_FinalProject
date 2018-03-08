library("shiny")
library(maps)
library(mapproj)

ui <- navbarPage("Global Terrorism",
  
  # code for the overview tab
  tabPanel("Overview",
    titlePanel("Trends in Global Terrorism Over Time"),
    textOutput("overview")
  ),
  
  # all justin's ui code
  tabPanel("Justin",
    sidebarLayout(
             
      sidebarPanel(

          sliderInput("year",
              "Year:",
              value = 0,
              min = 5,
              max = 10)
          ),
             
      mainPanel(
        textOutput("justin")
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

  # all hannah's ui code
  tabPanel("Hannah",
           
    sidebarLayout(
             
      sidebarPanel(
        sliderInput("year",
              "Year:",
              value = 0,
              min = 5,
              max = 10)
        ),
             
      mainPanel(
        textOutput("hannah")
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