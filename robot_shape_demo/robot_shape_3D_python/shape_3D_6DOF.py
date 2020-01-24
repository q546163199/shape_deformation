import numpy as np
import matplotlib.pyplot as plt
import sys
sys.path.append('/home/qjm/ShapeDeformationProj/github/shape_deformation/python_package/custom_feature_package')
sys.path.append('/home/qjm/ShapeDeformationProj/github/shape_deformation/python_package/robot_simulator_3D')
from user_define_package import Euler2T, T2Euler, DrawAllFrame
from  robot_6DOF import robot_6DOF
import matlab.engine
eng = matlab.engine.start_matlab()
##
bias = [0, 0, 0]
robot = robot_6DOF('6DOF', bias)
print(robot.name)
##
state0 = np.array([1, 2, 0, 0, 0, 0])
T = np.array([[-0.951824224709527, -0.215406747948987,   0.218244308503453,   1.86510304766092],
              [-0.220054417855173,  0.975482731713992,   0.00308112158621450, 1.52780847532721],
              [-0.213557248620901, -0.0450929380928978, -0.975889301353192,  -0.784181787984638],
              [0,                  0,                   0,                   1]])
lx = T[0, 3] - state0[0]
ly = T[1, 3] - state0[1]
lz = T[2, 3] - state0[2]
angle = T2Euler(T)
ax = angle[0]
ay = angle[1]
az = angle[2]
state1 = (state0 + np.array([lx, ly, lz, ax, ay, az])).tolist()
state0 = state0.tolist()
cable_length = np.float(6)
para = np.zeros([24, 1]).tolist()
##
[p_data, phi_data, T_data, para_temp] = eng.shape_3D(matlab.double(state0), matlab.double(state1), cable_length, matlab.double(para), nargout = 4)
para = para_temp
##
p_data = np.array(p_data)
phi_data = np.array(phi_data)
T_data = np.array(T_data)
np.savetxt('p_data', p_data)
np.savetxt('phi_data', phi_data)
np.savetxt('T_data', T_data)
plt.ion()
plt.show()
##
q = robot.ikine(T)
joint = q[0, :]
ax = robot.plot(joint)
ax.plot(p_data[:, 0], p_data[:, 1], p_data[:, 2], color='red', linewidth=2)
T_world = np.eye(4)
T_base_ur5 = np.eye(4)
T_end_ur5 = T
T_base_shape = T_data[0:4, 0:4]
T_end_shape = T_data[0:4, (51*4-4):(51*4)]
DrawAllFrame(T_world, T_base_ur5, T_end_ur5, T_base_shape, T_end_shape, ax)
plt.pause(0)

