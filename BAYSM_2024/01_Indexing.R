## ----libraries
library(stringr)
library(tidybayes)
library(ggplot2)
library(dplyr)
library(tidyr)
library(brms)
library(bayesplot)
library(patchwork)
library(ggragged)
library(geofacet)
library(grid)

## ----loading the data---------------------------------------------------------
load(here::here("PISA_Data", "Europe_Pisamaths.Rdata"))

# We have decided to remove year 2022 from my data and make prediction for 2022.
# Hence i will filter year = 2022.
PISA_Europe_Data <- Pisa_Europe_Data |>
  filter(year != "2022")

#Creating the indexing for the analysis
## -----------------------------------------------------------------------------
country_names <- levels(factor(PISA_Europe_Data$Country))
region_names <- levels(factor(PISA_Europe_Data$Region))
income_names <- levels(factor(PISA_Europe_Data$Income))
incomeregion_names <- levels(factor(PISA_Europe_Data$Income_Region))

## Obtaining the region indexes
country_region <- PISA_Europe_Data |> group_by(Country) |>
  summarise(Region=first(Region)) |>
  mutate(Country_num = as.numeric(as.factor(Country))) |>
  mutate(region_num = as.numeric(as.factor(Region)))

REGION <- country_region |> select(Country, Region)

## Obtaining the income indexes
country_income <- PISA_Europe_Data |> group_by(Country) |>
  summarise(Income=first(Income)) |>
  mutate(Country_num = as.numeric(as.factor(Country))) |>
  mutate(income_num = as.numeric(as.factor(Income)))

INCOME <- country_income |> select(Country, Income)

## Obtaining the income_region indexes
country_incomeregion <- PISA_Europe_Data |> group_by(Country) |>
  summarise(Income_Region=first(Income_Region)) |>
  mutate(Country_num = as.numeric(as.factor(Country))) |>
  mutate(incomeregion_num = as.numeric(as.factor(Income_Region)))

INCOME_REGION <- REGION |>
  left_join(INCOME, join_by(Country))

Country_region <- country_region |> left_join(INCOME, join_by(Country))
Country_income <- country_income |> left_join(REGION, join_by(Country))
Country_incomeregion <- country_incomeregion |> 
  left_join(INCOME_REGION, join_by(Country))
