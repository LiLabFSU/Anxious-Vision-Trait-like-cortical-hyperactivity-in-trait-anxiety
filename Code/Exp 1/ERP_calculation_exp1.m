clear;
load('Exp1_T1_T2_T3_data.mat');
chans = [1:96];  %All channels
Oz = [31:33];

subs = [1:47];
T1_subs_num = [1:47];
T3_sub = [1:4 7:8 10:11 13:16 18:23 25:26 29:34 36:42 44:45 47];
time_erp = times(206:334);%-0.2 -0.3s

for s = subs %Subject Loop
    for chan = 1:length(Oz)  %Estimate power for each individual channel
        for block = 1:3
            if block == 3 & ismember(s,T3_sub) == 0
                continue
            else
                color_data_erp{s,block}(chan,:,:) = color_data{s,block}(Oz(chan),206:334,:);
                gray_data_erp{s,block}(chan,:,:) = gray_data{s,block}(Oz(chan),206:334,:);
            end
        end
    end
end

for s = subs %Subject Loop
    for block = 1:3
        if block == 3 & ismember(s,T3_sub) == 0
           continue
        else
           color_data_erp_epoch{s,block} = squeeze(mean(color_data_erp{s,block},3));
           gray_data_erp_epoch{s,block} = squeeze(mean(gray_data_erp{s,block},3));
        end
    end
end

for s = subs %Subject Loop
    for block = 1:3
        if block == 3 & ismember(s,T3_sub) == 0
           continue
        else
           color_data_erp_Oz{s,block} = squeeze(mean(color_data_erp_epoch{s,block},1));
           gray_data_erp_Oz{s,block} = squeeze(mean(gray_data_erp_epoch{s,block},1));
        end
    end
end

gray_erpdata_T1 = [];
gray_erpdata_T2 = [];
gray_erpdata_T3 = [];
color_erpdata_T1 = [];
color_erpdata_T2 = [];
color_erpdata_T3 = [];
for s = subs
    gray_erpdata_T1 = [gray_erpdata_T1;gray_data_erp_Oz{s,1}];
    gray_erpdata_T2 = [gray_erpdata_T2;gray_data_erp_Oz{s,2}];
    color_erpdata_T1 = [color_erpdata_T1;color_data_erp_Oz{s,1}];
    color_erpdata_T2 = [color_erpdata_T2;color_data_erp_Oz{s,2}];
end
for s = T3_sub
    gray_erpdata_T3 = [gray_erpdata_T3;gray_data_erp_Oz{s,3}];
    color_erpdata_T3 = [color_erpdata_T3;color_data_erp_Oz{s,3}];
end

T1_gray = mean(gray_erpdata_T1,1);
T2_gray = mean(gray_erpdata_T2,1);
T3_gray = mean(gray_erpdata_T3,1);
T1_color = mean(color_erpdata_T1,1);
T2_color = mean(color_erpdata_T2,1);
T3_color = mean(color_erpdata_T3,1);

figure(1);
hold on
axis on;
title('T1 ERP');
plot(time_erp,T1_gray,'Color','#0072BD');
plot(time_erp,T1_color,'Color','#EDB120');
xlabel('Time(s)');
ylabel('Amplitude');
xlim([-210 310]);
% ylim([-5 5]);
xticks([-200 -100 0 100 200 300]); 
set(gca, 'XAxisLocation', 'origin','YAxisLocation', 'origin');

figure(2);
hold on
axis on;
title('T2 ERP');
plot(time_erp,T2_gray,'Color','#0072BD');
plot(time_erp,T2_color,'Color','#EDB120');
xlabel('Time(s)');
ylabel('Amplitude');
xlim([-210 310]);
% ylim([-5 5]);
xticks([-200 -100 0 100 200 300]); 
set(gca, 'XAxisLocation', 'origin','YAxisLocation', 'origin');

