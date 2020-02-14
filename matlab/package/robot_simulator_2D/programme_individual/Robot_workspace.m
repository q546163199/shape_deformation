function Robot_workspace()

global robot

maxlength = robot.link1.length + robot.link2.length;
N = 200;
theta = linspace(0,2*pi,N);
for i=1:N
    x(i) = maxlength * cos(theta(i));
    y(i) = maxlength * sin(theta(i));
end
plot(x,y,'--b','linewidth',2)
