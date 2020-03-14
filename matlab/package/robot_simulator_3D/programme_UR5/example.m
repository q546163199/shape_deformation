clc;clear;close all
%%
robot = robot_UR5(0,0,0);
%%
q = deg2rad([30 30 30 20 60 50]);
[T6,T5,T4,T3,T2,T1,T0] = robot.fkine(q);
angle = robot.ikine(T6);
robot.plot(q);
hold on
grid on
%%
DrawAllFrame(eye(4),eye(4),T6,[],[])