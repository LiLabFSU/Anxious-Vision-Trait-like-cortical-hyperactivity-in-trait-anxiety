clear;
load('Exp4_data.mat');
chans = [1:96];  %All channels
Oz = [30:32];
sub_ID = [1:3 5:6 8:15 17:22 24:25 27:39 41:46];

for s = 1:length(sub_ID) %Subject Loop
    for chan = 1:length(Oz)  %Estimate power for each individual channel
        LSF_data_erp{s,1}(chan,:,:) = LSF_EEG{s,1}(Oz(chan),52:129,:);%0ms~300ms
        HSF_data_erp{s,1}(chan,:,:) = HSF_EEG{s,1}(Oz(chan),52:129,:);
    end
end

for s = 1:length(sub_ID) %Subject Loop
    LSF_data_erp_epoch{s,1} = squeeze(mean(LSF_data_erp{s,1},3));
    HSF_data_erp_epoch{s,1} = squeeze(mean(HSF_data_erp{s,1},3));
end

for s = 1:length(sub_ID) %Subject Loop
    LSF_data_erp_Oz{s,1} = squeeze(mean(LSF_data_erp_epoch{s,1},1));
    HSF_data_erp_Oz{s,1} = squeeze(mean(HSF_data_erp_epoch{s,1},1));
end

LSF_erpdata = [];
HSF_erpdata = [];
for s = 1:length(sub_ID) 
    LSF_erpdata = [LSF_erpdata;LSF_data_erp_Oz{s,1}];
    HSF_erpdata = [HSF_erpdata;HSF_data_erp_Oz{s,1}];
end
time_erp = times(52:129);

LSF_ERP = mean(LSF_erpdata,1);
HSF_ERP = mean(HSF_erpdata,1);

figure(4);
hold on
axis on;
title('0-0.3 ERP average reference');
plot(time_erp,LSF_ERP,'Color','#0072BD');
plot(time_erp,HSF_ERP,'Color','#EDB120');
legend('LSF','HSF');
xlabel('Time(ms)');
ylabel('Amplitude');
xlim([-110 310]);
ylim([-1 9]);
xticks([-100 0 100 200 300]); 
set(gca, 'XAxisLocation', 'origin','YAxisLocation', 'origin');

%% P1 amplitude calculation

%100-135 ms for LSF/HSF P1

LSF_P1 = mean(LSF_erpdata(:,27:36),2);
HSF_P1 = mean(HSF_erpdata(:,27:36),2);