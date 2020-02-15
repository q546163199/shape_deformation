clc;clear;close all
%%
addpath('..\..\..\package\shape_simulator_3D');
addpath('..\..\..\package\shape_simulator_3D\Tools');
%% Definition of the global frame:
global Rf Rt Re D L
global n s0 s1 ds lx ly lz state0 state1
L = 1;
Rf = 1;       % Flexural coefficient
Rt = 1;       % Torsional coefficient
Re = 0.0;     % extension coefficient
D = 0.0;      % weight par m
N = 50;
s0 = 0;
s1 = L;    
ds = (s1 - s0)/N;
kmax = 2;             % Use 2nd order approximation
n = 2 * kmax + 2;     % number of parameters per varaible
%% Constraints
state0 = [-0.2 -0.2 0 0 0 0]; % positon and orientation of left point
lx = 0.4;
ly = 0.4;
lz = 0.5;
ax = pi/3;
ay = 0;
az = 0;
state1 = [state0(1)+lx state0(2)+ly state0(3)+lz state0(4)+ax state0(5)+ay state0(6)+az];
%% Computation
param0 = zeros(4*n,1);
[param1, cost] = fmincon(@costfun,param0,[],[],[],[],[],[],@nonlinc);
[p_dat, PHI_dat, T_dat] = plotDLO(param1);
%% Fourier calculation
N = 4;
[~,~,shape_est_Fourier] = Fourier_curve_3D(p_dat,L,N);
%%
T_start = T_dat(1:4,(1*4-3):(1*4));
T_end = T_dat(1:4,(51*4-3):(51*4));
T_base = eye(4);
%%
figure
plot3(p_dat(:,1),p_dat(:,2),p_dat(:,3),'k-.','linewidth',3);hold on
plot3(shape_est_Fourier(:,1),shape_est_Fourier(:,2),shape_est_Fourier(:,3),'r--','linewidth',3);hold on
plot3(0,0,0,'r*','linewidth',3);hold on
DrawFrame(T_start,L/3, 2);
DrawFrame(T_end,  L/3, 2);
DrawFrame(T_base, L/3, 2);
grid on
axis([-L L -L L -L L]);
daspect([1 1 1])
xlabel('X');    
ylabel('Y');
zlabel('Z');
text(0,0,0,'world','fontsize',15)
title('Euler Rotation is XYZ')