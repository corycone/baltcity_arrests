library(tidyverse)
library(lubridate)

arrests.df <- read.csv("Arrests.csv", stringsAsFactors = FALSE)
crime.df <- read.csv("Part1_Crime_data.csv", stringsAsFactors = FALSE)

str(arrests.df)

head(arrests.df)

n_distinct(arrests.df$ArrestNumber)

#fix date data type
arrests.df$ArrestDateTime <- ymd_hms(arrests.df$ArrestDateTime)
arrests.df$year <- year(arrests.df$ArrestDateTime)

arrests_2020_2021.df <- arrests.df %>% filter(ArrestDateTime > '2019-12-31 20:47:00' & ArrestDateTime < '2021-01-01 20:47:00' )


arrests_by_week.df <- arrests_2020_2021.df %>% group_by(week(ArrestDateTime)) %>% summarise(n = n_distinct(ArrestNumber))

colnames(arrests_by_week.df) <- c("week", "arrests")

#in progress
ggplot(arrests_by_week.df, aes(x = week, y = arrests)) +
  geom_bar(stat = "identity")

arrests.df.yearly <- arrests.df %>% group_by(year, week(ArrestDateTime)) %>% summarise(n = n_distinct(ArrestNumber))

colnames(arrests.df.yearly) <- c("year", "week", "arrests")
ggplot(arrests.df.yearly, aes(x = week, y = arrests)) +
  geom_bar(stat = "identity") +
  facet_wrap(~year)

ggplot(arrests.df.yearly, aes(x = year, y = arrests)) +
  geom_bar(stat = "identity") +
  facet_wrap(~year)
#line
ggplot(arrests.df.yearly, aes(x = factor(week), y = arrests, color = factor(year), group = year)) +
  geom_line(stat = "identity") +
  theme_classic()

#crime stats

gsub("/","-",crime.df$CrimeDateTime)
crime.df$CrimeDateTime <- date(crime.df$CrimeDateTime)

crime.df$year <- year(crime.df$CrimeDateTime)
crime.df$week <- week(crime.df$CrimeDateTime)

crime.df.yearly <- crime.df %>% group_by(year, week, Description) %>% summarise(n = n_distinct(RowID))

crime.df.yearly <- crime.df.yearly %>% filter(year > '2013')

ggplot(crime.df.yearly, aes(x = factor(week), y = n, color = factor(Description), group = Description)) +
  geom_line() +
  facet_wrap(~year) +
  theme_classic()
