function q = Robot_ikine(p2)

%% robot is global variable
global robot
l1 = robot.link1.length;
l2 = robot.link2.length;
x = p2.x;
y = p2.y;
%% judge if the position in the workspace
isField = Robot_isField(p2);
if ~isField
    q = [];
    fprintf('The position is not in the workspace, pleast try it again\n');
    return
end
%% elbow shape choose
elbow_case = 2;
%%
elbow_up = 1;
elbow_down = 2;
%%
c2 = (x^2 + y^2 -l1^2 -l2^2)/(2*l1*l2);
switch elbow_case
    case elbow_up
        s2 = -sqrt(1-c2^2);
    case elbow_down
        s2 = sqrt(1-c2^2);
end
%% calculate q2 and q1
q2 = atan2(s2,c2);
k1 = l1 + l2 * c2;
k2 = l2 * s2;
q1 = atan2(y,x) - atan2(k2,k1);
q = [q1;q2];
end