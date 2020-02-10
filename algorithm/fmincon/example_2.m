clc;clear;close all
%%
x0 = [1 1 1];
A = [];
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
nonlcon = [];
options = optimset('LargeScale','off','display','iter');
%%
[x,fval] = fmincon('fun3',x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
x