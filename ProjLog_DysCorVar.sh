#!/bin/bash

#For bash
nhlpDir=$STORAGE/nhlp
projDir=$STORAGE/nhlp/projects/FastLoc/DysCorVar
scriptDir=$STORAGE/nhlp/scripts/FastLoc/DysCorVar
clustDir=$STORAGE/nhlp/projects/FastLoc/DysCorVar/ClustSim
resDir=${projDir}/202002/ResVar_Maps/DiffVar
sumaDir=~/suma_TT_N27

#Download the TT_N27 files for SUMA from https://afni.nimh.nih.gov/pub/dist/tgz/suma_TT_N27.tgz

#Create the ROI masks based on the Destrieux, 2010 atlas
#IFG
# 3dcalc -a ${sumaDir}/aparc.a2009s+aseg.nii -datum byte -prefix ${projDir}/ROI_masks/L_IFG.nii \
#                 -expr 'amongst(a,11112,11113,11114)' 
# 3dcalc -a ${sumaDir}/aparc.a2009s+aseg.nii -datum byte -prefix ${projDir}/ROI_masks/R_IFG.nii \
#                 -expr 'amongst(a,12112,12113,12114)'
#STG
# 3dcalc -a ${sumaDir}/aparc.a2009s+aseg.nii -datum byte -prefix ${projDir}/ROI_masks/L_STG.nii \
#                 -expr 'amongst(a,11134,11135,11136)' 
# 3dcalc -a ${sumaDir}/aparc.a2009s+aseg.nii -datum byte -prefix ${projDir}/ROI_masks/R_STG.nii \
#                 -expr 'amongst(a,12134,12135,12136)'
#Transverse temporal
# 3dcalc -a ${sumaDir}/aparc.a2009s+aseg.nii -datum byte -prefix ${projDir}/ROI_masks/L_TT.nii \
#                 -expr 'amongst(a,11133)' 
# 3dcalc -a ${sumaDir}/aparc.a2009s+aseg.nii -datum byte -prefix ${projDir}/ROI_masks/R_TT.nii \
#                 -expr 'amongst(a,12133)'
#Whole Fusiform
# 3dcalc -a ${sumaDir}/aparc.a2009s+aseg.nii -datum byte -prefix ${projDir}/ROI_masks/L_wholeFF.nii \
#                 -expr 'amongst(a,11121)' 
# 3dcalc -a ${sumaDir}/aparc.a2009s+aseg.nii -datum byte -prefix ${projDir}/ROI_masks/R_wholeFF.nii \
#                 -expr 'amongst(a,12121)'

#Segment the fusiform into 3-5 sections
#Find the minimum and maximum coordinates in the A-P direction from this output
#Explanation of output here https://msu.edu/~zhuda/fmri_class/labs/lab3/afni11_roi.pdf
# 3dclust -1thresh 0 1 200 'L_wholeFF.nii'
#Decided to segment into 4 sections
#Left= min:20 max: 78  
#Right= min:10 max: 82 
#Decided on 4 sections in overlapping areas 20-78
#Cut to 21 through 76 so that they divide evenly into 4 sections of 14mm each
#Create actual segmentations
#Left
# 3dcalc -a L_wholeFF.nii -expr 'a * within(y,21,34)' -RAI \
# 	-prefix ${projDir}/ROI_masks/L_FF_Sec1.nii
# 3dcalc -a L_wholeFF.nii -expr 'a * within(y,35,48)' -RAI \
# 	-prefix ${projDir}/ROI_masks/L_FF_Sec2.nii
# 3dcalc -a L_wholeFF.nii -expr 'a * within(y,49,62)' -RAI \
# 	-prefix ${projDir}/ROI_masks/L_FF_Sec3.nii
# 3dcalc -a L_wholeFF.nii -expr 'a * within(y,63,76)' -RAI \
# 	-prefix ${projDir}/ROI_masks/L_FF_Sec4.nii
#Right
# 3dcalc -a R_wholeFF.nii -expr 'a * within(y,21,34)' -RAI \
# 	-prefix ${projDir}/ROI_masks/R_FF_Sec1.nii
# 3dcalc -a R_wholeFF.nii -expr 'a * within(y,35,48)' -RAI \
# 	-prefix ${projDir}/ROI_masks/R_FF_Sec2.nii
# 3dcalc -a R_wholeFF.nii -expr 'a * within(y,49,62)' -RAI \
# 	-prefix ${projDir}/ROI_masks/R_FF_Sec3.nii
# 3dcalc -a R_wholeFF.nii -expr 'a * within(y,63,76)' -RAI \
# 	-prefix ${projDir}/ROI_masks/R_FF_Sec4.nii

