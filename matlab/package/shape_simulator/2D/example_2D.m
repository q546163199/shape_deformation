clc;clear;close all
tic
%%
xleft = 0;
yleft = 0;
xright = 0.7;
yright = 0.0;
Theta1 =   pi / 6;
Theta2 = - pi / 6;
cable_length = 2;
%%
shape1 = dlodynamics_2D(xleft, yleft, xright, yright,Theta1, Theta2, cable_length);
plot(shape1(:, 1), shape1(:, 2),'ok--','linewidth',1,'Markersize',5,'MarkerEdgeColor', 'k','MarkerFaceColor', [254, 67, 101]/255);
hold on
toc
%%
tic
shape2 = dlodynamics_2D_ji(xleft, yleft, xright, yright,Theta1, Theta2, cable_length);
plot(shape2(:, 1), shape2(:, 2),'b-','linewidth',2);grid on
%%
error = shape1 - shape2;
toc