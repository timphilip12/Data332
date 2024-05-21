# Final Project - Tennis
Tim Philip and Nico Navarro

## Introduction
Tennis is a sport where a lot of different factors determine the winner of the match. This sport is all about details, and that is why in this project we got some insights about several aspects that make players win. 

Besides, we have made available an easy access to the important stats of the professional tennis players.

## Dictionary
The tennis data was extracted from the followinf files: "atp_matches_2023.csv", "atp_matches_2022.csv", "atp_matches_2021.csv", "atp_matches_2020.csv", "atp_matches_2019.csv", "atp_matches_2018.csv", "atp_matches_2017.csv", ... "atp_matches_2000.csv".

We analyzed the tennis matches in the professional circuit from 2000 to 2023.

## Data Cleaning
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


# The columns used were: 
- Surface: Hard, clay, or grass
- 