#Resample the masks
# 3dresample -master ${resDir}/pb2199_VisCR_DiffVarMasked+tlrc -prefix ${projDir}/ROI_masks/L_IFG_2mm.nii -input ${projDir}/ROI_masks/L_IFG.nii
# 3dresample -master ${resDir}/pb2199_VisCR_DiffVarMasked+tlrc -prefix ${projDir}/ROI_masks/R_IFG_2mm.nii -input ${projDir}/ROI_masks/R_IFG.nii
# 3dresample -master ${resDir}/pb2199_VisCR_DiffVarMasked+tlrc -prefix ${projDir}/ROI_masks/L_STG_2mm.nii -input ${projDir}/ROI_masks/L_STG.nii
# 3dresample -master ${resDir}/pb2199_VisCR_DiffVarMasked+tlrc -prefix ${projDir}/ROI_masks/R_STG_2mm.nii -input ${projDir}/ROI_masks/R_STG.nii
# 3dresample -master ${resDir}/pb2199_VisCR_DiffVarMasked+tlrc -prefix ${projDir}/ROI_masks/L_TT_2mm.nii -input ${projDir}/ROI_masks/L_TT.nii
# 3dresample -master ${resDir}/pb2199_VisCR_DiffVarMasked+tlrc -prefix ${projDir}/ROI_masks/R_TT_2mm.nii -input ${projDir}/ROI_masks/R_TT.nii
# 3dresample -master ${resDir}/pb2199_VisCR_DiffVarMasked+tlrc -prefix ${projDir}/ROI_masks/L_wholeFF_2mm.nii -input ${projDir}/ROI_masks/L_wholeFF.nii
# 3dresample -master ${resDir}/pb2199_VisCR_DiffVarMasked+tlrc -prefix ${projDir}/ROI_masks/R_wholeFF_2mm.nii -input ${projDir}/ROI_masks/R_wholeFF.nii
# 3dresample -master ${resDir}/pb2199_VisCR_DiffVarMasked+tlrc -prefix ${projDir}/ROI_masks/L_FF_Sec1_2mm.nii -input ${projDir}/ROI_masks/L_FF_Sec1.nii
# 3dresample -master ${resDir}/pb2199_VisCR_DiffVarMasked+tlrc -prefix ${projDir}/ROI_masks/R_FF_Sec1_2mm.nii -input ${projDir}/ROI_masks/R_FF_Sec1.nii
# 3dresample -master ${resDir}/pb2199_VisCR_DiffVarMasked+tlrc -prefix ${projDir}/ROI_masks/L_FF_Sec2_2mm.nii -input ${projDir}/ROI_masks/L_FF_Sec2.nii
# 3dresample -master ${resDir}/pb2199_VisCR_DiffVarMasked+tlrc -prefix ${projDir}/ROI_masks/R_FF_Sec2_2mm.nii -input ${projDir}/ROI_masks/R_FF_Sec2.nii
# 3dresample -master ${resDir}/pb2199_VisCR_DiffVarMasked+tlrc -prefix ${projDir}/ROI_masks/L_FF_Sec3_2mm.nii -input ${projDir}/ROI_masks/L_FF_Sec3.nii
# 3dresample -master ${resDir}/pb2199_VisCR_DiffVarMasked+tlrc -prefix ${projDir}/ROI_masks/R_FF_Sec3_2mm.nii -input ${projDir}/ROI_masks/R_FF_Sec3.nii
# 3dresample -master ${resDir}/pb2199_VisCR_DiffVarMasked+tlrc -prefix ${projDir}/ROI_masks/L_FF_Sec4_2mm.nii -input ${projDir}/ROI_masks/L_FF_Sec4.nii
# 3dresample -master ${resDir}/pb2199_VisCR_DiffVarMasked+tlrc -prefix ${projDir}/ROI_masks/R_FF_Sec4_2mm.nii -input ${projDir}/ROI_masks/R_FF_Sec4.nii