figure(3);
hold on
axis on;
title('T3 ERP');
plot(time_erp,T3_gray,'Color','#0072BD');
plot(time_erp,T3_color,'Color','#EDB120');
xlabel('Time(s)');
ylabel('Amplitude');
xlim([-210 310]);
% ylim([-5 5]);
xticks([-200 -100 0 100 200 300]); 
set(gca, 'XAxisLocation', 'origin','YAxisLocation', 'origin');
%% point-by-point correlation of BIS VS ERP
BIS = readtable('C:\Users\zwu2\Desktop\ERP_Yuqi\Experiment 4\Step 1 pre_sti resting para\ap_parameters.xlsx');
%correlation between gray and color
R_GC = [];
P_GC = [];
for po = 1:length(time_erp)
[R,P] = corrcoef(gray_erpdata_T1(:,po),color_erpdata_T1(:,po),"Rows","pairwise");
R_GC = [R_GC,R(1,2)];
P_GC = [P_GC,P(1,2)];
end
%plot point-by-point result
figure(4);
x = time_erp(52:129);
for po = 1:length(x)
    p_thresh(1,po) = 0.05;
end
hold on; 
title('T1 gray&color ERP coorelation')
plot(x,R_GC(52:129),'Color','#EDB120');
plot(x,P_GC(52:129),'Color','#0072BD');
plot(x,p_thresh,'--k');
% legend('R color','P color','R gray','P gray','P=0.05');
legend('R GC','P GC','P=0.05');
xlabel('Time(ms)');
set(gca, 'XAxisLocation', 'origin','YAxisLocation', 'origin');



%T1
R_gray_all = [];
P_gray_all = [];
R_color_all = [];
P_color_all = [];
for po = 1:length(time_erp)
[R,P] = corrcoef(gray_erpdata_T1(:,po),BIS.BIS,"Rows","pairwise");
R_gray_all = [R_gray_all,R(1,2)];
P_gray_all = [P_gray_all,P(1,2)];
end
for po = 1:length(time_erp)
[R,P] = corrcoef(color_erpdata_T1(:,po),BIS.BIS,"Rows","pairwise");
R_color_all = [R_color_all,R(1,2)];
P_color_all = [P_color_all,P(1,2)];
end
%plot point-by-point result
figure(4);
x = time_erp(52:129);
for po = 1:length(x)
    p_thresh(1,po) = 0.05;
end
hold on; 
title('T1 Oz Gray ERP VS BIS ')
plot(x,R_gray_all(52:129),'Color','#EDB120');
plot(x,P_gray_all(52:129),'Color','#0072BD');
% plot(x,R_interact_gray_T1,'Color','#D95319');
% plot(x,P_interact_gray_T1,'Color','#7E2F8E');
plot(x,p_thresh,'--k');
% legend('R color','P color','R gray','P gray','P=0.05');
legend('R gray','P gray','P=0.05');
xlabel('Time(ms)');
set(gca, 'XAxisLocation', 'origin','YAxisLocation', 'origin');



figure(4);
x = time_erp(52:129);
for po = 1:length(x)
    p_thresh(1,po) = 0.05;
end
hold on; 
title('T1 Oz color ERP VS BIS ')
plot(x,R_color_all(52:129),'Color','#EDB120');
plot(x,P_color_all(52:129),'Color','#0072BD');
% plot(x,R_interact_gray_T1,'Color','#D95319');
% plot(x,P_interact_gray_T1,'Color','#7E2F8E');
plot(x,p_thresh,'--k');
% legend('R color','P color','R gray','P gray','P=0.05');
legend('R color','P color','P=0.05');
xlabel('Time(ms)');
set(gca, 'XAxisLocation', 'origin','YAxisLocation', 'origin');

