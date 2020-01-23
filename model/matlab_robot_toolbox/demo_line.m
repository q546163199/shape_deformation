clc;clear;close all
%����������ģ��
%       theta    d        a        alpha     R/L
L1=Link([0       0.4      0.025    pi/2      0     ]); %�������˵�D-H����
L2=Link([pi/2    0        0.56     0         0     ]);
L3=Link([0       0        0.035    pi/2      0     ]);
L4=Link([0       0.515    0        pi/2      0     ]);
L5=Link([pi      0        0        pi/2      0     ]);
L6=Link([0       0.08     0        0         0     ]);
robot=SerialLink([L1 L2 L3 L4 L5 L6],'name','manman'); %�������ˣ�������ȡ��manman
robot.display

step=50;
T1=transl(0.5,0.4,0.3);  %���ݸ�����ʼ�㣬�õ���ʼ��λ��
T2=transl(-0.7,-0.6,0);%���ݸ�����ֹ�㣬�õ���ֹ��λ��
Tc = ctraj(T1,T2,step);    %get line matrix
tt = transl(Tc);           %get xyz position vector
q  = robot.ikine(Tc);      %inverse solution with Tc

space=[-2 2 -2 2 -1 2];

for i=1:1:step
    T=robot.fkine(q(i,:)); %�����ؽڽ�,�õ�λ��4x4����
    axis(space);
    robot.plot(q(i,:));
%     robot.plot(q(i,:),'scale',2,'workspace',space); 
    plot2(T.t(1:3)','r.');hold on
end

