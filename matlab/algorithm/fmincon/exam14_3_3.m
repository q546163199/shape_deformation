clc;clear;close all
%%
fun = @(x,a)exp(x(1))*(4*x(1)^2+2*x(2)^2+4*x(1)*x(2)+2*x(2)+a);
x0 = [1 1];
A = [2 1;3 5];
b = [4;10];
Aeq = [1 -2];
beq = [-1];
lb = [];
ub = [];
options = optimset('LargeScale','off','display','iter');
%%
[x,fval] = fmincon(@(x)fun(x,1),x0,A,b,Aeq,beq,lb,ub,@nlinconfun);
%%
function[c,ceq] = nlinconfun(x)
c = 1.5-x(1)*x(2);
ceq = x(1)^2+x(2)^2-3;
end
