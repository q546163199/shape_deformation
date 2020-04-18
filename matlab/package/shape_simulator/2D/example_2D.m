clc;clear;close all
%%
xleft = 0;
yleft = 0;
xright = 0.7;
yright = 0.0;
Theta1 =   pi / 6;
Theta2 = - pi / 6;
cable_length = 2;
shape = dlodynamics_2D(xleft, yleft, xright, yright,Theta1, Theta2, cable_length);
%%
figure
plot(shape(:, 1), shape(:, 2),'k-','linewidth',2);
grid on