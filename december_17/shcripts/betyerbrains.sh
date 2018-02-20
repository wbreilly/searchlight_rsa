#!/bin/sh
# export FREESURFER_HOME=/Applications/freesurfer
# source $FREESURFER_HOME/SetUpFreeSurfer.sh

for isub in s001 s002 s003 s004 s007 s008  s010 s011 s015 s016 s018 s019
	do
		bet /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty2/$isub/ssms* /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty2/$isub/$isub_bettedbrain -R -m
done

for isub in s001 s002 s003 s004 s007 s008  s010 s011 s015 s016 s018 s019
	do
		fslmaths /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty2/$isub/ssms* -mas /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty2/$isub/_mask.nii.gz /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty2/$isub/justbrain.nii.gz 
done

for isub in s001 s002 s003 s004 s007 s008  s010 s011 s015 s016 s018 s019
	do
		fast -g -p /Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty2/$isub/justbrain.nii.gz 
done