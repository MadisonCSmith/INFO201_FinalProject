# Hannah Lee
# Madison Smith
# Justin Chang
# Zale de Jong
# Section AF - Team 2
# Final Project

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

                 # All of Mady's ui code
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
                 ),
                 
                 
                 # Creates the tabPanel relating to types of terrorist attacks in
                 # different locations around the world.
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
                              sliderInput("zale_year",
                                          "Year Span:",
                                          min = zale.year.range[1],
                                          max = zale.year.range[47],
                                          value = zale.year.range[c(1, 47)],
                                          step = 1,
                                          sep = ""),
                              # Outputs a selectInput for the type of CO2 emission.
                              selectInput("attack_type", "Attack Type:",
                                          choices = attack.type)
                              ),
                            # Creates a mainPanel for the UI.
                            mainPanel(
                              # Outputs a tabPanel with the world map and data table.
                              tabsetPanel(type = "tabs",
                                          
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

                  tabPanel("United States Comparison",
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
                 )
)

shinyUI(ui)
