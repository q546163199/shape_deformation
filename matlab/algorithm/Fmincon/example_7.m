clc;clear;close all
%%
[x,fval] = fmincon(@fun,rand(3,1),[],[],[],[],zeros(3,1),[],@nonlin);
%%
function f = fun(x)
f = x(1).^2 + x(2).^2 + x(3).^2 + 8;
end
%%
function [c,ceq] = nonlin(x)
c = [-x(1).^2 + x(2) - x(3).^2
      x(1) + x(2).^2 + x(3).^3 - 20];
ceq = [-x(1) - x(2).^2 + 2
        x(2) + 2*x(3).^2 - 3];
end