% reslice gray matter masks

dataDir     = '/Users/wbr/walter/fmri/sms_scan_analyses/data_for_spm/batch_preproc_native_10_12_17';
subjects    = {'s001' 's002' 's003' 's004' 's007' 's008' 's010' 's011' 's015' 's016' 's018' 's019'};% 


% Loop over subjects
for isub = 2:length(subjects)
    b.curSubj   = subjects{isub};
    b.dataDir   = fullfile(dataDir, b.curSubj, '002_mprage_sag_NS_g3');
    
    %thesholded image from above 
    b.maskthresh    = cellstr(spm_select('ExtFPListRec', b.dataDir, '_mask.*.nii'));
    
    % mean image as the reference 
    path1 = '/Users/wbr/walter/fmri/sms_scan_analyses/data_for_spm/batch_preproc_native_10_12_17/';
    path2 = sprintf('Rifa_1/meanslicetime_%s.Rifa_1.bold.nii', b.curSubj);
    ref_img = fullfile(path1, b.curSubj, path2);
    
    %loop through masks

    matlabbatch{1}.spm.spatial.coreg.write.ref = cellstr(ref_img);
    matlabbatch{1}.spm.spatial.coreg.write.source = b.maskthresh;
    matlabbatch{1}.spm.spatial.coreg.write.roptions.interp = 0;
    matlabbatch{1}.spm.spatial.coreg.write.roptions.wrap = [0 0 0];
    matlabbatch{1}.spm.spatial.coreg.write.roptions.mask = 0;
    matlabbatch{1}.spm.spatial.coreg.write.roptions.prefix = 'reslice_';
    
    
    %run
    spm('defaults','fmri');
    spm_jobman('initcfg');
    spm_jobman('run',matlabbatch);
    
end % end isub


clear all
clc
keyboard

dataDir     = '/Users/wbr/walter/fmri/sms_scan_analyses/data_for_spm/batch_preproc_native_10_12_17';
subjects    = { 's002' 's003' 's004' 's007' 's008' 's010' 's011' 's015' 's016' 's018' 's019'};% 's001' 



% Loop over subjects
for isub = 1:length(subjects)
    b.curSubj   = subjects{isub};
    b.dataDir   = fullfile(dataDir, b.curSubj, '002_mprage_sag_NS_g3');
    b.mask      = cellstr(spm_select('ExtFPListRec', b.dataDir, 'reslice.*.nii'));
    
    
    %%
    matlabbatch{1}.spm.util.imcalc.input = cellstr(b.mask);
    %%
    matlabbatch{1}.spm.util.imcalc.output = 'spm_gray_thresh_reslice';
    matlabbatch{1}.spm.util.imcalc.outdir = cellstr(b.dataDir);
    matlabbatch{1}.spm.util.imcalc.expression = 'i1 > .05';
    matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
    matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
    matlabbatch{1}.spm.util.imcalc.options.mask = 0;
    matlabbatch{1}.spm.util.imcalc.options.interp = 0;
    matlabbatch{1}.spm.util.imcalc.options.dtype = 16;

    spm('defaults','fmri');
    spm_jobman('initcfg');
    spm_jobman('run',matlabbatch);
end % end isub

clear all
clc



