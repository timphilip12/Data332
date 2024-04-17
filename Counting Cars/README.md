# Counting cars IRL
## Introduction
This a repo to share our findings on car data collected on the speed radar sign on 30th Street, Rock Island IL

## Dictionnary
The collected data was recorded in the excel file Car_Data.xlsx
### The columns used were:
1. Date: the date on which the vehicle was collected
2. Time: the time at which the vehicle was collected
3. Speed: the speed of the car based on the speed radar sign
4. Color: the color of the vehicle collected
5. Type: the type of the vehicle collected
6. Temperature: the temperature at the time of the collection in °F
7. Weather: The weather at the time of the collection
8. Name: The name of the person that recorded the vehicle

## Data cleaning
1. Get rid of any mispelling manually to make sure that the data will be used correctly in R
2. Get the time into a readable format using this code:
```
df <- df %>%
  mutate(date_time = as.POSIXlt(date_time, format = "%Y-%m-%d %H:%M:%S"),
         date_time = format(date_time, "%H:%M:%S"))
```
## Shiny Application
### User Interface
Our User interface is divided in three sections:
1. A drop-down to select by which column the data will be grouped by
2. A bar chart showing the average speed of each group within the selected column
3. A pivot table showing the count, the mean, the min and the max of each group of the selected column
Here is the code used for our user interface:
```
ui <- fluidPage(
  titlePanel(title = "Explore Car Speed"),
  h4('Car data collection at 30th Street, Rock Island'),
  fluidRow(
    column(2,
           selectInput('X', 'Choose x', column_names)
    ),
    column(6, plotOutput('plot_01')),
    column(4, DT::dataTableOutput("table_01", width = "100%"))
  )
)
```

