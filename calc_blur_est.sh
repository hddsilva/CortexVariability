#!/bin/bash
#Calculate blur estimates

procDir=$STORAGE/nhlp/processed
clustDir=$STORAGE/nhlp/projects/FastLoc/DysCorVar/Rest_MVM/ClustSim
IDs=$STORAGE/nhlp/scripts/subjectIDs

aSub=$1

3dFWHMx -demed -acf -mask ${procDir}/${aSub}/${aSub}.rest/full_mask.${aSub}+tlrc \
${procDir}/${aSub}/${aSub}.rest/errts.${aSub}.fanaticor+tlrc >> ${clustDir}/blur_est_new/${aSub}.blur.err.acf.1D
1dcat ${clustDir}/blur_est_new/${aSub}.blur.err.acf.1D'[0..$]{1}' >> ${clustDir}/blurerrts_acf_all_new.1D

