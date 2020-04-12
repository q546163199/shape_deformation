clc;clear;close all
%%
p_dat = load('pcd_3D_1.txt');
row = size(p_dat, 1);
col = size(p_dat, 2);
for i=1:row
    x = p_dat(i,1);
    y = p_dat(i,2);
    z = p_dat(i,3);
    r = sqrt(x^2 + y^2 + z^2);
    theta = atan2(sqrt(x^2 + y^2), z);
    psi = atan2(y, x);
    polar_coor(i,:) = [r rad2deg(theta) rad2deg(psi)];
end
theta_max = max(polar_coor(:,2));
theta_min = min(polar_coor(:,2));
psi_max = max(polar_coor(:,3)); 
psi_min = min(polar_coor(:,3)); 
theta_judge = linspace(theta_min,theta_max, 100);
psi_judge = linspace(psi_min,psi_max,200);
%%
for i=1:row
    for j=1:length(theta_judge)
        if polar_coor(i,2) <= theta_judge(j)
            for k=1:length(psi_judge)
                if (polar_coor(i,3) <= psi_judge(k))
                    polar_coor(i,4) = j*k;
                    break;
                end
            end
        end      
    end
end

new = [];
for i=1:row
    index = find(polar_coor(:,4) == polar_coor(i,4));
    temp = [index polar_coor(index,:)];
    [~,index1] = max(temp(:,2)); 
    
    if isempty(new)
        new = [new; temp(index1,:)];
    end
    
    if ~ismember(temp(index1,1), new(:,1))
        new = [new; temp(index1,:)];
    end
end
index2 = new(:,1);
%%
figure
plot3(p_dat(index2,1),p_dat(index2,2),p_dat(index2,3),'k.','linewidth',3);hold on
% plot3(p_dat(:,1),p_dat(:,2),p_dat(:,3),'k.','linewidth',3);hold on
grid on
daspect([1 1 1])
title('Euler Rotation is XYZ')
T_world = eye(4);
T_base_ur5 = [];
T_end_ur5 = [];
T_base_shape = [];
T_end_shape = [];
DrawAllFrame(T_world,T_base_ur5,T_end_ur5,T_base_shape,T_end_shape)