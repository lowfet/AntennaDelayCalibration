clear all;close all;
% A0_A1=xlsread('./Data/校准数据20180223/A0-A1.csv');
% A0_A2=xlsread('./Data/校准数据20180223/A0-A2.csv');
% A0_T0=xlsread('./Data/校准数据20180223/A0-T0.csv');
% A1_A2=xlsread('./Data/校准数据20180223/A1-A2.csv');
% A1_T0=xlsread('./Data/校准数据20180223/A1-T0.csv');
% A2_T0=xlsread('./Data/校准数据20180223/A2-T0.csv');
load F0_calibrationdata.mat
realdistance=2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%使用SDS-TWR校准后的参数begin%%%%%%%%%%%%%%%%%%%%%%%%%%
dA0_SDS = 16452.8802175173;
dA1_SDS = 16420.5444747771;
dA2_SDS = 16426.6429448168;
dT0_SDS = 16430.6351611433;
dA0_A1_SDS=3.287944002379190e+04;
dA0_A2_SDS=3.288105355547225e+04;
dA0_T0_SDS=3.287596965402482e+04;
dA1_A2_SDS=3.283964169495806e+04;
dA1_T0_SDS=3.285271002905857e+04;
dA2_T0_SDS=3.286329343745758e+04;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%使用SDS-TWR校准后的参数end%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%使用ADS-TWR校准后的参数begin%%%%%%%%%%%%%%%%%%%%%%%%%%
% 这是以前论文公式错误时得出的数据 no use
% dA0_ADS = 16438.1042265310;
% dA1_ADS = 16428.8414021527;
% dA2_ADS = 16426.6723093124;
% dT0_ADS = 16439.1476999241;
% dA0_A1_ADS=3.286587345991266e+04;
% dA0_A2_ADS=3.287092032231401e+04;
% dA0_T0_ADS=3.287218030875541e+04;
% dA1_A2_ADS=3.285044209376539e+04;
% dA1_T0_ADS=3.287413288854748e+04;
% dA2_T0_ADS=3.286474784046557e+04;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%使用ADS-TWR校准后的参数end%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%使用ADS-TWR 修正校准后的参数begin%%%%%%%%%%%%%%%%%%%%%%%%%%
dA0_ADS = 16447.3173507987;
dA1_ADS = 16433.3472850481;
dA2_ADS = 16438.9628782449;
dT0_ADS = 16446.7539518769;
dA0_A1_ADS=[32883.2168198808];
dA0_A2_ADS=[32888.2690141552];
dA0_T0_ADS=[32889.5303335300];
dA1_A2_ADS=[32867.7691941474];
dA1_T0_ADS=[32882.0900220365];
dA2_T0_ADS=[32888.2690141558];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%使用ADS-TWR 修正校准后的参数end%%%%%%%%%%%%%%%%%%%%%%%%%%

datalength=900;
%未校准结果
[Dis_A0_A1(1,:),~]=cal_ADSTWR_distance(A0_A1(1:datalength,:),0);
[Dis_A0_A2(1,:),~]=cal_ADSTWR_distance(A0_A2(1:datalength,:),0);
[Dis_A0_T0(1,:),~]=cal_ADSTWR_distance(A0_T0(1:datalength,:),0);
[Dis_A1_A2(1,:),~]=cal_ADSTWR_distance(A1_A2(1:datalength,:),0);
[Dis_A1_T0(1,:),~]=cal_ADSTWR_distance(A1_T0(1:datalength,:),0);
[Dis_A2_T0(1,:),~]=cal_ADSTWR_distance(A2_T0(1:datalength,:),0);

%粗校准结果
[Dis_A0_A1(2,:),~]=cal_ADSTWR_distance(A0_A1(1:datalength,:),32899);
[Dis_A0_A2(2,:),~]=cal_ADSTWR_distance(A0_A2(1:datalength,:),32899);
[Dis_A0_T0(2,:),~]=cal_ADSTWR_distance(A0_T0(1:datalength,:),32899);
[Dis_A1_A2(2,:),~]=cal_ADSTWR_distance(A1_A2(1:datalength,:),32899);
[Dis_A1_T0(2,:),~]=cal_ADSTWR_distance(A1_T0(1:datalength,:),32899);
[Dis_A2_T0(2,:),~]=cal_ADSTWR_distance(A2_T0(1:datalength,:),32899);

%精校准结果_官方校准
[Dis_A0_A1(3,:),~]=cal_ADSTWR_distance(A0_A1(1:900,:),dA0_SDS+dA1_SDS);
[Dis_A0_A2(3,:),~]=cal_ADSTWR_distance(A0_A2(1:900,:),dA0_SDS+dA2_SDS);
[Dis_A0_T0(3,:),~]=cal_ADSTWR_distance(A0_T0(1:900,:),dA0_SDS+dT0_SDS);
[Dis_A1_A2(3,:),~]=cal_ADSTWR_distance(A1_A2(1:900,:),dA1_SDS+dA2_SDS);
[Dis_A1_T0(3,:),~]=cal_ADSTWR_distance(A1_T0(1:900,:),dA1_SDS+dT0_SDS);
[Dis_A2_T0(3,:),~]=cal_ADSTWR_distance(A2_T0(1:900,:),dA2_SDS+dT0_SDS);

