# Hannah Lee
# Madison Smith
# Justin Chang
# Zale de Jong
# Section AF - Team 2
# Final Project
# server file

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
  
  # Renders a DataTable with the correct information.
  output$table <- renderDataTable({
    zale.data.formatted <- zale.data.filtered  %>%
      filter(year >= input$zale_year[1], year <= input$zale_year[2]) %>%
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
