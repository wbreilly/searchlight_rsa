% Mask searchlight RDMs and create contrast image for SVSS (same verb, same sequence)
% After masking within intact and scrambled for a sub, ttest at every voxel
% and the contrast image will consist of those t values 

% A1Day1
clear all;
clc;
close all;
subjects = {'s001' 's002' 's003' 's004' 's007' 's008' 's009' 's010'...
            's011' 's015' 's016' 's018' 's019'};
        
% load and prepare trial mask 
load('SVSS.mat');
SVSS=SVSS(1:90,1:90);

% loop through subjects
for isub = 2:length(subjects)
    try
        % load intact RDMs
        loadthis = sprintf('RDMs/%s_c1_15_18_fMRISearchlight_RDMs.mat', subjects{isub});
        load(loadthis);

        % get the RDMs in a nice 5d array with a simple name
        x = struct2array(searchlightRDMs);

        % convert to similarity
        x = -1.*(x-1);

        % could apply the mask to x(:,:,1,1,1) some other way..
    %     x =  bsxfun(@times, x, cast(SVSS,class(x)));
        % this is easier
        x(:,:,1,1,1) = double(SVSS);

        % reshape into voxel by trial 2d array
        intact_brains = zeros(90,155648);
        count = 1;
        for irow = 1:size(x,1)
            for icol = 1:size(x,2)
                if x(irow,icol,1,1,1) == 1
                    intact_brains(count,:) = reshape(squeeze(x(irow,icol,:,:,:)),155648,1)';
                    count = count + 1;
                end
            end
        end

        clear loadthis x searchlightRDMs

        %%
        % load scrambled RDMs
        loadthis = sprintf('RDMs/%s_c3_15_18_fMRISearchlight_RDMs.mat', subjects{isub});
        load(loadthis);

        % get the RDMs in a nice 5d array with a simple name
        x = struct2array(searchlightRDMs);

        % convert to similarity
        x = -1.*(x-1);

        % could apply the mask to x(:,:,1,1,1) some other way..
    %     x =  bsxfun(@times, x, cast(SVSS,class(x)));
        % this is easier
        x(:,:,1,1,1) = double(SVSS);

        % reshape into voxel by trial 2d array
        scrambled_brains = zeros(90,155648);
        count = 1;
        for irow = 1:size(x,1)
            for icol = 1:size(x,2)
                if x(irow,icol,1,1,1) == 1
                    scrambled_brains(count,:) = reshape(squeeze(x(irow,icol,:,:,:)),155648,1)';
                    count = count + 1;
                end
            end
        end
        %%
        clear loadthis x searchlightRDMs


        %tmap brain
        tmap = NaN(1,155648);

        for ivox = 1:155648
            % try becuase for voxels outside gray matter mask everything is a
            % NaN and ttest will error out
            try
                % ttest at every voxel between intact SVSS trials and scrambled
                % SVSS trials
                [h, p, c, stat] = ttest(intact_brains(:,ivox),scrambled_brains(:,ivox));
                % put the tvalues in a vector that will be reshaped back into a
                % brain. Now have one tmap brain per subject
                tmap(ivox) = stat.tstat;
            end %try
            clear h p c stat
        end %ivox


        %make it 3d again
        tmap = reshape(tmap',64,64,38);

        %% final step is write it to nii in subject space

        % mean epi that will steal header info from to write nii in register
        path1 = '/Users/wbr/walter/fmri/sms_scan_analyses/data_for_spm/batch_preproc_native_10_12_17/';
        path2 = sprintf('Rifa_1/meanslicetime_%s.Rifa_1.bold.nii', subjects{isub});
        mean_img = fullfile(path1, subjects{isub}, path2);
        mean_img = spm_vol(mean_img);
        % copy header/other nii info 
        tmapnii = mean_img;
        % name of the tmap nii file
        niiname = sprintf('%s_tmap.nii',subjects{isub});
        tmapnii.fname = niiname;
        % write the mat array tmap to nii, which will be in register with
        % sub's mean epi and therefore mprage
        spm_write_vol(tmapnii,tmap);
        
    catch
        fprintf('Error!! %s had a problem!!\n\n',subjects{isub})
    end %try
    
end % end isub


    