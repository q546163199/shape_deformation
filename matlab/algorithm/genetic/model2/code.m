clc;clear;close all

fitnessfcn=@f;
nvars=2;
A=[1 1;-1 2;2 1];b=[2;2;3];
Aeq=[];beq=[];
lb=[0,0];ub=[];
               
options=gaoptimset;               
options=gaoptimset(options,'paretoFraction',0.3); %���Ÿ���ϵ�� paretoFraction Ϊ0.3
options=gaoptimset(options,'populationsize',100); %��Ⱥ��С populationsize Ϊ100
options=gaoptimset(options,'generations',200);    %���������� generations Ϊ200
options=gaoptimset(options,'stallGenLimit',200);  %ֹͣ���� stallGenLimit Ϊ200
options=gaoptimset(options,'TolFun',1e-10);       %��Ӧ�Ⱥ���ƫ�� TolFun Ϊ1e-100
options=gaoptimset(options,'PlotFcns',{@gaplotpareto,@gaplotrankhist}); %���� gaplotpareto ���� Paretoǰ��

[x,fval]=gamultiobj(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,options);