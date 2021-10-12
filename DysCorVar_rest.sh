#!/bin/bash

nhlpDir=$STORAGE/nhlp
projDir=$STORAGE/nhlp/projects/FastLoc/DysCorVar
scriptDir=$STORAGE/nhlp/scripts/FastLoc/DysCorVar
clustDir=$STORAGE/nhlp/projects/FastLoc/DysCorVar/Rest_MVM/ClustSim
resDir=${projDir}/202002/ResVar_Maps/DiffVar
sumaDir=~/suma_TT_N27
IDs=$STORAGE/nhlp/scripts/subjectIDs


#Right fusiform segment 4 is too large to use as an ROI for the resting state analysis

#Find the center of mass for right fusiform segment 4
#3dclust -1thresh 0 2 2 'R_FFsec4_2mm.nii'
#Center of Mass: -28.0 RL, 68.2 AP, -14.9 IS

#Create an 8mm spherical mask centered on the above center of mass
#Followed instructions here: https://blog.cogneurostats.com/2014/02/05/advanced-creation-of-rois-in-afni/
# 3dcalc -a R_FFsec4_2mm.nii \
# -prefix R_FFsec4_8mmSphere \
# -expr 'step(16-(x+28)*(x+28)-(y-68.2)*(y-68.2)-(z+14.9)*(z+14.9))'

#Find the resting state closest to the fastloc being used

#Check that everyone's been processed through anaticor
# for aSub in $(cat ${IDs}/EquivRest_mrrcIDs_2020-06-03.txt)
# do
#   	if test -n "$(find ${nhlpDir}/processed/${aSub}/${aSub}.rest/ -maxdepth 1 -name '*fanaticor*' -print -quit)"
#   	then
#     	echo "${aSub} anaticor found"
#     else
# 		echo "${aSub}" >> ${scriptDir}/anaticor_audit.txt
#     fi
# done

#Create the seed-based correlation maps
# for aSub in $(cat ${IDs}/EquivRest_mrrcIDs_2020-06-03.txt)
# do
# 	sbatch -J ${aSub} --out ${scriptDir}/slurm/seed_CorrelationMaps/${aSub}_calcs.txt ${scriptDir}/seed_CorrelationMaps.sh ${aSub}
# done

#Run an MVM
#sbatch --out ${scriptDir}/slurm/MVM.txt -J MVM ${scriptDir}/run_rest_MVM.sh

#Cluster Correction
##Calculate blur estimates
# for aSub in $(cat ${IDs}/EquivRest_mrrcIDs_2020-06-03.txt)
# do
# 	 sbatch --out ${scriptDir}/slurm/blur_est/${aSub}_calc_blur_est.txt -J ${aSub} ${scriptDir}/calc_blur_est.sh ${aSub}
# done


##Find the acf parameters to input into 3dClustSim
#1d_tool.py -show_mmms -infile ${clustDir}/blurerrts_acf_all.1D >> acf_parameters.txt

##Run ClustSim
#sbatch --out ${scriptDir}/slurm/ClustSim.txt -J ClustSim ${scriptDir}/ClustSim.sh

# Add to ClustSim results to MVM
3drefit -atrstring AFNI_CLUSTSIM_NN1_1sided file:${clustDir}/EquivRest_errts_ClustSim.NN1_1sided.niml \
  -atrstring AFNI_CLUSTSIM_MASK file:${clustDir}/EquivRest_errts_ClustSim.mask \
  -atrstring AFNI_CLUSTSIM_NN2_1sided file:${clustDir}/EquivRest_errts_ClustSim.NN2_1sided.niml \
  -atrstring AFNI_CLUSTSIM_NN3_1sided file:${clustDir}/EquivRest_errts_ClustSim.NN3_1sided.niml \
  -atrstring AFNI_CLUSTSIM_NN1_2sided file:${clustDir}/EquivRest_errts_ClustSim.NN1_2sided.niml \
  -atrstring AFNI_CLUSTSIM_NN2_2sided file:${clustDir}/EquivRest_errts_ClustSim.NN2_2sided.niml \
  -atrstring AFNI_CLUSTSIM_NN3_2sided file:${clustDir}/EquivRest_errts_ClustSim.NN3_2sided.niml \
  -atrstring AFNI_CLUSTSIM_NN1_bisided file:${clustDir}/EquivRest_errts_ClustSim.NN1_bisided.niml \
  -atrstring AFNI_CLUSTSIM_NN2_bisided file:${clustDir}/EquivRest_errts_ClustSim.NN2_bisided.niml \
  -atrstring AFNI_CLUSTSIM_NN3_bisided file:${clustDir}/EquivRest_errts_ClustSim.NN3_bisided.niml \
${projDir}/Rest_MVM/RestCorrelationMaps_RFFsec4Seed+tlrc

