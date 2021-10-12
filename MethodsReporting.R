#Used to generate metrics

library(dplyr)

#Load in data
ROI_Variability_Mean <- read.delim("nhlp_data/projects/DysCortexVariability/ROI_Variability_Mean_2020-05-07.txt", header=TRUE)

quantile(ROI_Variability_Mean$age_mri/365)


