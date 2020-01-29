clc;clear;close all

m=0.75;g=9.81;l=0.258;
kt =1;%kt = 3.179*10^(-5);
Jx = 1.9688*10^(-2);Jy = 1.9688*10^(-2);Jz = 3.9388*10^(-2);
omega=1;
omega1=omega;omega2=omega;omega3=omega;omega4=omega;
K1=0.001;K2=0.001;K3=0.001;K4=0.001;K5=0.001;K6=0.001;
ctrsel = 1 ;

phi_init = 0;dphi_init = 1;  
the_init=  1;dthe_init = 1;  
psi_init = 0;dpsi_init = 1;          
x_init = 0;dx_init = 0;       
y_init = 0;dy_init = 0;                 
z_init = 0;dz_init = 0;

sim('uav_1')

