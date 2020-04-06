function isField = Robot_isField(p2)

%% robot is global variable
global robot
l1 = robot.link1.length;
l2 = robot.link2.length;
x = p2.x;
y = p2.y;
%% judge if the position in the workspace
judge = (x^2 + y^2 -l1^2 -l2^2)/(2*l1*l2);
if abs(judge) > 1
    isField = false;
else
    isField = true;
end
%%
end
