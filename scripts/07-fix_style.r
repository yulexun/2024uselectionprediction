#### Preamble ####
# Purpose: Fix formatting error with styler and lintr
# Author: Lexun Yu
# Date: 16 Sep 2024
# Contact: lx.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace Setup ####
library(styler)
library(lintr)

#### Format the code ####
styler::style_dir("scripts/")
lintr::lint_dir("scripts/")
