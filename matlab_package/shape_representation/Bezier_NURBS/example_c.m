clc;clear;close all
%%
addpath('..\Fourier')
%%
xleft = 0;
yleft = 0;
xright = 0.7;
yright = 0.0;
Theta1 =   pi / 6;
Theta2 = - pi / 6;
cable_length = 2.0;
shape = dlodynamics_2D(xleft, yleft, xright, yright,Theta1, Theta2, cable_length);
%%
[s1,G1,shape_est_Fourier] = Fourier_curve_2D(shape,cable_length,4);
[s2,G2,shape_est_Bezier] = Bezier_curve_2D(shape,cable_length,8);
[s3,G3,shape_est_NURBS] = NURBS_curve_2D(shape,cable_length,8);
error1 = norm(shape - shape_est_Fourier);
error2 = norm(shape - shape_est_Bezier);
error3 = norm(shape - shape_est_NURBS);
%%
figure
plot(shape(:, 1), shape(:, 2),'k-','linewidth',2);hold on
plot(shape_est_Fourier(:, 1), shape_est_Fourier(:, 2),'r-.','linewidth',2);hold on
plot(shape_est_Bezier(:, 1), shape_est_Bezier(:, 2),'g-.','linewidth',2);hold on
plot(shape_est_NURBS(:, 1), shape_est_NURBS(:, 2),'b-.','linewidth',2);
grid on
legend('Real','Fourier','Bezier','NURBS')
text(0.2,0.15,['error Fourier: ',num2str(error1)])
text(0.2,0.10,['error Bezier:  ',num2str(error2)])
text(0.2,0.05,['error NURBS:  ',num2str(error3)])