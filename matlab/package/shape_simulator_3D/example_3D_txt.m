clc;clear;close all
%% Constraints
state0 = [0.45672169 -0.25137791  0.83653642  0.35574022 -1.56994948 -1.92758319];
state1 = [0.45670461  0.25185566  0.83623001 -0.79692865 -1.56965789  2.36667874];
cable_length = 1;
param0 = zeros(4*6, 1);
%%
[p_dat, PHI_dat, T_dat, ~] = dlodynamics_3D(state0,state1,cable_length,param0);
%%
modified = point_cloud_fill(p_dat,150,0.025,2.2);
figure
plot3(modified(:,1),modified(:,2),modified(:,3),'k.','linewidth',1);hold on
grid on
daspect([1 1 1])
title('Euler Rotation is XYZ')
DrawAllFrame(eye(4),[],[],T_dat(1:4,(1*4-3):(1*4)),T_dat(1:4,(size(p_dat,1)*4-3):(size(p_dat,1)*4)))
%%
for i=1:2
    filename=['pcd_3D_',num2str(i),'.txt'];
    save(filename, 'modified', '-ascii')
end