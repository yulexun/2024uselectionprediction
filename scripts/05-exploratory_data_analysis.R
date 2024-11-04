#### Preamble ####
# Purpose:  Build SLR model
# Author: Lexun Yu, Colin Sihan Yang
# Date: 1 November 2024
# Contact: lx.yu@mail.utoronto.ca
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/cleaned_data.parquet")


### Model data ####
Harris_data = cleaned_data[cleaned_data$candidate_name == "Kamala Harris", ]
just_harris_data = Harris_data |> na.omit()
lm_model1 = lm(pct ~ pollscore, data = just_harris_data)
predictions = predict(lm_model1, just_harris_data)
summary(lm_model1)

ggplot(just_harris_data, aes(x = pct, y = predictions)) +
  geom_point(color = 'blue') +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "red") +
  labs(title = "Actual vs Predicted Values",
       x = "Actual pct",
       y = "Predicted pct") +
  theme_minimal()


#### Save model ####
saveRDS(
  lm_model1,
  file = "models/first_model.rds"
)
