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
7. Save the table as a RDS file with this code:
   ```
   saveRDS(combined_uber, "combined_uber.rds")
   ```
8. Get a random sample of 1000 rows for the leaflet with this code:
   ```
   leaflet_data <- combined_uber %>%
     sample_n(1000)
   ```

## Libraries 
All the libraries used were the following:
```
library(dplyr)
library(tidyr)
library(ggplot2)
library(lubridate)
library(leaflet)
library(leaflet.extras)
library(data.table)
library(shiny)
library(shinydashboard)
library(shinythemes)
library(stringr)
```
## Pivot tables
In order to create bar charts and heat maps, I created several pivot tables. They were all created using the following code:
```
pivot_table_name <- combined_uber %>%
  group_by(column_name) %>%
  summarize(count = n())
```
Some pivot tables were grouped by two different column.
## Shiny application
### User Interface
My user interface has three pages. One for the bar charts, one for the heatmaps, one for the leaflet and one for the predictive charts. I used the libraries shinydashboard and shinytheme to make it look better. I had 5 bar charts, 4 heatmaps, 1 leaflet and 2 predictive charts. 
```
ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(title = "Data Visualization"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Bar Chart", tabName = "bar_chart", icon = icon("bar-chart")),
      menuItem("Heatmap", tabName = "heatmap", icon = icon("heatmap")),
      menuItem("Leaflet Map", tabName = "map", icon = icon("map")),
      menuItem("Predictive chart", tabName = "predictive_chart", icon = icon("predictive"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "bar_chart",
        fluidRow(
          column(12, plotOutput("bar_chart1")),
          column(12, verbatimTextOutput("bar_chart1_desc"))
        ),
        fluidRow(
          column(12, plotOutput("bar_chart2")),
          column(12, verbatimTextOutput("bar_chart2_desc"))
        ),
        fluidRow(
          column(12, plotOutput("bar_chart3")),
          column(12, verbatimTextOutput("bar_chart3_desc"))
        ),
        fluidRow(
          column(12, plotOutput("bar_chart4")),
          column(12, verbatimTextOutput("bar_chart4_desc"))
        ),
        fluidRow(
          column(12, plotOutput("bar_chart5")),
          column(12, verbatimTextOutput("bar_chart5_desc"))
        )
      ),
      tabItem(
        tabName = "heatmap",
        fluidRow(
          column(12, plotOutput("heatmap1")),
          column(12, verbatimTextOutput("heatmap1_desc"))
        ),
        fluidRow(
          column(12, plotOutput("heatmap2")),
          column(12, verbatimTextOutput("heatmap2_desc"))
        ),
        fluidRow(
          column(12, plotOutput("heatmap3")),
          column(12, verbatimTextOutput("heatmap3_desc"))
        ),
        fluidRow(
          column(12, plotOutput("heatmap4")),
          column(12, verbatimTextOutput("heatmap4_desc"))
        )
      ),
      tabItem(
        tabName = "map",
        leafletOutput("map"),
        verbatimTextOutput("map_desc")
      ),
      tabItem(
        tabName = "predictive_chart",
        fluidRow(
          column(12, plotOutput("predictive_chart1")),
          column(12, verbatimTextOutput("predictive_chart1_desc"))
        ),
        fluidRow(
          column(12, plotOutput("predictive_chart2")),
          column(12, verbatimTextOutput("predictive_chart2_desc"))
        )
      )
    )
  )
)
```

