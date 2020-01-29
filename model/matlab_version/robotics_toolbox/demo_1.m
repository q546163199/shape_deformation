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
robot.display();
% robot.edit
robot.teach

T1=transl(0.5,0.4,0.3);  %���ݸ�����ʼ�㣬�õ���ʼ��λ��
T2=transl(-0.7,-0.6,0.1);%���ݸ�����ֹ�㣬�õ���ֹ��λ��
q1=robot.ikine(T1);      %������ʼ��λ�ˣ��õ���ʼ��ؽڽ�
q2=robot.ikine(T2);      %������ֹ��λ�ˣ��õ���ֹ��ؽڽ�

length=100;
QDO=0.5*ones(1,6);QD1=1*ones(1,6);
[q,dq,ddq]=jtraj(q1,q2,length,QDO,QD1); %��ζ���ʽ�켣���õ��ؽڽǶȣ����ٶȣ��Ǽ��ٶ�

for i=1:1:length
    T=robot.fkine(q(i,:)); %�����ؽڽ�,�õ�λ��4x4����
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
