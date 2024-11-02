#### Preamble ####
# Purpose: Tests the structure and validity of the simulated US
# election poll dataset.
# Author: Lexun Yu
# Date: 2 November 2024
# Contact: lx.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites:
# - The `tidyverse` package must be installed and loaded
# - 00-simulate_data.R must have been run


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(testthat)

analysis_data <- read_parquet("data/00-simulated_data/simulated_data.parquet")

# Test if the data was successfully loaded
if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####

# Check if the dataset has 200 rows

test_that("Dataset row count is 200", {
  expect_equal(nrow(analysis_data), 200, 
               info = "The dataset does not have 200 rows.")
})

# Check if the dataset has 6 columns
test_that("Dataset column count is 6", {
  expect_equal(ncol(analysis_data), 6, 
               info = "The dataset does not have 6 columns.")
})

# Check if all values in the 'state' column are a valid state name
valid_states <- 
  c(state.name, "National")

test_that("The 'state' column contains only valid US state names", {
  expect_true(all(analysis_data$state %in% valid_states), 
              info = "The 'state' column contains invalid state names.")
})


# Check if there are any missing values in the dataset
test_that("The dataset contains no missing values", {
  expect_true(all(!is.na(analysis_data)), 
              info = "The dataset contains missing values.")
})

# Check if the percentages are all above 0
test_that("The percentage are positive values", {
  expect_true(all(analysis_data$pct >= 0, 
  info = ""))
})