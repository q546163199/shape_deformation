clc;clear;close all

fitnessfcn=@f;
nvars=3;
A=[-1 -2 0;-1 0 0];b=[-1;0];
Aeq=[];beq=[];
lb=[0 0];ub=[1 13];

options=gaoptimset('paretoFraction',0.3,... %最优个体系数 paretoFraction 为0.3
                   'populationsize',100,... %种群大小 populationsize 为100
                   'generations',200,...    %最大进化代数 generations 为200
                   'stallGenLimit',200,...  %停止代数 stallGenLimit 为200
                   'TolFun',1e-10,...      %适应度函数偏差 TolFun 为1e-100
                   'PlotFcns',{@gaplotpareto,@gaplotrankhist});%函数 gaplotpareto 绘制 Pareto前端

[x,fval]=gamultiobj(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,@ga_con1)