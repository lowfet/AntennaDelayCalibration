
% fitdata=A0_A1;%3.286587345991266e+04
% fitdata=A0_A2;%3.287092032231401e+04
% fitdata=A0_T0;%3.287218030875541e+04
% fitdata=A1_A2;%3.285044209376539e+04
% fitdata=A1_T0;%3.287413288854748e+04
% fitdata=A2_T0;%3.286474784046557e+04

%ADS-TWR校准
% 这是以前论文公式错误时得出的数据 no use
dA0_A1=3.286587345991266e+04;
dA0_A2=3.287092032231401e+04;
dA0_T0=3.287218030875541e+04;
dA1_A2=3.285044209376539e+04;
dA1_A3=3.286587346020784e+04;
dA1_T0=3.287413288854748e+04;
dA2_A3=3.287092032084848e+04;
dA2_T0=3.286474784046557e+04;
dA3_T0=3.287218031280406e+04;

%ADS-TWR校准 修正
dA0_A1=[32883.2168198808];
dA0_A2=[32888.2690141552];
dA0_T0=[32889.5303335300];
dA1_A2=[32867.7691941474];
dA1_A3=[32891.4849837626];
dA1_T0=[32882.0900220365];
dA2_A3=[32883.2168198803];
dA2_T0=[32888.2690141558];
dA3_T0=[32889.5303335231];
% fitdata=A0_A1;%
% fitdata=A0_A2;%
% fitdata=A0_T0;%
% fitdata=A1_A2;%
% fitdata=A1_T0;%
% fitdata=A2_T0;%
% fitdata=A1_A3;%
% fitdata=A2_A3;%
% fitdata=A3_T0;%

%SDS-TWR校准
% [16452.8802175173;16420.5444747771;16426.6429448168;16430.6351611433]
% dA0_A1=3.287944002379190e+04;
% dA0_A2=3.288105355547225e+04;
% dA0_T0=3.287596965402482e+04;
% dA1_A2=3.283964169495806e+04;
% dA1_A3=3.287944002379190e+04;
% dA1_T0=3.285271002905857e+04;
% dA2_A3=3.288105355547225e+04;
% dA2_T0=3.286329343745758e+04;
% dA3_T0=3.287596965402482e+04;

% Td_=[dA1_A2 dA1_A3 dA1_T0 dA2_A3 dA2_T0 dA3_T0];
Td_=[dA0_A1 dA0_A2 dA0_T0 dA1_A2 dA1_T0 dA2_T0];
% Td1_=[dA0_A1 dA0_A2 dA1_A2];


% A1_A2    A1
% A1_A3    A2
% A1_T0    A3
% A2_A3    T0
% A2_T0
% A3_T0

M1=[1 1 0 0;
    1 0 1 0;
    1 0 0 1;
    0 1 1 0;
    0 1 0 1;
    0 0 1 1];
Td=(M1'*M1)^(-1)*M1'*Td_'

% M2=[1 1 1 1 0 0 0 0;
%     1 1 0 0 1 1 0 0;
%     1 1 0 0 0 0 1 1;
%     0 0 1 1 1 1 0 0;
%     0 0 1 1 0 0 1 1;
%     0 0 0 0 1 1 1 1];
% t=pinv(M2);
% Td=t*Td_';
% Td=(M2'*M2)^(-1)*M2'*Td_'
% t=(M2'*M2)
% t1=(t)^(-1)
% t2=t1*M2'

% M3=[1 1 0;
%     1 0 1;
%     0 1 1;];
% Td=(M3'*M3)^(-1)*M3'*Td1_'