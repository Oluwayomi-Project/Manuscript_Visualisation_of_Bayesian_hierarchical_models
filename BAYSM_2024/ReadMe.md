## The PISA data
#### All the data needed for this analysis are saved in the folder named "PISA_Data" as; maths_pisa.Rdata and Europe_Pisamaths.Rdata.

**If you can not load this data, the codes in OECD_Rawdata.Rmd file will generate the data for you but you have to download the SPSS raw data directly from OECD website.**

*The maths_pisa.Rdata contains the entire data from OECD with all the countries that participated in PISA survey. This data set is the average maths score across all the countries over time.*

*The Europe_Pisamaths.Rdata contains the data for the European countries comprising of 237 observations from 40 countries. Filtering year 2022, we have 202 observations left.*

### 02_Exploratory_Analysis.Rmd

**This Rmarkdown file contains the codes for the exploratory data analysis.**

### 03_Hierarchical model.Rmd

The proposed models for the PISA analysis are fitted here, but there are many divergent transition and majority of the models have this error message: 
**Warning: Bulk Effective Samples Size (ESS) is too low, indicating posterior means and medians may be unreliable.**


