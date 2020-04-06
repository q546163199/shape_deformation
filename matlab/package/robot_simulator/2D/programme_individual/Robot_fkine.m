function [p1,p2] = Robot_fkine(q)

%% robot is global variable
global robot
l1 = robot.link1.length;
l2 = robot.link2.length;
q1 = q(1);
q2 = q(2);
%% calculate the position of the end point of link1 and link2
p1.x = l1 * cos(q1);
p1.y = l1 * sin(q1);
p2.x = l1 * cos(q1) + l2 * cos(q1 + q2);
p2.y = l1 * sin(q1) + l2 * sin(q1 + q2);
end

