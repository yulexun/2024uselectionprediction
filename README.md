# Forecasting the 2024 U.S. Presidential Election through Poll Aggregation and Adjustments for Poll Quality

## Overview
This paper forecast the winner of the 2024 US presidential election using “poll-of-polls” by building a linear model.

This repository contains the code and accompanying paper analyzing polling data from the 2024 U.S. presidential election. Our aim is to forecast the winner of the 2024 US presidential election and explore the factors influencing candidates' support. By employing simple linear regression models, multiple linear regression model and Bayesian model, we assess the effects of variables such as sample size, poll scores, and poll days taken from election on the percentage of candidate support(pct). 

In the SLR model analysis, we find that while sample size has a limited effect on candidate support, there is a slight association between higher poll scores and increased pct. However, this relationship alone is insufficient to fully explain variations in candidate support, indicating that other factors likely contribute significantly to pct.

In the MLR model analysis, which incorporates predictors such as poll score, days taken from the election, methodology, sample size, and state, provides a more comprehensive view. This model captures a substantial portion of the variance in pct and offers a more accurate prediction. The results demonstrate that including multiple variables enhances the model's ability to predict candidate support effectively.

According to our Bayesian model, the credible interval for Kamala Harris's pct ranges from approximately 50 to 54 percent. This finding suggests that Harris has a strong possibility of winning the election.

This paper also discusses the strengths and limitations of using statistical models for election forecasting, enhancing our understanding of the role voting methods play in influencing public opinion during high-stakes elections.


## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from FiveThirtyEight.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models for candidate. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download, clean data and build models.


## Statement on LLM usage

The drafted outline and introduction were written with the help of ChatGPT 4. The entire chat history is available in other/llm_usage/usage.txt.

## Note

This R project is setup with [Positron](https://positron.posit.co/), the new IDE by Posit PBC. The properties of this project is stored in `/renv/settings.json`. We use renv for reproducibility and portability. With the metadata from the lockfile, other researchers can install exactly the same version of every package.
You can run 
```sh
renv::restore()
```
to restore the R project emvironment. We also included a .Rproj file for RStudio users. For more information, see [this Github Issue](https://github.com/posit-dev/positron/discussions/3967) and [renv](https://rstudio.github.io/renv/articles/renv.html).

