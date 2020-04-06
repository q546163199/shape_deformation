clc;clear;close all
%%
robot = robot_6DOF(0,0,0);
%%
T = Euler2T([0.1 0.2 0.3]);
T(1,4) = 2;
T(2,4) = 2;
T(3,4) = 1;
q = robot.ikine(T);
angle = T2Euler(T);
[T6,T5,T4,T3,T2,T1,T0] = robot.fkine(q(1,:));
robot.plot(q(1,:));hold on;grid on
T6 - T
%%
DrawAllFrame(eye(4),eye(4),T6,[],[])