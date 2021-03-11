library(tidyverse)
library(lubridate)

arrests.df <- read.csv("Arrests.csv", stringsAsFactors = FALSE)

str(arrests.df)

head(arrests.df)

n_distinct(arrests.df$ArrestNumber)

#fix date data type
arrests.df$ArrestDateTime <- ymd_hms(arrests.df$ArrestDateTime)

arrests_2020_2021.df <- arrests.df %>% filter(ArrestDateTime > '2019-12-26 20:47:00' & ArrestDateTime > '2021-01-01 20:47:00' )


arrests_by_week.df <- arrests_2020_2021.df %>% group_by(week(ArrestDateTime)) %>% summarise(n = n_distinct(ArrestNumber))

colnames(arrests_by_week.df) <- c("week", "arrests")

#in progress
ggplot(arrests_by_week.df, aes(x = week, y = arrests)) +
  geom_bar(stat = "identity")


