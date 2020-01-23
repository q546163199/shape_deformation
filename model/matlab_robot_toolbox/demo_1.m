clc;clear;close all
%建立机器人模型
%       theta    d        a        alpha     R/L
L1=Link([0       0.4      0.025    pi/2      0     ]); %定义连杆的D-H参数
L2=Link([pi/2    0        0.56     0         0     ]);
L3=Link([0       0        0.035    pi/2      0     ]);
L4=Link([0       0.515    0        pi/2      0     ]);
L5=Link([pi      0        0        pi/2      0     ]);
L6=Link([0       0.08     0        0         0     ]);
robot=SerialLink([L1 L2 L3 L4 L5 L6],'name','manman'); %连接连杆，机器人取名manman
robot.display();
% robot.edit
robot.teach

T1=transl(0.5,0.4,0.3);  %根据给定起始点，得到起始点位姿
T2=transl(-0.7,-0.6,0.1);%根据给定终止点，得到终止点位姿
q1=robot.ikine(T1);      %根据起始点位姿，得到起始点关节角
q2=robot.ikine(T2);      %根据终止点位姿，得到终止点关节角

length=100;
QDO=0.5*ones(1,6);QD1=1*ones(1,6);
[q,dq,ddq]=jtraj(q1,q2,length,QDO,QD1); %五次多项式轨迹，得到关节角度，角速度，角加速度

for i=1:1:length
    T=robot.fkine(q(i,:)); %给定关节角,得到位姿4x4矩阵
    robot.plot(q(i,:)); 
    plot2(T.t(1:3)','r.');hold on
end

figure
subplot(3,1,1)
i=1:6;plot(q(:,i));
subplot(3,1,2)
i=1:6;plot(dq(:,i));
subplot(3,1,3)
i=1:6;plot(ddq(:,i));
