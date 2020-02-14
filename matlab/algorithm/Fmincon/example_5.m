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
[x,fval] = fmincon(@fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
%%
function f = fun(x)
x1 = x(1);
x2 = x(2);
x3 = x(3);
f = (x1-3.69)^2 + (x2-2)^2 + (x3-x2*x1^2-1.5)^2;
end