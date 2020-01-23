function Robot_plot_circle(radius,bias)

n = 100;
theta = linspace(0,2*pi,n);

for i=1:n
    traj(i,1) = radius*cos(theta(i)) + bias.x;
    traj(i,2) = radius*sin(theta(i)) + bias.y;
end
plot(traj(:,1),traj(:,2),'--','linewidth',1.5)
% axis([bias.x-radius bias.x+radius bias.y-radius bias.y+radius])
end