clc;clear;close all
%%
robot = robot_2DOF(1,1,0.2,0.3,2);
%%
N = 200;
theta = linspace(0,2*pi,N);
pitch = deg2rad(210);
for i=1:N
    traj(i,1) = 0.7 + 0.3*cos(theta(i));
    traj(i,2) = 0.8 + 0.3*sin(theta(i));
    p2.x = traj(i,1);
    p2.y = traj(i,2);
    q = robot.ikine(p2);
    the = sum(q) - pi;
    rad2deg(the)
    plot(traj(1:i,1),traj(1:i,2),'k--','linewidth',1.5);hold on
    robot.plot(q);hold on
    Draw2DFrame(q, p2, 0.5, 1)
    axis([-1.5 1.5 -1.5 1.5])
    grid on
    drawnow
end