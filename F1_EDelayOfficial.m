clear
clc
load F0_calibrationdata.mat
DWT_TIME_UNITS=(1.0/499.2e6/128.0);
SPEED_OF_LIGHT=2.997106669589869e+08;
%%%%%%%%%和延迟的关系
fitdata=A0_A1;%3.287944002379190e+04
% fitdata=A0_A2;%3.288105355547225e+04
% fitdata=A0_T0;%3.287596965402482e+04
% fitdata=A1_A2;%3.283964169495806e+04
% fitdata=A1_A3;%3.287944002379190e+04
% fitdata=A1_T0;%3.285271002905857e+04
% fitdata=A2_A3;%3.288105355547225e+04
% fitdata=A2_T0;%3.286329343745758e+04
% fitdata=A3_T0;%3.287596965402482e+04
fitreal=2;

distance=cal_SDSTWR_distance(fitdata,0);
error=fitreal-distance;
% fit=sum(abs(error)/length(distance));
value=EDelayLSM(distance,fitreal)/DWT_TIME_UNITS/SPEED_OF_LIGHT;value
% 
% for i=1:100
%    
%     
%     
%     distance=cal_SDSTWR_distance(fitdata,tdelay);
%     error=Tr-distance;
%     fit=sum(abs(error)/length(distance));
% 
% end