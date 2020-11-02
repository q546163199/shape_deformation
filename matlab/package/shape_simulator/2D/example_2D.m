clc;clear;close all
%%
xleft = 0;
yleft = 0;
xright = 0.71;
yright = 0.0;
Theta1 =   pi / 6;
Theta2 = - pi / 6;
cable_length = 1.5;
%%
tic
shape1 = dlodynamics_2D(xleft, yleft, xright, yright,Theta1, Theta2, cable_length);
plot(shape1(:, 1), shape1(:, 2),'ok--','linewidth',1,'Markersize',3,'MarkerEdgeColor', 'k','MarkerFaceColor', [254, 67, 101]/255);
hold on;grid on
axis([-0.1 0.8 -0.1 0.8])
daspect([1 1 1])
toc

