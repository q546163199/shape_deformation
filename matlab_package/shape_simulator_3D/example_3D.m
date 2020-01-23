clc;clear;close all
%%
addpath('Tools\');
%% Definition of the global frame:
global Rf Rt Re D L
global n s0 s1 ds lx ly lz state0 state1
L = 2;
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
lz = -0.3;
ax = pi/4;
ay = pi/2 + pi/8 + pi/4;
az = pi/4;
state1 = [state0(1)+lx state0(2)+ly state0(3)+lz state0(4)+ax state0(5)+ay state0(6)+az];
%% Computation
param0 = zeros(4*n,1);
[param1, cost] = fmincon(@costfun,param0,[],[],[],[],[],[],@nonlinc);
[p_dat, PHI_dat, T_dat] = plotDLO(param1);
%%
figure
plot3(p_dat(:,1),p_dat(:,2),p_dat(:,3),'k-','linewidth',3);hold on
grid on
daspect([1 1 1])
title('Euler Rotation is XYZ')
%%
T_world = eye(4);
T_base_ur5 = [];
T_end_ur5 = [];
T_base_shape = T_dat(1:4,(1*4-3):(1*4));
T_end_shape = T_dat(1:4,(51*4-3):(51*4));
DrawAllFrame(T_world,T_base_ur5,T_end_ur5,T_base_shape,T_end_shape)