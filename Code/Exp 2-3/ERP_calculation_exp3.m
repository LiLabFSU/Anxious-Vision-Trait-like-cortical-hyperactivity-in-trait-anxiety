clear;
load('Exp3_task_data.mat');
chans = [1:96];  %All channels
Oz = [30:32];
fs = [256]; %sampling rate of EEG data
NW = [2]; %taper parameter (NW*2 - 1 = # of tapers)
NFFT = [1024]; %frequency resolution parameter; "zero padding"

subs = [1:52];

for s = subs %Subject Loop
    for chan = 1:length(Oz)  %Estimate power for each individual channel
        LSF_data_erp{s,1}(chan,:,:) = LSF_EEG{s,1}(Oz(chan),:,:);
        HSF_data_erp{s,1}(chan,:,:) = HSF_EEG{s,1}(Oz(chan),:,:);
    end
end

for s = subs %Subject Loop
    LSF_data_erp_epoch{s,1} = squeeze(mean(LSF_data_erp{s,1},3));
    HSF_data_erp_epoch{s,1} = squeeze(mean(HSF_data_erp{s,1},3));
end

for s = subs %Subject Loop
    LSF_data_erp_Oz{s,1} = squeeze(mean(LSF_data_erp_epoch{s,1},1));
    HSF_data_erp_Oz{s,1} = squeeze(mean(HSF_data_erp_epoch{s,1},1));
end

LSF_ERP = zeros(1,104);
HSF_ERP = zeros(1,104);

for s = subs %-100ms~300ms
    LSF_ERP = LSF_ERP + LSF_data_erp_Oz{s,1}(1,231:334);
    HSF_ERP = HSF_ERP + HSF_data_erp_Oz{s,1}(1,231:334);
end

LSF_ERP = LSF_ERP/52;
HSF_ERP = HSF_ERP/52;

time_erp = times(231:334);

figure(4);
hold on
axis on;
title('-1.0-0.4 ERP average reference');
plot(time_erp,LSF_ERP,'Color','#0072BD');
plot(time_erp,HSF_ERP,'Color','#EDB120');
legend('LSF','HSF');
xlabel('Time(ms)');
ylabel('Amplitude');
xlim([-110 310]);
ylim([-4 4]);
xticks([-100 0 100 200 300]); 
set(gca, 'XAxisLocation', 'origin','YAxisLocation', 'origin');

%% ERP for each participant
% time -0.1-0.3s
%86 – 121 ms for LSF P1 
%54 - 70 for HSF C1
for s = subs
    LSF_P1(s,:) = LSF_data_erp_Oz{s,1}(279:288);
    HSF_C1(s,:) = HSF_data_erp_Oz{s,1}(271:275);
end

LSF_P1_sub = mean(LSF_P1,2);
HSF_C1_sub = mean(HSF_C1,2);