#T1
#Extract average variability within each ROI
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_var_IFG.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_var_IFG.sh     
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_var_STG.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_var_STG.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_var_TT.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_var_TT.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_var_wholeFF.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_var_wholeFF.sh  
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_var_FFsec1.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_var_FFsec1.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_var_FFsec2.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_var_FFsec2.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_var_FFsec3.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_var_FFsec3.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_var_FFsec4.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_var_FFsec4.sh 

#Extract mean activation within each ROI
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_mean_IFG.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_mean_IFG.sh     
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_mean_STG.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_mean_STG.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_mean_TT.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_mean_TT.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_mean_wholeFF.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_mean_wholeFF.sh  
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_mean_FFsec1.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_mean_FFsec1.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_mean_FFsec2.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_mean_FFsec2.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_mean_FFsec3.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_mean_FFsec3.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_mean_FFsec4.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_mean_FFsec4.sh
   


#T2
#Extract average variability within each ROI
#Will need to create the variability and maybe mean activation(?) maps for the T2 and T3 kids

#Timing Files
#Create the timing files for all participants from the NHLP_Eprime.R script on the shared drive under fMRI_ePrime_data/E-Prime/
#The timing files will be output to a folder there called "TimingFiles"
#Add new participants' timing files to $STORAGE/nhlp/scripts/stim_times_SDT folder
#Check the file count of the stim files for the new participants by running $STORAGE/nhlp/scripts/CheckStimFileCount.sh
	#and checking the new participants in CheckStimFileCount.txt. Missing timing files can be generated using
	#gen_missing_timing_files.sh

#Deconvolve
#For each participant, submits 3dDeconvolve scripts to slurm
# for aSub in $(cat ${nhlpDir}/scripts/subjectIDs/T2_T3_comb_2020-07-16.txt)
# do
#   	sbatch --out ${scriptDir}/slurm/Decon_VisVar/${aSub}_Decon_VarGAM_VisCR.out -J ${aSub}VisVar ${scriptDir}/202002/Decon_VarGAM_VisCR.sh $aSub
#   	sbatch --out ${scriptDir}/slurm/Decon_AudVar/${aSub}_Decon_VarGAM_AudCR.out -J ${aSub}AudVar ${scriptDir}/202002/Decon_VarGAM_AudCR.sh $aSub
#   	sbatch --out ${scriptDir}/slurm/Decon_FFVar/${aSub}_Decon_VarGAM_FFCR.out -J ${aSub}FFVar ${scriptDir}/202002/Decon_VarGAM_FFCR.sh $aSub
#   	sbatch --out ${scriptDir}/slurm/Decon_VocodVar/${aSub}_Decon_VarGAM_VocodCR.out -J ${aSub}VocodVar ${scriptDir}/202002/Decon_VarGAM_VocodCR.sh $aSub
#   	sbatch --out ${scriptDir}/slurm/Decon_Mean/${aSub}_Decon_MeanGAM.out -J ${aSub}Mean ${scriptDir}/202002/Decon_MeanGAM.sh $aSub
# done

