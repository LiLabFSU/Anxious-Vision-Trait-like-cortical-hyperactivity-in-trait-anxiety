clear;
load('Exp2_task_data.mat');
chans = [1:96];  %All channels
Oz = [30:32];
P7 = [14:16 20:22];
P8 = [48:50 54:56];

subs = [1:52];

for s = subs% column 1: magnocellular-left,column 2: magnocellular-right,column 3: parvocellular-central
    ml_mr_pc_data{s,1} = ml_EEG{s,1};
    ml_mr_pc_data{s,2} = mr_EEG{s,1};
    ml_mr_pc_data{s,3} = pc_EEG{s,1};
end

%% Oz chans ERP plot
for s = subs %Subject Loop
    for cond = 1:3
        for chan = 1:length(Oz)  %Estimate power for each individual channel
            ml_mr_pc_data_Oz{s,cond}(chan,:,:) = ml_mr_pc_data{s,cond}(Oz(chan),:,:);
        end
    end
end

for s = subs %Subject Loop
    for cond = 1:3
        ml_mr_pc_data_Oz_epoch{s,cond} = squeeze(mean(ml_mr_pc_data_Oz{s,cond},3));
    end
end

for s = subs %Subject Loop
    for cond = 1:3
        ml_mr_pc_data_Oz_erp{s,cond} = mean(ml_mr_pc_data_Oz_epoch{s,cond},1);
    end
end

ml_ERP_Oz = zeros(1,104);
mr_ERP_Oz = zeros(1,104);
pc_ERP_Oz = zeros(1,104);

for s = subs %-100ms~300ms
    ml_ERP_Oz = ml_ERP_Oz + ml_mr_pc_data_Oz_erp{s,1}(1,231:334);
    mr_ERP_Oz = mr_ERP_Oz + ml_mr_pc_data_Oz_erp{s,2}(1,231:334);
    pc_ERP_Oz = pc_ERP_Oz + ml_mr_pc_data_Oz_erp{s,3}(1,231:334);
end

ml_ERP_Oz = ml_ERP_Oz/52;
mr_ERP_Oz = mr_ERP_Oz/52;
pc_ERP_Oz = pc_ERP_Oz/52;

time_erp = times(231:334);

figure;
hold on
axis on;
title('-0.1-0.3 ERP average reference Oz chan');
plot(time_erp,ml_ERP_Oz,'Color','#0072BD');
plot(time_erp,mr_ERP_Oz,'Color','#EDB120');
plot(time_erp,pc_ERP_Oz,'Color','#D95319');
legend('ML','MR','PC');
xlabel('Time(ms)');
ylabel('Amplitude');
xlim([-110 310]);
ylim([-6 1]);
xticks([-100 0 100 200 300]); 
set(gca, 'XAxisLocation', 'origin','YAxisLocation', 'origin');
%% P7 chans ERP plot
for s = subs %Subject Loop
    for cond = 1:3
        for chan = 1:length(P7)  %Estimate power for each individual channel
            ml_mr_pc_data_P7{s,cond}(chan,:,:) = ml_mr_pc_data{s,cond}(P7(chan),:,:);
        end
    end
end

for s = subs %Subject Loop
    for cond = 1:3
        ml_mr_pc_data_P7_epoch{s,cond} = squeeze(mean(ml_mr_pc_data_P7{s,cond},3));
    end
end

for s = subs %Subject Loop
    for cond = 1:3
        ml_mr_pc_data_P7_erp{s,cond} = mean(ml_mr_pc_data_P7_epoch{s,cond},1);
    end
end

ml_ERP_P7 = zeros(1,104);
mr_ERP_P7 = zeros(1,104);
pc_ERP_P7 = zeros(1,104);

for s = subs %-100ms~300ms
    ml_ERP_P7 = ml_ERP_P7 + ml_mr_pc_data_P7_erp{s,1}(1,231:334);
    mr_ERP_P7 = mr_ERP_P7 + ml_mr_pc_data_P7_erp{s,2}(1,231:334);
    pc_ERP_P7 = pc_ERP_P7 + ml_mr_pc_data_P7_erp{s,3}(1,231:334);
