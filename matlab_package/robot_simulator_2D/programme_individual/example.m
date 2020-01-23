clc;clear;close all
global robot;
%%
length_link1 = 1;length_link2 = 1;
robot = Robot_setup(length_link1,length_link2);
%%
N = 100;
theta = linspace(0,2*pi,N);
for i=1:N
    %% generate circle trajectory
    traj(i,1) = 1.5 * cos(theta(i));
    traj(i,2) = 1.5 * sin(theta(i));
    p2.x = traj(i,1);
    p2.y = traj(i,2);
    %% inverse to get q
    [q] = Robot_ikine(p2);
    %% forward to get real p1 and p2 based on the above q
    [~,p2] = Robot_fkine(q);
    %% robot move and plot target point and real point
    plot(traj(1:i,1),traj(1:i,2),'k--','linewidth',1.5);hold on
    plot(p2.x,p2.y,'rx','linewidth',15);hold on
    Robot_plot(q);hold off
    grid on
    drawnow
end