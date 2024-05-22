library(dplyr)
library(shiny)
library(ggplot2)
library(leaflet)
library(countrycode)
library(maps)
library(shinySearchbar)
library(shinyWidgets)



#rm(list = ls()) #empty environment
#setwd('C:/Users/nicol/OneDrive/Augustana College/3 year/Spring term/DATA 332/Data/FinalProject/tennis_atp')

# tennis_data_2023 <- read.csv("atp_matches_2023.csv")
# tennis_data_2022 <- read.csv("atp_matches_2022.csv")
# tennis_data_2021 <- read.csv("atp_matches_2021.csv")
# tennis_data_2020 <- read.csv("atp_matches_2020.csv")
# tennis_data_2019 <- read.csv("atp_matches_2019.csv")
# tennis_data_2018 <- read.csv("atp_matches_2018.csv")
# tennis_data_2017 <- read.csv("atp_matches_2017.csv")
# tennis_data_2016 <- read.csv("atp_matches_2016.csv")
# tennis_data_2015 <- read.csv("atp_matches_2015.csv")
# tennis_data_2014 <- read.csv("atp_matches_2014.csv")
# tennis_data_2013 <- read.csv("atp_matches_2013.csv")
# tennis_data_2012 <- read.csv("atp_matches_2012.csv")
# tennis_data_2011 <- read.csv("atp_matches_2011.csv")
# tennis_data_2010 <- read.csv("atp_matches_2010.csv")
# tennis_data_2009 <- read.csv("atp_matches_2009.csv")
# tennis_data_2008 <- read.csv("atp_matches_2008.csv")
# tennis_data_2007 <- read.csv("atp_matches_2007.csv")
# tennis_data_2006 <- read.csv("atp_matches_2006.csv")
# tennis_data_2005 <- read.csv("atp_matches_2005.csv")
# tennis_data_2004 <- read.csv("atp_matches_2004.csv")
# tennis_data_2003 <- read.csv("atp_matches_2003.csv")
# tennis_data_2002 <- read.csv("atp_matches_2002.csv")
# tennis_data_2001 <- read.csv("atp_matches_2001.csv")
# tennis_data_2000 <- read.csv("atp_matches_2000.csv")
#
#
#tennis_data <- bind_rows(tennis_data_2023, tennis_data_2022, tennis_data_2021, tennis_data_2020, tennis_data_2019, tennis_data_2018, tennis_data_2017, tennis_data_2016, tennis_data_2015, tennis_data_2014, tennis_data_2013, tennis_data_2012, tennis_data_2011, tennis_data_2010, tennis_data_2009, tennis_data_2008, tennis_data_2007, tennis_data_2006, tennis_data_2005, tennis_data_2004, tennis_data_2003, tennis_data_2002, tennis_data_2001, tennis_data_2000)
#
#saveRDS(tennis_data, "tennis_data.rds")


tennis_data <- readRDS("tennis_data.rds")
player_data <- read.csv("atp_players.csv")




#win ratio per player per surface
winner_per_surface <- tennis_data %>%
  group_by(surface, player_name = winner_name) %>%
  summarize(count = n()) %>%
  mutate(`W/L` = 'W') #getting only the W

#lose ratio per player per surface
loser_per_surface <- tennis_data %>%
  group_by(surface, player_name = loser_name) %>%
  summarize(count = n()) %>%
  mutate(`W/L` = 'L') #getting only the L

combined_per_surface_data <- bind_rows(winner_per_surface, loser_per_surface)

#ratio W/L pivot table 
combined_per_surface_data2 <- combined_per_surface_data %>%
  group_by(surface, player_name) %>%
  summarise(
    wins = sum(count[`W/L` == "W"]),
    losses = sum(count[`W/L` == "L"]),
    ratio = (round(wins / (wins + losses), digit = 2))
  )







#leaflet code

pivot_players_per_country <- player_data %>%
  group_by(ioc) %>%
  summarize(count = n())


pivot_players_per_country$country <- countrycode(pivot_players_per_country$ioc, "iso3c", "country.name") #addding the colun of the complete country

pivot_players_per_country <- pivot_players_per_country %>%
  filter(!is.na(country)) #cleaning

