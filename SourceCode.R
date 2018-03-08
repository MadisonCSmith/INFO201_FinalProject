# Hannah Lee
# Madison Smith
# Justin Chang
# Zale de Jong
# Section AF - Team 2
# Final Project

# Loads the shiny, dplyr, ggplot2, maps, and mapproj packages.
library(tidyr)
library(shiny)
library(dplyr)
library(ggplot2)
library(maps)
library(mapproj)

# Reads in the data set "globalterrorism.csv" and stores it in 
# the variable my.data.
my.data <- read.csv('./data/globalterrorism.csv', 
                    stringsAsFactors=FALSE)
my.data <- arrange(my.data, country_txt)


year.range <- range(my.data$iyear)
hl.q5.data <- select(my.data, iyear, country_txt)  %>% 
  filter(country_txt != "United States") %>%
  unique() 

hannah.vector <- sort(hl.q5.data[, "country_txt"]) 


#
zale.data <- my.data

# Renames the first and seventh columns.
colnames(zale.data)[1] <- "year"
colnames(zale.data)[7] <- "attack_type"

# View(zale.data)

# Creates a new data frame containing only relevant information.
zale.data.filtered <- zale.data %>%
  select(year, country_txt, attack_type) %>%
  na.omit()
# Renames the second column of the data frame.
colnames(zale.data.filtered)[2] <- "Country"

#
zale.countries <- as.data.frame(sort(unique(zale.data.filtered$Country)), stringsAsFactors = FALSE)
colnames(zale.countries)[1] <- "Country"
attack.type <- as.vector(sort(unique(zale.data.filtered$attack_type)))

# Stores the range of years the data frame spans.
zale.year.range <- c(1970:2016)

# Stores the world map data frame and removes the column subregion.
zale.world.map <- map_data("world") %>%
  select(-subregion)
# Renames the fifth column of the data frame.
colnames(zale.world.map)[5] <- "Country"

# Adds a new column of two digit ISO codes to each country.
zale.world.map$a2 <- iso.alpha(world.map$Country, n = 2)

# Stores the iso3166 data frame in a new data frame.
iso.data.frame <- iso3166
# Renames the third row of the data frame.
colnames(iso.data.frame)[3] <- "Country"


