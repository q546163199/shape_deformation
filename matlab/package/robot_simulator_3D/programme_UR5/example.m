clc;clear;close all
addpath('C:\Users\q5461\OneDrive\ÎÄµµ\GitHub\shape_deformation\matlab_package\custom_feature_package')
addpath('C:\Users\q5461\OneDrive\ÎÄµµ\GitHub\shape_deformation\matlab_package\shape_simulator_3D\Tools')
%%
robot = robot_UR5(0,0,0);
%%
% q = deg2rad([0 -90 0 -90 0 0]);
q = deg2rad([30 30 30 20 60 50]);
[T6,T5,T4,T3,T2,T1,T0] = robot.fkine(q);
angle = robot.ikine(T6);
robot.plot(q);
hold on
grid on
%%
T_world = eye(4);
T_base_ur5 = eye(4);
T_end_ur5 = T6;
DrawAllFrame(T_world,T_base_ur5,T_end_ur5)