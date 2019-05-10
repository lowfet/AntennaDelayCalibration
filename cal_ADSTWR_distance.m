function [distance,distance_arm]=cal_ADSTWR_distance(data,td)
DWT_TIME_UNITS=(1.0/499.2e6/128.0);
SPEED_OF_LIGHT=2.997106669589869e+08;

distance_arm=data(:,1);
Tround1=data(:,3)*DWT_TIME_UNITS;
Tround2=data(:,4)*DWT_TIME_UNITS;
Treply2=data(:,5)*DWT_TIME_UNITS;
Treply1=data(:,6)*DWT_TIME_UNITS;
Td=td*DWT_TIME_UNITS*2;

tof=((Tround1.*Tround2-Treply2.*Treply1-(Treply1*Td+Treply2*Td+Td^2))./(Tround1+Tround2+Treply1+Treply2+2*Td));

distance = tof .* SPEED_OF_LIGHT;
end
