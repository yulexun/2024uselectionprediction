#### Preamble ####
# Purpose: Simulates a dataset of Australian electoral divisions, including the 
  #state and party that won each division.
# Author: Lexun Yu
# Date: 22 October 2024
# Contact: lx.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed


#### Workspace setup ####
library(tidyverse)
library(arrow)
set.seed(853)


#### Simulate data ####
# State names
states <- state.name
answer <- c("Trump", "Harris", "Oliver", "West")
pollster <- c("Marist", "YouGov", "Ipsos", "Emerson", "SurveyUSA")

# Generate Poll IDs and States
unique_poll_ids <- sample(10000:99999, 50)
poll_ids <- rep(unique_poll_ids, each = 4)
state_column <- rep(states, each = 4)
state_column <- rep(state_column, length.out = 200)
sample_size <- sample(100:20000, 50)
sample_size <- rep(sample_size, each = 4)
pollster_column <- sample(pollster, 50, replace = TRUE)
pollster_column <- rep(pollster_column, each = 4)

# Function to generate a set of 4 random percentages that sum to 100%
generate_percentages <- function() {
  # Generate 4 random numbers
  rand_values <- runif(4)
  # Normalize them so they sum to 100
  percentages <- (rand_values / sum(rand_values)) * 100
  return(percentages)
}

# Initialize an empty vector to store percentages
pct_column <- c()

# Generate percentages for 200 rows (50 groups of 4 rows)
for (i in 1:50) {
  pct_column <- c(pct_column, generate_percentages())
}

# Create a dataset by randomly assigning states and parties to divisions
analysis_data <- tibble(
  pollster = pollster_column,
  poll_ids = poll_ids,
  state = state_column,
  sample_size = sample_size,
  answer = rep(answer, length.out = 200),
  pct = pct_column,
)


#### Save data ####
write_parquet(analysis_data, "data/00-simulated_data/simulated_data.parquet")
