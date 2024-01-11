## Manuscript_Visualisation_of_Bayesian_hierarchical_models

### Data cleaning
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
