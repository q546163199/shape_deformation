clc;clear;close all
%%
start = 0;step = 0.1;final = 1;
t = start:step:final;
N = length(t) - 1;
%%
x(1) = 0;
y(1) = 1;
dy(1) = 0;
for i=1:N
    [y(i+1),dy(i+1)] = RK_main(x(i),y(i),step);
    x(i+1) = x(i) + step;
end
%%
figure
plot(x,y,'k-*','linewidth',1);
grid on