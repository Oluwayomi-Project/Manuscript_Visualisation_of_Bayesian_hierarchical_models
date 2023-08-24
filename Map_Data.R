## Loading the libraries
library(dplyr)
library(tidybayes)
library(tidyverse)
library(rjags)
library(R2jags)
library(bayesplot)

### Loading the  data
All <- learningtower::load_student("all")
### Changing data types 
All$year <- as.numeric(as.character(All$year))
names(All)[2] <- 'iso3c'
#### Sub-setting the data for the math scores, year and
#### country only while deleting rows with missing values.
Data <- All %>% select(c("iso3c","year", "math"))%>% tidyr::drop_na()

### Loading the Income classification data set
Income <- read.csv(here::here("gdp.csv"))
Income_Group <- Income %>% select(c("Country.Code", "IncomeGroup"))

Income_Group$IncomeGroup <- Income_Group$IncomeGroup %>% 
  recode_factor("Lower middle income" = "Middle Income")%>% 
  recode_factor("middle income" = "Middle Income")%>% 
  recode_factor("high income" = "Middle Income")

names(Income_Group)[1] <- "iso3c"
names(Income_Group)[2] <- "Income"

# Merging the PISA data and the WDI data
Pisa_Data <- merge(Data, Income_Group, by = "iso3c")

# Taking the mean of the math score across the country.
Math_Pisa <- Pisa_Data %>% 
  group_by(iso3c, year, Income)%>%summarize(math_mean = mean(math))%>% 
  mutate(year_orig = year - 2000)

### Loading the csv file for region classification
A <- read.csv(here::here("UNSD — Methodology.csv"))
Region_Class <- A %>% select(c("ISO.alpha3.Code","Region.Name", 
                               "Sub.region.Name", "Country.or.Area"))%>%unique()

# Renaming the variables
names(Region_Class)[1] <- 'iso3c'
names(Region_Class)[2] <- 'Region'
names(Region_Class)[3] <- 'Sub.Region'
names(Region_Class)[4] <- 'Country'

# Merging the two data frames
Dataset <- merge(Math_Pisa, Region_Class, by ="iso3c")

#Sub-setting the European region only
Math_Pisa_Dataset <- Dataset %>% select(-iso3c)%>% filter(Region == "Europe")

### Visualising the data
# Facet re-ordering for sub region
Math_Pisa_Dataset$facet = factor(Math_Pisa_Dataset$Sub.Region, 
                                 levels = c("Northern Europe", "Western Europe",
                                            "Eastern Europe", "Southern Europe"))

ggplot(data = Math_Pisa_Dataset,
       aes(x= math_mean, y = reorder(Country, math_mean), color = Sub.Region))+
  geom_point(color = "thistle4" , size = 0.95)+
  stat_pointinterval(point_interval = "mean_qi")+
  labs( x = " Average math scores", y = "Country")+
  theme_bw()+
  facet_grid(facet ~., scales = "free", space = "free")

# Loading the map data
# map data
mapdata <- map_data("world")
names(mapdata)[5] <- 'Country'

MAP <- Math_Pisa_Dataset %>% filter(year %in% "2003")
MAP_Data <- left_join(mapdata, MAP, by = "Country")
glimpse(MAP_Data1)

MAP_Data1 <- MAP_Data %>% filter(!is.na(MAP_Data$math))
summary(Map_Data1)

MAP1 <- ggplot(MAP_Data1,
               aes(x= long, y = lat, group=group))+
  geom_polygon(aes(fill = math), color = "black")

MAP1 +
  scale_fill_gradient(name = "Average maths score",
                      low = "darkorange3", high = "cadetblue")