### Server
The server I made to match my UI is the following:
```
server <- function(input, output) {
  output$bar_chart1 <- renderPlot({
    ggplot(pivot_hour_month, aes(x = hour, y = count, fill = Month)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Hourly Uber Rides by Month",
           x = "Hour of the Day",
           y = "Number of rides",
           color = "Month") +
      theme_minimal()
  })
  output$bar_chart1_desc <- renderText({
    "Description: This bar chart displays the amount of uber ride per hour of the day for each month. We can see that the amount of rides significantly increases from April to September"
  })
  
  output$bar_chart2 <- renderPlot({
    ggplot(pivot_hour, aes(x = hour, y = count)) +
      geom_bar(stat = "identity", fill = "#4CAF50") +
      labs(title = "Hourly Uber",
           x = "Hour of the Day",
           y = "Number of rides") +
      theme_minimal()
  })
  output$bar_chart2_desc <- renderText({
    "Description: This bar chart displays the amount of rides for every hour of the day in military time. The time with the most rides is 17 (5pm) and with the least rides is 2 (2am) which makes sense."
  })
  
  output$bar_chart3 <- renderPlot({
    ggplot(pivot_day, aes(x = Day, y = count)) +
      geom_bar(stat = "identity", fill = "blue") +
      labs(title = "Daily Uber",
           x = "Day of the month",
           y = "Number of rides") +
      theme_minimal()
  })
  output$bar_chart3_desc <- renderText({
    "Description: This bar chart displays the amount of rides for every days of the month. This graph is pretty consistant appart from the 31st which is way lower but it makes sense since only half of the month in this data have 31 days (May, July and August)"
  })
  
  output$bar_chart4 <- renderPlot({
    ggplot(pivot_day_of_week, aes(x = Month, y = count, fill = DayOfWeek)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Uber Rides by Month and by weekdays",
           x = "Month",
           y = "Number of rides",
           color = "Day of the Week") +
      theme_minimal()
  })
  output$bar_chart4_desc <- renderText({
    "Description: This bar chart displays the amount of rides per month for each day of the week. There is not a particular day of the week that has more rides than all the other days but Sunday is definitely the day with the least rides. Also, we can notice that the overall amount of rides increases from April to September"
  })
  
  output$bar_chart5 <- renderPlot({
    ggplot(pivot_base, aes(x = Base, y = count, fill = Month)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Uber Rides by Base and by Month",
           x = "Base",
           y = "Number of rides",
           color = "Month") +
      theme_minimal()
  })
  output$bar_chart5_desc <- renderText({
    "Description: This bar chart displays the amount of rides per base for each month. We can see that three bases share most of the rides and that the two other bases have significantly less rides."
  })
  
  
  # Render heatmap
  output$heatmap1 <- renderPlot({
    ggplot(pivot_hour_day, aes(x = hour, y = Day, fill = count)) +
      geom_tile() +
      labs(title = "Hour Day Heatmap",
           x = "Hour of the day",
           y = "Days")
  })
  output$heatmap1_desc <- renderText({
    "Description: This heatmap displays the amount of rides by hour of the day and days. There is no days that have a big difference of rides appart from the 31st but it is because only half of the month in this data have 31 days. We can notice that the times with the most rides are at the end of the afternoon and the times with the least rides are in the middle of the night."
  })
  
  output$heatmap2 <- renderPlot({
    ggplot(pivot_month_day, aes(x = Month, y = Day, fill = count)) +
      geom_tile() +
      labs(title = "Hour Day Heatmap",
           x = "Months",
           y = "Days")
  })
  output$heatmap2_desc <- renderText({
    "Description: This heatmap displays the amount of rides by Months and days of the month. We can see kind of a patern which probably due to the fact that there are more rides around the end of the week. We can also see that the heatmap gets clearer from April to September which means that there are more and more rides."
  })
  
  output$heatmap3 <- renderPlot({
    ggplot(pivot_month_week, aes(x = Month, y = week_number, fill = count)) +
      geom_tile() +
      labs(title = "Hour Week Heatmap",
           x = "Month",
           y = "Week number")
  })
  output$heatmap3_desc <- renderText({
    "Description: This heatmap displays the amount of rides by Months and week number. We can't really say anything from this graph except the fact that there are more and more rides from April to September. Also, there are some very dark spots but it is only because the weeks is over two different months"
  })
  
  output$heatmap4 <- renderPlot({
    ggplot(pivot_base_DayOfWeek, aes(x = Base, y = DayOfWeek, fill = count)) +
      geom_tile() +
      labs(title = "Base DayOfWeek Heatmap",
           x = "Base",
           y = "Day of the Week")
  })
  output$heatmap4_desc <- renderText({
    "Description: This heatmap displays the amount of rides by Base and days of the week. We can see that there are three bases that have way more rides that the two last bases. Also, Thurdays and Fridays are clearer that the rest of the days and Sundays are darker that the rest of the days."
  })
  
  # Render Leaflet map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%  
      addMarkers(
        data = leaflet_data,
        lat = ~Lat,
        lng = ~Lon
      )
  })
  output$map_desc <- renderText({
    "Description: This map only displays a sample of 1000 rows out the 4.5 millions rows of the dataset. I couldn't run it with 4.5 millions rows because it was too big for my laptop. I then decided to take a random sample of 1000 rows so I have a map to show."
  })
  
  output$predictive_chart1 <- renderPlot({
    ggplot(rides_per_month, aes(x = Month_Number, y = rides)) +
      geom_point() + # Scatter plot
      geom_abline(intercept = intercept_month, slope = slope_month, color = "red") +
      labs(title = "Average number of Rides per Month", x = "Month", y = "Number of Rides")
  })
  
  output$predictive_chart1_desc <- renderText({
    "Description: This is a scatter plot with a regression line that predicts how the number of rides will evoluate when grouped by month. We can see that the slope of the regression line is positive which means that the number of rides will probably grow in the future months."
  })
  
  output$predictive_chart2 <- renderPlot({
    ggplot(rides_per_day, aes(x = Day, y = rides)) +
      geom_point() + # Scatter plot
      geom_abline(intercept = intercept_day, slope = slope_day, color = "red") +  # Add regression line
      labs(title = "average number of Rides per Day of the Month", x = "Day", y = "Number of Rides")
  })
  
  output$predictive_chart2_desc <- renderText({
    "Description: This is scatter plot with a regression line that predicts how the number of rides will evoluate when grouped by day of the month. We can see that the slope is slightly negative which means that people are using uber a little bit more in the first days of the month. However, this is affected by the facts that only half of the month in this data have 31 days."
  })
  
  
}
```

### Link to Shiny App: https://timphilip.shinyapps.io/Uber_shiny/ 






