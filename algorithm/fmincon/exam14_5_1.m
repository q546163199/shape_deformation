clc;clear;close all
%%
A = [-1 0;1 0;0 -1;0 1];
b = [-5;8;-5;8];
Aeq = [];
beq = [];
lb = [0;0];
ub = [];
nonlcon = [];
x0 = [1;1.2];
options = optimset('LargeScale','off','display','iter');   
%%
[x,fval,maxfval,exitflag,output] = fminimax(@fun011,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
%%
fun011(x)