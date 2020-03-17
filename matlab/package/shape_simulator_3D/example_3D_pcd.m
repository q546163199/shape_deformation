clc;clear;close all
%% Constraints
state0 = [-0.2 -0.2 0 0 0 0]; % positon and orientation of left point
lx = 0.4;
ly = 0.4;
lz = -0.3;
ax = pi/4;
ay = pi/2 + pi/8 + pi/4;
az = pi/4;
state1 = [state0(1)+lx state0(2)+ly state0(3)+lz state0(4)+ax state0(5)+ay state0(6)+az];
param0 = zeros(4*6, 1);
cable_length = 2;
%%
[p_dat, PHI_dat, T_dat, ~] = dlodynamics_3D(state0,state1,cable_length,param0);
%%
modified = point_cloud_fill(p_dat,150,0.025,3);
figure
plot3(modified(:,1),modified(:,2),modified(:,3),'k.','linewidth',1);hold on
grid on
daspect([1 1 1])
title('Euler Rotation is XYZ')
DrawAllFrame(eye(4),[],[],T_dat(1:4,(1*4-3):(1*4)),T_dat(1:4,(51*4-3):(51*4)))
save data modified