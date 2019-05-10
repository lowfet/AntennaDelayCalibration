clear;close all;

% A1T0P=xlsread('./Data/位置测试数据20180223/A1-T0-P.csv');
% A2T0P=xlsread('./Data/位置测试数据20180223/A2-T0-P.csv');
% A3T0P=xlsread('./Data/位置测试数据20180223/A3-T0-P.csv');

% load positiondata.mat
load F4_positiondata_20180418.mat

pA0x=1.425;pA0y=2.85;
pA1x=0;pA1y=0;
pA2x=2.85;pA2y=0;
pT0P1xreal=1.9;pT0P1yreal=0.95;
pT0P2xreal=1.9;pT0P2yreal=1.9;
pT0P3xreal=0.95;pT0P3yreal=1.9;
pT0P4xreal=0.95;pT0P4yreal=0.95;

%SDS-TWR Calibration
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

%ADS-TWR Calibration
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

%ADS-TWR Calibration
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


%A0T0P1 A0T0P2 A0T0P3 A0T0P4
%A1T0P1 A1T0P2 A1T0P3 A1T0P4
%A2T0P1 A2T0P2 A2T0P3 A2T0P4

A0T0PSET={A0T0P1,A0T0P2,A0T0P3,A0T0P4};
A1T0PSET={A1T0P1,A1T0P2,A1T0P3,A1T0P4};
A2T0PSET={A2T0P1,A2T0P2,A2T0P3,A2T0P4};

% distanceA0T0
for i=1:4
    A0T0P=A0T0PSET{i};
    A1T0P=A1T0PSET{i};
    A2T0P=A2T0PSET{i};

    [dA1T0rough,~]=cal_ADSTWR_distance(A0T0P(1:500,:),32950);
    [dA2T0rough,~]=cal_ADSTWR_distance(A1T0P(1:500,:),32950);
    [dA3T0rough,~]=cal_ADSTWR_distance(A2T0P(1:500,:),32950);
    dmeanA0T0rough(i,:)=[mean(dA1T0rough),mean(dA2T0rough),mean(dA3T0rough)];
    
%     [dA1T0offical,~]=caldistance(A0T0P(1:500,:),dA0_T0_SDS);
%     [dA2T0offical,~]=caldistance(A1T0P(1:500,:),dA1_T0_SDS);
%     [dA3T0offical,~]=caldistance(A2T0P(1:500,:),dA2_T0_SDS);
    [dA1T0offical,~]=cal_ADSTWR_distance(A0T0P(1:500,:),dA0_SDS+dT0_SDS);
    [dA2T0offical,~]=cal_ADSTWR_distance(A1T0P(1:500,:),dA1_SDS+dT0_SDS);
    [dA3T0offical,~]=cal_ADSTWR_distance(A2T0P(1:500,:),dA2_SDS+dT0_SDS);

%     [dA1T0offical,~]=caldistance(A0T0P(1:500,:),dA0_ADS+dT0_ADS);
%     [dA2T0offical,~]=caldistance(A1T0P(1:500,:),dA1_ADS+dT0_ADS);
%     [dA3T0offical,~]=caldistance(A2T0P(1:500,:),dA2_ADS+dT0_ADS);
    dmeanA0T0offical(i,:)=[mean(dA1T0offical),mean(dA2T0offical),mean(dA3T0offical)];
    
%     [dA1T0mine,~]=caldistance(A0T0P(1:500,:),dA0_T0_ADS);
%     [dA2T0mine,~]=caldistance(A1T0P(1:500,:),dA1_T0_ADS);
%     [dA3T0mine,~]=caldistance(A2T0P(1:500,:),dA2_T0_ADS);
    [dA1T0mine,~]=cal_ADSTWR_distance(A0T0P(1:500,:),dA0_ADS+dT0_ADS);
    [dA2T0mine,~]=cal_ADSTWR_distance(A1T0P(1:500,:),dA1_ADS+dT0_ADS);
    [dA3T0mine,~]=cal_ADSTWR_distance(A2T0P(1:500,:),dA2_ADS+dT0_ADS);
    dmeanA0T0mine(i,:)=[mean(dA1T0mine),mean(dA2T0mine),mean(dA3T0mine)];
    
    pT0rough(i,:)=cal_Position(dmeanA0T0rough(i,1),dmeanA0T0rough(i,2),dmeanA0T0rough(i,3));
    pT0offical(i,:)=cal_Position(dmeanA0T0offical(i,1),dmeanA0T0offical(i,2),dmeanA0T0offical(i,3));
    pT0bmine(i,:)=cal_Position(dmeanA0T0mine(i,1),dmeanA0T0mine(i,2),dmeanA0T0mine(i,3));
end

label_size=15;
fig=figure(1)
plot(pT0rough(:,1),pT0rough(:,2),'xb',pT0offical(:,1),pT0offical(:,2),'xg',pT0bmine(:,1),pT0bmine(:,2),'xm',...
pT0P1xreal,pT0P1yreal,'ok',pT0P2xreal,pT0P2yreal,'ok',pT0P3xreal,pT0P3yreal,'ok',pT0P4xreal,pT0P4yreal,'ok',...
pA0x,pA0y,'*r',pA1x,pA1y,'*r',pA2x,pA2y,'*r','LineWidth',2);
set(gca,'xlim',[-0.5 3.3],'ylim',[-0.5 3.3],'FontName','Times New Roman','FontSize',label_size,'FontWeight','bold');
text(pA0x-0.08,pA0y-0.1,'A0')
text(pA1x-0.08,pA1y-0.1,'A1')
text(pA2x-0.08,pA2y-0.1,'A2')
text(pT0P1xreal+0.2,pT0P1yreal-0.1,'P1')
text(pT0P2xreal+0.2,pT0P2yreal+0.1,'P2')
text(pT0P3xreal-0.2,pT0P3yreal+0.1,'P3')
text(pT0P4xreal-0.2,pT0P4yreal-0.1,'P4')

xlabel('X(m)','FontName','Times New Roman','FontSize',label_size,'FontWeight','bold');
ylabel('Y(m)','FontName','Times New Roman','FontSize',label_size,'FontWeight','bold');
legend('Rough Calibration','Offical Calibration','Proposed Calibration','Real Position')

saveas(fig,['Result/Position_test_' num2str(i) '.emf']);

pT0real=[pT0P1xreal,pT0P1yreal;pT0P2xreal,pT0P2yreal;pT0P3xreal,pT0P3yreal;pT0P4xreal,pT0P4yreal];

error_rough=pT0rough-pT0real;
error_square_rough=sqrt(error_rough(:,1).^2+error_rough(:,2).^2)

error_offical=pT0offical-pT0real;
error_square_offical=sqrt(error_offical(:,1).^2+error_offical(:,2).^2)

error_mine=pT0bmine-pT0real;
error_square_mine=sqrt(error_mine(:,1).^2+error_mine(:,2).^2)