%T2
R_gray_T2 = [];
P_gray_T2 = [];
R_color_T2= [];
P_color_T2 = [];
for po = 1:length(time_erp)
[R,P] = corrcoef(gray_erpdata_T2(:,po),BIS.BIS,"Rows","pairwise");
R_gray_T2 = [R_gray_T2,R(1,2)];
P_gray_T2 = [P_gray_T2,P(1,2)];
end
for po = 1:length(time_erp)
[R,P] = corrcoef(color_erpdata_T2(:,po),BIS.BIS,"Rows","pairwise");
R_color_T2 = [R_color_T2,R(1,2)];
P_color_T2 = [P_color_T2,P(1,2)];
end
%plot point-by-point result


figure(5);
x = time_erp(52:129);
for po = 1:length(x)
    p_thresh(1,po) = 0.05;
end
hold on; 
title('T2 Oz color ERP VS BIS ')
plot(x,R_color_T2(52:129),'Color','#EDB120');
plot(x,P_color_T2(52:129),'Color','#0072BD');
% plot(x,R_interact_gray_T1,'Color','#D95319');
% plot(x,P_interact_gray_T1,'Color','#7E2F8E');
plot(x,p_thresh,'--k');
% legend('R color','P color','R gray','P gray','P=0.05');
legend('R color','P color','P=0.05');
xlabel('Time(ms)');
set(gca, 'XAxisLocation', 'origin','YAxisLocation', 'origin');

%T3
R_gray_T3 = [];
P_gray_T3 = [];
R_color_T3= [];
P_color_T3 = [];
BIS_T3 = BIS.BIS(T3_sub);
for po = 1:length(time_erp)
[R,P] = corrcoef(gray_erpdata_T3(:,po),BIS_T3,"Rows","pairwise");
R_gray_T3 = [R_gray_T3,R(1,2)];
P_gray_T3 = [P_gray_T3,P(1,2)];
end
for po = 1:length(time_erp)
[R,P] = corrcoef(color_erpdata_T3(:,po),BIS_T3,"Rows","pairwise");
R_color_T3 = [R_color_T3,R(1,2)];
P_color_T3 = [P_color_T3,P(1,2)];
end
%plot point-by-point result


figure(6);
x = time_erp(52:129);
for po = 1:length(x)
    p_thresh(1,po) = 0.05;
end
hold on; 
title('T3 Oz color ERP VS BIS ')
plot(x,R_color_T3(52:129),'Color','#EDB120');
plot(x,P_color_T3(52:129),'Color','#0072BD');
% plot(x,R_interact_gray_T1,'Color','#D95319');
% plot(x,P_interact_gray_T1,'Color','#7E2F8E');
plot(x,p_thresh,'--k');
% legend('R color','P color','R gray','P gray','P=0.05');
legend('R color','P color','P=0.05');
xlabel('Time(ms)');
set(gca, 'XAxisLocation', 'origin','YAxisLocation', 'origin');

%% ERP for each participant
% time -0.2-0.3s
%113 – 148 ms P1
%117 – 152 ms N1
%89 - 121 ms C1
%82- 117 ms C1 test
%74 - 152 ms for C1-N1 complex
for s = subs
%       P1_T1(s,:) = gray_data_erp_Oz{s,1}(81:90);
%       P1_T2(s,:) = gray_data_erp_Oz{s,2}(81:90);
%     N1_T1(s,:) = color_data_erp_Oz{s,1}(82:91);
%     N1_T2(s,:) = color_data_erp_Oz{s,2}(82:91);
%       C1_T1(s,:) = color_data_erp_Oz{s,1}(75:83);
%       C1_T2(s,:) = color_data_erp_Oz{s,2}(75:83);
%       C1_test_T1(s,:) = color_data_erp_Oz{s,1}(73:82);
%       C1_test_T2(s,:) = color_data_erp_Oz{s,2}(73:82);
        C1N1_T1(s,:) = color_data_erp_Oz{s,1}(71:91);
        C1N1_T2(s,:) = color_data_erp_Oz{s,2}(71:91);
end

