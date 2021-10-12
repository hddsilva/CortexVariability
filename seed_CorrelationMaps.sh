#!/bin/bash

nhlpDir=$STORAGE/nhlp
projDir=$STORAGE/nhlp/projects/FastLoc/DysCorVar

aSub=$1

#Make correlation maps
# echo "Making correlation maps for ${aSub}"
# 3dmaskave -quiet -mask ${projDir}/ROI_masks/R_FFsec4_8mmSphere+tlrc \
# 	${nhlpDir}/processed/${aSub}/${aSub}.rest/errts.${aSub}.fanaticor+tlrc > ${projDir}/seed_ts/${aSub}_R_FFsec4.1D
# 3dDeconvolve -input ${nhlpDir}/processed/${aSub}/${aSub}.rest/errts.${aSub}.fanaticor+tlrc \
# 	-censor ${nhlpDir}/processed/${aSub}/${aSub}.rest/censor_${aSub}_combined_2.1D \
# 	-num_stimts 1 \
# 	-stim_file 1 ${projDir}/seed_ts/${aSub}_R_FFsec4.1D -stim_label 1 SeedCorr \
# 	-tout -rout -fitts ${projDir}/CorrelationMaps/${aSub}_RFFsec4_fit+tlrc \
# 	-bucket ${projDir}/CorrelationMaps/${aSub}_RFFsec4_correl+tlrc
3dcalc -a ${projDir}/CorrelationMaps/${aSub}_RFFsec4_correl+tlrc'[4]' \
 -b ${projDir}/CorrelationMaps/${aSub}_RFFsec4_correl+tlrc'[2]' \
 -expr 'ispositive(b)*sqrt(a)-isnegative(b)*sqrt(a)' \
 -prefix ${projDir}/CorrelationMaps/${aSub}_RFFsec4_r
3dcalc -prefix ${projDir}/CorrelationMaps/${aSub}_RFFsec4_r2z \
 -a ${projDir}/CorrelationMaps/${aSub}_RFFsec4_r+tlrc \
 -expr 'atanh(a)'