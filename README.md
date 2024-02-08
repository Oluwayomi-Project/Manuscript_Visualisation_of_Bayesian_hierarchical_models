
## Manuscript_Visualisation_of_Bayesian_hierarchical_models

### Data cleaning - OECD_RawData.Rmd
Upon careful examination, it was observed that the PISA dataset recorded by the learningtower differs from the information available on the OECD website. 
Consequently, a decision was made to directly download the raw data from the OECD website.

The datasets for the years 2022, 2018, and 2015 are saved as SPSS (.sav file), while the preceding years—2012, 2009, 2006, 2003, and 2000—are saved as TXT files.

For the .sav files, the R package named haven provides a function called read_spss, facilitating the reading of SPSS files into R. 
Utilizing this package, we successfully loaded the data in its SPSS format for the years 2022, 2018, and 2015.

As for the PISA surveys conducted prior to 2015, the data was stored as TXT files. 
There are multiple methods to load the data into R, including downloading SPSS software. 
However, to streamline the process, we opted for the R package pbiecek, which contains the raw data directly from the OECD website spanning from 2000 to 2012. 
The raw data, comprising score points and weights, was downloaded as a dataset.

Each score point is associated with a weight, crucial for calculating the weighted mean across countries for each year. 
The R package intsvy, designed to consider complex sample designs like replicate weights in its calculations, was employed for this purpose. 
Consequently, the package was utilized to compute the weighted mean of the raw data.

The intsvy package calculated the weighted mean for each country and estimated the standard error for each country. 
The standard error serves as a measure of variability in the weighted mean of each country from the population mean.

### Exploratory Data Analysis -.Rmd
We introduced a novel variable named Income_Region by combining the Region and Income variables. Our objective is to establish additional variables with a hierarchical structure for the Bayesian model, aiming to assess the impact of this structure on model estimates.

Subsequently, we fitted separate linear models (lm) with weights set to 1/se^2 for the 40 European countries involved in the PISA survey. The model estimates derived from these fitted models were utilized to visually present the model regression line on the observed data. The countries were grouped based on their geographical regions and income levels.

To accomplish this, we employed geo_facet to group countries according to their respective regions and facet_wrap for income grouping. The resulting plots were saved as "fit_grouped_by region.pdf" and "fit_grouped_by income.pdf," respectively.

### Hierarchical model fitting - .Rmd
In our hierarchical model, we employed a JAGS model where
$y.i ~ dnorm(\mu_i[i], \sigma_y[i]^-2)$ , 

Such that; 

$\mu_i[i] <- \alpha_j [C[i]] + \beta_j[C[i]]*(x.i[i])$ 

$\sigma_y[i]^{-2} <- \sqrt{(\sigma[i]^2 + \sigma.m^2)}$ 

Priors were established for the country-specific alphas and betas, as well as for $\sigma$.m. Introducing a prior on $\sigma$.m was crucial for facilitating the posterior setup, enabling predictions for missing data points and future estimations. This process was reiterated with a hyper-parameterization of  $\alpha$ and $\beta$, ensuring that country estimates originated from a common prior distribution. 

Subsequently, we extended the model into a hierarchical structure, incorporating three levels (Region, Income, and Income-Region). The model was adapted to assign hyper-parameters to countries based on their respective hierarchical structures. Our rationale behind specifying distinct hyper-parameters according to the hierarchical structure was to evaluate the influence of information sharing within specific groups.

### JAGS_Model_Estimates - .Rmd 

The estimates for parameters and hyperparameters derived from the fitted model and hierarchical models were utilised to generate visual representations of the model regression line on the observed data. These visualisations are stored as "fit_ind_country_model.pdf," "fit_country_model.pdf," "fit_region_model.pdf," "fit_income_model.pdf," and "fit_incomeregion_model.pdf" within the **regression_fits folder**. 



