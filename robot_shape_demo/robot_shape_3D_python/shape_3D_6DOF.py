import numpy as np
import matplotlib.pyplot as plt
import math
import matlab
import matlab.engine
eng = matlab.engine.start_matlab()
import sys
sys.path.append('/home/qjm/ShapeDeformationProj/GIthub/shape_deformation/python_package/robot_simulator_2D')

##
cable_length = np.float(2)
state0 = np.array([-0.2, -0.2, 0, 0, 0, 0])
lx = 0.4
# state0 = [-0.2, -0.2, 0, 0, 0, 0]
ly = 0.4
lz = -0.3
ax = np.pi/4
ay = np.pi/2 + np.pi/8 + np.pi/4
az = np.pi/4
state1 = state0 + np.array([lx, ly, lz, ax, ay, az])
# print(state1)

# state0.tolist()
# state1.tolist()

para = np.zeros([1, 24])
# print(para)
# print(para.tolist()[0])
# print(matlab.double(para.tolist()))
#

# print(state0)
# print(state1)


# cellfun(@double, cell(state0.tolist()))
s00 = map(list, state0)
s11 = map(list, state1)

s0 = matlab.double(state0.reshape(1,6).tolist())
s1 = matlab.double(state1.reshape(1,6).tolist())


s0 = [[-0.2], [-0.2], [0], [0], [0], [0]]
s1 = [[0.2], [0.2], [-0.3], [0.78539816], [2.74889357], [0.78539816]]
shape = eng.shape_3D(matlab.double(s0), matlab.double(s1), cable_length)[0]
# shape, PHI, T, para_temp = eng.shape_3D(matlab.double(state0), matlab.double(state1), cable_length)
# shape, para_temp = eng.shape_2D(xleft, yleft, xright, yright, theta1, theta2, cable_length, matlab.double(para), nargout = 2)
# para = para_temp
# shape = np.array(shape)


# param0 = zeros(24, 1);
# %%
# [shape, PHI, T, para_temp] = shape_3D(state0, state1, cable_length, param0);
# %%
# figure
# plot3(shape(:,1),shape(:,2),shape(:,3),'k-','linewidth',3);hold on
# grid on
# daspect([1 1 1])
# %%
# T_world = eye(4);
# T_base_ur5 = [];
# T_end_ur5 = [];
# T_base_shape = T(1:4,(1*4-3):(1*4));
# T_end_shape = T(1:4,(51*4-3):(51*4));
# DrawAllFrame(T_world,T_base_ur5,T_end_ur5,T_base_shape,T_end_shape);