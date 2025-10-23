clear;
%load resting-state data
load('epoched_resting_EO_EC_data.mat');
addpath('FOOOF\fooof_mat-main\fooof_mat');

% FOOOF settings
settings = struct(); % used by Donoghue et al 2020, p.14,EEG resting-state anaylsis
settings.peak_width_limts=[1,6];
settings.max_n_peaks=6;
settings.min_peak_height=0.05;
settings.peak_threshold=2.0;
settings.aperiodic_mode='fixed';%fixed,knee
f_range=[3,40];

subs = [9:50 52];% Subs with resting-state data
chans = [1:96];  %All channels
fs = [256]; %sampling rate of EEG data
NW = [2]; %taper parameter (NW*2 - 1 = # of tapers)
NFFT = [1024]; %frequency resolution parameter; "zero padding"

%% get unadjusted power spectrum of resting state

% EO
for s = 1:43 %Subject Loop
    for chan = chans  %Estimate power for each individual channel
                for epoch = 1:size(EO_data{s,1},3) %Estimate power for each epoch; EEG.epoch is an index of epoch numbers
                    window = EO_data{s,1}(chan,:,epoch);   %-0.5~0.5s

                    freq_range = [13:161];   %Define the frequency range you want to use to normalize (3-40 Hz at frequency resolution of .25 Hz = 13:161)

                    [power,f] = pmtm(window,NW,NFFT,fs);  %This line performs the multitaper spectral estimation to give you the power for each frequency
                    powerd = double(power);   %This converts power values to double precision (some matlab transformations require double precision)

                    EEG_range = mean(powerd(freq_range));    %Average of power spectra used for normalizing data; defined in line 25

                    normalized_power = powerd/EEG_range; %Normalizes power spectra by dividing by average of power defined in line 25, generated in line 30

                    EO_raw_power_spectrum{s,1}(chan,:,epoch) = powerd;
                    EO_norm_power_spectrum{s,1}(chan,:,epoch) = normalized_power;
                end
    end
end

%% calculate aperiodic paramters of each participants

center_chans = [1,2,11,38,51,63,70,84,85];

%average across all epochs
for s = 1:43
    EO_allchan{s,1} = squeeze(mean(EO_raw_power_spectrum{s,1},3));
end

%cacluate aperiodic parameters for central electrodes
for s = 1:43
    EO_cent_sub{s,1} = mean(EO_allchan{s,1}(center_chans,:),1);
end
                   
for s = 1:43
    EO_ap_parameter = fooof(f,EO_cent_sub{s,1},f_range,settings,false);
%     EO_ap_fit(s,1) = EO_ap_parameter.r_squared;
    EO_ap_parameter_cent(s,1) = EO_ap_parameter.aperiodic_params(1);%offset
    EO_ap_parameter_cent(s,2) = EO_ap_parameter.aperiodic_params(2);%exp
end
