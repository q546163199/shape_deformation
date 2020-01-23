clc;clear;close all
%%
start = 0;step = 0.005;final = 10;
t = start:step:final;
N = length(t) - 1;
%%
q(:,1) = [0.01;0.01];
dq(:,1) = [0.01;0.01];
ddq(:,1) = [0.01;0.01];
qd(:,1) = Desired(t(1));
for i=1:N
    tau(:,1) = [0.01 0.01];
    [q(:,i+1) dq(:,i+1) ddq(:,i+1)] = RK_main(q(:,i),dq(:,i),tau(:,1),step,t(i));
    [qd(:,i+1),dqd(:,i+1),ddqd(:,i+1)] = Desired(t(i+1));
end

figure
subplot(2,2,1)
plot(t,q(1,:))
grid on
legend('q1')
subplot(2,2,2)
plot(t,q(2,:))
grid on
legend('q2')
subplot(2,2,3)
plot(t,dq(1,:))
grid on
legend('dq1')
subplot(2,2,4)
plot(t,dq(2,:))
grid on
legend('dq2')

% figure
% subplot(2,2,1)
% plot(t,qd(1,:))
% grid on
% subplot(2,2,2)
% plot(t,qd(2,:))
% grid on