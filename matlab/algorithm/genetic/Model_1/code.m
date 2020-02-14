clc;clear;close all

fitnessfcn=@f;
nvars=2;
lb=[-5,-5,];
ub=[5,5];
A=[];b=[];
Aeq=[];beq=[];
options=gaoptimset('paretoFraction',0.3,... %���Ÿ���ϵ�� paretoFraction Ϊ0.3
                   'populationsize',100,... %��Ⱥ��С populationsize Ϊ100
                   'generations',200,...    %���������� generations Ϊ200
                   'stallGenLimit',200,...  %ֹͣ���� stallGenLimit Ϊ200
                   'TolFun',1e-100,...      %��Ӧ�Ⱥ���ƫ�� TolFun Ϊ1e-100
                   'PlotFcns',{@gaplotpareto,@gaplotrankhist});%���� gaplotpareto ���� Paretoǰ��

[x,fval]=gamultiobj(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,options);
