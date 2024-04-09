library(readxl)
library(ggplot2)

rm(list = ls())
setwd('C:/Users/timot/OneDrive/Augustana/Junior year/Spring semester/DATA 332')


car_speed <- read_excel("Data/Car_Data.xlsx")

speed_min <- min(car_speed$Speed)
speed_max <- max(car_speed$Speed)

total_speed <- sum(car_speed$Speed)

number_of_cars_recorded <- nrow(car_speed)

avg_speed_per_car_rec <- round(total_speed / number_of_cars_recorded, digits = 3)

speed_per_color <- car_speed %>%
  group_by(Color) %>%
  summarize(count = n(),
            mean_speed_per_color = mean(Speed, na.rm = TRUE))
