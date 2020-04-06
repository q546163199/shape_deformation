function robot = Robot_setup(length1,length2)

%% define the length of link1 and link2
robot.link1.length = length1;
robot.link2.length = length2;
%% define the positon of origin,default = [0 0]
robot.origin.x = 0;
robot.origin.y = 0;
end

