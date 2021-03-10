library(tidyverse)
library(lubridate)

arrests.df <- read.csv("Arrests.csv", stringsAsFactors = FALSE)

str(arrests.df)

head(arrests.df)

n_distinct(arrests.df$ArrestNumber)

#fix date data type
arrests.df$ArrestDateTime <- ymd_hms(arrests.df$ArrestDateTime)

arrests_2020_2021.df <- arrests.df %>% filter(ArrestDateTime > '2019-12-26 20:47:00')


