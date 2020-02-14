clc;clear;close all
%%
x0 = [1;1.2];
A = [-1 0;1 0;0 -1;0 1];
b = [-5;8;-5;8];
Aeq = [];
beq = [];
lb = [0;0];
ub = [];
nonlcon = [];
options = optimset('LargeScale','off','display','iter');   
%%
[x,fval,maxfval,exitflag,output] = fminimax(@fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
%%
function f = fun(x)
m = [1 4 3 5 9 12 6 20 17 8];
n = [2 10 8 18 1 4 5 10 8 9];

for i=1:10
    f(i) = abs(x(1) - m(i)) + abs(x(2) - n(i));
end
end