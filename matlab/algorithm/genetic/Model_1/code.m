clc;clear;close all

fitnessfcn=@f;
nvars=2;
lb=[-5,-5,];
ub=[5,5];
A=[];b=[];
Aeq=[];beq=[];
options=gaoptimset('paretoFraction',0.3,... %最优个体系数 paretoFraction 为0.3
                   'populationsize',100,... %种群大小 populationsize 为100
                   'generations',200,...    %最大进化代数 generations 为200
                   'stallGenLimit',200,...  %停止代数 stallGenLimit 为200
                   'TolFun',1e-100,...      %适应度函数偏差 TolFun 为1e-100
                   'PlotFcns',{@gaplotpareto,@gaplotrankhist});%函数 gaplotpareto 绘制 Pareto前端

[x,fval]=gamultiobj(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,options);
