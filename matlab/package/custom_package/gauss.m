clc;clear;close all

x = -10:0.05:10;

mu = 0;sigma = sqrt(0.2);
a = 1/(sigma * sqrt(2 * pi));b = mu;c = sigma;
y1 = a*exp(-(x-b).^2/(2* c^2));

mu = 0;sigma = sqrt(1.0);
a = 1/(sigma * sqrt(2 * pi));b = mu;c = sigma;
y2 = a*exp(-(x-b).^2/(2* c^2));

mu = 0;sigma = sqrt(5.0);
a = 1/(sigma * sqrt(2 * pi));b = mu;c = sigma;
y3 = a*exp(-(x-b).^2/(2* c^2));

figure
plot(x,[y1; y2; y3],'linewidth',2);
legend('\mu = 0, \sigma^2 = 0.2','\mu = 0, \sigma^2 = 1.0','\mu = 0, \sigma^2 = 5.0')
grid on