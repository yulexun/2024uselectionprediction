#### Preamble ####
# Purpose: Cleans the raw  data from FiveThirtyEight
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


cleaned_data <- raw_data |>
  filter(
    numeric_grade >= 2.7
  )

cleaned_data_national <- cleaned_data |>
  filter(is.na(state))

cleaned_data_state <- cleaned_data |>
  filter(!is.na(state))

# Delete NA columns
# cleaned_data <- raw_data |>
#   select(-sponsor_ids, 
#     -sponsors, 
#     -sponsor_candidate_id, 
#     -sponsor_candidate, 
#     -sponsor_candidate_party, 
#     -endorsed_candidate_id, 
#     -endorsed_candidate_name, 
#     -endorsed_candidate_party, 
#     -subpopulation, -tracking, 
#     -notes, -url_article, -url_topline, -url_crosstab,
#     -source, -internal, -partisan, -seat_name, 
#     -ranked_choice_round) |> na.omit()


# Keep data from one pollster for Appendix
# morningconsult_data <- cleaned_data %>%
#   filter(pollster == "Morning Consult")

#### Save data ####
write_csv(cleaned_data, "data/02-analysis_data/cleaned_data.csv")
write_csv(cleaned_data_national, "data/02-analysis_data/cleaned_data_national.csv")
write_csv(cleaned_data_national, "data/02-analysis_data/cleaned_data_state.csv")
# write_csv(morningconsult_data, "data/02-analysis_data/mc_data.csv")
