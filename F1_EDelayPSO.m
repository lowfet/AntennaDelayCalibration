% Copyright by Xinzhe Gui @ 2017
% Email: lwft@qq.com
% You can change and distribute this code freely for academic usage
% Business usage is strictly prohibited
clear
clc
load F0_calibrationdata.mat
%%%%%%%%%和延迟的关系
% 这是以前论文公式错误时得出的数据 no use
% fitdata=A0_A1;%3.286587345991266e+04
% fitdata=A0_A2;%3.287092032231401e+04
% fitdata=A0_T0;%3.287218030875541e+04
% fitdata=A1_A2;%3.285044209376539e+04
% fitdata=A1_T0;%3.287413288854748e+04
% fitdata=A2_T0;%3.286474784046557e+04
% fitdata=A1_A3;%3.286587346020784e+04
% fitdata=A2_A3;%3.287092032084848e+04
% fitdata=A3_T0;%3.287218031280406e+04
fitreal=2;
fitdata=A0_A1;%[32883.2168198808]
fitdata=A0_A2;%[32888.2690141552]
% fitdata=A0_T0;%[32889.5303335300]
fitdata=A1_A2;%[32867.7691941474]
% fitdata=A1_T0;%[32891.4849837626]
% fitdata=A2_T0;%[32882.0900220365]
% fitdata=A1_A3;%[32883.2168198803]
% fitdata=A2_A3;%[32888.2690141558]
% fitdata=A3_T0;%[32889.5303335231]

%% 
%初始化PSO相关参数
% vmax=0.15; %每个粒子的最大速度
% vmin=-0.15;
xmax=65536; 
xmin=-65536;
vmax=65536/2; %每个粒子的最大速度
vmin=-65536/2;
minerr=0.0015; %最小误差
% wmax=1;%最大惯性权重
% wmin=1;%最小惯性权重
wmax=0.90;%最大惯性权重
wmin=0.40;%最小惯性权重
global itmax; %最大寻优次数
itmax=200;
c1=2.05;%自身
c2=2.05;%全局
cf=0.729;
W(itmax)=0;
for iter=1:itmax
    W(iter)=wmax-((wmax-wmin)/itmax)*iter; % 惯性权重的线性下降
end
Vmax(itmax)=0;
for iter=1:itmax
    Vmax(iter)=vmax/iter; % 最大速度的线性下降
%     Vmax(iter)=vmax;
end
Vmin(itmax)=0;
for iter=1:itmax
    Vmin(iter)=vmin/iter; % 最大反向速度的线性下降
%     Vmin(iter)=vmin;
end
% 粒子位置初始化范围
a=0;
b=65536;
% 粒子速度初始化范围
m=0;
n=65536;
ParticleNum=100;

% 优化参数个数，权值和阀值 
% 1 3 1 的时候D=((1+1)*3+(3+1)*1)=10 为10
ParticleDimension=1; %D=(14+1)*7+(7+1)*1=113

rng(sum(100*clock),'v5uniform');
%粒子位置被初始化为(0,1)之间的随机值
X=a+(b-a)*rand(ParticleNum,ParticleDimension,1);
%粒子速度被初始化为(0,1)之间的随机值
V=m+(n-m)*rand(ParticleNum,ParticleDimension,1);

%粒子适应度

MinFit=[];
BestFit=[];

fitness=fitcal(X,fitdata,fitreal); %返回值 每一个个体的平均适应值

fvrec(:,1,1)=fitness(:,1,1);%返回值 每一个个体(共40个个体)的适应值 第一代

[C,I]=min(fitness(:,1,1)); %当代最小适应值C，及其索引I
MinFit=[MinFit C];  %第一代的自身最佳适应度值
BestFit=[BestFit C]; %第一代的全局最佳适应度值
L(:,1,1)=fitness(:,1,1); %在每个循环中记录粒子的适应度
B(1,1,1)=C; %记录出粒子的最小适应度
gbest(1,:,1)=X(I,1,1); %全局最优的适应度值

%Matrix composed of gbest vector
for p=1:ParticleNum
    G(p,:,1)=gbest(1,:,1); %每个个体的全局最优
end
for i=1:ParticleNum;
    pbest(i,:,1)=X(i,:,1); %第一代的历史最好就是自己
end
%粒子速度更新公式
V(:,:,2)=W(1)*V(:,:,1)+c1*rand*(pbest(:,:,1)-X(:,:,1))+c2*rand*(G(:,:,1)-X(:,:,1));
%V(:,:,2)=cf*(W(1)*V(:,:,1)+c1*rand*(pbest(:,:,1)-X(:,:,1))+c2*rand*(G(:,:,1)-X(:,:,1)));
% V(:,:,2)=cf*(V(:,:,1)+c1*rand*(pbest(:,:,1)-X(:,:,1))+c2*rand*(G(:,:,1)-X(:,:,1)));
% V(:,:,2)=cf*(c1*rand*(pbest(:,:,1)-X(:,:,1))+c2*rand*(G(:,:,1)-X(:,:,1)));
%限制每代粒子的速度，在（vmin,vmax）之间
for ni=1:ParticleNum
    for di=1:ParticleDimension
        if V(ni,di,2) > Vmax(1)
            V(ni,di,2) = Vmax(1);
        elseif V(ni,di,2) < Vmin(1)
            V(ni,di,2) = Vmin(1);
        else
            V(ni,di,2) = V(ni,di,2);
        end
    end
