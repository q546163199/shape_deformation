clc;clear;close all
%%
xleft = 0.1;
yleft = 0;
xright = 0.7;
yright = 0.0;
Theta1 =   pi / 6;
Theta2 = - pi / 6;
cable_length = 1.5;
%%
tic
figure
[shape,~,angle] = dlodynamics_2D(xleft, yleft, xright, yright,Theta1, Theta2, cable_length, [], 2);
fill(shape(:,1),shape(:,2),'r');hold on
plot(shape(:, 1), shape(:, 2),'ob-','linewidth',2,'Markersize',3,'MarkerEdgeColor', 'k','MarkerFaceColor', [254, 67, 101]/255);
hold on;grid on
axis([-0.1 0.8 -0.1 0.8])
daspect([1 1 1])
polyarea(shape(:,1),shape(:,2))
toc

