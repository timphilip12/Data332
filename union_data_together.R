library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(stringr)

rm(list = ls())

# setting up working directory
setwd('C:/Users/timot/OneDrive/Augustana/Junior year/Spring semester/DATA 332')

df_truck_0001 <- read_excel('Data/truck data 0001.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')

df_truck_0369 <- read_excel('Data/truck data 0369.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')

df_truck_1226 <- read_excel('Data/truck data 1226.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')

df_truck_1442 <- read_excel('Data/truck data 1442.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')

df_truck_1478 <- read_excel('Data/truck data 1478.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')

df_truck_1539 <- read_excel('Data/truck data 1539.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')

df_truck_1769 <- read_excel('Data/truck data 1769.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')

df_truck_0001 <- read_excel('Data/truck data 0001.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')

df_pay <- read_excel('Data/Driver Pay Sheet.xlsx', .name_repair = 'universal')

df <- rbind(df_truck_0001,
            df_truck_0369,
            df_truck_1226,
            df_truck_1442,
            df_truck_1478,
            df_truck_1539,
            df_truck_1769
            )

df_starting_pivot <- df %>% 
  group_by(Truck.ID) %>%
  summarize(count = n())

df <- left_join(df, df_pay, by = c('Truck.ID'))

df$Miles_driven <- df$Odometer.Ending - df$Odometer.Beginning

df$Labor_cost <- df$Miles_driven * df$labor_per_mil

df$full_name <- paste(df$first, df$last)

df_Labor_pivot <- df %>% 
  group_by(full_name, Truck.ID) %>%
  summarize(count = n(),
            Total_Truck_Cost = sum(Labor_cost, na.rm = TRUE)
            )

set.seed(123)  
num_bars <- nrow(df_Labor_pivot)
random_colors <- sample(colors(), num_bars)

ggplot(df_Labor_pivot, aes(x = full_name, y = Total_Truck_Cost, fill = random_colors)) +
  geom_col() +
  geom_text(aes(label = Total_Truck_Cost), vjust = -0.5, size = 3, color = "black") +
  scale_fill_identity() +
  theme(axis.text = element_text(angle = 45, vjust = 0.5, hjust = 1))