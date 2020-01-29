clc;clear;close all

a = [0;0;1;1];
T = Euler2T(deg2rad([0,90,0]))
b = T * a
