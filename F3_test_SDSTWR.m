clear all;close all;
% A0_A1=xlsread('./Data/校准数据20180223/A0-A1.csv');
% A0_A2=xlsread('./Data/校准数据20180223/A0-A2.csv');
% A0_T0=xlsread('./Data/校准数据20180223/A0-T0.csv');
% A1_A2=xlsread('./Data/校准数据20180223/A1-A2.csv');
% A1_T0=xlsread('./Data/校准数据20180223/A1-T0.csv');
% A2_T0=xlsread('./Data/校准数据20180223/A2-T0.csv');
load calibrationdata.mat
realdistance=2;

dA0_A1_SDS=3.287944002379190e+04;
dA0_A2_SDS=3.288105355547225e+04;
dA0_T0_SDS=3.287596965402482e+04;
dA1_A2_SDS=3.283964169495806e+04;
dA1_T0_SDS=3.285271002905857e+04;
dA2_T0_SDS=3.286329343745758e+04;

dA1_A3_SDS=3.287944002379190e+04;
dA2_A3_SDS=3.288105355547225e+04;
dA3_T0_SDS=3.287596965402482e+04;
%32899
%1.029741336137821e-06

%未校准结果
% [Dis_A0_A1,~]=cal_SDSTWR_distance(A0_A1(1:900,:),0);
% [Dis_A0_A2,~]=cal_SDSTWR_distance(A0_A2(1:900,:),0);
% [Dis_A0_T0,~]=cal_SDSTWR_distance(A0_T0(1:900,:),0);
% [Dis_A1_A2,~]=cal_SDSTWR_distance(A1_A2(1:900,:),0);
% [Dis_A1_T0,~]=cal_SDSTWR_distance(A1_T0(1:900,:),0);
% [Dis_A2_T0,~]=cal_SDSTWR_distance(A2_T0(1:900,:),0);

%粗校准结果
% [Dis_A0_A1,~]=cal_SDSTWR_distance(A0_A1(1:900,:),32899);
% [Dis_A0_A2,~]=cal_SDSTWR_distance(A0_A2(1:900,:),32899);
% [Dis_A0_T0,~]=cal_SDSTWR_distance(A0_T0(1:900,:),32899);
% [Dis_A1_A2,~]=cal_SDSTWR_distance(A1_A2(1:900,:),32899);
% [Dis_A1_T0,~]=cal_SDSTWR_distance(A1_T0(1:900,:),32899);
% [Dis_A2_T0,~]=cal_SDSTWR_distance(A2_T0(1:900,:),32899);

%精校准结果
% [Dis_A0_A1,~]=cal_SDSTWR_distance(A0_A1(1:900,:),dA0_SDS+dA1_SDS);
% [Dis_A0_A2,~]=cal_SDSTWR_distance(A0_A2(1:900,:),dA0_SDS+dA2_SDS);
% [Dis_A0_T0,~]=cal_SDSTWR_distance(A0_T0(1:900,:),dA0_SDS+dT0_SDS);
% [Dis_A1_A2,~]=cal_SDSTWR_distance(A1_A2(1:900,:),dA1_SDS+dA2_SDS);
% [Dis_A1_T0,~]=cal_SDSTWR_distance(A1_T0(1:900,:),dA1_SDS+dT0_SDS);
% [Dis_A2_T0,~]=cal_SDSTWR_distance(A2_T0(1:900,:),dA2_SDS+dT0_SDS);

%最佳拟合结果
[Dis_A0_A1,~]=cal_SDSTWR_distance(A0_A1(1:900,:),dA0_A1_SDS);
[Dis_A0_A2,~]=cal_SDSTWR_distance(A0_A2(1:900,:),dA0_A2_SDS);
[Dis_A0_T0,~]=cal_SDSTWR_distance(A0_T0(1:900,:),dA0_T0_SDS);
[Dis_A1_A2,~]=cal_SDSTWR_distance(A1_A2(1:900,:),dA1_A2_SDS);
[Dis_A1_T0,~]=cal_SDSTWR_distance(A1_T0(1:900,:),dA1_T0_SDS);
[Dis_A2_T0,~]=cal_SDSTWR_distance(A2_T0(1:900,:),dA2_T0_SDS);

t=1:length(Dis_A0_A1);
figure(1);
pointout(:,1)=Dis_A0_A1-realdistance;
pointout(:,2)=Dis_A0_A2-realdistance;
pointout(:,3)=Dis_A0_T0-realdistance;
pointout(:,4)=Dis_A1_A2-realdistance;
pointout(:,5)=Dis_A1_T0-realdistance;
pointout(:,6)=Dis_A2_T0-realdistance;
plot(t,pointout(:,1),'r',t,pointout(:,2),'b',t,pointout(:,3),'g',t,pointout(:,4),'c',t,pointout(:,5),'m',t,pointout(:,6),'y',t,zeros(length(Dis_A0_A1),1),'--k');
% axis([0 900 -0.3 0.05]);
% axis([0 900 153.8 154.5]);
xlabel('Time Samples');ylabel('Error(m)');
legend('A0->A1','A0->A2','A0->T0','A1->A2','A1->T0','A2->T0')

for i=1:6
    meanerror(i)=mean(pointout(:,i));
end
totalmeanerror=mean(meanerror);

