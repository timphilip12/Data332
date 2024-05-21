# Final Project - Tennis 🎾
Tim Philip and Nico Navarro

## Introduction
Tennis is a sport where a lot of different factors determine the winner of the match. This sport is all about details, and that is why in this project we got some insights about several aspects that make players win. 

Besides, we have made available an easy access to the important stats of the professional tennis players.

## Dictionary 📖
The tennis data was extracted from the followinf files: "atp_matches_2023.csv", "atp_matches_2022.csv", "atp_matches_2021.csv", "atp_matches_2020.csv", "atp_matches_2019.csv", "atp_matches_2018.csv", "atp_matches_2017.csv", ... "atp_matches_2000.csv".

We analyzed the tennis matches in the professional circuit from 2000 to 2023.

## Data Cleaning 🧹
1. Get all the data into one single data frame
```
tennis_data <- bind_rows(tennis_data_2023, tennis_data_2022, tennis_data_2021, tennis_data_2020, tennis_data_2019, tennis_data_2018, tennis_data_2017, tennis_data_2016, tennis_data_2015, tennis_data_2014, tennis_data_2013, tennis_data_2012, tennis_data_2011, tennis_data_2010, tennis_data_2009, tennis_data_2008, tennis_data_2007, tennis_data_2006, tennis_data_2005, tennis_data_2004, tennis_data_2003, tennis_data_2002, tennis_data_2001, tennis_data_2000)
```

2. Save the tennis_data into RDS
```
tennis_data <- readRDS("tennis_data.rds")
```

3. Creating pivot table for wins and loses 
```
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
```

4. Combining the winner and loser pivot table
```
combined_WL_data <- bind_rows(winner_name_pivot, loser_name_pivot)
```

5. Pivot table with specific stats of each player
```
pivot_per_player <- combined_WL_data %>%
  group_by(player_name) %>%
  summarize(matches = sum(count),
            average_num_aces = round(mean(average_num_aces)),
            average_num_df = round(mean(average_num_df)),
            average_bp_saved = round(mean(average_bp_saved)),
            average_bp_faced = round(mean(average_bp_faced))
  )
```

6. Win ratio per player by surface
```
#win ratio per player per surface
winner_per_surface <- tennis_data %>%
  group_by(surface, player_name = winner_name) %>%
  summarize(count = n()) %>%
  mutate(`W/L` = 'W')

loser_per_surface <- tennis_data %>%
  group_by(surface, player_name = loser_name) %>%
  summarize(count = n()) %>%
  mutate(`W/L` = 'L')
```

7. Combining the win ratio pivot table
```
combined_per_surface_data <- bind_rows(winner_per_surface, loser_per_surface)
```


## Leaflet 🗺️
 The leaflet displays the world map where you can see where the professional tennis players are from.

 Also, the mark 📍 per country is bigger depending on the number of players that the country has on the tour.

 ```
pivot_players_per_country <- player_data %>%
  group_by(ioc) %>%
  summarize(count = n())


pivot_players_per_country$country <- countrycode(pivot_players_per_country$ioc, "iso3c", "country.name")

pivot_players_per_country <- pivot_players_per_country %>%
  filter(!is.na(country))

world_map <- map_data("world")

# Calculate centroids for each country
country_centroids <- world_map %>%
  group_by(region) %>%
  summarize(
    latitude = mean(range(lat)),
    longitude = mean(range(long))
  )

pivot_players_per_country <- pivot_players_per_country %>%
  mutate(country = ifelse(country == "United States", "USA", country))


country_positions <- left_join(pivot_players_per_country, country_centroids, by = c("country" = "region"))

country_positions <- country_positions %>%
  mutate(latitude = ifelse(country == "USA", 37.0902, latitude),
         longitude = ifelse(country == "USA", -95.7129, longitude))

country_positions$marker_size <- country_positions$count / 200


leaflet() %>%
  addTiles() %>%  
  addCircleMarkers(
    data = country_positions,
    lat = ~latitude,
    lng = ~longitude,
    radius = ~marker_size
  )

```

## Graph codes 📊

1. Average aces per surface
```
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
```

2. Number of first serves won per surface and by dominant hand
```
#First serves won between right and left hand and per surface

#Clean the data: Remove rows where data is NA
cleaned_hand_surface_1st <- combined_WL_data %>%
  filter(!is.na(player_hand) & player_hand %in% c("L", "R") & !is.na(surface) & !is.na(average_1st_won)) #We removed the unkonwn hand players

#Calculate the average number
average_first_serve_won_by_hand_surface <- cleaned_hand_surface_1st %>%
  group_by(player_hand, surface) %>%
  summarise(
    total_entries = n(),  
    average_1st_won = ifelse(n() > 0, round(mean(average_1st_won, na.rm = TRUE), 2), NA)
  ) %>%
  filter(!is.na(average_1st_won))  #results with NA removed

#plotting first serve won by hand on each surface
ggplot(average_first_serve_won_by_hand_surface, aes(x = player_hand, y = average_1st_won, fill = surface)) +
  geom_bar(stat = "identity", position = position_dodge()) + # Use dodge to separate bars based on surface
  labs(title = "Average Number of First Serves Won by Player Hand and Surface",
       x = "Player Hand",
       y = "Number of First Serves Won",
       fill = "Surface") +
  theme_minimal() +
  scale_fill_manual(values = c("Clay" = "orange", "Grass" = "green", "Hard" = "blue")) + #assign colors
  geom_text(aes(label = average_1st_won), position = position_dodge(width = 0.9), vjust = -0.3) 
```

3. Comparing whether the taller player wins or not
```
#Difference in height (cheking if the taller players has an advanatge)
#cleaning data
height_data <- tennis_data %>%
  filter(!is.na(winner_ht) & !is.na(loser_ht)) %>%
  mutate(
    height_diff = winner_ht - loser_ht,
    taller_winner = ifelse(height_diff > 0, 1, 0)  # 1 if winner is taller, 0 otherwise
  )

#Aggregate to count matches won by taller and matches not won by taller (includes equal height or shorter)
match_counts_taller_or_shorter <- height_data %>%
  summarise(
    Total_Matches = n(),
    Matches_Won_By_Taller = sum(taller_winner),  # Count of 1s
    Matches_Won_By_Not_Taller = sum(taller_winner == 0)  # Count of 0s
  )


#pivot table to plot
height_for_plotting <- data.frame(
  Category = c("Matches Won By Taller", "Matches Won By Not Taller"),
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
```

4. To see if taller player wins depending on the surface
```
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
```

5. Experience in matches
```
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
```
