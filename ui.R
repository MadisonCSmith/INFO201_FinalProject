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
  tabPanel("Mady",
    sidebarLayout(
             
      sidebarPanel(
        
        radioButtons("unit", "Group attacks by unit of time:",
                    c("year" = "iyear",
                      "month" = "imonth",
                      "day" = "iday")),
        
        br(),
        
        sliderInput("year",
                    "Year:",
                    value = 1993,
                    min = 1970,
                    max = 2016)
        
      ),
      
             
      mainPanel(
        textOutput("mady"),
        plotOutput("alsomady")
      )
    )
  )
)

  

shinyUI(ui)