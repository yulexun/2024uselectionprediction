#### Preamble ####
# Purpose: Downloads and saves the data from fivethirtyeight.com.
# Author: Lexun Yu
# Date: 19 October 2024
# Contact: lx.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(tidyverse)

#### Download data ####
# Specify the download URL from FiveThirtyEight
url <- "https://projects.fivethirtyeight.com/polls/data/president_polls.csv"

# Save the data csv
download.file(url, "data/01-raw_data/president_polls.csv")
