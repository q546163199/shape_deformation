clc;clear;close all
%%
robot = robot_UR5(0,0,0);
%%
traj = robot.circle(0.5);
N = size(traj,1);
for i=11:90
    T = Euler2T([0.1 0.1 0.1]);
    T(1,4) = traj(i,1);
    T(2,4) = traj(i,2);
    T(3,4) = traj(i,3);
    q = robot.ikine(T);
    robot.plot(q(1,:));
    hold on
    grid on
    %%
    DrawAllFrame(eye(4),eye(4),T,[],[]);hold off
    drawnow
    pause(0.01)
end