P1_T1_sub = mean(P1_T1,2);
P1_T2_sub = mean(P1_T2,2);
[T1_P1_corr,T1_P1_corr_p] =corrcoef(P1_T1_sub,BIS.BIS,"Rows","pairwise");
[T2_P1_corr,T2_P1_corr_p] =corrcoef(P1_T2_sub,BIS.BIS,"Rows","pairwise");
% N1_T1_sub = mean(N1_T1,2);
% N1_T2_sub = mean(N1_T2,2);
% C1_T1_sub = mean(C1_T1,2);
% C1_T2_sub = mean(C1_T2,2);
% [T1_C1_corr,T1_C1_corr_p] =corrcoef(C1_T1_sub,BIS.BIS,"Rows","pairwise");
% [T2_C1_corr,T2_C1_corr_p] =corrcoef(C1_T2_sub,BIS.BIS,"Rows","pairwise");
C1N1_T1_sub = mean(C1N1_T1,2);
C1N1_T2_sub = mean(C1N1_T2,2);
[T1_C1N1_corr,T1_C1N1_corr_p] =corrcoef(C1N1_T1_sub,BIS.BIS,"Rows","pairwise");
[T2_C1N1_corr,T2_C1N1_corr_p] =corrcoef(C1N1_T2_sub,BIS.BIS,"Rows","pairwise");

C1_test_T1_sub = mean(C1_test_T1,2);
C1_test_T2_sub = mean(C1_test_T2,2);
[T1_C1_test_corr,T1_C1_test_corr_p] =corrcoef(C1_test_T1_sub,BIS.BIS,"Rows","pairwise");
[T2_C1_test_corr,T2_C1_test_corr_p] =corrcoef(C1_test_T2_sub,BIS.BIS,"Rows","pairwise");

for s = 1:length(T3_sub)
%     C1_T3(s,:) = color_data_erp_Oz{T1_T2_overlap(s),3}(75:83);
%     P1_T3(s,:) = gray_data_erp_Oz{T1_T2_overlap(s),3}(81:90);
%       C1_test_T3(s,:) = color_data_erp_Oz{T1_T2_overlap(s),3}(73:82);
      C1N1_T3(s,:) = color_data_erp_Oz{T3_sub(s),3}(71:91);
end
C1_test_T3_sub = mean(C1_test_T3,2);
P1_T3_sub = mean(P1_T3,2);
BIS_T3 = BIS.BIS(T3_sub);

C1N1_T3_sub = mean(C1N1_T3,2);
[T3_C1N1_corr,T3_C1N1_corr_p] =corrcoef(C1N1_T3_sub,BIS_T3,"Rows","pairwise");

[T3_C1_test_corr,T3_C1_test_corr_p] =corrcoef(C1_test_T3_sub,BIS_T3,"Rows","pairwise");
[T3_P1_corr,T3_P1_corr_p] =corrcoef(P1_T3_sub,BIS_T3,"Rows","pairwise");
% P1_T3 = NaN(47,10);
% N1_T3 = NaN(47,10);
% 
% for s = T1_T2_overlap
%     P1_T3(s,:) = gray_data_erp_Oz{s,3}(81:90);
%     N1_T3(s,:) = color_data_erp_Oz{s,3}(82:91);
% end
% 
% P1_T3_sub = mean(P1_T3,2,'omitnan');
% N1_T3_sub = mean(N1_T3,2,'omitnan');
%% average ERP of all 3 conditions
gray_all = [];
color_all = [];
for s = subs %Subject Loop
    for block = 1:3
        if block == 3 & ismember(s,T3_sub) == 0
           continue
        else
            gray_all = [gray_all;gray_data_erp_Oz{s,block}];
            color_all = [color_all;color_data_erp_Oz{s,block}];
        end
    end
end

all_gray = mean(gray_all,1);
all_color = mean(color_all,1);

