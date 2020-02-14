clc;clear;close all
%%
robot = robot_3DOF(1,1,1,0.2,0.3,2);
%%
N = 200;
theta = linspace(0,2*pi,N);
pitch = deg2rad(210);
for i=1:N
    traj(i,1) = 0.2 + 0.3*cos(theta(i));
    traj(i,2) = 0.3 + 0.3*sin(theta(i));
    p3.x = traj(i,1);
    p3.y = traj(i,2);
    q = robot.ikine(p3,pitch + theta(i));
    the = sum(q) - pi;
    rad2deg(the)
    plot(traj(1:i,1),traj(1:i,2),'k--','linewidth',1.5);hold on
    robot.plot(q);hold off
    axis([-2 2 -2 2])
    grid on
    drawnow
end