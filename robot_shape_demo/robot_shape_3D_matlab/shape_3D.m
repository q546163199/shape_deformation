function [shape, PHI, T, para_temp] = shape_3D(state_init, state_end, cable_length, param0)
addpath('C:\Users\q5461\OneDrive\�ĵ�\GitHub\shape_deformation\matlab_package\shape_simulator_3D\')
addpath('C:\Users\q5461\OneDrive\�ĵ�\GitHub\shape_deformation\matlab_package\shape_simulator_3D\Tools')
addpath('C:\Users\q5461\OneDrive\�ĵ�\GitHub\shape_deformation\matlab_package\robot_simulator_3D\programme_modified')
addpath('C:\Users\q5461\OneDrive\�ĵ�\GitHub\shape_deformation\matlab_package\shape_representation\Fourier')
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
state1 = state_end;
%%
switch nargin
    case 3
        param0 = zeros(4*n, 1);
        fprintf('%d', nargin)
end
%% Computation
[param1, cost] = fmincon(@costfun,param0,[],[],[],[],[],[],@nonlinc);
[p_dat, PHI_dat, T_dat] = plotDLO(param1);
%% output
shape = p_dat;
PHI = PHI_dat;
T = T_dat;
para_temp = param1;








