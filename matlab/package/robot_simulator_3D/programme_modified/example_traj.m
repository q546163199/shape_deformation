clc;clear;close all
%%
robot = robot_6DOF(0.6,0.6,0.6);
%% 轨迹规划参数设置
init_ang = [0 0 0 0 0 0];
targ_ang = [pi/4, -pi/3, pi/5, pi/2, -pi/4, pi/6];
qd0 = ones(1,6) * 0.5;
qd1 = ones(1,6) * 0.5;
step = 50;
%% 轨迹规划方法
[q,dq,ddq] = robot.jtraj(init_ang,targ_ang,step,qd0,qd1);
figure
subplot(3,1,1)
i = 1:6;
plot(q(:,i));
grid on;
subplot(3,1,2)
i = 1:6;
plot(dq(:,i));
grid on;
subplot(3,1,3)
i = 1:6;
plot(ddq(:,i));
grid on;