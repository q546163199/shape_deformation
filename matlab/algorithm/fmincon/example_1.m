clc;clear;close all
%%
fun = @(x)-x(1)*x(2)*x(3);
%%
x0 = [10 10 10];
A = [-1 -2 -2; 1 2 2];
b = [0;72];
Aeq = [];
beq = [];
lb = [];
ub = [];
nonlcon = [];
options = optimset('LargeScale','off','display','iter');
%%
[x,fval] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);