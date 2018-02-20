% Control script to run fMRISearchlight for every subject on betas within
% each condition
% 1_14_17

%  for loop around fMRISearchlight, subj needs to change, and condition
%  label needs to go into .mat file 
% use a flag/counter to run for each sub the different conditions
clear all;
clc;
close all;

subjects = {'s001' 's002' 's003' 's004' 's007' 's008' 's010' 's011' 's015' 's016' 's018' 's019'}; %'s009'

global subjects;
global isub;
global itri;
global cond_flag

% loop through subjects
for isub = 1:length(subjects)
    % loop through conditions (which are groups of trials) 
    for itri = 1:3
        cond_flag = itri;
        % do the stuff
        Recipe_fMRI_searchlight;
    end % end itri
end % end isub


