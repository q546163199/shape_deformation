clc;clear;close all 
%ini robot
L1=Link([0 12.4  0  pi/2 0 -pi/2 ]);
L2=Link([0 0     0 -pi/2         ]);
L3=Link([0 15.43 0  pi/2         ]);
L4=Link([0 0     0 -pi/2 0  0    ]);
L5=Link([0 15.92 0  pi/2         ]);
L6=Link([0 0     0 -pi/2         ]);
L7=Link([0 15    0  0    0  pi/2 ]);
Rbt=SerialLink([L1 L2 L3 L4 L5 L6 L7],'name','my robot');
%init param
qsq0=[0 0 0 0 0 0 0];
qsq1=[0.46088 0.37699 0 1.31 0 1.4451 0];
qsq2=[0.81681 0.56549 0 1.0681 0 1.2566 0 ];
qsq3=[2.36 0.69115 0 0.848 0 1.4451 0 ];
qsq4=[2.66 0.37699 0 1.31 0 1.4451 0];
qsq5=[pi/2 0.62831 0 1.5708 0 0.94249 0];
qsq6=[0 0.62831 0 1.5708 0 0.94249 0];
%calculate trajectory
t=50;
sqtraj1=jtraj(qsq0,qsq1,t); 
sqtraj2=jtraj(qsq1,qsq2,t); 
sqtraj3=jtraj(qsq2,qsq3,t); 
sqtraj4=jtraj(qsq3,qsq4,t);
sqtraj5=jtraj(qsq4,qsq5,t);
sqtraj6=jtraj(qsq5,qsq6,t);
sqtraj7=jtraj(qsq6,qsq0,t);

% view(-35,40);
xlim([-40,40])
ylim([-40,40])
zlim([0,60])
%step1 display
for i=1:1:t
    atj1(i)=Rbt.fkine(sqtraj1(i,:)); %给定关节角,得到位姿4x4矩阵
    tt(i,:)=transl(atj1(i));
    plot3(tt(:,1),tt(:,2),tt(:,3),'b.');hold on
end
for i=1:1:t
    Rbt.plot(sqtraj1(i,:));
    plot2(atj1(i).t(1:3)','r*');
end
%step2 display
for i=1:1:t
    atj2(i)=Rbt.fkine(sqtraj2(i,:));
    tt(i,:)=transl(atj2(i));
    plot3(tt(:,1),tt(:,2),tt(:,3),'b.');hold on
end
for i=1:1:t
    Rbt.plot(sqtraj2(i,:))
    plot2(atj2(i).t(1:3)','r*');
end
%step3 display
for i=1:1:t
    atj3(i)=Rbt.fkine(sqtraj3(i,:));
    tt(i,:)=transl(atj3(i));
    plot3(tt(:,1),tt(:,2),tt(:,3),'b.');hold on
end
for i=1:1:t
    Rbt.plot(sqtraj3(i,:))
    plot2(atj3(i).t(1:3)','r*');
end
%step4 display
for i=1:1:t
    atj4(i)=Rbt.fkine(sqtraj4(i,:));
    tt(i,:)=transl(atj4(i));
    plot3(tt(:,1),tt(:,2),tt(:,3),'b.');hold on
end
for i=1:1:t
    Rbt.plot(sqtraj4(i,:))
    plot2(atj4(i).t(1:3)','r*');
end
%step5 display
for i=1:1:t
    atj5(i)=Rbt.fkine(sqtraj5(i,:));
    tt(i,:)=transl(atj5(i));
    plot3(tt(:,1),tt(:,2),tt(:,3),'b.');hold on
end
for i=1:1:t
    Rbt.plot(sqtraj5(i,:))
    plot2(atj5(i).t(1:3)','r*');
end
%step6 display
for i=1:1:t
    atj6(i)=Rbt.fkine(sqtraj6(i,:));
    tt(i,:)=transl(atj6(i));
    plot3(tt(:,1),tt(:,2),tt(:,3),'b.');hold on
end
for i=1:1:t
    Rbt.plot(sqtraj6(i,:))
    plot2(atj6(i).t(1:3)','r*');
end
%step7 display
for i=1:1:t
    atj7(i)=Rbt.fkine(sqtraj7(i,:));
    tt(i,:)=transl(atj7(i));
    plot3(tt(:,1),tt(:,2),tt(:,3),'b.');hold on
end
for i=1:1:t
    Rbt.plot(sqtraj7(i,:))
    plot2(atj7(i).t(1:3)','r*');
end
