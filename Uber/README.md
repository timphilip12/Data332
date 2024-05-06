# Uber assignment
Tim Philip
## Introduction
This is a repo for my findings on some uber data over 6 months. 

## Dictionnary
The uber data was from the files "uber-raw-data-apr14.csv", "uber-raw-data-aug14.csv", "uber-raw-data-jul14.csv", "uber-raw-data-jun14.csv", "uber-raw-data-may14.csv" and "uber-raw-data-sep14.csv".
### The columns used were:
1. Date/Time: the date and the time on which the uber ride was taken
2. Lat: the latitude of the position where the uber ride was taken
3. Lon: the longitude of the position where the uber ride was taken
4. Base: the base of the uber ride

## Data cleaning
1. Get all the tables into one single table. The code used was:
   ```
   combined_uber <- bind_rows(raw_uber_apr, raw_uber_may, raw_uber_jun, raw_uber_jul, raw_uber_aug, raw_uber_sep)
   ```
2. Change the format of the time using this code:
   ```
   combined_uber$Date.Time <- as.POSIXct(combined_uber$Date.Time, format = "%m/%d/%Y %H:%M:%S")
   ```
3. Create a column for hour, day and month using this code:
   ```
   combined_uber <- combined_uber %>%
     mutate(newColumn = format(Date.Time, "%value"))
   ```
4. Get the name of each month and add it to the column month with this code:
   ```
   combined_uber$MonthName <- month.name[as.integer(combined_uber$Month)]

combined_uber$Month <- paste(combined_uber$Month,       combined_uber$MonthName, sep = " ")

combined_uber$MonthName <- NULL
   ```
5. Get the day of the week for each date with this code:
```
combined_uber$DayOfWeek <- weekdays(combined_uber$Date.Time)
```
6. Get the week number with this code:
```
combined_uber$week_number <- week(combined_uber$Date.Time)
```
7. Save the table as a RDS file:
```
saveRDS(combined_uber, "combined_uber.rds")
```



