clc;close all;clear
tic
tmax = 10;
para.p1=2.9;para.p2=0.76;para.p3=0.87;para.p4=3.04;para.p5=0.87;g=9.81;
q_init = [0.01 0.01];
dq_init = [0.01 0.01];
sim('common_2')
toc