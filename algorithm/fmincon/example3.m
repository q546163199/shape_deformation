clc;clear;close all
%%
K = rand(10,8) * 10;
N = 100;
for i=1:100
    x(:,i) = rand(8,1) * 3 + (rand-0.5) / 2;
    y(:,i) = K * x(:,i);
end
save data
%%
A0 = rand(10,8);
A = [];
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
nonlcon = [];
options = optimset('LargeScale','off','display','iter');
%%
[A1,fval] = fmincon('fun4',A0,A,b,Aeq,beq,lb,ub,nonlcon,options);
K - A1