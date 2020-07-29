clc;clear;close all
%%
robot = robot_6DOF(0,0,0);
%%
load('data','xt'); load('At')
%% Definition of ,''the global frame:
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
%% target shape
state0 = [1 2 0 0 0 0]; % positon and orientation of left point
q_target = xt(25,:);
T = robot.fkine(q_target);
angle = T2Euler(T);
lx = T(1,4) - state0(1);
ly = T(2,4) - state0(2);
lz = T(3,4) - state0(3);
ax = angle(1);
ay = angle(2);
az = angle(3);
state1 = [state0(1)+lx state0(2)+ly state0(3)+lz state0(4)+ax state0(5)+ay state0(6)+az];
param0 = zeros(4*n,1);
[param1, cost] = fmincon(@costfun,param0,[],[],[],[],[],[],@nonlinc);
[shape_target, PHI_dat, T_dat] = plotDLO(param1);
[y_target,G,~] = Fourier_curve_3D(shape_target,L,6);
%% init shape
q_init = xt(32,:);
q_real = q_init;
%% start move
lambda = 0.1;
step = 1;
param0 = zeros(4*n,1);
while true
    T = robot.fkine(q_real);
    angle = T2Euler(T);
    lx = T(1,4) - state0(1);
    ly = T(2,4) - state0(2);
    lz = T(3,4) - state0(3);
    ax = angle(1);
    ay = angle(2);
    az = angle(3);
    state1 = [state0(1)+lx state0(2)+ly state0(3)+lz state0(4)+ax state0(5)+ay state0(6)+az];
    [param1, cost] = fmincon(@costfun,param0,[],[],[],[],[],[],@nonlinc);
    param0 = param1;
    [shape_real, PHI_dat, T_dat] = plotDLO(param1);
    [y_real,G,~] = Fourier_curve_3D(shape_real,L,6);
    %% calculate error and display process steps
    shape_error(step,:) = norm(shape_real - shape_target,2);
    %%
    subplot(1,2,1)
    robot.plot(q_real(1,:));hold on
    plot3(shape_real(:,1),shape_real(:,2),shape_real(:,3),'k-','linewidth',2);hold on
    plot3(shape_target(:,1),shape_target(:,2),shape_target(:,3),'r-.','linewidth',2);hold on
    grid on
    view([45 20])
    T_world = eye(4);
    T_base_ur5 = eye(4);
    T_end_ur5 = T;
    T_base_shape = T_dat(1:4,(1*4-3):(1*4));
    T_end_shape = T_dat(1:4,(51*4-3):(51*4));
    DrawAllFrame(T_world,T_base_ur5,T_end_ur5,T_base_shape,T_end_shape);
    subplot(1,2,2)
    plot(shape_error(1:step),'k-*','linewidth',2)
    grid on
    drawnow
    %%
    fprintf('Error between real and targer is %f step: %d \n',shape_error(step,:),step)
    if step > 69
        break;
    end
    step = step + 1;
    %% veloctity controller design
    ut = -lambda * pinv(At) * (y_real - y_target);
    %% xt update
    q_real = q_real + ut';
end