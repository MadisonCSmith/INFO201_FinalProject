# Hannah Lee
# Madison Smith
# Justin Chang
# Zale de Jong
# Section AF - Team 2
# Final Project

source("SourceCode.R")

server <- function(input, output) {
  # reactive element that changes the data set everytime the widgets are changed
  d <- reactive({
    current.unit <- rlang::sym(input$unit)
    
    # filter data according to inputs in widgets
    the.data <- filter(my.data, iyear <= input$endyear) %>%
      filter(iyear >= input$startyear) %>%
      group_by(!!current.unit) %>%
      summarize(count = n())
    
  })
  
  # overview server code
  output$overview <- renderText({
    paste("overview of project, citations, etc.")
    
  })
  
  # justins server code
  user.data <- reactive({
    country.data <- my.data %>%
      filter(country_txt %in% input$countries) %>%
      filter(iyear == input$year)
    return(country.data)
  })
  
  output$justin <- renderPlot({
    
    ggplot(data = user.data()) +
      geom_bar(mapping = aes(x = country_txt, fill = country_txt),
               show.legend = FALSE) +
      labs(
        x = "Countries",
        y = "Terrorist Attacks"
      )
  })
  
  #
  output$justin.text <- renderText({
    print("It can be seen that in the year 1970,  the United States had an 
          unusually large amount of terrorism. Other countries with large
          amounts of terrorism include Argentina, Spain, and Uruguay. However, 
          the United States drastically overtakes these countries with a huge 
          500+ terrorist attacks in 1970. It seems that these countries, 
          especially the US, are the most prone to terrorism. In 1972, however, 
          the amount of terrorism drastically decreases with the amount in the 
          US being less than 100 attacks. Then in 1973 the amount of attacks in 
          Argentina surpasses the US. In 1977 the amount of terrorism in Spain 
          skyrockets and continues to increase until 1980 where it makes a slow
          decline, but increases again in 1982. Spain stays as the country with
          the most terrorism all this time up to 1994, where the US takes the 
          top spot again. At this point in time Russia makes a huge increase in 
          terrorist attacks in their country. From then on until 2016, 
          terrorism has declined in all 4 of these countries, however, in 2003, 
          Iraq gains a huge increase in terrorist attacks. The amount of attacks
          on Iraq keep increasing all the way through 2016. Although Argentina,
          Iraq, Russia, Spain, the United States, and Uruguay are generally more
          prone to terrorism than other countries, different countries can also
          be chosen to be compared over time.")
  })
  
  output$map <- renderPlot({
    # Creates a data frame of the year span and attack types input
    # by the user.
    zale.data.formatted <- zale.data.filtered  %>%
      filter(year >= input$year[1], year <= input$year[2],
             attack_type %in% input$attack_type) %>%
      with(table(Country, attack_type))
    zale.data.formatted <- as.data.frame(zale.data.formatted)
    # Creates a data frame of the number of occurrences of terrorism
    # without some countries.
    zale.data.occurrences.missing <- zale.data.formatted %>%
      group_by(Country) %>%
      summarise(Occurrences = sum(Freq)) %>%
      ungroup()
    zale.data.occurrences.missing$Country <- as.character(
                                            zale.data.occurrences.missing$Country)
    # Creates a data frame with every country, and 0 for no
    # occurances.
    zale.data.occurrences <- zale.data.occurrences.missing %>%
      right_join(zale.countries, by = "Country") %>%
      mutate_all(funs(replace(., is.na(.), 0)))
    
    # Renames old countries which can be assigned to new countries.
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
    zale.data.occurrences[189, 1] <-
                          "United Kingdom of Great Britain and Northern Ireland"
    zale.data.occurrences[194, 1] <- "Holy See (Vatican City State)"
    zale.data.occurrences[198, 1] <- "Palestine, State of"
    zale.data.occurrences[203, 1] <- "Democratic Republic of the Congo"
    
    # Creates new values in the data frame of new countries which didn't exist
    # then.
    zale.data.occurrences[206, 1] <- "Czech Republic"
    zale.data.occurrences[206, 2] <- zale.data.occurrences[42, 2] +
                                     zale.data.occurrences[43, 2]
    zale.data.occurrences[207, 1] <- "Germany"
    zale.data.occurrences[207, 2] <- zale.data.occurrences[49, 2] +
                                     zale.data.occurrences[67, 2] + 
                                     zale.data.occurrences[199, 2]
    zale.data.occurrences[208, 1] <- "Vanuatu"
    zale.data.occurrences[208, 2] <- zale.data.occurrences[127, 2] +
                                     zale.data.occurrences[193, 2]
    zale.data.occurrences[209, 1] <- "Yemen"
    zale.data.occurrences[209, 2] <- zale.data.occurrences[133, 2] +
                                     zale.data.occurrences[165, 2]
    zale.data.occurrences[210, 1] <- "Republic of Congo"
    zale.data.occurrences[210, 2] <- zale.data.occurrences[139, 2] +
                                     zale.data.occurrences[145, 2]
    zale.data.occurrences[211, 1] <- "Zimbabwe"
    zale.data.occurrences[211, 2] <- zale.data.occurrences[146, 2] +
                                     zale.data.occurrences[205, 2]
    zale.data.occurrences[212, 1] <- "Russian Federation"
    zale.data.occurrences[212, 2] <- zale.data.occurrences[148, 2] +
                                     zale.data.occurrences[166, 2]
    zale.data.occurrences[213, 1] <- "Serbia"
    zale.data.occurrences[213, 2] <- zale.data.occurrences[153, 2] +
                                     zale.data.occurrences[152, 2] +
                                     zale.data.occurrences[202, 2]
    zale.data.occurrences[214, 1] <- "Vietnam"
    zale.data.occurrences[214, 2] <- zale.data.occurrences[164, 2] +
                                     zale.data.occurrences[196, 2]

    # Joins the zale.data.occurrences data frame with the iso.data.frame,
    # selects the desired columns, and omits the NA values.
    zale.data.iso <- zale.data.occurrences %>%
      left_join(iso.data.frame, by = "Country") %>%
      select(Country, Occurrences, a2) %>%
      na.omit()
    
    # Joins the zale.data.iso and zale.world.map data frames.
    zale.data.all <- zale.data.iso %>%
      left_join(zale.world.map, by = "a2")
    
    # Renames the first column.
    colnames(zale.data.all)[1] <- "Country"
    
    # Selects the desired columns.
    zale.data.final <- zale.data.all %>%
      select(Country, Occurrences, long, lat, group)
    
    
    # Breaks the frequency of attacks.
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
    
    # Returns a ggplot polygon world map for the terrorism dataset,
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
  
  # Renders a DataTable with the correct information.
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

  # Mady's server code
  output$alsomady <- renderPlot({
    
    # shows year unit chart
    if (input$unit == "iyear") {
      print("year")
      return (ggplot(data = d()) +
        geom_line(mapping = aes(x=iyear, y=count)) +
          labs(
            x = "year",
            y = "count"
          ))
    } 
    
    # Shows month unit chart
    if (input$unit == "imonth") {
      print("month")
      return (ggplot(data = d()) +
        geom_line(mapping = aes(x=imonth, y=count))
        +
          labs(
            x = "month",
            y = "count"
          ))
    }
    
    # Shows day unit chart
    if (input$unit == "iday") {
      print("iday")
      return (ggplot(data = d()) +
        geom_line(mapping = aes(x=iday, y=count)) +
          labs(
            x = "day",
            y = "count"
          ))
    }
  })
  
  # Creates a paragraph of text explaining the chart
  output$mady <- renderText({
    paste("This line plot shows the frequency of terrorist attacks
          over time. The frequency can be by year, month of the year, or day of the month. What
          unit is shown can be selected using the radio buttons on the left. The 
          plot can also show the data over a certain range of years, using the sliders
          on the left.")
  })


  # Creates another paragraph of text explaining the chart
  output$anothermady <- renderText({
    paste("The plot above shows that while the frequency in terrorist attacks do not change much by month of the 
          year or day of the month. However, the frequency of terrorist attck do change a lot by year. The plot 
          shows that the number of terrorist attacks spiked dramatically after 2010.")
  })
  # Creates a dataframe of the United States and the input$country 
  # then it filters it by the input$year
    hl.country <- reactive({
      new.data.frame <- filter(my.data, country_txt == "United States") %>% 
        filter(iyear == input$years)
      new.one <- filter(my.data, country_txt == input$country) %>%
        filter(iyear == input$years)
      combine <- full_join(new.data.frame, new.one)
    }) 
    
    # Creates the dataframe that will be used find the number of times 
    # United States and the input$country occurs 
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
    
    # Renders the bar plot 
    output$bar <- renderPlot({
      return(ggplot(data = h.code(), aes(x = name, y = n, fill = name), show.legend = FALSE) + 
               geom_bar(stat = "identity"))
    })
    
} 

shinyServer(server)
