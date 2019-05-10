function [ pT0 ] = cal_Position( dT0A1,dT0A2,dT0A3 )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

    %Anchor position
    pA0x=1.425;pA0y=2.85;
    pA1x=0;pA1y=0;
    pA2x=2.85;pA2y=0;

    for i=1:1:length(dT0A3)
        A=[2*(pA0x-pA2x) 2*(pA0y-pA2y);
           2*(pA1x-pA2x) 2*(pA1y-pA2y)];
        b=[pA0x^2-pA2x^2+pA0y^2-pA2y^2+dT0A3(i)^2-dT0A1(i)^2;
           pA1x^2-pA2x^2+pA1y^2-pA2y^2+dT0A3(i)^2-dT0A2(i)^2];

        pT0(:,i)=(A'*A)^(-1)*A'*b;
    end

end