#Check deconvolve files
#Reports the number of file types in the Deconvolve directory
# cbucketFiles_VisVar=$(ls ${projDir}/Decon_VisVar/cbucket/cbucket.*|wc -l)
# errtsFiles_VisVar=$(ls ${projDir}/Decon_VisVar/errts/errts.*|wc -l)
# fittsFiles_VisVar=$(ls ${projDir}/Decon_VisVar/fitts/fitts.*|wc -l)
# jpgFiles_VisVar=$(ls ${projDir}/Decon_VisVar/xjpeg/*.jpg|wc -l)
# echo "VisVar: ${cbucketFiles_VisVar} ${errtsFiles_VisVar} ${fittsFiles_VisVar} ${jpgFiles_VisVar}"
# cbucketFiles_AudVar=$(ls ${projDir}/Decon_AudVar/cbucket/cbucket.*|wc -l)
# errtsFiles_AudVar=$(ls ${projDir}/Decon_AudVar/errts/errts.*|wc -l)
# fittsFiles_AudVar=$(ls ${projDir}/Decon_AudVar/fitts/fitts.*|wc -l)
# jpgFiles_AudVar=$(ls ${projDir}/Decon_AudVar/xjpeg/*.jpg|wc -l)
# echo "AudVar: ${cbucketFiles_AudVar} ${errtsFiles_AudVar} ${fittsFiles_AudVar} ${jpgFiles_AudVar}"
# cbucketFiles_FFVar=$(ls ${projDir}/Decon_FFVar/cbucket/cbucket.*|wc -l)
# errtsFiles_FFVar=$(ls ${projDir}/Decon_FFVar/errts/errts.*|wc -l)
# fittsFiles_FFVar=$(ls ${projDir}/Decon_FFVar/fitts/fitts.*|wc -l)
# jpgFiles_FFVar=$(ls ${projDir}/Decon_FFVar/xjpeg/*.jpg|wc -l)
# echo "FFVar: ${cbucketFiles_FFVar} ${errtsFiles_FFVar} ${fittsFiles_FFVar} ${jpgFiles_FFVar}"
# cbucketFiles_VocodVar=$(ls ${projDir}/Decon_VocodVar/cbucket/cbucket.*|wc -l)
# errtsFiles_VocodVar=$(ls ${projDir}/Decon_VocodVar/errts/errts.*|wc -l)
# fittsFiles_VocodVar=$(ls ${projDir}/Decon_VocodVar/fitts/fitts.*|wc -l)
# jpgFiles_VocodVar=$(ls ${projDir}/Decon_VocodVar/xjpeg/*.jpg|wc -l)
# echo "VocodVar: ${cbucketFiles_VocodVar} ${errtsFiles_VocodVar} ${fittsFiles_VocodVar} ${jpgFiles_VocodVar}"
# cbucketFiles_Mean=$(ls ${projDir}/Decon_Mean/cbucket/cbucket.*|wc -l)
# errtsFiles_Mean=$(ls ${projDir}/Decon_Mean/errts/errts.*|wc -l)
# fittsFiles_Mean=$(ls ${projDir}/Decon_Mean/fitts/fitts.*|wc -l)
# jpgFiles_Mean=$(ls ${projDir}/Decon_Mean/xjpeg/*.jpg|wc -l)
# echo "Mean: ${cbucketFiles_Mean} ${errtsFiles_Mean} ${fittsFiles_Mean} ${jpgFiles_Mean}"

#Create difference of residuals variability maps
#For each participant, submits DOR scripts to slurm
# for aSub in $(cat ${nhlpDir}/scripts/subjectIDs/T2_T3_comb_2020-07-16.txt)
# do
#   	sbatch --out ${scriptDir}/slurm/Calc_Dor/${aSub}_Calc_DoR.out -J ${aSub}DoR ${scriptDir}/202002/Calc_DoR.sh $aSub
# done

#Check the difference of residuals maps
#Reports the number of maps
# DiffVarMasked=$(ls ${projDir}/ResVar_Maps/DiffVar/*DiffVarMasked+tlrc* |wc -l)
# echo "DiffVarMasked: ${DiffVarMasked}"

#T2 & T3
#Extract average variability within each ROI
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_var_IFG.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_var_IFG.sh     
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_var_STG.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_var_STG.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_var_TT.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_var_TT.sh
sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_var_wholeFF.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_var_wholeFF.sh  
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_var_FFsec1.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_var_FFsec1.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_var_FFsec2.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_var_FFsec2.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_var_FFsec3.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_var_FFsec3.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_var_FFsec4.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_var_FFsec4.sh 

#Extract mean activation within each ROI
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_mean_IFG.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_mean_IFG.sh     
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_mean_STG.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_mean_STG.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_mean_TT.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_mean_TT.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_mean_wholeFF.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_mean_wholeFF.sh  
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_mean_FFsec1.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_mean_FFsec1.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_mean_FFsec2.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_mean_FFsec2.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_mean_FFsec3.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_mean_FFsec3.sh
# sbatch --out ${scriptDir}/slurm/extract_ROIs/extract_ROIs_mean_FFsec4.out -J exROIsIFGVar ${scriptDir}/extract_ROIs/extract_ROIs_mean_FFsec4.sh
