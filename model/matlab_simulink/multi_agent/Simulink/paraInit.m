clc;clear;close all

tmax=20;
q1_init=[0.5;0.5;];dq1_init=[0;0];
q2_init=[0.2;0.1;];dq2_init=[0;0];
q3_init=[-0.1;-0.2];dq3_init=[0;0];
q4_init=[-0.5;-0.5];dq4_init=[0;0];

GA=[0 1 1 0;1 0 0 1;1 0 0 1;0 1 1 0];
GB=[0 1 0 0;1 0 1 1;0 1 0 0;0 1 0 0];
K1=4*eye(2);K2=4*eye(2);K3=4*eye(2);K4=4*eye(2);
K=blkdiag(K1,K2,K3,K4);

LA=calLaplas(GA);LB=calLaplas(GB);
sim('multiagent')
% plotfigure

