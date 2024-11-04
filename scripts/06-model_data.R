#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(here)
#### Read data ####
# analysis_data <- read_csv("data/analysis_data/analysis_data.csv")

# ### Model data ####
# first_model <-
#   stan_glm(
#     formula = flying_time ~ length + width,
#     data = analysis_data,
#     family = gaussian(),
#     prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
#     prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
#     prior_aux = exponential(rate = 1, autoscale = TRUE),
#     seed = 853
#   )


# #### Save model ####
# saveRDS(
#   first_model,
#   file = "models/first_model.rds"
# )

cleaned_data = read_csv(here("data/02-analysis_data/cleaned_data.csv"))
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

write.csv(train_data, "./data/02-analysis_data/train_data.csv")
write.csv(test_data, "./data/02-analysis_data/test_data.csv")

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