world_map <- map_data("world") #gives the map

#Calculate centroids for each country
country_centroids <- world_map %>%
  group_by(region) %>%
  summarize(
    latitude = mean(range(lat)),
    longitude = mean(range(long))
  )

pivot_players_per_country <- pivot_players_per_country %>%
  mutate(country = ifelse(country == "United States", "USA", country)) #Changing United States to USA 


country_positions <- left_join(pivot_players_per_country, country_centroids, by = c("country" = "region")) #left joining

country_positions <- country_positions %>%
  mutate(latitude = ifelse(country == "USA", 37.0902, latitude),
         longitude = ifelse(country == "USA", -95.7129, longitude)) #changing latitude and longitude of the US for a problem with Alaska

country_positions$marker_size <- country_positions$count / 200 #making the count smaller to fit


leaflet() %>%
  addTiles() %>%  
  addCircleMarkers(
    data = country_positions,
    lat = ~latitude,
    lng = ~longitude,
    radius = ~marker_size
  )






#player search code
winner_name_pivot <- tennis_data %>%
  group_by(player_name = winner_name, player_height = winner_ht, player_hand = winner_hand) %>%
  summarize(count = n(),
            age_last_match = max(winner_age, na.rm = TRUE),
            average_match_length = round(mean(minutes, na.rm = TRUE)),
            average_ace = round(mean(w_ace, na.rm = TRUE)),
            average_df = round(mean(w_df, na.rm = TRUE)),
            average_bp_saved = round(mean(w_bpSaved, na.rm = TRUE)),
            average_bp_faced = round(mean(w_bpFaced, na.rm = TRUE))) %>%
  mutate(`W/L` = 'W')

loser_name_pivot <- tennis_data %>%
  group_by(player_name = loser_name, player_height = loser_ht, player_hand = loser_hand) %>%
  summarize(count = n(),
            age_last_match = max(loser_age, na.rm = TRUE),
            average_match_length = round(mean(minutes, na.rm = TRUE)),
            average_ace = round(mean(l_ace, na.rm = TRUE)),
            average_df = round(mean(l_df, na.rm = TRUE)),
            average_bp_saved = round(mean(l_bpSaved, na.rm = TRUE)),
            average_bp_faced = round(mean(l_bpFaced, na.rm = TRUE))) %>%
  mutate(`W/L` = 'L')

combined_WL_data <- bind_rows(winner_name_pivot, loser_name_pivot)


pivot_per_player <- combined_WL_data %>%
  group_by(player_name, player_height, player_hand) %>%
  summarize(wins = sum(count[`W/L` == "W"]),
            losses = sum(count[`W/L` == "L"]),
            ratio = (round(wins / (wins + losses), digit = 2)),
            age_last_match = max(age_last_match, na.rm = TRUE),
            average_match_length = round(mean(average_match_length, na.rm = TRUE)),
            average_ace = round(mean(average_ace, na.rm = TRUE)),
            average_df = round(mean(average_df, na.rm = TRUE)),
            average_bp_saved = round(mean(average_bp_saved, na.rm = TRUE)),
            average_bp_faced = round(mean(average_bp_faced, na.rm = TRUE))
  )







#GRAPHS

#creating winner pivot table
winner_name_pivot <- tennis_data %>%
  group_by(player_name = winner_name, best_of, player_hand = winner_hand, player_country = winner_ioc, player_height = winner_ht, surface) %>%
  summarize(count = n(),
            age_at_last_match_played = max(winner_age),
            average_match_length = round(mean(minutes, na.rm = TRUE)),
            average_num_aces = round(mean(w_ace, na.rm = TRUE)),
            average_num_df = round(mean(w_df, na.rm = TRUE)),
            average_bp_saved = round(mean(w_bpSaved, na.rm = TRUE)),
            average_bp_faced = round(mean(w_bpFaced, na.rm = TRUE)),
            average_1st_won = round(mean(w_1stWon, na.rm = TRUE))
  ) %>%
  mutate(`W/L` = 'W')

