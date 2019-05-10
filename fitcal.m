function fitval = fitcal(pm,DATA,Tr)
%pm粒子位置的值
[x,y,z]=size(pm);

DWT_TIME_UNITS=(1.0/499.2e6/128.0);
SPEED_OF_LIGHT=2.997106669589869e+08;

for i=1:x

    %https://refractiveindex.info/?shelf=other&book=air&page=Mathar-2.8
    % SPEED_OF_LIGHT=299702547;
    % 2.997094384855395e+08 1.000277
    % 2.997025472358292e+08 1.0003
    % 2.997106669589869e+08 1.00027290
    distance_arm=DATA(:,1);
    Tround1=DATA(:,3)*DWT_TIME_UNITS;
    Tround2=DATA(:,4)*DWT_TIME_UNITS;
    Treply2=DATA(:,5)*DWT_TIME_UNITS;
    Treply1=DATA(:,6)*DWT_TIME_UNITS;
    Td=pm(i,1,z)*DWT_TIME_UNITS*2;

%     tof=((Tround1.*Tround2-Treply2.*Treply1-(Treply1*Td+Treply2*Td+4*Td^2))./(Tround1+Tround2+Treply1+Treply2+2*Td));
    tof=((Tround1.*Tround2-Treply2.*Treply1-(Treply1*Td+Treply2*Td+Td^2))./(Tround1+Tround2+Treply1+Treply2+2*Td));

    % tof = tof_dtu .* DWT_TIME_UNITS;
    distance = tof .* SPEED_OF_LIGHT;

    error=Tr-distance;
%     fitval(i,1,z)=mse(error); %返回值 每一个个体的适应值
    fitval(i,1,z)=sum(abs(Tr-distance)/length(distance));
end