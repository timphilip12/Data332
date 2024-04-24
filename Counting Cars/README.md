# Counting cars IRL
- Tim Philip
- Maggie Huntley
- Ruth Girma
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
9. Day: The day of the week at the which the person recorded the vehicle

## Data cleaning
1. Get rid of any mispelling manually to make sure that the data will be used correctly in R
2. Get the time into a readable format using this code:
```
car_speed <- car_speed %>%
  mutate(Time = as.POSIXlt(Time, format = "%Y-%m-%d %H:%M:%S"),
         Time = format(Time, "%H:%M:%S"))
```
## Shiny Application
### User Interface
Our User interface is divided in three sections:
1. A drop-down for the user to select an input which is the column the data will be grouped by
2. A bar chart showing the average speed of each group within the selected column
3. A pivot table showing the count, the mean, the min and the max of each group of the selected column
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
### Server
The server to support our UI has two outputs, plot_01 and table_01. Both use a pivot table in order to get the mean speed for selected input. Here is the code for our server:
```
server <- function(input, output){
  output$plot_01 <- renderPlot({
    speed_per_x <- car_speed %>%
      group_by_at(vars(input$X)) %>%
      summarize(mean_speed = mean(Speed, na.rm = TRUE))
    ggplot(speed_per_x, aes_string(x = input$X, y = "Average speed", fill=input$X)) +
      geom_col() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
  
  output$table_01 <- DT::renderDataTable({
    speed_per_x <- car_speed %>%
      group_by_at(vars(input$X)) %>%
      summarize(count = n(),
                mean = round(mean(Speed, na.rm = TRUE), 2),
                min = min(Speed, na.rm = TRUE),
                max = max(Speed, na.rm = TRUE)
                )
    
    datatable(speed_per_x)
  })
}
```
### Shiny App visualization
<img src="Images/Shiny App visualization.PNG" height = 300, width = 700>

### Link to Shiny App:  https://timphilip.shinyapps.io/McQueens_Shiny/

