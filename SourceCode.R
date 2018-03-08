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
countries <- as.data.frame(sort(unique(zale.data.filtered$Country)), stringsAsFactors = FALSE)
colnames(countries)[1] <- "Country"
attack.type <- as.vector(sort(unique(zale.data.filtered$attack_type)))

# Stores the range of years the data frame spans.
year.range <- c(1970:2016)

# Stores the world map data frame and removes the column subregion.
world.map <- map_data("world") %>%
  select(-subregion)
# Renames the fifth column of the data frame.
colnames(world.map)[5] <- "Country"

# Adds a new column of two digit ISO codes to each country.
world.map$a2 <- iso.alpha(world.map$Country, n = 2)

# Stores the iso3166 data frame in a new data frame.
iso.data.frame <- iso3166
# Renames the third row of the data frame.
colnames(iso.data.frame)[3] <- "Country"

# attack.types <- c("Armed Assault", "Assassination", "Bombing/Explosion", "Facility/Infrastructure Attack",
#                   "Hijacking", "Hostage Taking (Barricade Incident)", "Hostage Taking (Kidnapping)", "Unarmed Assault",
#                   "Unknown")
# 
# zale.data.formatted <- zale.data.filtered  %>%
#   filter(year >= 1970, year <= 1971, attack_type %in% attack.types) %>%
#   with(table(Country, attack_type))
# zale.data.formatted <- as.data.frame(zale.data.formatted)
# View(zale.data.formatted)
# 
# zale.data.occurrences.missing <- zale.data.formatted %>%
#   group_by(Country) %>%
#   summarise(Occurrences = sum(Freq)) %>%
#   ungroup()
# zale.data.occurrences.missing$Country <- as.character(zale.data.occurrences.missing$Country)
# View(zale.data.occurrences.missing)
# 
# zale.data.occurrences <- zale.data.occurrences.missing %>%
#   right_join(countries, by = "Country") %>%
#   mutate_all(funs(replace(., is.na(.), 0)))
# View(zale.data.occurrences)
# 
# #
# zale.data.occurrences[21, 1] <- "Bolivia, Plurinational State of"
# zale.data.occurrences[22, 1] <- "Bosnia and Herzegovina"
# zale.data.occurrences[25, 1] <- "Brunei Darussalam"
# zale.data.occurrences[50, 1] <- "Timor-Leste"
# zale.data.occurrences[58, 1] <- "Falkland Islands (Malvinas)"
# zale.data.occurrences[84, 1] <- "Iran, Islamic Republic of"
# zale.data.occurrences[89, 1] <- "Cote d'Ivoire"
# zale.data.occurrences[98, 1] <- "Lao People's Democratic Republic"
# zale.data.occurrences[106, 1] <- "Macao"
# zale.data.occurrences[107, 1] <- "the former Yugoslav Republic of Macedonia"
# zale.data.occurrences[118, 1] <- "Moldova, Republic of"
# zale.data.occurrences[132, 1] <- "Democratic People's Republic of Korea"
# zale.data.occurrences[157, 1] <- "Slovakia"
# zale.data.occurrences[162, 1] <- "Republic of Korea"
# zale.data.occurrences[169, 1] <- "Saint Kitts and Newis"
# zale.data.occurrences[170, 1] <- "Saint Lucia"
# zale.data.occurrences[176, 1] <- "Syrian Arab Republic"
# zale.data.occurrences[179, 1] <- "Tanzania, United Republic of"
# zale.data.occurrences[189, 1] <- "United Kingdom of Great Britain and Northern Ireland"
# zale.data.occurrences[194, 1] <- "Holy See (Vatican City State)"
# zale.data.occurrences[198, 1] <- "Palestine, State of"
# zale.data.occurrences[203, 1] <- "Democratic Republic of the Congo"
# 
# #
# zale.data.occurrences[206, 1] <- "Czech Republic"
# zale.data.occurrences[206, 2] <- zale.data.occurrences[42, 2] + zale.data.occurrences[43, 2]
# zale.data.occurrences[207, 1] <- "Germany"
# zale.data.occurrences[207, 2] <- zale.data.occurrences[49, 2] + zale.data.occurrences[67, 2] + zale.data.occurrences[199, 2]
# zale.data.occurrences[208, 1] <- "Vanuatu"
# zale.data.occurrences[208, 2] <- zale.data.occurrences[127, 2] + zale.data.occurrences[193, 2]
# zale.data.occurrences[209, 1] <- "Yemen"
# zale.data.occurrences[209, 2] <- zale.data.occurrences[133, 2] + zale.data.occurrences[165, 2]
# zale.data.occurrences[210, 1] <- "Republic of Congo"
# zale.data.occurrences[210, 2] <- zale.data.occurrences[139, 2] + zale.data.occurrences[145, 2]
# zale.data.occurrences[211, 1] <- "Zimbabwe"
# zale.data.occurrences[211, 2] <- zale.data.occurrences[146, 2] + zale.data.occurrences[205, 2]
# zale.data.occurrences[212, 1] <- "Russian Federation"
# zale.data.occurrences[212, 2] <- zale.data.occurrences[148, 2] + zale.data.occurrences[166, 2]
# zale.data.occurrences[213, 1] <- "Serbia"
# zale.data.occurrences[213, 2] <- zale.data.occurrences[153, 2] + zale.data.occurrences[152, 2] + zale.data.occurrences[202, 2]
# zale.data.occurrences[214, 1] <- "Vietnam"
# zale.data.occurrences[214, 2] <- zale.data.occurrences[164, 2] + zale.data.occurrences[196, 2]
# 
# View(zale.data.occurrences)
# 
# View(iso.data.frame)
# #
# zale.data.iso <- zale.data.occurrences %>%
#   left_join(iso.data.frame, by = "Country") %>%
#   select(Country, Occurrences, a2) #%>%
#  # na.omit()
# 
# View(zale.data.iso)
# 
# #
# zale.data.all <- zale.data.iso %>%
#   left_join(world.map, by = "a2")
# 
# View(zale.data.all)
# #
# colnames(zale.data.all)[1] <- "Country"
# 
# #
# zale.data.final <- zale.data.all %>%
#   select(Country, Occurrences, long, lat, group)
# View(zale.data.final)
