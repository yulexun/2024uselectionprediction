#### Preamble ####
# Purpose: Downloads and saves the data from [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)

#### Download data ####
# Specify the download URL from FiveThirtyEight
url <- "https://projects.fivethirtyeight.com/polls/data/president_polls.csv"

# Save the data csv
download.file(url, "data/01-raw_data/president_polls.csv")