end
%粒子位置更新公式
X(:,:,2)=X(:,:,1)+V(:,:,2);
%限制每代粒子的位置，在（xmin,xmax）之间
for ni=1:ParticleNum
    for di=1:ParticleDimension
        if X(ni,di,2) > xmax
            X(ni,di,2) = xmax;
        elseif V(ni,di,2) < xmin
            X(ni,di,2) = xmin;
        else
            X(ni,di,2) = X(ni,di,2);
        end
    end
end
%%
%******************************************************
for j=2:itmax
    disp('Iteration and Current Best Fitness')
    disp(j-1)
    disp(B(1,1,j-1))
    % Calculation of new positions
    fitness=fitcal(X,fitdata,fitreal); %返回值 每一个个体的适应值******************************************************
    fvrec(:,1,j)=fitness(:,1,j); %返回值 每一个个体的适应值 第j代
    %[maxC,maxI]=max(fitness(:,1,j));
    %MaxFit=[MaxFit maxC];
    %MeanFit=[MeanFit mean(fitness(:,1,j))];
    [C,I]=min(fitness(:,1,j));%第j代粒子的最小适应值,求出当代例子中适应度最小的一个并记录，C---当代最小适应度值，I---当代最小适应度值对应的粒子序号
    
    MinFit=[MinFit C]; %记录每代的最小适应值
    BestFit=[BestFit min(MinFit)]; %记录全部全局最好适应值
    
    L(:,1,j)=fitness(:,1,j); %记录每代粒子的适应值
    B(1,1,j)=C;              %记录j代粒子的最小适应值
    
    gbest(1,:,j)=X(I,:,j);%把第j代具有最小适应值的粒子放入gbest中
    [C,I]=min(B(1,1,:));%记录历史直到第j代粒子的最小适应值
    
    % keep gbest is the best particle of all have occured
    if B(1,1,j)<=C
        gbest(1,:,j)=gbest(1,:,j);
    else
        gbest(1,:,j)=gbest(1,:,I);
    end
     %Matrix composed of gbest vector
    for p=1:ParticleNum
        G(p,:,j)=gbest(1,:,j);
    end
    
    for i=1:ParticleNum;
        [iMinC,I]=min(L(i,1,:));
        if L(i,1,j)<=iMinC
            pbest(i,:,j)=X(i,:,j);
        else
            pbest(i,:,j)=X(i,:,I);
        end
    end
    
    if C<=minerr, break, end
    if j>=itmax, break, end
    
    %粒子速度更新公式
    V(:,:,j+1)=W(j)*V(:,:,j)+c1*rand*(pbest(:,:,j)-X(:,:,j))+c2*rand*(G(:,:,j)-X(:,:,j));
    %V(:,:,j+1)=cf*(W(j)*V(:,:,j)+c1*rand*(pbest(:,:,j)-X(:,:,j))+c2*rand*(G(:,:,j)-X(:,:,j)));
%     V(:,:,j+1)=cf*(V(:,:,j)+c1*rand*(pbest(:,:,j)-X(:,:,j))+c2*rand*(G(:,:,j)-X(:,:,j)));
%     V(:,:,j+1)=cf*(c1*rand*(pbest(:,:,j)-X(:,:,j))+c2*rand*(G(:,:,j)-X(:,:,j)));
    %限制每代粒子的速度，在（vmin,vmax）之间
    for ni=1:ParticleNum
        for di=1:ParticleDimension
            if V(ni,di,j+1)>Vmax(j)
                V(ni,di,j+1)=Vmax(j);
            elseif V(ni,di,j+1)<Vmin(j)
                V(ni,di,j+1)=Vmin(j);
            else
                V(ni,di,j+1)=V(ni,di,j+1);
            end
        end
    end
    
    %粒子位置更新公式
    X(:,:,j+1)=X(:,:,j)+V(:,:,j+1);
    %限制每代粒子的速度，在（vmin,vmax）之间
    for ni=1:ParticleNum
        for di=1:ParticleDimension
            if X(ni,di,j+1) > xmax
                X(ni,di,j+1) = xmax;
            elseif V(ni,di,j+1) < xmin
                X(ni,di,j+1) = xmin;
            else
                X(ni,di,j+1) = X(ni,di,j+1);
            end
        end
    end
    
end

disp('Iteration and Current Best Fitness')
disp(j)
disp(B(1,1,j))
disp('Global Best Fitness and Occurred Iteration')
[C,I] = min(B(1,1,:))
best_para=gbest(:,:,I)
%显示适应度的变化

%显示参数值得变化
