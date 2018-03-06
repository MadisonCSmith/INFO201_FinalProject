library("shiny")
library(maps)
library(mapproj)


ui <- navbarPage("Global Terrorism",
  
  # code for the overview tab
  tabPanel("Overview",
    titlePanel("Trends in Global Terrorism Over Time"),
    textOutput("overview")
  ),

  # all hannah's ui code
  tabPanel("Hannah",
    sidebarLayout(
      sidebarPanel(
        selectInput('country', "Select the country you would like to compare to",
                    choice =  vector.country.names)
        ),
             
      mainPanel(
        textOutput("hannah")
      )
    )
  )
)
shinyUI(ui)