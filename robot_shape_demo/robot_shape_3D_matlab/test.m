clc;clear;close all
%% Definition of ,''the global frame:
cable_length = 2;
%% target shape
state0 = [-0.2 -0.2 0 0 0 0]; % positon and orientation of left point
lx = 0.4;
ly = 0.4;
lz = -0.3;
ax = pi/4;
ay = pi/2 + pi/8 + pi/4;
az = pi/4;
state1 = [state0(1)+lx state0(2)+ly state0(3)+lz state0(4)+ax state0(5)+ay state0(6)+az];
param0 = zeros(24, 1);
%%
[shape, PHI, T, para_temp] = shape_3D(state0, state1, cable_length);
%%
figure
plot3(shape(:,1),shape(:,2),shape(:,3),'k-','linewidth',3);hold on
grid on
daspect([1 1 1])
%%
T_world = eye(4);
T_base_ur5 = [];
T_end_ur5 = [];
T_base_shape = T(1:4,(1*4-3):(1*4));
T_end_shape = T(1:4,(51*4-3):(51*4));
DrawAllFrame(T_world,T_base_ur5,T_end_ur5,T_base_shape,T_end_shape);