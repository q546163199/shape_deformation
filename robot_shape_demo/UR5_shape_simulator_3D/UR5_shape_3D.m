clc;clear;close all
addpath('C:\Users\q5461\OneDrive\文档\GitHub\shape_deformation\matlab_package\shape_simulator_3D\')
addpath('C:\Users\q5461\OneDrive\文档\GitHub\shape_deformation\matlab_package\shape_simulator_3D\Tools')
addpath('C:\Users\q5461\OneDrive\文档\GitHub\shape_deformation\matlab_package\robot_simulator_3D\programme_modified')
addpath('C:\Users\q5461\OneDrive\文档\GitHub\shape_deformation\matlab_package\shape_representation\Fourier')
%%
robot = robot_6DOF(0,0,0);
%% Definition of the global frame:
global Rf Rt Re D L
global n s0 s1 ds lx ly lz state0 state1
L = 6;
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
%% left and right constraints
state0 = [1 2 0 0 0 0]; % positon and orientation of left point
T = [-0.951824224709527, -0.215406747948987,   0.218244308503453,   1.86510304766092;
     -0.220054417855173,  0.975482731713992,   0.00308112158621450, 1.52780847532721;
     -0.213557248620901, -0.0450929380928978, -0.975889301353192,  -0.784181787984638;
      0,                  0,                   0,                   1];
angle = T2Euler(T);
lx = T(1,4) - state0(1);
ly = T(2,4) - state0(2);
lz = T(3,4) - state0(3);
ax = angle(1);
ay = angle(2);
az = angle(3);
state1 = [state0(1)+lx state0(2)+ly state0(3)+lz state0(4)+ax state0(5)+ay state0(6)+az];
%% Computation
param0 = zeros(4*n,1);
[param1, cost] = fmincon(@costfun,param0,[],[],[],[],[],[],@nonlinc);
[p_dat, PHI_dat, T_dat] = plotDLO(param1);
%% Fourier calculation
N = 5;
[s,~,shape_est_Fourier] = Fourier_curve_3D(p_dat,L,N);
%%
q = robot.ikine(T);
figure
robot.plot(q(1,:));hold on
plot3(p_dat(:,1),p_dat(:,2),p_dat(:,3),'k-','linewidth',2);hold on
plot3(shape_est_Fourier(:,1),shape_est_Fourier(:,2),shape_est_Fourier(:,3),'r-.','linewidth',2);hold on
grid on
T_world = eye(4);
T_base_ur5 = eye(4);
T_end_ur5 = T;
T_base_shape = T_dat(1:4,(1*4-3):(1*4));
T_end_shape = T_dat(1:4,(end-3):(end));
DrawAllFrame(T_world,T_base_ur5,T_end_ur5,T_base_shape,T_end_shape);