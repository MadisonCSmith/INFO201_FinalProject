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


# Creates a copy of the data frame for Zale.
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

# Creates a vector of types of attacks.
attack.type <- as.vector(sort(unique(zale.data.filtered$attack_type)))

# Stores the range of years the data frame spans.
zale.year.range <- c(1970:2016)