end

ml_ERP_P7 = ml_ERP_P7/52;
mr_ERP_P7 = mr_ERP_P7/52;
pc_ERP_P7 = pc_ERP_P7/52;

time_erp = times(231:334);

figure;
hold on
axis on;
title('-0.1-0.3 ERP average reference P7 chan');
plot(time_erp,ml_ERP_P7,'Color','#0072BD');
plot(time_erp,mr_ERP_P7,'Color','#EDB120');
plot(time_erp,pc_ERP_P7,'Color','#D95319');
legend('ML','MR','PC');
xlabel('Time(ms)');
ylabel('Amplitude');
xlim([-110 310]);
ylim([-2 2]);
xticks([-100 0 100 200 300]); 
set(gca, 'XAxisLocation', 'origin','YAxisLocation', 'origin');
%% P8 chans ERP plot
for s = subs %Subject Loop
    for cond = 1:3
        for chan = 1:length(P8)  %Estimate power for each individual channel
            ml_mr_pc_data_P8{s,cond}(chan,:,:) = ml_mr_pc_data{s,cond}(P8(chan),:,:);
        end
    end
end

for s = subs %Subject Loop
    for cond = 1:3
        ml_mr_pc_data_P8_epoch{s,cond} = squeeze(mean(ml_mr_pc_data_P8{s,cond},3));
    end
end

for s = subs %Subject Loop
    for cond = 1:3
        ml_mr_pc_data_P8_erp{s,cond} = mean(ml_mr_pc_data_P8_epoch{s,cond},1);
    end
end

ml_ERP_P8 = zeros(1,104);
mr_ERP_P8 = zeros(1,104);
pc_ERP_P8 = zeros(1,104);

for s = subs %-100ms~300ms
    ml_ERP_P8 = ml_ERP_P8 + ml_mr_pc_data_P8_erp{s,1}(1,231:334);
    mr_ERP_P8 = mr_ERP_P8 + ml_mr_pc_data_P8_erp{s,2}(1,231:334);
    pc_ERP_P8 = pc_ERP_P8 + ml_mr_pc_data_P8_erp{s,3}(1,231:334);
end

ml_ERP_P8 = ml_ERP_P8/52;
mr_ERP_P8 = mr_ERP_P8/52;
pc_ERP_P8 = pc_ERP_P8/52;

time_erp = times(231:334);

figure;
hold on
axis on;
title('-0.1-0.3 ERP average reference P8 chan');
plot(time_erp,ml_ERP_P8,'Color','#0072BD');
plot(time_erp,mr_ERP_P8,'Color','#EDB120');
plot(time_erp,pc_ERP_P8,'Color','#D95319');
legend('ML','MR','PC');
xlabel('Time(ms)');
ylabel('Amplitude');
xlim([-110 310]);
ylim([-2 3]);
xticks([-100 0 100 200 300]); 
set(gca, 'XAxisLocation', 'origin','YAxisLocation', 'origin');
%% ERP for each participant
% time -0.1-0.3s
%P1: 125-160 ms at P7, 121-156 ms at P8, collapsed across the two sites
%62 - 86 ms for PC C1

for s = subs
    ML_P1_P7(s,:) = ml_mr_pc_data_P7_erp{s,1}(289:298);
    MR_P1_P8(s,:) = ml_mr_pc_data_P8_erp{s,2}(288:297);
    PC_C1_Oz(s,:) = ml_mr_pc_data_Oz_erp{s,3}(273:279);
end

ML_P1_P7_sub = mean(ML_P1_P7,2);
MR_P1_P8_sub = mean(MR_P1_P8,2);
P1_sub = (ML_P1_P7_sub+MR_P1_P8_sub)/2;
PC_C1_Oz_sub = mean(PC_C1_Oz,2);