#!/bin/bash

FN_MASK="$STORAGE/nhlp/masks/TT_N27_mask_2mm+tlrc"

3dClustSim -mask ${FN_MASK} -acf 0.7160 5.9809 15.5112 \
-LOTS -niml -both -prefix $STORAGE/nhlp/projects/FastLoc/DysCorVar/Rest_MVM/ClustSim/EquivRest_errts_ClustSim