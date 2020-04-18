clc;clear;close all
%%
robot = robot_UR5(0,0,0);
%%
q = deg2rad([10 20 30 40 50 60]);
[T6,T5,T4,T3,T2,T1,T0] = robot.fkine(q);
% angle = robot.ikine(T6);
robot.plot(q);
% set(gcf,'windowButtonDownFcn',@robot.WindowButtonDownFcn);

hold on
grid on
%%
DrawAllFrame(eye(4),eye(4),T6,[],[])