#creating loser pivot table
loser_name_pivot <- tennis_data %>%
  group_by(player_name = loser_name, best_of, player_hand = loser_hand, player_country = loser_ioc, player_height = loser_ht, surface) %>%
  summarize(count = n(),
            age_at_last_match_played = max(loser_age),
            average_match_length = round(mean(minutes, na.rm = TRUE)),
            average_num_aces = round(mean(l_ace, na.rm = TRUE)),
            average_num_df = round(mean(l_df, na.rm = TRUE)),
            average_bp_saved = round(mean(l_bpSaved, na.rm = TRUE)),
            average_bp_faced = round(mean(l_bpFaced, na.rm = TRUE)),
            average_1st_won = round(mean(l_1stWon, na.rm = TRUE))
  ) %>%
  mutate(`W/L` = 'L')

combined_WL_data_graphs <- bind_rows(winner_name_pivot, loser_name_pivot)


##1
#Calculate the average aces per surface
average_aces_per_surface <-
  tennis_data %>%
  group_by(surface) %>%
  summarise(average_aces = round(mean(w_ace + l_ace, na.rm = TRUE), 2)) %>%
  filter(surface %in% c("Clay", "Hard", "Grass"))


#Plotting average aces per surface
ggplot(average_aces_per_surface, aes(x = surface, y = average_aces, fill = surface)) +
  geom_col() +
  theme_minimal() +
  labs(title = "Average Number of Aces on Different Surfaces", x = "Surface", y = "Average Aces")  


##2
#First serves won between right and left hand and per surface

#Clean the data: Remove rows where data is NA
cleaned_hand_surface_1st <- combined_WL_data_graphs %>%
  filter(!is.na(player_hand) & player_hand %in% c("L", "R") & !is.na(surface) & !is.na(average_1st_won)) #We removed the unkonwn hand players

#Calculate the average number
average_first_serve_won_by_hand_surface <- cleaned_hand_surface_1st %>%
  group_by(player_hand, surface) %>%
  summarise(
    count = n(),  
    average_1st_won = ifelse(n() > 0, round(mean(average_1st_won, na.rm = TRUE), 2), NA)
  ) %>%
  filter(!is.na(average_1st_won))  #results with NA removed

#plotting first serve won by hand on each surface
ggplot(average_first_serve_won_by_hand_surface, aes(x = player_hand, y = average_1st_won, fill = surface)) +
  geom_bar(stat = "identity", position = position_dodge()) + 
  labs(title = "Average Number of First Serves Won by Player Hand and Surface",
       x = "Player Hand",
       y = "Number of First Serves Won",
       fill = "Surface") +
  theme_minimal() +
  scale_fill_manual(values = c("Clay" = "orange", "Grass" = "green", "Hard" = "blue", "carpet"  = "grey")) + #assign colors
  geom_text(aes(label = average_1st_won), position = position_dodge(width = 0.9), vjust = -0.3)


##3
#Difference in height (checking if the taller players has an advantage)
#cleaning data
height_data <- tennis_data %>%
  filter(!is.na(winner_ht) & !is.na(loser_ht)) %>%
  mutate(
    height_diff = winner_ht - loser_ht,
    taller_winner = ifelse(height_diff > 0, 1, 0)  #1 if winner is taller, 0 otherwise
  )

#Aggregate to count matches won by taller and matches not won by taller (includes equal height or shorter)
match_counts_taller_or_shorter <- height_data %>%
  summarise(
    Total_Matches = n(),
    Matches_Won_By_Taller = sum(taller_winner),  #Count of 1s
    Matches_Won_By_Not_Taller = sum(taller_winner == 0)  #Count of 0s
  )


#pivot table to plot
height_for_plotting <- data.frame(
  Category = c("Matches Won By Taller", "Matches Won By NOT Taller"),
  Count = c(match_counts_taller_or_shorter$Matches_Won_By_Taller, match_counts_taller_or_shorter$Matches_Won_By_Not_Taller)
)

#plotting graph
ggplot(height_for_plotting, aes(x = Category, y = Count, fill = Category)) +
  geom_bar(stat = "identity") +
  labs(title = "Match Outcomes Based on Player Height",
       x = "",
       y = "Number of Matches",
       fill = "Outcome") +
  theme_minimal() +
  geom_text(aes(label = Count), vjust = -0.5)  



