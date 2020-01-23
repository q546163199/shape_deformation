clc;clear;close all
addpath('..\..\custom_feature_package')
addpath('..\..\shape_simulator_3D\Tools\')
%%
robot = robot_6DOF(0,0,0);
%%
traj = robot.circle(2);
N = size(traj,1);
for i=11:90
    T = Euler2T([0.1 0.1 0.1]);
    T(1,4) = traj(i,1);
    T(2,4) = traj(i,2);
    T(3,4) = traj(i,3);
    q = robot.ikine(T);
    robot.plot(q(1,:));hold on
    grid on
    %%
    T_world = eye(4);
    T_base_ur5 = eye(4);
    T_end_ur5 = T;
    DrawAllFrame(T_world,T_base_ur5,T_end_ur5)
    drawnow
    pause(0.1)
end