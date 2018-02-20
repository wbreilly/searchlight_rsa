#!/bin/sh
export FREESURFER_HOME=/Applications/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh


# concatenate all subjects' gray masks
fslmerge -t /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/mni_stuff/group_gray_mask.nii.gz /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/*/normalized_reslice__mask.nii

# take the temporal mean
fslmaths /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/mni_stuff/group_gray_mask.nii.gz -Tmean /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/mni_stuff/group_gray_mask_tmean.nii.gz

# threshold
fslmaths /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/mni_stuff/group_gray_mask_tmean.nii.gz -thr 1 /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/mni_stuff/group_gray_mask_tmean_thresh.nii.gz

# conc the tmaps
fslmerge -t /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/mni_stuff/group_tmaps.nii.gz /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/*/normalized_s0*.nii 

# pad to make SPM MNI space FSL MNI compatible
#tmaps
flirt -in /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/mni_stuff/group_tmaps.nii.gz -ref /usr/local/fsl/data/standard/MNI152_T1_2mm_brain_mask.nii.gz -out /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/mni_stuff/group_tmaps_fslified.nii.gz
# and mask


# flirt -in /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/mni_stuff/group_tmaps.nii.gz -ref /usr/local/fsl/data/standard/MNI152_T1_2mm_brain_mask.nii.gz -out /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/mni_stuff/group_tmaps_fslified.nii.gz

# randomise
randomise -i /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/mni_stuff/group_tmaps.nii.gz -o /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/mni_stuff/tfce_v5smooth -m /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/mni_stuff/group_brain_mask_spmmean.nii -1 -v 5 -T


/Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/mni_stuff/group_brain_mask_spmmean.nii,1
# standard
/usr/local/fsl/data/standard/MNI152_T1_2mm_brain_mask.nii.gz

flirt -in /usr/local/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz  -ref /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/mni_stuff/group_brain_mask_spmmean.nii -out /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/mni_stuff/MNI_2mm__brain_spmified.nii.gz















