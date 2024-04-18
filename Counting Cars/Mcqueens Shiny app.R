library(readxl)
library(ggplot2)
library(dplyr)
library(shiny)
library(DT)


rm(list = ls())
# setwd('C:/Users/timot/OneDrive/Augustana/Junior year/Spring semester/DATA 332/McQueens')


car_speed <- read_excel("Car_Data.xlsx")

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
  ,
  tags$hr(),
  tags$p("More information about Speed Radar Signs: ",
         tags$a(href = "https://ruthgirma.shinyapps.io/SpeedRadarSignsArticle/", "Link Text"))
)

server <- function(input, output){
  output$plot_01 <- renderPlot({
    speed_per_x <- car_speed %>%
      group_by_at(vars(input$X)) %>%
      summarize(mean_speed = mean(Speed, na.rm = TRUE))
    ggplot(speed_per_x, aes_string(x = input$X, y = "mean_speed", fill=input$X)) +
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

shinyApp(ui=ui, server=server)



