#### Workspace setup ####
#### Preamble ####
# Purpose: Simulates a dataset of Australian electoral divisions, including the
# state and party that won each division.
# Author: Lexun Yu, Siddharth Gowda
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
# Add National
states <- c(state.name, "National", "Maine CD-2", "Maine CD-1", "Nebraska CD-2")
candidate_names <- c(
  "Donald Trump", "Kamala Harris", "Jill Stein",
  "Robert F. Kennedy"
)
pollster <- c("Marist", "YouGov", "Ipsos", "Emerson", "SurveyUSA")

# Methodology
methodologies <- c("IVR", "Email", "Online Panel", "Text", "Phone")


# Reliably blue states
blue_states <- c(
  "California", "Colorado", "Connecticut", "Delaware", "Hawaii",
  "Illinois", "Maine", "Maryland", "Massachusetts", "Minnesota",
  "New Jersey", "New Mexico", "New York", "Oregon", "Rhode Island",
  "Vermont", "Virginia", "Washington", "District of Columbia"
)

# Reliably red states
red_states <- c(
  "Alabama", "Alaska", "Arkansas", "Florida", "Idaho", "Indiana",
  "Iowa", "Kansas", "Kentucky", "Louisiana", "Mississippi",
  "Missouri", "Montana", "Nebraska", "North Dakota", "Ohio",
  "Oklahoma", "South Carolina", "South Dakota", "Tennessee",
  "Texas", "Utah", "West Virginia", "Wyoming"
)

# Swing states (from the search results)
swing_states <- c(
  "Arizona", "Georgia", "Michigan", "Nevada",
  "North Carolina", "Pennsylvania", "Wisconsin"
)



unique_poll_ids <- sample(10000:99999, length(states))
unique_question_ids <- sample(10000:999999, length(states))
poll_ids <- rep(unique_poll_ids, each = 4)
question_ids <- rep(unique_question_ids, each = 4)
methodology_column <- sample(methodologies, 4 * length(states), replace = TRUE)
state_column <- rep(states, each = 4)
state_column <- rep(state_column, length.out = 4 * length(states))
sample_size <- sample(100:20000, length(states))
sample_size <- rep(sample_size, each = 4)
pollster_column <- sample(pollster, length(states), replace = TRUE)
pollster_column <- rep(pollster_column, each = 4)

generate_percentages <- function(state) {
  jill_pct <- max(rnorm(1, 0.02, 0.01), 0.0)
  rfk_pct <- max(rnorm(1, 0.02, 0.01), 0.0)
  percentage_left <- 1 - jill_pct - rfk_pct

  # candiatate order c("Donald Trump", "Kamala Harris", "Jill Stein", "Robert F. Kennedy")
  if (state %in% swing_states) {
    trump_pct <- rnorm(1, percentage_left * 0.5, 0.02)
    kamala_pct <- percentage_left - trump_pct
    return(c(trump_pct, kamala_pct, jill_pct, rfk_pct))
  } else if (state %in% red_states) {
    trump_pct <- rnorm(1, percentage_left * 0.57, 0.03)
    kamala_pct <- percentage_left - trump_pct
    return(c(trump_pct, kamala_pct, jill_pct, rfk_pct))
  } else if (state %in% blue_states) {
    trump_pct <- rnorm(1, percentage_left * 0.43, 0.03)
    kamala_pct <- percentage_left - trump_pct
    return(c(trump_pct, kamala_pct, jill_pct, rfk_pct))
  }

  # Case of National
  trump_pct <- rnorm(1, percentage_left * 0.5, 0.015)
  kamala_pct <- percentage_left - trump_pct
  return(c(trump_pct, kamala_pct, jill_pct, rfk_pct))
}


analysis_data <- tibble(
  pollster = pollster_column,
  poll_id = poll_ids,
  question_ids = question_ids,
  state = state_column,
  methodology = methodology_column,
  sample_size = sample_size,
  candidate_name = rep(candidate_names, length.out = 216),
)

analysis_data <- analysis_data %>% mutate(pct = 0.0)

for (id_ in unique(analysis_data$poll_id)) {
  state_ <- analysis_data$state[analysis_data$poll_id == id_][1]
  pcts <- generate_percentages(state_)

  analysis_data <- analysis_data %>%
    mutate(pct = case_when(
      poll_id == id_ & candidate_name == candidate_names[1] ~ pcts[1],
      poll_id == id_ & candidate_name == candidate_names[2] ~ pcts[2],
      poll_id == id_ & candidate_name == candidate_names[3] ~ pcts[3],
      poll_id == id_ & candidate_name == candidate_names[4] ~ pcts[4],
      TRUE ~ pct # keep original value if no match
    ))
}

analysis_data$pct <- analysis_data$pct * 100

#### Save data ####
write_parquet(analysis_data, "data/00-simulated_data/simulated_data.parquet")
