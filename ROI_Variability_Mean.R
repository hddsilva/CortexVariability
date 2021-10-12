#Used to plot the variability interactions

library(dplyr)

#Load in data
IFG_Mean <- read.delim(dir("nhlp_data/projects/DysCortexVariability/ROI_variability_mean/",
                                         full.names=T, pattern="^IFG_Mean"),header=FALSE, sep=" ")
STG_Mean <- read.delim(dir("nhlp_data/projects/DysCortexVariability/ROI_variability_mean/",
                           full.names=T, pattern="^STG_Mean"),header=FALSE, sep=" ")
TT_Mean <- read.delim(dir("nhlp_data/projects/DysCortexVariability/ROI_variability_mean/",
                           full.names=T, pattern="^TT_Mean"),header=FALSE, sep=" ")
wholeFF_Mean <- read.delim(dir("nhlp_data/projects/DysCortexVariability/ROI_variability_mean/",
                           full.names=T, pattern="^wholeFF_Mean"),header=FALSE, sep=" ")
FFsec1_Mean <- read.delim(dir("nhlp_data/projects/DysCortexVariability/ROI_variability_mean/",
                           full.names=T, pattern="^FFsec1_Mean"),header=FALSE, sep=" ")
FFsec2_Mean <- read.delim(dir("nhlp_data/projects/DysCortexVariability/ROI_variability_mean/",
                              full.names=T, pattern="^FFsec2_Mean"),header=FALSE, sep=" ")
FFsec3_Mean <- read.delim(dir("nhlp_data/projects/DysCortexVariability/ROI_variability_mean/",
                              full.names=T, pattern="^FFsec3_Mean"),header=FALSE, sep=" ")
FFsec4_Mean <- read.delim(dir("nhlp_data/projects/DysCortexVariability/ROI_variability_mean/",
                              full.names=T, pattern="^FFsec4_Mean"),header=FALSE, sep=" ")

IFG_Var <- read.delim(dir("nhlp_data/projects/DysCortexVariability/ROI_variability_mean/",
                           full.names=T, pattern="^IFG_Var"),header=FALSE, sep=" ")
STG_Var <- read.delim(dir("nhlp_data/projects/DysCortexVariability/ROI_variability_mean/",
                           full.names=T, pattern="^STG_Var"),header=FALSE, sep=" ")

TT_Var <- read.delim(dir("nhlp_data/projects/DysCortexVariability/ROI_variability_mean/",
                          full.names=T, pattern="^TT_Var"),header=FALSE, sep=" ")
wholeFF_Var <- read.delim(dir("nhlp_data/projects/DysCortexVariability/ROI_variability_mean/",
                               full.names=T, pattern="^wholeFF_Var"),header=FALSE, sep=" ")
FFsec1_Var <- read.delim(dir("nhlp_data/projects/DysCortexVariability/ROI_variability_mean/",
                              full.names=T, pattern="^FFsec1_Var"),header=FALSE, sep=" ")
FFsec2_Var <- read.delim(dir("nhlp_data/projects/DysCortexVariability/ROI_variability_mean/",
                              full.names=T, pattern="^FFsec2_Var"),header=FALSE, sep=" ")
FFsec3_Var <- read.delim(dir("nhlp_data/projects/DysCortexVariability/ROI_variability_mean/",
                              full.names=T, pattern="^FFsec3_Var"),header=FALSE, sep=" ")
FFsec4_Var <- read.delim(dir("nhlp_data/projects/DysCortexVariability/ROI_variability_mean/",
                              full.names=T, pattern="^FFsec4_Var"),header=FALSE, sep=" ")

mri_data <- read.delim(dir("nhlp_data/data_categories/mri_data/",
                           full.names=T, pattern="^mri_data_20"),header=TRUE, sep="\t")
long_mri <- read.delim(dir("nhlp_data/data_categories/mri_data/additional_mri_data/long_mri/",
                           full.names=T, pattern="^long_mri_20"),header=TRUE, sep="\t")
Fastloc_Driver_Summary <- read.delim(dir("nhlp_data/data_categories/mri_data/additional_mri_data/driver_summaries",
                           full.names=T, pattern="^Fastloc_Driver_Summary_20"),header=TRUE, sep="\t")
