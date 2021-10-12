#!/bin/bash

projectpath="$STORAGE/nhlp/projects/FastLoc/DysCorVar"
FN_MASK="$STORAGE/nhlp/masks/TT_N27_mask_2mm+tlrc"

module load R/3.4.1-foss-2016b
module load Python/2.7.13-foss-2016b

cd ${projectpath}/Rest_MVM/

3dMVM -prefix ${projectpath}/Rest_MVM/RestCorrelationMaps_RFFsec4Seed+tlrc \
-jobs 20 \
-mask $FN_MASK \
-bsVars "RU1m1*age_mri+SESComposite+Comp_1+Comp_2+Comp_3+average_motion_per_TR" \
-qVars "age_mri,Comp_1,Comp_2,Comp_3,average_motion_per_TR" \
-num_glt 6 \
-gltLabel 1 RU1m1_0 -gltCode 1 'RU1m1: 1*No' \
-gltLabel 2 RU1m1_1 -gltCode 2 'RU1m1: 1*Yes' \
-gltLabel 3 RU1m1_1vs0 -gltCode 3 'RU1m1: 1*Yes -1*No' \
-gltLabel 4 age -gltCode 4 'age_mri :' \
-gltLabel 5 SES_1vs0 -gltCode 5 'SESComposite : 1*Yes -1*No' \
-gltLabel 6 motion -gltCode 6 'average_motion_per_TR :' \
-dataTable @Rest_MVM_DataTable.txt 