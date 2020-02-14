%init model
ur5_model
%init param
step=10;
init_ang = rand(1,6);
targ_ang = rand(1,6);
T0 = robot.fkine(init_ang);%forward solution
T1 = robot.fkine(targ_ang);%inverse solution
Tc = ctraj(T0,T1,step);    %get line matrix
tt = transl(Tc);           %get xyz position vector
q  = robot.ikine(Tc);      %inverse solution with Tc
tt1=[0 0 0];                

for i=1:length(q)
    T=robot.fkine(q(i,:)); %给定关节角,得到位姿4x4矩阵
    tt1_=transl(T);
    if i==1
        tt1=tt1_;
    else
        tt1=[tt1;tt1_];
    end
    
    robot.plot(q(i,:)); 
    plot2(T.t(1:3)','b.');hold on
    plot2(Tc(i).t(1:3)','r.');hold on
end

figure 
plot3(tt(:,1),tt(:,2),tt(:,1),'r.');hold on
plot3(tt1(:,1),tt1(:,2),tt1(:,1),'b.');
legend('desired','actual')

err=tt-tt1;

