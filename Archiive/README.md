## This folder contains the previous works we have done.
The previous analysis and previous plots.


### Investigating Covid-impact – Analysis.Rmd 

I filtered out observational data points for the year 2022, then applied an lm model and assessed the slope before and after the onset of COVID. The post-COVID slope is predominantly lower and negative compared to the pre-COVID slope, indicating a negative impact of COVID on the overall slope of the PISA dataset.

Subsequently, I calculated the overall sigma of the model for both post- and pre-COVID periods. The overall variation post-COVID is higher than pre-COVID. Similarly, the hyper-parameter intercept estimate variation for post-COVID is lower than the pre-COVID hyper-parameter variation.

These findings suggest that COVID adversely affects the overall performance of the model. The decrease in hyper-parameter variation is attributed to an increase in sample size. I recommend generating visuals that compare parameter and hyper-parameter estimates between pre- and post-COVID models.
