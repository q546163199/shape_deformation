clc;clear;close all
addpath('C:\Users\q5461\OneDrive\文档\GitHub\shape_deformation\matlab_package\robot_simulator_3D\programme_modified')
addpath('C:\Users\q5461\OneDrive\文档\GitHub\shape_deformation\matlab_package\custom_feature_package')
addpath('C:\Users\q5461\OneDrive\文档\GitHub\shape_deformation\matlab_package\shape_simulator_3D\')
addpath('C:\Users\q5461\OneDrive\文档\GitHub\shape_deformation\matlab_package\shape_simulator_3D\Tools')
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
%% dynamic
number = 50;
state0 = [1 2 0 0 0 0]; % positon and orientation of left point
q0 = [ -2.53296143579338,...
       -0.163830123946357,...
        1.18901198538923,...
        0.622267504464277,...
        1.76649902241177,...
       -1.19463682364673];
param0 = zeros(4*n,1);
for i=1:number
    q = q0 + (rand - 0.5) / 5;
    T = robot.fkine(q);
    angle = T2Euler(T);
    lx = T(1,4) - state0(1);
    ly = T(2,4) - state0(2);
    lz = T(3,4) - state0(3);
    ax = angle(1);
    ay = angle(2);
    az = angle(3);
    state1 = [state0(1)+lx state0(2)+ly state0(3)+lz state0(4)+ax state0(5)+ay state0(6)+az];
    %% Computation
    [param1, cost] = fmincon(@costfun,param0,[],[],[],[],[],[],@nonlinc);
    [p_dat, PHI_dat, T_dat] = plotDLO(param1);
    param0 = param1;
    %% Fourier calculation
    [coff,G,shape_est_Fourier] = Fourier_curve_3D(p_dat,L,5);
    %%
    robot.plot(q(1,:));hold on
    plot3(p_dat(:,1),p_dat(:,2),p_dat(:,3),'r-.','linewidth',2);hold on
    plot3(shape_est_Fourier(:,1),shape_est_Fourier(:,2),shape_est_Fourier(:,3),'k-','linewidth',2);hold on
    grid on
    view([45 20])
    %%
    T_world = eye(4);
    T_base_ur5 = eye(4);
    T_end_ur5 = T;
    T_base_shape = T_dat(1:4,(1*4-3):(1*4));
    T_end_shape = T_dat(1:4,(51*4-3):(51*4));
    DrawAllFrame(T_world,T_base_ur5,T_end_ur5,T_base_shape,T_end_shape);
    hold off
    drawnow
    %% save data
    xt(i,:) = q;
    yt(i,:) = coff';
    shape_real_save(:,:,i) = p_dat;
    fprintf('iterative steps: %d',i);
end
save data