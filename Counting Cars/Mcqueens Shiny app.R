library(readxl)
library(ggplot2)
library(dplyr)
library(shiny)
library(DT)


rm(list = ls())
setwd('C:/Users/timot/OneDrive/Augustana/Junior year/Spring semester/DATA 332')


car_speed <- read_excel("Data/Car_Data.xlsx")

car_speed <- car_speed %>%
  mutate(Time = as.POSIXlt(Time, format = "%Y-%m-%d %H:%M:%S"),
         Time = format(Time, "%H:%M:%S"))

column_names <- colnames(car_speed)


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

server <- function(input, output){
  output$plot_01 <- renderPlot({
    # Calculate the mean speed per group
    speed_per_x <- car_speed %>%
      group_by_at(vars(input$X)) %>%
      summarize(mean_speed = mean(Speed, na.rm = TRUE))
    
    # Plot using the calculated mean
    ggplot(speed_per_x, aes_string(x = input$X, y = "mean_speed", fill=input$X)) +
      geom_col() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
  
  output$table_01 <- DT::renderDataTable({
    speed_per_x <- car_speed %>%
      group_by_at(vars(input$X)) %>%
      summarize(count = n(),
                mean_speed_per_x = round(mean(Speed, na.rm = TRUE), 2))
    
    datatable(speed_per_x)
  })
  
}

shinyApp(ui=ui, server=server)



