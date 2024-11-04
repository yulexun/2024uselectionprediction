#### Preamble ####
# Purpose: Bayesian Model for the paper
# Author: Colin Sihan Yang
# Date: 3 November 2024
# Contact: lx.yu@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)
#### Read data ####

cleaned_data = read_parquet(here("data/02-analysis_data/cleaned_data.parquet"))
baye_model_data = cleaned_data[cleaned_data$candidate_name == "Kamala Harris", ]
# Define the Bayesian model with brms
# test and train dataset

formula <- pct ~ pollscore + days_taken_from_election + sample_size + (1 | methodology) + (1 | state)

priors = normal(0, 2.5, autoscale = TRUE)

bayesian_model_1 <- stan_glmer(
  formula = formula,
  data = baye_model_data,
  family = gaussian(),
  prior = priors,
  prior_intercept = priors,
  seed = 123,
  cores = 4,
  adapt_delta = 0.95
)

saveRDS(
  bayesian_model_1,
  file = "models/bayesian_model_1.rds"
)


just_harris_data = cleaned_data[cleaned_data$candidate_name == "Kamala Harris", ]
train_indices <- sample(seq_len(nrow(just_harris_data)), size = 0.7 * nrow(just_harris_data))
train_data <- just_harris_data[train_indices, ]
test_data <- just_harris_data[-train_indices, ]

write_parquet(train_data, "./data/02-analysis_data/train_data.parquet")
write_parquet(test_data, "./data/02-analysis_data/test_data.parquet")

# Fit the model on the training data
bayesian_model_train <- stan_glmer(
  formula = formula,
  data = train_data,
  family = gaussian(),
  prior = priors,
  prior_intercept = priors,
  seed = 123,
  cores = 4,
  adapt_delta = 0.95
)

saveRDS(
  bayesian_model_train,
  file = "models/bayesian_model_train.rds"
)