##4
#Now we are going to plot if the taller or shorter won but by surface
height_counts_by_surface <- height_data %>%
  filter(surface %in% c("Clay", "Grass", "Hard")) %>%  #Only include these surfaces
  group_by(surface) %>%
  summarise(
    Total_Matches = n(),
    Matches_Won_By_Taller = sum(taller_winner),  #Count matches where the winner was taller
    Matches_Won_By_Not_Taller = sum(taller_winner == 0)  #Count matches where the winner was not taller
  ) %>%
  ungroup()

#Prepare the data for plotting by converting it into a long format suitable for ggplot
height_surface_data_for_plotting <- height_counts_by_surface %>%
  pivot_longer(
    cols = c("Matches_Won_By_Taller", "Matches_Won_By_Not_Taller"),
    names_to = "Outcome",
    values_to = "Count"
  )

#Plotting the data
ggplot(height_surface_data_for_plotting, aes(x = surface, y = Count, fill = Outcome)) +
  geom_bar(stat = "identity", position = position_dodge(), width = 0.7) +
  scale_fill_brewer(palette = "Pastel1") +
  labs(title = "Match Outcomes by Player Height on Different Surfaces",
       x = "Surface",
       y = "Number of Matches",
       fill = "Match Outcome") +
  theme_minimal() +  
  geom_text(aes(label = Count, y = Count/2), position = position_dodge(width = 0.7), vjust = 0.5)  



##5
#Amount of victories by age
wins_by_age <- tennis_data %>%
  filter(!is.na(winner_age)) %>%
  mutate(winner_age = floor(winner_age)) %>% #to remove decimals
  group_by(winner_age) %>%
  summarise(wins = n())



#line plot to visualize the number of matches won by different ages
ggplot(wins_by_age, aes(x = winner_age, y = wins)) +
  geom_line(group=1, color = "steelblue", size=1) +  
  geom_point(color = "red", size=3, shape=21, fill="white") +  
  labs(title = "Number of Matches Won by Age",
       x = "Age",
       y = "Number of Matches Won") +
  theme_minimal() +  
  theme(axis.text.x = element_text(angle = 0, hjust = 1))





