clc;clear;close all
%%
addpath('..\..\..\package\shape_simulator_2D');
%% shape intialization
xleft = 0.9503;
yleft = 0.2940;
xright = 1.5;
yright = 0;
Theta1 = 0.4;
Theta2 = 0;
length = 1.5;
shape_real = dlodynamics_2D(xleft, yleft, xright, yright,Theta1, Theta2, length);
%% Fourier calculation
N = 4;
[~,~,shape_est_Fourier] = Fourier_curve_2D(shape_real,length,N);
%% comparison
figure
plot(shape_real(:,1),shape_real(:,2),'k-','linewidth',2);hold on
plot(shape_est_Fourier(:,1),shape_est_Fourier(:,2),'r--','linewidth',2)
legend('shape\_real','shape\_est\_Fourier')
grid on
