library("shiny")
library(maps)
library(mapproj)

ui <- fluidPage(
  
  # title 
  titlePanel("Global Terrorism"),
  
  # creates two columns
  sidebarLayout(
    
    # creates left column with the slider/dropdown menu
    sidebarPanel(
      
      # creates the dropdown menu
          # put in widgets
    ),
    
    
    # creates the right columns with the visualizations
    mainPanel(
      
      # creates two tabs- the map and table tab
      tabsetPanel(type = "tabs",
                  
        # creates the table tab
        tabPanel("Hannah", tableOutput("table")),
          # put in plot
        
        tabPanel("Zale", tableOutput("table")),
        # put in plot
                
        tabPanel("Justin", tableOutput("table")),
        # put in plot
                
        tabPanel("Madison", tableOutput("table"))
        # put in plot        
                           
      )
      
    )
  )
)

shinyUI(ui)