figure(7);
hold on
axis on;
title('ERP of 3 conds');
plot(time_erp,all_gray,'Color','#0072BD');
plot(time_erp,all_color,'Color','#EDB120');
xlabel('Time(s)');
ylabel('Amplitude');
xlim([-210 310]);
ylim([-5 5]);
xticks([-200 -100 0 100 200 300]); 
set(gca, 'XAxisLocation', 'origin','YAxisLocation', 'origin');

BIS = readtable('C:\Users\zwu2\Desktop\ERP_Yuqi\Experiment 4\Step 1 pre_sti resting para\ap_parameters.xlsx');



gray_erpdata_T3 = zeros(47,129);
color_erpdata_T3 = zeros(47,129);
for s = T3_sub
    gray_erpdata_T3(s,:) = gray_data_erp_Oz{s,3};
    color_erpdata_T3(s,:) = color_data_erp_Oz{s,3};
end

gray_erp_all = zeros(47,129);
color_erp_all = zeros(47,129);
for s = subs %Subject Loop
    for time = 1:129
        if  ismember(s,T3_sub) == 0
           gray_erp_all(s,time) = (gray_erpdata_T1(s,time) + gray_erpdata_T2(s,time))/2;
           color_erp_all(s,time) = (color_erpdata_T1(s,time) + color_erpdata_T2(s,time))/2;
        else
           gray_erp_all(s,time) = (gray_erpdata_T1(s,time) + gray_erpdata_T2(s,time) + gray_erpdata_T3(s,time))/3;
           color_erp_all(s,time) = (color_erpdata_T1(s,time) + color_erpdata_T2(s,time) + color_erpdata_T3(s,time))/3;
        end
    end
end
save('C:\Users\zwu2\Desktop\ERP_Yuqi\Result writing\Exp 4\all conds erp.mat','color_erp_all',"gray_erp_all");
%Point by point
R_gray_all = [];
P_gray_all = [];
R_color_all = [];
P_color_all = [];
for po = 1:length(time_erp)
[R,P] = corrcoef(gray_erp_all(:,po),BIS.BIS,"Rows","pairwise");
R_gray_all = [R_gray_all,R(1,2)];
P_gray_all = [P_gray_all,P(1,2)];
end
for po = 1:length(time_erp)
[R,P] = corrcoef(color_erp_all(:,po),BIS.BIS,"Rows","pairwise");
R_color_all = [R_color_all,R(1,2)];
P_color_all = [P_color_all,P(1,2)];
end
%plot point-by-point result


figure(8);
x = time_erp(52:129);
for po = 1:length(x)
    p_thresh(1,po) = 0.05;
end
hold on; 
title('all 3 conds Oz color ERP VS BIS ')
plot(x,R_color_all(52:129),'Color','#EDB120');
plot(x,P_color_all(52:129),'Color','#0072BD');
% plot(x,R_interact_gray_T1,'Color','#D95319');
% plot(x,P_interact_gray_T1,'Color','#7E2F8E');
plot(x,p_thresh,'--k');
% legend('R color','P color','R gray','P gray','P=0.05');
legend('R color','P color','P=0.05');
xlabel('Time(ms)');
set(gca, 'XAxisLocation', 'origin','YAxisLocation', 'origin');

%82- 113 ms C1 (73:81)
%78- 109 ms C1 (72:80)
%78- 101 ms C1 (72:78)
%82- 101 ms C1 (73:78)
for s = subs
%        P1_all(s,:) = gray_erp_all(s,73:81);
       C1_all(s,:) = color_erp_all(s,73:78);
end

% P1_all_sub = mean(P1_all,2);
% [all_P1_corr,all_P1_corr_p] =corrcoef(P1_all_sub,BIS.BIS,"Rows","pairwise");
C1_all_sub = mean(C1_all,2);
[all_C1_corr,all_C1_corr_p] =corrcoef(C1_all_sub,BIS.BIS,"Rows","pairwise");
