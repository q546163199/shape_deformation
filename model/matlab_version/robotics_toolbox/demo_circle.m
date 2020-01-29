clc;clear;close all
tic
%建立机器人模型
%       theta    d        a        alpha     R/L
L1=Link([0       0.4      0.025    pi/2      0     ]); %定义连杆的D-H参数
L2=Link([pi/2    0        0.56     0         0     ]);
L3=Link([0       0        0.035    pi/2      0     ]);
L4=Link([0       0.515    0        pi/2      0     ]);
L5=Link([pi      0        0        pi/2      0     ]);
L6=Link([0       0.08     0        0         0     ]);
robot=SerialLink([L1 L2 L3 L4 L5 L6],'name','manman'); %连接连杆，机器人取名manman
default=[1,2,3,4,5,6];
robot.plot(default);
robot.display
radius=0.6;
step=2;
theta=0:10:360;

for i=1:(length(theta)-1)
    T1 = transl(radius*cosd(theta(i))  ,radius*sind(theta(i))  ,1.3);
    T2 = transl(radius*cosd(theta(i+1)),radius*sind(theta(i+1)),1.3);
    Tc = ctraj(T1,T2,step);    %get line matrix
    robot.ikine(Tc);
    q(2*i-(step-1):2*i,:) = robot.ikine(Tc);      %inverse solution with Tc
end

% tt = transl(Tc);           %get xyz position vector
space=[-2 2 -2 2 -1 2];

for i=1:1:length(q)
    T=robot.fkine(q(i,:)); %给定关节角,得到位姿4x4矩阵
    axis(space);
    robot.plot(q(i,:));
    plot2(T.t(1:3)','r.');hold on
end
toc
