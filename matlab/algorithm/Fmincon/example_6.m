clc;clear;close all
%%
tic
K = rand(10,8) * 10;
N = 200;
for i=1:N
    x(:,i) = rand(8,1) * 3 + (rand-0.5) / 2;
    y(:,i) = K * x(:,i);
end
save data
%%
K0 = rand(10,8);
A = [];
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
nonlcon = [];
options = optimset('LargeScale','off','display','iter');
%%
[Kc,fval] = fmincon(@fun,K0,A,b,Aeq,beq,lb,ub,nonlcon,options);
error = norm(Kc - K, 2);
%%
toc