clc;clear;close all
%建立机器人模型
d1=89.459;d2=0;d3=0;d4=109.15;d5=94.65;d6=82.3;
a1=0;a2=-425;a3=-392.25;a4=0;a5=0;a6=0;
alpha1=pi/2;alpha2=0;alpha3=0;alpha4=pi/2;alpha5=-pi/2;alpha6=0;

%          theta    d       a       alpha   R/L
L1 = Link([0        d1      a1      alpha1  0 ],'standard'); %定义连杆的D-H参数
L2 = Link([0        d2      a2      alpha2  0 ],'standard');
L3 = Link([0        d3      a3      alpha3  0 ],'standard');
L4 = Link([0        d4      a4      alpha4  0 ],'standard');
L5 = Link([0        d5      a5      alpha5  0 ],'standard');
L6 = Link([0        d6      a6      alpha6  0 ],'standard');

L1.qlim = [-360 360]*pi/180;
L2.qlim = [-360 360]*pi/180;
L3.qlim = [-360 360]*pi/180;
L4.qlim = [-360 360]*pi/180;
L5.qlim = [-360 360]*pi/180;
L6.qlim = [-360 360]*pi/180;

robot=SerialLink([L1 L2 L3 L4 L5 L6],'name','UR5'); %连接连杆，机器人取名manman
robot.display();
% robot.teach