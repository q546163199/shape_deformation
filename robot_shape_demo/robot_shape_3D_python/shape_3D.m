function [p_dat, PHI_dat, T_dat, param1] = shape_3D(state_init, state_end, cable_length, param0)
addpath('/home/qjm/ShapeDeformationProj/GIthub/shape_deformation/matlab_package/shape_simulator_3D')
addpath('/home/qjm/ShapeDeformationProj/GIthub/shape_deformation/matlab_package/shape_simulator_3D/')
addpath('/home/qjm/ShapeDeformationProj/GIthub/shape_deformation/matlab_package/shape_simulator_3D/Tools')
%% Definition of the global frame:
global Rf Rt Re D L
global n s0 s1 ds lx ly lz state0 state1
L = cable_length;
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
state0 = state_init;
lx = 0.4;
ly = 0.4;
lz = -0.3;
ax = pi/4;
ay = pi/2 + pi/8 + pi/4;
az = pi/4;
state1 = state_end;
%%
switch nargin
    case 3
        param0 = zeros(4*n, 1);
        %%fprintf('%d', nargin)
end
%% Computation
[param1, cost] = fmincon(@costfun,param0,[],[],[],[],[],[],@nonlinc);
[p_dat, PHI_dat, T_dat] = plotDLO(param1);











