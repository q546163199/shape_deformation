clc;clear;close all
%建立机器人模型
%       theta    d        a        alpha     R/L
L1=Link([0       0.4      0.025    pi/2      0     ]); %定义连杆的D-H参数
L2=Link([pi/2    0        0.56     0         0     ]);
L3=Link([0       0        0.035    pi/2      0     ]);
% L4=Link([0       0.515    0        pi/2      0     ]);
% L5=Link([pi      0        0        pi/2      0     ]);
% L6=Link([0       0.08     0        0         0     ]);
robot=SerialLink([L1 L2 L3],'name','manman'); %连接连杆，机器人取名manman
robot.display();

step=pi/4;
k=1;
for q1=-2*pi:step:2*pi
    for q2=-2*pi:step:2*pi
        for q3=-2*pi:step:2*pi
              q=[q1 q2 q3];
              T = robot.fkine(q); 
              Tc(:,k) = T.t; 
              plot3(Tc(1,k),Tc(2,k),Tc(3,k),'r.');hold on
              robot.plot(q);  
              k=k+1;   
              axis([-2 2 -2 2 -1 2])    
        end        
    end
end

