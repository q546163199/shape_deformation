clc;clear;close all
%%
x0 = rand(3,1);
A = [];
b = [];
Aeq = [];
beq = [];
lb = zeros(3,1);
ub = [];
[x,fval] = fmincon(@fun,x0,A,b,Aeq,beq,lb,ub,@nonlin);
%%
function f = fun(x)
x1 = x(1);
x2 = x(2);
x3 = x(3);
f = x1^2 + x2^2 + x3^2 + 8;
end
%%
function [c,ceq] = nonlin(x)
x1 = x(1);
x2 = x(2);
x3 = x(3);
c = [-x1^2 + x2 - x3^2
      x1 + x2^2 + x3^3 - 20];
ceq = [-x1 - x2^2 + 2
        x2 + 2*x3^2 - 3];
end