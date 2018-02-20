%-----------------------------------------------------------------------
% Job saved on 25-Jan-2018 12:31:26 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6906)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
%%
matlabbatch{1}.spm.util.imcalc.input = {
                                        '/Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/s001/normalized_reslice__mask.nii,1'
                                        '/Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/s002/normalized_reslice__mask.nii,1'
                                        '/Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/s003/normalized_reslice__mask.nii,1'
                                        '/Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/s004/normalized_reslice__mask.nii,1'
                                        '/Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/s007/normalized_reslice__mask.nii,1'
                                        '/Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/s008/normalized_reslice__mask.nii,1'
                                        '/Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/s010/normalized_reslice__mask.nii,1'
                                        '/Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/s011/normalized_reslice__mask.nii,1'
                                        '/Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/s015/normalized_reslice__mask.nii,1'
                                        '/Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/s016/normalized_reslice__mask.nii,1'
                                        '/Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/s018/normalized_reslice__mask.nii,1'
                                        '/Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty3/s019/normalized_reslice__mask.nii,1'
                                        };
%%
matlabbatch{1}.spm.util.imcalc.output = 'group_brain_mask_spmmean.nii';
matlabbatch{1}.spm.util.imcalc.outdir = {'/Users/wbr/walter/fmri/sms_scan_analyses/searchlight_rsa/december_17/nifty2/mni_stuff'};
matlabbatch{1}.spm.util.imcalc.expression = 'i1 .* i2 .* i3 .* i4 .* i5 .* i6 .* i7  .* i8 .* i9 .* i10 .* i11 .* i12';
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 0;
matlabbatch{1}.spm.util.imcalc.options.dtype = 16;

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);