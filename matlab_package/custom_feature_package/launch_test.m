clc;clear;close all
%%
% p1.x = 1;
% p1.y = 1;
% p1.z = 0;
% p2.x = 0.5;
% p2.y = 1;
% p2.z = 0;
% p3.x = 0.5 - sqrt(2)/2;
% p3.y = 1 - sqrt(2)/2;
% p3.z = 1;
% 
% angle = rad2deg(Folding_angle(p1,p2,p3));
% plot3([p1.x p2.x p3.x],[p1.y,p2.y,p3.y],[p1.z,p2.z,p3.z],'k-*','linewidth',3)
% grid on
% axis([-1 1 -1 1 0 2])

T1 = Euler2T(deg2rad([80 120 170]));
T2 = Euler2T(deg2rad([-100 60 -10]));
angle = rad2deg(T2Euler(T1));
T1 - T2
