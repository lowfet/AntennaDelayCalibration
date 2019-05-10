clear all;close all;

load calibrationdata.mat
realdistance=2;

dA0_A1=3.286587345991266e+04;
dA0_A2=3.287092032231401e+04;
dA0_T0=3.287218030875541e+04;

dA1_A2=3.285044209376539e+04;
%[1.02822146978182e-06]
dA1_A3=3.286587346020784e+04;
%[1.02870447278796e-06]
dA1_T0=3.287413288854748e+04;
%[1.02896299355680e-06]
dA2_A3=3.287092032084848e+04;
%[1.02886243993040e-06]
dA2_T0=3.286474784046557e+04;
%[1.02866924079983e-06]
dA3_T0=3.287218031280406e+04;
%[1.02890187777957e-06]


[Dis_A1_A2,Dis_A2_A1,~]=calTWRdistance(A1_A2(1:900,:),0);
[Dis_A1_A3,Dis_A3_A1,~]=calTWRdistance(A1_A3(1:900,:),0);
[Dis_A1_T0,Dis_T0_A1,~]=calTWRdistance(A1_T0(1:900,:),0);
[Dis_A2_A3,Dis_A3_A2,~]=calTWRdistance(A2_A3(1:900,:),0);
[Dis_A2_T0,Dis_T0_A2,~]=calTWRdistance(A2_T0(1:900,:),0);
[Dis_A3_T0,Dis_T0_A3,~]=calTWRdistance(A3_T0(1:900,:),0);

t=1:length(Dis_A1_A2);
figure(1);
pointout(:,1)=Dis_A1_A2-realdistance;
pointout(:,2)=Dis_A2_A1-realdistance;
plot(t,pointout(:,1),'r',t,pointout(:,2),'b',t,(pointout(:,1)+pointout(:,2))/2,'y');
axis([0 900 150 158]);

figure(2);
pointout(:,3)=Dis_A1_A3-realdistance;
pointout(:,4)=Dis_A3_A1-realdistance;
plot(t,pointout(:,3),'r',t,pointout(:,4),'b',t,(pointout(:,3)+pointout(:,4))/2,'y');
axis([0 900 150 158]);

figure(3);
pointout(:,5)=Dis_A1_T0-realdistance;
pointout(:,6)=Dis_T0_A1-realdistance;
plot(t,pointout(:,5),'r',t,pointout(:,6),'b',t,(pointout(:,5)+pointout(:,6))/2,'y');
axis([0 900 150 158]);

figure(4);
pointout(:,7)=Dis_A2_A3-realdistance;
pointout(:,8)=Dis_A3_A2-realdistance;
plot(t,pointout(:,7),'r',t,pointout(:,8),'b',t,(pointout(:,7)+pointout(:,8))/2,'y');
axis([0 900 150 158]);

figure(5);
pointout(:,9)=Dis_A2_T0-realdistance;
pointout(:,10)=Dis_T0_A2-realdistance;
plot(t,pointout(:,9),'r',t,pointout(:,10),'b',t,(pointout(:,9)+pointout(:,10))/2,'y');
axis([0 900 150 158]);

figure(6);
pointout(:,11)=Dis_A3_T0-realdistance;
pointout(:,12)=Dis_T0_A3-realdistance;
plot(t,pointout(:,11),'r',t,pointout(:,12),'b',t,(pointout(:,11)+pointout(:,12))/2,'y');
axis([0 900 150 158]);

% xlabel('Time Samples');ylabel('Error(m)');
% legend('A1->A2','A2->A3','A1->T0','A2->A3','A2->T0','A3->T0')

for i=1:6
    meanerror(i)=mean(pointout(:,i));
end
totalmeanerror=mean(meanerror);
