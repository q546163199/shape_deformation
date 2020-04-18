clc;clear;close all
%%
angle = [0.1,0.2, 0.3];
T1 = Euler2T(angle)
% T2Euler(T1)
T2 = angle2dcm(angle(3),angle(2),angle(1),'ZYX')'
[a,b,c] = dcm2angle(T2','ZYX');