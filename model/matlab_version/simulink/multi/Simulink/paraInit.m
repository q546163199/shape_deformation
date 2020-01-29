clc;clear;close all

para.p1=2.9;para.p2=0.76;para.p3=0.87;para.p4=3.04;para.p5=0.87;g=9.81;
tmax=20;

q1_init=[0.1;0.1;];dq1_init=[0;0];
q2_init=[0.1;0.1;];dq2_init=[0;0];

kp=100;ki=10;

sim('common_3')
