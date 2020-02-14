clc;clear;close all
%%
N = 30;
theta = linspace(0,pi,N);
phi = linspace(0,2*pi,N);
radius = 10 * rand;
bias.x = 3 * rand;
bias.y = 4 * rand;
bias.z = 5 * rand;
for i=1:N
    for j=1:N
        x(N*(i-1) + j) = radius * sin(theta(i))*cos(phi(j)) + bias.x;
        y(N*(i-1) + j) = radius * sin(theta(i))*sin(phi(j)) + bias.y;
        z(N*(i-1) + j) = radius * cos(theta(i)) + bias.z;
    end
end
%%
num = 110;
p1.x = x(num);
p1.y = y(num);
p1.z = z(num);
num = 220;
p2.x = x(num);
p2.y = y(num);
p2.z = z(num);
num = 330;
p3.x = x(num);
p3.y = y(num);
p3.z = z(num);
num = 550;
p4.x = x(num);
p4.y = y(num);
p4.z = z(num);
%%
[R,centre] = circle_3D(p1,p2,p3,p4);
%%
figure
plot3(x,y,z,'k*');hold on
plot3([centre.x p1.x],[centre.y p1.y],[centre.z,p1.z],'r-','linewidth',2);hold on
plot3([centre.x p2.x],[centre.y p2.y],[centre.z,p2.z],'r-','linewidth',2);hold on
plot3([centre.x p3.x],[centre.y p3.y],[centre.z,p3.z],'r-','linewidth',2);hold on
plot3([centre.x p4.x],[centre.y p4.y],[centre.z,p4.z],'r-','linewidth',2);hold on
plot3(p1.x,p1.y,p1.z,'bo','linewidth',3);hold on
plot3(p2.x,p2.y,p2.z,'bo','linewidth',3);hold on
plot3(p3.x,p3.y,p3.z,'bo','linewidth',3);hold on
plot3(p4.x,p4.y,p4.z,'bo','linewidth',3);hold on
plot3(centre.x,centre.y,centre.z,'bx','linewidth',10);hold on
grid on
daspect([1 1 1])