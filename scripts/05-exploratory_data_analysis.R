#### Preamble ####
# Purpose: Visualize the relationship between variables and overall trend of response
# Author: Lexun Yu
# Date: 1 November 2024
# Contact: lx.yu@mail.utoronto.ca
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/cleaned_data.parquet")

# Plot poll score and sample size

pairs(analysis_data)

### Model data ####


#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)