ui <- navbarPage(
  "Tennis Player Statistics App",
  tabPanel(
    "Player Statistics",
    fluidPage(
      titlePanel("Tennis Player Statistics"),
      sidebarLayout(
        sidebarPanel(
          pickerInput(
            inputId = "player_search",
            label = "Enter player name:",
            choices = unique(pivot_per_player$player_name),
            options = list(`live-search` = TRUE),
            multiple = FALSE
          ),
          actionButton("submit_button", "Get Statistics")
        ),
        mainPanel(
          h4("Player Statistics"),
          verbatimTextOutput("player_stats")
        )
      )
    )
  ),
  tabPanel(
    "Players per country",
    fluidPage(
      titlePanel("Amount of tennis player per country"),
      leafletOutput("map")
    )
  ),
  tabPanel(
    "Plots",
    fluidPage(
      titlePanel("Tennis Data Plots"),
      plotOutput("plot1"),
      plotOutput("plot2"),
      plotOutput("plot3"),
      plotOutput("plot4"),
      plotOutput("plot5")
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  # Function to filter data based on player name
  player_filter <- reactive({
    req(input$submit_button)
    player <- input$player_search
    filtered_data <- subset(pivot_per_player, player_name == player)
    return(filtered_data)
  })
  
  # Function to get player statistics
  player_stats <- reactive({
    filtered_data <- player_filter()
    player <- input$player_search
    player_height <- filtered_data$player_height
    player_hand <- filtered_data$player_hand
    age_last_match <- filtered_data$age_last_match
    matches_played <- filtered_data$wins + filtered_data$losses
    matches_won <- filtered_data$wins
    matches_lost <- filtered_data$losses
    win_percentage <- filtered_data$ratio * 100
    average_match_length <- filtered_data$average_match_length
    average_ace <- filtered_data$average_ace
    average_df <- filtered_data$average_df
    average_bp_faced <- filtered_data$average_bp_faced
    average_bp_saved <- filtered_data$average_bp_saved
    return(list(
      player_height = player_height,
      player_hand = player_hand,
      age_last_match = age_last_match,
      matches_played = matches_played,
      matches_won = matches_won,
      matches_lost = matches_lost,
      win_percentage = win_percentage,
      average_match_length = average_match_length,
      average_ace = average_ace,
      average_df = average_df,
      average_bp_faced = average_bp_faced,
      average_bp_saved = average_bp_saved
      
    ))
  })
  
  # Display player statistics
  output$player_stats <- renderPrint({
    if(input$submit_button > 0){
      player <- input$player_search
      cat("Statistics for", player, ":\n")
      cat("Player heigth in cm: ", player_stats()$player_height, "\n")
      cat("Player hand:", player_stats()$player_hand, "\n")
      cat("Player age at last match played: ", player_stats()$age_last_match, "\n")
      cat("Matches Played:", player_stats()$matches_played, "\n")
      cat("Matches Won:", player_stats()$matches_won, "\n")
      cat("Matches Lost:", player_stats()$matches_lost, "\n")
      cat("Win Percentage:", sprintf("%.2f%%", player_stats()$win_percentage), "\n")
      cat("Average match length in minutes:", player_stats()$average_match_length, "\n")
      cat("Average number of aces per match:", player_stats()$average_ace, "\n")
      cat("Average number of double faults per match:", player_stats()$average_df, "\n")
      cat("Average number of break points faced per match:", player_stats()$average_bp_faced, "\n")
      cat("Average number of break points saved per match:", player_stats()$average_bp_saved, "\n")
    }
  })
  
  # Render leaflet map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addCircleMarkers(
        data = country_positions,
        lat = ~latitude,
        lng = ~longitude,
        radius = ~marker_size
      )
  })
  
  # Render plots
  output$plot1 <- renderPlot({
    ggplot(average_aces_per_surface, aes(x = surface, y = average_aces, fill = surface)) +
      geom_col() +
      theme_minimal() +
      labs(title = "Average Number of Aces on Different Surfaces", x = "Surface", y = "Average Aces")
  })
  
  output$plot2 <- renderPlot({
    ggplot(average_first_serve_won_by_hand_surface, aes(x = player_hand, y = average_1st_won, fill = surface)) +
      geom_bar(stat = "identity", position = position_dodge()) + # Use dodge to separate bars based on surface
      labs(title = "Average Number of First Serves Won by Player Hand and Surface",
           x = "Player Hand",
           y = "Number of First Serves Won",
           fill = "Surface") +
      theme_minimal() +
      scale_fill_manual(values = c("Clay" = "orange", "Grass" = "green", "Hard" = "blue")) + #assign colors
      geom_text(aes(label = average_1st_won), position = position_dodge(width = 0.9), vjust = -0.3)
  })
  
  output$plot3 <- renderPlot({
    ggplot(height_for_plotting, aes(x = Category, y = Count, fill = Category)) +
      geom_bar(stat = "identity") +
      labs(title = "Match Outcomes Based on Player Height",
           x = "",
           y = "Number of Matches",
           fill = "Outcome") +
      theme_minimal() +
      geom_text(aes(label = Count), vjust = -0.5)
  })
  
  output$plot4 <- renderPlot({
    ggplot(height_surface_data_for_plotting, aes(x = surface, y = Count, fill = Outcome)) +
      geom_bar(stat = "identity", position = position_dodge(), width = 0.7) +
      scale_fill_brewer(palette = "Pastel1") +
      labs(title = "Match Outcomes by Player Height on Different Surfaces",
           x = "Surface",
           y = "Number of Matches",
           fill = "Match Outcome") +
      theme_minimal() +  
      geom_text(aes(label = Count, y = Count/2), position = position_dodge(width = 0.7), vjust = 0.5)
  })
  
  output$plot5 <- renderPlot({
    ggplot(wins_by_age, aes(x = winner_age, y = wins)) +
      geom_line(group=1, color = "steelblue", size=1) +  
      geom_point(color = "red", size=3, shape=21, fill="white") +  
      labs(title = "Number of Matches Won by Age",
           x = "Age",
           y = "Number of Matches Won") +
      theme_minimal() +  
      theme(axis.text.x = element_text(angle = 0, hjust = 1))
  })
}

# Run the application
shinyApp(ui = ui, server = server)

