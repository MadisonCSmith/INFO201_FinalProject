library(shiny)
library(maps)
library(mapproj)
library(rsconnect)


ui <- navbarPage("Global Terrorism",
  
  # code for the overview tab
  tabPanel("Overview",
    titlePanel("Trends in Global Terrorism Over Time"),
    textOutput("overview")
  ),

  # all hannah's ui code
  tabPanel("Hannah",
    titlePanel("Is the United States at a significantly higher risk for terrorist attacks than other
            countries?"),
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
          year and country that reflect the state of country. ")
      )
    )
  )
)
shinyUI(ui)