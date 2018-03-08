# Hannah Lee
# Madison Smith
# Justin Chang
# Zale de Jong
# Section AF - Team 2
# Final Project

source("SourceCode.R")

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


shinyServer(server)