function handle = Robot_plot(q)

%% robot is global variable
global robot
%% forward calculation
[p1,p2] = Robot_fkine(q);
%% plot figure
handle = plot([robot.origin.x p1.x p2.x],[robot.origin.y p1.y p2.y],'k-*','linewidth',2);
%% axis limitation
axis_limit = robot.link1.length + robot.link2.length + 0;
axis([-axis_limit axis_limit -axis_limit axis_limit])
daspect([1 1 1])
end