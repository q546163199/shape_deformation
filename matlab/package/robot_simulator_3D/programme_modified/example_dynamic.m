clc;clear;close all
%%
robot = robot_6DOF(0.6,0.6,0.6);
%%
N = 150;
q = ones(1,6)/2;
for i=1:N
    q = q + 0.0001 * i;
    [T6,T5,T4,T3,T2,T1,T0] = robot.fkine(q);
    robot.plot(q);hold on
    grid on
    %%
    DrawAllFrame(eye(4),T0,T6,[],[]);hold off
    %%
    qt = robot.ikine(T6);
    for j=1:8
        error(:,:,j) = T6 - robot.fkine(qt(j,:));
        norm(error(:,:,j))
    end
    drawnow
end