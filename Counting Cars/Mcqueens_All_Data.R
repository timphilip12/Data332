library(readxl)
library(data.table)
library(dplyr)
library(ggplot2)
library(shiny)
library(DT)

rm(list = ls())
# setwd('C:/Users/timot/OneDrive/Augustana/Junior year/Spring semester/DATA 332/McQueens')

## import all data
Car_Data_Excel <- read_excel('Car Data Excel.xlsx')
Car_Data <- read_excel('Car_Data.xlsx')
Car <- read_excel('Car.xlsx')
counting_cars <- read_excel('counting_cars.xlsx')
IRL_Car_Data <- read_excel('IRL_Car_Data.xlsx')
mergedCarData <- read_excel("MergedCarData.xlsx")
speed_analyst_332_Car_Data <- read_excel('Speed analyst 332 Car Data.xlsx')
UpdatedCarTracking<- read_xlsx('UpdatedCarTracking.xlsx')


## change column names and dropping columns that are no longer needed
setnames(UpdatedCarTracking, old = 'Time of Day', new = 'Time')
setnames(UpdatedCarTracking, old = 'Speed (mph)', new = 'Speed')
setnames(UpdatedCarTracking, old = 'Type of Car', new = 'Type')
setnames(UpdatedCarTracking, old = 'Car Number', new = 'CN')
setnames(UpdatedCarTracking, old = 'Weather', new = 'Temperature')
UpdatedCarTracking<- subset(UpdatedCarTracking, select = -CN)

setnames(speed_analyst_332_Car_Data, old = 'MPH', new = 'Speed')
setnames(speed_analyst_332_Car_Data, old = 'Time of Day', new = 'Time')
setnames(speed_analyst_332_Car_Data, old = 'Type of se', new = 'Type')
setnames(speed_analyst_332_Car_Data, old = 'Orange Light', new = 'OL')
setnames(speed_analyst_332_Car_Data, old = 'Student', new = 'Name')
speed_analyst_332_Car_Data<- subset(speed_analyst_332_Car_Data, select = -OL)


colnames(IRL_Car_Data)[colnames(IRL_Car_Data) == "MPH"] <- "Speed"
colnames(IRL_Car_Data)[colnames(IRL_Car_Data) == "Time.of.Day"] <- "Time"
colnames(IRL_Car_Data)[colnames(IRL_Car_Data) == "Wheater"] <- "Weather"
colnames(IRL_Car_Data)[colnames(IRL_Car_Data) == "Collector"] <- "Name"
colnames(IRL_Car_Data)[colnames(IRL_Car_Data) == "Time of Day"] <- "Time"
colnames(IRL_Car_Data)[colnames(IRL_Car_Data) == "Week Day"] <- "Day"

setnames(counting_cars, old = 'Temp', new = 'Temperature')
setnames(counting_cars, old = 'MPH', new = 'Speed')
counting_cars<- subset(counting_cars, select = -...6)
counting_cars<- subset(counting_cars, select = -...7)
counting_cars<- subset(counting_cars, select = -...8)
counting_cars<- subset(counting_cars, select = -...9)
counting_cars<- subset(counting_cars, select = -...10)
counting_cars<- subset(counting_cars, select = -...11)

setnames(Car, old = 'Speed MPH', new = 'Speed')
setnames(Car, old = 'Vehicle Color', new = 'Color')
setnames(Car, old = 'Vehicle Type', new = 'Type')
setnames(Car, old = 'Collector Name', new = 'Name')
setnames(Car, old = 'Flashing Light', new = 'FlashingLight')
Car <- subset(Car, select = -Manufacturer)
Car <- subset(Car, select = -FlashingLight)

setnames(Car_Data_Excel, old = 'License plate state', new = 'LPS')
Car_Data_Excel <- subset(Car_Data_Excel, select = -LPS)

setnames(mergedCarData, old = 'Orange Light', new = 'OL')
mergedCarData<- subset(mergedCarData, select = -OL)
mergedCarData<- subset(mergedCarData, select = -State)

## Combing all the data together
combined_data <- bind_rows(Car, Car_Data, Car_Data_Excel, counting_cars, IRL_Car_Data, mergedCarData, speed_analyst_332_Car_Data, UpdatedCarTracking)


## Running
car_speed <- combined_data

car_speed <- car_speed %>%
  mutate(Time = as.POSIXlt(Time, format = "%Y-%m-%d %H:%M:%S"),
         Time = format(Time, "%H:%M:%S"))

column_names <- colnames(car_speed)

car_speed$Color <- tolower(car_speed$Color)
car_speed$Type <- tolower(car_speed$Type)
car_speed$Weather <- tolower(car_speed$Weather)


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
