#Used to generate the MVM datatable for the resting state connectivity
#part of Mellissa's project

library(dplyr)

#Load in data
Rest_CloseToFastloc <- read.delim(dir("nhlp_data/data_categories/mri_data/additional_mri_data/match_modalities/",
                                     full.names=T, pattern="^Rest_CloseToFastloc_20"),header=TRUE, sep="\t")
Mellissa_df <- read.csv("nhlp_data/projects/DysCortexVariability/variability_rs6935076.csv", header=TRUE)
Resting_Driver_Summary <- read.delim(dir("nhlp_data/data_categories/mri_data/additional_mri_data/driver_summaries/",
                                         full.names=T, pattern="^Resting_Driver_Summary_20"),header=TRUE, sep="\t")

Mellissa_df_reduce <- Mellissa_df %>% 
  select(Subj, RU1m1, age_mri, SESComposite,Comp.1, Comp.2, Comp.3) %>% 
  mutate(SESComposite = replace(SESComposite, which(SESComposite < -1), NA),
         RU1m1 = case_when(RU1m1==1 ~ "Yes",
                           RU1m1==0 ~ "No"),
         SESComposite = case_when(SESComposite==1 ~ "Yes",
                                  SESComposite==0 ~ "No"))
Resting_Driver_Summary_reduce <- Resting_Driver_Summary %>% 
  select(subject.ID, average.motion..per.TR.) %>% 
  rename(average_motion_per_TR = average.motion..per.TR.)

#Create MVM datatable 
DataTable <- Rest_CloseToFastloc %>% 
  left_join(Mellissa_df_reduce, by = "Subj")  %>% 
  left_join(Resting_Driver_Summary_reduce, by = c("equiv_rest" = "subject.ID")) %>% 
  filter(!is.na(equiv_rest),
         !is.na(Comp.1),
         !is.na(SESComposite)) %>% 
  select(-Subj, -record_id) %>% 
  rename(Subj = equiv_rest,
         Comp_1 = Comp.1,
         Comp_2 = Comp.2,
         Comp_3 = Comp.3)
DataTable$`InputFile\ \\` <- paste("$STORAGE/nhlp/projects/FastLoc/DysCorVar/CorrelationMaps/",DataTable$Subj,"_RFFsec4_r2z+tlrc\ \\",sep="")

#Write out MVM data table
write.table(DataTable,"nhlp_data/projects/DysCortexVariability/Rest_MVM_DataTable.txt",row.names = FALSE,col.names = TRUE,quote=FALSE)
