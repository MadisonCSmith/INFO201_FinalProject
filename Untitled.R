my.data <- read.csv('data/globalterrorism.csv', 
                    stringsAsFactors=FALSE)
my.data <- my.data %>% na.omit()

testing.data <- filter(my.data, iyear <= 2000) %>%
  group_by(iyear) %>%
  summarize(count = n())

ggplot(data = testing.data) +
  geom_line(mapping = aes(x=iyear, y=count))

test <- "thing"
print(rlang::sym(test))
