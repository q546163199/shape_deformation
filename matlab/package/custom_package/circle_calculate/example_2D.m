clc;clear;close all
%%
N = 100;
theta = linspace(0,2*pi,N);
radius = 3 * rand;
bias.x = 4 * rand;
bias.y = 5* rand;
for i=1:N
    x(i) = radius * cos(theta(i)) + bias.x;
    y(i) = radius * sin(theta(i)) + bias.y;
end
%%
p1.x = x(1);
p1.y = y(1);
p2.x = x(25);
p2.y = y(25);
p3.x = x(51);
p3.y = y(51);
% [R,centre] = circle_2D(p1,p2,p3);
% [R,centre,zeta] = circle_2D_David_modi(p1,p2,p3);
% [R,centre] = circle_2D_David_orig(p1,p2,p3);
[R,centre] = circle_2D_Net(p1,p2,p3);

figure
plot(x,y,'k.','linewidth',1);hold on
plot([centre.x p1.x],[centre.y p1.y],'r-','linewidth',2);hold on
plot([centre.x p2.x],[centre.y p2.y],'g-','linewidth',2);hold on
plot([centre.x p3.x],[centre.y p3.y],'b-','linewidth',2);hold on
plot(p1.x,p1.y,'ro','linewidth',3);hold on
plot(p2.x,p2.y,'go','linewidth',3);hold on
plot(p3.x,p3.y,'bo','linewidth',3);hold on
plot(centre.x,centre.y,'kx','linewidth',15);hold on
grid on
daspect([1 1 1])
%%
for i=1:N
    test(i) = sqrt((x(i)-centre.x)^2 + (y(i)-centre.y)^2) - R; 
end
norm(test)
%%