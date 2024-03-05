library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(stringr)

rm(list = ls())

# setting up working directory
setwd('C:/Users/timot/OneDrive/Augustana/Junior year/Spring semester/DATA 332')

df_truck <- read_excel('Data/NP_EX_1-2.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')

# selecting columns
df <- df_truck[, c(4:15)]

# deselect columns
df <- subset(df, select = -c(...10))

# getting difference in days with a column
date_min <- min(df$Date)
date_max <- max(df$Date)

number_of_days_on_the_road <- date_max - date_min
print(number_of_days_on_the_road)

days <- difftime(max(df$Date), min(df$Date))
print(days)

total_hours <- sum(df$Hours)

number_of_days_recorded <- nrow(df)

avg_hrs_per_day_rec <- round(total_hours / number_of_days_recorded, digits = 3)
print(avg_hrs_per_day_rec)

df$fuel_cost <- df$Gallons * df$Price.per.Gallon

df$Total_cost <- df$fuel_cost + df$Tolls + df$Misc

df$Other_cost <- df$Tolls + df$Misc

df[c('warehouse', 'city_state')] <- str_split_fixed(df$Starting.Location, ',', 2)

df$Total_gallon_consumed <- sum(df$Gallons)

df$Total_gallon_consumed <- NULL

Total_gallon_consumed <- sum(df$Gallons)
 
df$Miles_driven <- df$Odometer.Ending - df$Odometer.Beginning

Total_miles_driven <- sum(df$Miles_driven)

df$Miles_per_gallon <- round(df$Miles_driven / df$Gallons, digit = 3)

df$Price_per_mile <- round((df$Gallons * df$Price.per.Gallon) / df$Miles_driven, digit = 3)

