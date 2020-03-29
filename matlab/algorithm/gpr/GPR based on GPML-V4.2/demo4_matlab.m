clc;clear;close all
num = 50;
x(:,1) = linspace(-5, 5, num)';
x(:,2) = linspace(-5, 5, num)';
x(:,3) = linspace(-5, 5, num)';
xt = (rand(num,3)-0.5) * 5;
for i=1:num
    y(i,1) = sin(x(i,1)) + cos(x(i,2)) + atan(x(i,3));
    yt(i,1) = sin(xt(i,1)) + cos(xt(i,2)) + atan(xt(i,3));
end
gprMdl = fitrgp(x, y(:,1));
yfit(:,1) = predict(gprMdl,xt);
%% 可视化结果
plotResult(yt, yfit)