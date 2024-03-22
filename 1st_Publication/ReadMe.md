## The PISA data
#### All the data needed for this analysis are saved in the folder named "PISA_Data" as; maths_pisa.Rdata and Europe_Pisamaths.Rdata.

**If you can not load this data, the codes in OECD_Rawdata.Rmd file will generate the data for you but you have to download the SPSS raw data directly from OECD website.**

*The maths_pisa.Rdata contains the entire data from OECD with all the countries that participated in PISA survey. This data set is the average maths score across all the countries over time.*

*The Europe_Pisamaths.Rdata contains the data for the European countries comprising of 237 observations from 40 countries. Filtering year 2022, we have 202 observations left.*

### 02_Exploratory_Analysis.Rmd

**This Rmarkdown file contains the codes for the exploratory data analysis.**

A separate linear model is fitted for each country using lm fit, and the resulting estimates are displayed by categorising the countries based on both Region and Income.

In order to accomplish this, we utilised the ggragged package to cluster the countries based on their geographical region classification, ordering the countries in each cluster by ascending slopes. Additionally, the patchwork package was employed to arrange the income categorization horizontally. We then applied unique colors to distinguish between the region and income categories.

### 03_Hierarchical model.Rmd
There are two distinct files with this naming; 03_BRMS_Hierarchical_Model.Rmd and 03_JAGS_Hierarchical_Model.Rmd.

We fitted an independent model, country-specific model, and Region, Income, Income-Region hierarchical model with the PISA data set from 2003 to 2018.

### 04_Model Estimates.Rmd
There are two distinct files with this naming; 04_BRMS_Model_Estimates.Rmd and 04_JAGS_Model_Estimates.Rmd.

From the fitted models, we proceeded to extract the model estimates (Intercept and Slope), followed by a visual displaying the model fits on the data points.

### 05_Customised_Visualisations.Rmd
There are four distinct files with this nomenclature; 05_BRMS_Customised_Visualisations_geofacet.Rmd, 05_BRMS_Customised_Visualisations_ggragged.Rmd, 05_JAGS_Customised_Visualisations_geofacet.Rmd and 05_JAGS_Customised_Visualisations_ggragged.Rmd.

The main aim of this research is to propose a visualisation approach for model comparison and selection. To achieve this, we used both the geofacet and ggragged R packages to arrange the countries according to their position on the Europe map and the ggragged to group the countries according to their respective Income-Region group. The model estimates across all the fitted models alongside the hierarchical model estimates were represented using the stat_intervals for the 80% and 95% credible intervals.

### 06_Model Prediction
There are two distinct files with this nomenclature; 06_BRMS_Model_Prediction.Rmd and 06_JAGS_Model_Prediction.Rmd.

Using the fitted models, we made predictions for year 2022 and compared the estimates with the PISA 2022 data set.


