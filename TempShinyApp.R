# Zale de Jong


# Sources the file "SourceCode.R".
source("SourceCode.R")

ui <- navbarPage("Global Terrorism",
   
  # Creates the tabPanel relating to the overview of the tab, and explains
  # what the website is about.
  tabPanel("Overview",
          titlePanel("Trends In Global Terrorism Over Time"),
          h3("What Is This Website About?"),
          br(),
          h3("The Dataset"),
          h4("This dataset concerns statistics relating to terrorist attacks
            around the world, spanning from 1970 to 2016. The dataset
            contains a large amount of information about each attack, and
            holds over 170,000 instances of terrorist attacks. As such,
            the data needs to be worked with in order to gain a clear
            understanding of what the data set is about, and to use
            that information to answer questions we may have about the
            data set. As it would happen, we happen to have some questions
            about the data ourselves."),
          br(),
          h3("Question 1: Have the countries most prone to terrorism
             changed over time?"),
          h4("In this section, we will examine how countries which experience
            large amounts of terrorism have experienced terrorism in the
            past, and if this was always the case. This questions is aimed
            at tendencies of terrorism in locations, and if hotspots for
            terrorism are always this way."),
          br(),
          h3("Question 2: How do different types of terrorism change over
             time in varying locations?"),
          h4("In this section, we will examine the types of terrorist attacks
            and the frequency at which they occur in countries around the
            world. This questions is thought provoking, as insight can be
            gained into tendencies to use a certain type of terrorist tactic
            in specific locations for example, which can be useful in
            determining future incidents or determining how to best prevent
            it."),
          br(),
          h3("Question 3: Have terrorist attacks increased in frequency
             over the past forty-some years?"),
          h4("In this section, we aim to examine if the general frequency of
             terrorist attacks is on the rise, and what implications this may
             hold for the future. The reason why this is important is because
             it can inform us about the world current state of affairs,
             which could be eye opening and enlightening to many people."),
          br(),
          h3("Question 4: Is the United State at a significantly higher risk
             of terrorist attacks than other countries?"),
          h4("This question is interesting because it tackles a preconception
            about terrorism that is instilled in many Americans, which is
            namely that the U.S. is more prone to terrorism than other
            countries. Even if this is not the case, comparing the number of
            instances of terrorist attacks of other countries to the U.S.
            gives us insight into how the U.S. fares against terrorism as
            compared to other countries."),
          br(),
          h4("We hope you enjoy our website!"),
          h4("- Hannah, Justin, Mady, and Zale")
  ),
   
  # Creates the tabPanel relating to types of terrorist attacks in
  # different locations around the world..
  tabPanel("Types Of Attacks",
           # Creates a title for the titlePanel.
           titlePanel("What Types Of Attacks Are Most Frequent?"),
           
           # Creates a sidebarLayout for the UI.
           sidebarLayout(
             # Creates a sidebarPanel for the UI.
             sidebarPanel(
               # Prints information about what the data set is about.
               p("In this section, we look at what types of attacks occur
                 with varying frequency over time and in different locations.
                 By default, all countries are selected, but individual
                 countries can be deselected and selected to form a different
                 basis for the data shown."),
               br(),
               
               # Prints a disclaimer in italics.
               p(em("Disclaimer: Countries with missing data have been
                    excluded from consideration.")),
               br(),
               
               # Prints a description of the sidebar panel.
               p("To see how the data can change, use the widgets below to
                 alter the years and location of terrorist attacks."),
               
               # Outputs a sliderInput for the span of years.
               sliderInput("year",
                           "Year Span:",
                           min = year.range[1],
                           max = year.range[47],
                           value = year.range[c(1, 47)],
                           step = 1,
                           sep = ""),
               
               # Outputs a selectInput for the types of attacks.
               selectInput("attack_type", "Attack Type:",
                           choices = attack.type, multiple = TRUE,
                           selected = attack.type)
              ),
             
             # Creates a mainPanel for the UI.
             mainPanel(
               # Outputs a tabPanel with the world map and data table.
               tabsetPanel(type = "tabs",
                           # Outputs the world map and map description.
                           tabPanel("Map", plotOutput("map"),
                                    textOutput("zale_map_description")
                           ),
                           
                           # Outputs the data table and table description.
                           tabPanel("Table", br(),
                                    textOutput("zale_table_description"),
                                    br(),
                                    dataTableOutput("table")
                           ),
                           
                           # Outputs the conclusion.
                           tabPanel("Conclusion",
                                h1("So, how does terrorism change with time
                                   and location?"),
                                h4("By examining the data, we can start to
                                   identify trends in where specific types
                                   of attacks occur more often than others.
                                   A good way to start looking at the data
                                   set is to leave the span at the entirety
                                   of the data to compare how types of
                                   terrorism have occurred in total. By
                                   doing this, we can see that the rankings
                                   for each type of attack are as follows:
                                   Pakistan for armed assaults,
                                   the United Kingdom for assassinations,
                                   Iraq for bombing/explosions, the
                                   United States for facility/infrastructure
                                   attacks, India for hijacking, El Salvador
                                   for barricade hostage incidents, India for
                                   kidnapping hostage incidents, India for
                                   unarmed assault, and Afghanistan for
                                   uncategorical attacks."),
                                h4("This data alone is very interesting, as
                                   it shows that apart from India, different
                                   types of terrorism are most common in
                                   very different places around the world,
                                   hinting at a cultural basis for each
                                   attack. As the data is altered by shifting
                                   the span of years, we can look for other
                                   details about frequency and type of attack
                                   as well, which could lead to further
                                   investigation.")
                           )
                )
              )
            )
  )
)

server <- function(input, output) {
  
  output$map <- renderPlot({
    
    zale.data.formatted <- zale.data.filtered  %>%
      filter(year >= input$year[1], year <= input$year[2], attack_type %in% input$attack_type) %>%
      with(table(Country, attack_type))
    zale.data.formatted <- as.data.frame(zale.data.formatted)
    
    zale.data.occurrences.missing <- zale.data.formatted %>%
      group_by(Country) %>%
      summarise(Occurrences = sum(Freq)) %>%
      ungroup()
    zale.data.occurrences.missing$Country <- as.character(zale.data.occurrences.missing$Country)
    
    zale.data.occurrences <- zale.data.occurrences.missing %>%
      right_join(countries, by = "Country") %>%
      mutate_all(funs(replace(., is.na(.), 0)))
    
    #
    zale.data.occurrences[21, 1] <- "Bolivia, Plurinational State of"
    zale.data.occurrences[22, 1] <- "Bosnia and Herzegovina"
    zale.data.occurrences[25, 1] <- "Brunei Darussalam"
    zale.data.occurrences[50, 1] <- "Timor-Leste"
    zale.data.occurrences[58, 1] <- "Falkland Islands (Malvinas)"
    zale.data.occurrences[84, 1] <- "Iran, Islamic Republic of"
    zale.data.occurrences[89, 1] <- "Cote d'Ivoire"
    zale.data.occurrences[98, 1] <- "Lao People's Democratic Republic"
    zale.data.occurrences[106, 1] <- "Macao"
    zale.data.occurrences[107, 1] <- "the former Yugoslav Republic of Macedonia"
    zale.data.occurrences[118, 1] <- "Moldova, Republic of"
    zale.data.occurrences[132, 1] <- "Democratic People's Republic of Korea"
    zale.data.occurrences[157, 1] <- "Slovakia"
    zale.data.occurrences[162, 1] <- "Republic of Korea"
    zale.data.occurrences[169, 1] <- "Saint Kitts and Newis"
    zale.data.occurrences[170, 1] <- "Saint Lucia"
    zale.data.occurrences[176, 1] <- "Syrian Arab Republic"
    zale.data.occurrences[179, 1] <- "Tanzania, United Republic of"
    zale.data.occurrences[189, 1] <- "United Kingdom of Great Britain and Northern Ireland"
    zale.data.occurrences[194, 1] <- "Holy See (Vatican City State)"
    zale.data.occurrences[198, 1] <- "Palestine, State of"
    zale.data.occurrences[203, 1] <- "Democratic Republic of the Congo"
    
    #
    zale.data.occurrences[206, 1] <- "Czech Republic"
    zale.data.occurrences[206, 2] <- zale.data.occurrences[42, 2] + zale.data.occurrences[43, 2]
    zale.data.occurrences[207, 1] <- "Germany"
    zale.data.occurrences[207, 2] <- zale.data.occurrences[49, 2] + zale.data.occurrences[67, 2] + zale.data.occurrences[199, 2]
    zale.data.occurrences[208, 1] <- "Vanuatu"
    zale.data.occurrences[208, 2] <- zale.data.occurrences[127, 2] + zale.data.occurrences[193, 2]
    zale.data.occurrences[209, 1] <- "Yemen"
    zale.data.occurrences[209, 2] <- zale.data.occurrences[133, 2] + zale.data.occurrences[165, 2]
    zale.data.occurrences[210, 1] <- "Republic of Congo"
    zale.data.occurrences[210, 2] <- zale.data.occurrences[139, 2] + zale.data.occurrences[145, 2]
    zale.data.occurrences[211, 1] <- "Zimbabwe"
    zale.data.occurrences[211, 2] <- zale.data.occurrences[146, 2] + zale.data.occurrences[205, 2]
    zale.data.occurrences[212, 1] <- "Russian Federation"
    zale.data.occurrences[212, 2] <- zale.data.occurrences[148, 2] + zale.data.occurrences[166, 2]
    zale.data.occurrences[213, 1] <- "Serbia"
    zale.data.occurrences[213, 2] <- zale.data.occurrences[153, 2] + zale.data.occurrences[152, 2] + zale.data.occurrences[202, 2]
    zale.data.occurrences[214, 1] <- "Vietnam"
    zale.data.occurrences[214, 2] <- zale.data.occurrences[164, 2] + zale.data.occurrences[196, 2]
    
    #
    zale.data.iso <- zale.data.occurrences %>%
      left_join(iso.data.frame, by = "Country") %>%
      select(Country, Occurrences, a2) %>%
      na.omit()
    
    #
    zale.data.all <- zale.data.iso %>%
      left_join(world.map, by = "a2")
    
    #
    colnames(zale.data.all)[1] <- "Country"
    
    #
    zale.data.final <- zale.data.all %>%
      select(Country, Occurrences, long, lat, group)
    

    # Breaks the emissions levels of the specified CO2 type into levels
    # that are color coded on the world map.
      zale.data.final$breaks <- cut(zale.data.final$Occurrences,
                                       breaks = c(0, 500, 1000, 1500,
                                                  2000, 2500, 3000, 3500),
                                       labels = c("0 - 500",
                                                  "500 - 1000",
                                                  "1000 - 1500",
                                                  "1500 - 2000",
                                                  "2000 - 2500",
                                                  "2500 - 3000",
                                                  "3000 - 3500")
                                  )

    # Returns a ggplot polygon world map for the map emissions iso dataset,
    # with longitude on the x and latitude on the y axis.
    ggplot(data = zale.data.final) +
      geom_polygon(aes(x = long, y = lat, group = group, fill = breaks),
                   color = "black") +
      coord_quickmap() +
      scale_fill_brewer(palette = "Greens") +
      labs(title = "World Map",
           x = "Longitude",
           y = "Latitude",
           fill = "Number Of Attacks")
  })
  
  # Renders the map description output.
  output$zale_map_description <- renderText({
    paste("The map above displays the frequency of terrorist attacks in
          various locations around the world for any given span of
          years from 1970 to 2016. As you interact with the slider,
          try and look for countries that either change drastically
          in color, or stay a consistently light or dark color.")
  })
  
  output$table <- renderDataTable({
    zale.data.formatted <- zale.data.filtered  %>%
      filter(year >= input$year[1], year <= input$year[2]) %>%
      with(table(Country, attack_type))
    
    zale.data.formatted <- as.data.frame(zale.data.formatted)
    zale.data.wide <- spread(zale.data.formatted, attack_type, Freq)
    
    return(zale.data.wide)
  })
  
  # Renders the table description output.
  output$zale_table_description <- renderText({
    paste("This table gives the exact values for the frequency of
          specific types of terrorist attacks in countries around
          the world in a given span of years. You can sort the
          columns to see the countries with the largest or smallest
          values for a type of attack, or simply browse the countries
          alphabetically.")
  })
}

shinyApp(ui = ui, server = server)
