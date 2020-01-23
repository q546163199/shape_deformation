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
    T_base = T0;
    T_world = eye(4);
    T_end = T6;
    DrawFrame(T_base,1,2);hold on
    text(T_base(1,4),T_base(2,4),T_base(3,4)-0.1,'Base','fontsize',12)
    DrawFrame(T_world,1,2);hold on
    text(T_world(1,4),T_world(2,4),T_world(3,4)-0.1,'World','fontsize',12)
    DrawFrame(T_end,1,2);hold off
    text(T_end(1,4),T_end(2,4),T_end(3,4)-0.1,'End','fontsize',12)
    %%
    qt = robot.ikine(T6);
    for j=1:8
        error(:,:,j) = T6 - robot.fkine(qt(j,:));
        norm(error(:,:,j))
    end
    drawnow
end