RespSummary_Overall <- read.delim(dir("fMRI_ePrime_data/E-Prime",
                                         full.names=T, pattern="^RespSummary_Overall"),header=TRUE, sep="\t")

lookup_table <- read.delim(dir("nhlp_data/data_categories/lookup_table/",
                           full.names=T, pattern="^lookup_table_20"),header=TRUE, sep="\t")


#Clean the ROI dataframes
listDF <- c('IFG_Mean', 'STG_Mean', 'TT_Mean', 'wholeFF_Mean', 'FFsec1_Mean', 'FFsec2_Mean', 'FFsec3_Mean', 'FFsec4_Mean',
            'IFG_Var', 'STG_Var', 'TT_Var', 'wholeFF_Var', 'FFsec1_Var', 'FFsec2_Var', 'FFsec3_Var', 'FFsec4_Var')

for(df in listDF) {
  df.tmp <- get(df)
  df.num <- select_if(df.tmp, is.numeric)
  df.wIDs <- df.tmp[1] %>% bind_cols(df.num)
  names(df.wIDs) <- c("mrrc_ID", paste("L_",df,"_Vis"), paste("L_",df,"_Aud"), paste("L_",df,"_FF"), paste("L_",df,"_Vocod"),
                     paste("R_",df,"_Vis"), paste("R_",df,"_Aud"), paste("R_",df,"_FF"), paste("R_",df,"_Vocod"))
  assign(df, df.wIDs)
}

#Select parts of dataframes we want
select_driver <- Fastloc_Driver_Summary %>% select(subject.ID, average.motion..per.TR.) %>% rename(average_motion_per_TR = average.motion..per.TR.)
select_acc <- RespSummary_Overall %>% select(mrrc_id, meanACC, PropHits, PropMiss, PropCR, PropFA, aprime, bdprime)

#Create the dataframe
ROI_Variability_Mean <- IFG_Mean %>%  
  left_join(STG_Mean, by = "mrrc_ID") %>%
  left_join(TT_Mean, by = "mrrc_ID") %>%
  left_join(wholeFF_Mean, by = "mrrc_ID") %>% 
  left_join(FFsec1_Mean, by = "mrrc_ID") %>%
  left_join(FFsec2_Mean, by = "mrrc_ID") %>%
  left_join(FFsec3_Mean, by = "mrrc_ID") %>%
  left_join(FFsec4_Mean, by = "mrrc_ID") %>%
  left_join(IFG_Var, by = "mrrc_ID") %>%
  left_join(STG_Var, by = "mrrc_ID") %>%
  left_join(TT_Var, by = "mrrc_ID") %>%
  left_join(wholeFF_Var, by = "mrrc_ID") %>% 
  left_join(FFsec1_Var, by = "mrrc_ID") %>%
  left_join(FFsec2_Var, by = "mrrc_ID") %>%
  left_join(FFsec3_Var, by = "mrrc_ID") %>%
  left_join(FFsec4_Var, by = "mrrc_ID") %>% 
  left_join(mri_data, by = c("mrrc_ID"="mrrc_id")) %>% 
  left_join(long_mri, by = c("mrrc_ID"="mrrc_id")) %>% 
  left_join(select_driver, by = c("mrrc_ID"="subject.ID")) %>%
  left_join(select_acc, by = c("mrrc_ID"="mrrc_id")) %>%
  left_join(lookup_table, by = c("record_id")) %>%
  select(record_id, Subj, mrrc_ID, age_mri, mri_tp, childsex.factor, everything(), -mri_date, -childdob, -childsex) %>% 
  distinct()

#Check there aren't any duplicated rows or columns (likely an error if there are)
#Both checks should be same dimension as ROI_Variability_Mean
check_rows <- distinct(ROI_Variability_Mean)
check_columns <- ROI_Variability_Mean[!duplicated(lapply(ROI_Variability_Mean, summary))]


#Write out dataframe
write.table(ROI_Variability_Mean, file=paste("nhlp_data/projects/DysCortexVariability/ROI_Variability_Mean_T2T3_",Sys.Date(),".txt",sep=""), sep="\t", row.names = FALSE)


