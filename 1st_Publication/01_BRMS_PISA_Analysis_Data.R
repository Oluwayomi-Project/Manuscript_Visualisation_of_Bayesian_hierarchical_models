## ----libraries, include = FALSE------------------------------------------
library(lme4)
library(tidybayes)
library(ggplot2)
library(dplyr)
library(tidyr)
library(brms)
library(rjags)
library(R2jags)
library(stringr)
library(bayesplot)
library(patchwork)
library(ggragged)
library(geofacet)
library(grid)


## ----loading the data----------------------------------------------------
load(here::here("PISA_Data", "maths_pisa.Rdata"))


## ----Europe--------------------------------------------------------------
Pisa_Europe_Data <- PISA_Data |> filter(Continent == "Europe")

#For these analysis, the baseline year is 2018, hence, we will create a variable called year_orig centering the year on 0 with year 2018.

baseline_year <- 2018

Pisa_Europe_Data <- Pisa_Europe_Data |>
  mutate(year_orig = year - baseline_year)|> arrange(Country)


## ----PISA_Europe---------------------------------------------------------
if (!dir.exists(here::here("PISA_Data")))
 dir.create(here::here("PISA_Data"))

PISA_Europe <- here::here("PISA_Data", "Europe_Pisamaths.Rdata")

# Joining the Income and Region together to form one new column
Pisa_Europe_Data <- unite(Pisa_Europe_Data, col = "Income_Region", c("Income", "Region"), sep = "_ ", remove = FALSE)

# We intend to make prediction for year 2022 and compare it with the observed data,
# Hence the complete PISA Europe data set is stored as Pisa_Europe_Data, while the data set without the year 2022 is stored as PISA_Europe_Data.
PISA_Europe_Data <- Pisa_Europe_Data |>
  filter(year != "2022")

## For the independent country  model, we ignored countries with one data point as this countries only have one data point.
#Hence, This model will be fitted excluding Belarus, Ukraine, and Bosnia& Herzergovina. We created a new variable called SCountry containing the countries with one data point.
SCountry <- c("Belarus", "Bosnia& Herzegovina", "Ukraine")

SPisa_Europe_Data <- Pisa_Europe_Data |>
  filter(!Country %in% SCountry)

SPISA_Europe_Data <- PISA_Europe_Data |>
  filter(!Country %in% SCountry)

save(Pisa_Europe_Data,PISA_Europe_Data, SPisa_Europe_Data, SPISA_Europe_Data, file =PISA_Europe)


## ------------------------------------------------------------------------
## Creating the indexing for the variables in the data set
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
  left_join(INCOME, join_by(Country == Country))

## Joining the variables with the missing variables.
Country_region <- country_region |> left_join(INCOME, join_by(Country))
Country_income <- country_income |> left_join(REGION, join_by(Country))
Country_incomeregion <- country_incomeregion |> left_join(INCOME_REGION, join_by(Country))

## ------------------------------------------------------------------------
#Creating a grid of the data to make prediction for year 2022.
Pred <-Pisa_Europe_Data |>
  modelr::data_grid(Country) |> 
  mutate(year = 2022, year_orig = year-baseline_year)

## Adding the numeric index
Pred_grid <- Pred |>
  left_join(Country_incomeregion, join_by(Country)) |>
  select(-c(Country_num, incomeregion_num))

# For the independent model, recall that we excluded countries with one data points, the grid should only include the countries used in fitting the model.
# Grid for independent model.
SPred_grid <- Pred_grid |>
  filter(!Country %in% SCountry)