%精校准结果_所提校准方法
[Dis_A0_A1(4,:),~]=cal_ADSTWR_distance(A0_A1(1:900,:),dA0_ADS+dA1_ADS);
[Dis_A0_A2(4,:),~]=cal_ADSTWR_distance(A0_A2(1:900,:),dA0_ADS+dA2_ADS);
[Dis_A0_T0(4,:),~]=cal_ADSTWR_distance(A0_T0(1:900,:),dA0_ADS+dT0_ADS);
[Dis_A1_A2(4,:),~]=cal_ADSTWR_distance(A1_A2(1:900,:),dA1_ADS+dA2_ADS);
[Dis_A1_T0(4,:),~]=cal_ADSTWR_distance(A1_T0(1:900,:),dA1_ADS+dT0_ADS);
[Dis_A2_T0(4,:),~]=cal_ADSTWR_distance(A2_T0(1:900,:),dA2_ADS+dT0_ADS);

%最佳拟合结果_官方校准
[Dis_A0_A1(5,:),~]=cal_ADSTWR_distance(A0_A1(1:900,:),dA0_A1_SDS);
[Dis_A0_A2(5,:),~]=cal_ADSTWR_distance(A0_A2(1:900,:),dA0_A2_SDS);
[Dis_A0_T0(5,:),~]=cal_ADSTWR_distance(A0_T0(1:900,:),dA0_T0_SDS);
[Dis_A1_A2(5,:),~]=cal_ADSTWR_distance(A1_A2(1:900,:),dA1_A2_SDS);
[Dis_A1_T0(5,:),~]=cal_ADSTWR_distance(A1_T0(1:900,:),dA1_T0_SDS);
[Dis_A2_T0(5,:),~]=cal_ADSTWR_distance(A2_T0(1:900,:),dA2_T0_SDS);

%最佳拟合结果__所提校准方法
[Dis_A0_A1(6,:),~]=cal_ADSTWR_distance(A0_A1(1:900,:),dA0_A1_ADS);
[Dis_A0_A2(6,:),~]=cal_ADSTWR_distance(A0_A2(1:900,:),dA0_A2_ADS);
[Dis_A0_T0(6,:),~]=cal_ADSTWR_distance(A0_T0(1:900,:),dA0_T0_ADS);
[Dis_A1_A2(6,:),~]=cal_ADSTWR_distance(A1_A2(1:900,:),dA1_A2_ADS);
[Dis_A1_T0(6,:),~]=cal_ADSTWR_distance(A1_T0(1:900,:),dA1_T0_ADS);
[Dis_A2_T0(6,:),~]=cal_ADSTWR_distance(A2_T0(1:900,:),dA2_T0_ADS);

for i=1:6
    t=1:length(Dis_A0_A1);
    fig=figure(i);
    pointout(:,1)=Dis_A0_A1(i,:)-realdistance;
    pointout(:,2)=Dis_A0_A2(i,:)-realdistance;
    pointout(:,3)=Dis_A0_T0(i,:)-realdistance;
    pointout(:,4)=Dis_A1_A2(i,:)-realdistance;
    pointout(:,5)=Dis_A1_T0(i,:)-realdistance;
    pointout(:,6)=Dis_A2_T0(i,:)-realdistance;
    
    label_size=15;
    if i==1
        plot(t,pointout(:,1),'r',t,pointout(:,2),'b',t,pointout(:,3),'g',t,pointout(:,4),'c',t,pointout(:,5),'m',t,pointout(:,6),'y');
        hold on;
        set(gca,'xlim',[0 900],'FontName','Times New Roman','FontSize',label_size,'FontWeight','bold');
    else
        plot(t,pointout(:,1),'r',t,pointout(:,2),'b',t,pointout(:,3),'g',t,pointout(:,4),'c',t,pointout(:,5),'m',t,pointout(:,6),'y',t,zeros(length(Dis_A0_A1),1),'--k');
        hold on;
        set(gca,'xlim',[0 900],'FontName','Times New Roman','FontSize',label_size,'FontWeight','bold');
    end
    
    xlabel('Time Samples','FontName','Times New Roman','FontSize',label_size,'FontWeight','bold');
    ylabel('Error(m)','FontName','Times New Roman','FontSize',label_size,'FontWeight','bold');
    legend('A0->A1','A0->A2','A0->T0','A1->A2','A1->T0','A2->T0');
    saveas(fig,['Result/Distance_test_' num2str(i) '.emf']);
    
    for j=1:6
        meanerror(i,j)=mean(pointout(:,j));
    end
    
end

totalmeanerror=mean(meanerror');