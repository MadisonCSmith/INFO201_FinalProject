library("shiny")
library(maps)
library(mapproj)
source("./server.R")

my.data <- arrange(my.data, country_txt)
year.range <- range(my.data$iyear)

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
          
          selectInput("country",
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
        sliderInput("year",
              "Year:",
              value = 0,
              min = 5,
              max = 10)
        ),
             
      mainPanel(
        textOutput("mady") 
      )
    )
  )
)

  

shinyUI(ui)