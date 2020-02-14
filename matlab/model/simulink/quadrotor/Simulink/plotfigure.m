clc
close all

%%位置曲线
figure
subplot(3,1,1);
plot(x,'r-','LineWidth',2);
grid on
xlabel('t/s');
ylabel('x(m)');
legend('Actual trajectory');

subplot(3,1,2);
plot(y,'r -','LineWidth',2);
grid on
xlabel('t/s');
ylabel('y(m)');
legend('Actual trajectory');

subplot(3,1,3);
plot(z,'r -','LineWidth',2);
grid on
xlabel('t/s');
ylabel('z(m)');
legend('Actual trajectory');

%%角度曲线
figure
subplot(3,1,1);
plot(phi.Time,phi.Data,'r -','LineWidth',2);
legend('Actual trajectory');
grid on
xlabel('t/s');
ylabel('phi(rad)','fontname','Times New Roman','fontsize',12);

subplot(3,1,2);
plot(theta.Time,theta.Data,'r -','LineWidth',2);
legend('Actual trajectory');
grid on
xlabel('t/s');
ylabel('theta(rad)','fontname','Times New Roman','fontsize',12);

subplot(3,1,3);
plot(psi.Time,psi.Data,'r -','LineWidth',2);
legend('Actual trajectory');
grid on
xlabel('t/s');
ylabel('psi(rad)','fontname','Times New Roman','fontsize',12);

% %%角速度曲线
% figure
% plot(dphi.Time,dphi.Data,'r --','LineWidth',2);
% hold on
% plot(dtheta.Time,dtheta.Data,'b -.','LineWidth',2);
% hold on
% plot(dpsi.Time,dpsi.Data,'m -','LineWidth',2);
% legend('v_{\phi}','v_{\theta}','v_{\psi}');
% xlabel('t/s');
% ylabel('rad/s','fontname','Times New Roman','fontsize',12);
% grid on

%%力矩曲线
figure
subplot(4,1,1);
plot(u1.Time,u1.Data,'LineWidth',2);
xlabel('t/s');
ylabel('{\sl{u_1}}/N','fontname','Times New Roman','fontsize',12,'Interpreter','tex');
legend('Total force');
grid on

subplot(4,1,2);
plot(u2.Time,u2.Data,'LineWidth',2);
xlabel('t/s');
ylabel('{\sl{u_2}}/N','fontname','Times New Roman','fontsize',12,'Interpreter','tex');
legend('Roll component');
grid on

subplot(4,1,3);
plot(u3.Time,u3.Data,'LineWidth',2);
xlabel('t/s');
ylabel('{\sl{u_3}}/N','fontname','Times New Roman','fontsize',12,'Interpreter','tex');
legend('Pitch component');
grid on

subplot(4,1,4);
plot(u4.Time,u4.Data,'LineWidth',2);
xlabel('t/s');
ylabel('{\sl{u_4}}/Nm','fontname','Times New Roman','fontsize',12,'Interpreter','tex');
legend('Yaw componet');
grid on

%%三维空间曲线
figure
plot3(x.Data,y.Data,z.Data,'r-','LineWidth',2);
hold on
scatter3(0,0,0,'filled');
xlabel('x/m');
ylabel('y/m');
zlabel('z/m');
grid on

