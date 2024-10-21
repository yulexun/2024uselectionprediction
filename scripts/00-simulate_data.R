#### Preamble ####
# Purpose: Simulates a dataset of Australian electoral divisions, including the 
  #state and party that won each division.
# Author: Rohan Alexander
# Date: 26 September 2024
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
set.seed(853)


#### Simulate data ####
# State names
states <- state.name
answer <- c("Trump", "Harris")
pollster <- c("Marist", "YouGov", "Ipsos", "Emerson", "SurveyUSA")



# Create a dataset by randomly assigning states and parties to divisions
analysis_data <- tibble(
  state = sample(
    states,
    size = 1500,
    replace = TRUE,
  ),

)


#### Save data ####
write_csv(analysis_data, "data/00-simulated_data/simulated_data.csv")
