#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/president_polls.csv")

# Delete NA columns, 
# Note: I am not sure if I deleting state here is appropriate, the half of the state column are missing.
cleaned_data <- raw_data |>
  select(-sponsor_ids, 
    -sponsors, 
    -sponsor_candidate_id, 
    -sponsor_candidate, 
    -sponsor_candidate_party, 
    -state, 
    -endorsed_candidate_id, 
    -endorsed_candidate_name, 
    -endorsed_candidate_party, 
    -subpopulation, -tracking, 
    -notes, -url_article, -url_topline, -url_crosstab,
    -source, -internal, -partisan, -seat_name, 
    -ranked_choice_round) |> na.omit()

# Keep data from one pollster for Appendix
morningconsult_data <- cleaned_data %>%
  filter(pollster == "Morning Consult")

#### Save data ####
write_csv(cleaned_data, "data/02-analysis_data/cleaned_data.csv")
write_csv(morningconsult_data, "data/02-analysis_data/mc_data.csv")
