function [p_dat, PHI_dat, T_dat, param1] = dlodynamics_3D(state_init, state_end, cable_length, param0)
%% Definition of the global frame:
global Rf Rt Re D L
global n s0 s1 ds lx ly lz state0 state1
L = cable_length;
Rf = 1;       % Flexural coefficient
Rt = 1;       % Torsional coefficient
Re = 0.0;     % extension coefficient
D = 0.0;      % weight par m
N = 100;
s0 = 0;
s1 = L;    
ds = (s1 - s0)/N;
kmax = 2;             % Use 2nd order approximation
n = 2 * kmax + 2;     % number of parameters per varaible
%% left and right constraints
state0 = state_init;
state1 = state_end;
lx = state1(1) - state0(1);
ly = state1(2) - state0(2);
lz = state1(3) - state0(3);
ax = state1(4) - state0(4);
ay = state1(5) - state0(5);
az = state1(6) - state0(6);
%%
switch nargin
    case 3
        param0 = zeros(4*n, 1);
end
%% Computation
[param1, cost] = fmincon(@costfun,param0,[],[],[],[],[],[],@nonlinc);
[p_dat, PHI_dat, T_dat] = plotDLO(param1);