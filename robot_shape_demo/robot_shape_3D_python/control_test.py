import numpy as np
import matplotlib.pyplot as plt
import torch
import sys
sys.path.append('/home/qjm/ShapeDeformationProj/github/shape_deformation/python_package/custom_feature_package')
sys.path.append('/home/qjm/ShapeDeformationProj/github/shape_deformation/python_package/robot_simulator')
from user_define import Euler2T, T2Euler, DrawAllFrame
from user_Fourier_curve import Fourier_curve_3D
from  robot_6DOF import robot_6DOF
import matlab.engine
eng = matlab.engine.start_matlab()
#
angle_data = np.loadtxt(r'/home/qjm/ShapeDeformationProj/github/shape_deformation/robot_shape_demo/robot_shape_3D_python/datafile/xt.mat')
#
bias = [0, 0, 0]
robot = robot_6DOF('6DOF', bias)
# target shape
# q_target = np.array([-2.53296143579338, -0.163830123946357, 1.18901198538923, 0.622267504464277, 1.76649902241177, -1.19463682364673]) + (np.random.rand(1, 6) - 0.5) / 5
# q_target = np.array([-2.61678439, -0.26142944, 1.26416514, 0.57045049, 1.81427616, -1.10543722])
q_target = angle_data[18, :]
T6 = robot.fkine(q_target)[0]
state0 = np.array([1, 2, 0, 0, 0, 0])
angle = T2Euler(T6)
lx = T6[0, 3] - state0[0]
ly = T6[1, 3] - state0[1]
lz = T6[2, 3] - state0[2]
ax = angle[0]
ay = angle[1]
az = angle[2]
state1 = (state0 + np.array([lx, ly, lz, ax, ay, az])).tolist()
state0 = state0.tolist()
cable_length = np.float(6)
para = np.zeros([24, 1]).tolist()
[p_target, phi_target, T_target, para_temp] = eng.shape_3D(matlab.double(state0), matlab.double(state1), cable_length, matlab.double(para), nargout=4)
para = para_temp
p_target = np.array(p_target)
T_target = np.array(T_target)
y_target = Fourier_curve_3D(p_target, cable_length, 5)[0]
# load nn
net = torch.nn.Sequential(torch.nn.Linear(33, 500),
                          torch.nn.ReLU(),
                          torch.nn.Linear(500, 6))
net.load_state_dict(torch.load('./net_structure/net_params.pkl'))
# real shape
q_real = net(torch.Tensor(y_target.transpose())).detach().numpy()
T6 = robot.fkine(q_real)[0]
state0 = np.array([1, 2, 0, 0, 0, 0])
angle = T2Euler(T6)
lx = T6[0, 3] - state0[0]
ly = T6[1, 3] - state0[1]
lz = T6[2, 3] - state0[2]
ax = angle[0]
ay = angle[1]
az = angle[2]
state1 = (state0 + np.array([lx, ly, lz, ax, ay, az])).tolist()
state0 = state0.tolist()
para = np.zeros([24, 1]).tolist()
[p_real, phi_real, T_real, para_temp] = eng.shape_3D(matlab.double(state0), matlab.double(state1), cable_length, matlab.double(para), nargout=4)
para = para_temp
p_real = np.array(p_real)
T_real = np.array(T_real)
# plot
ax = robot.plot(q_real)
ax.plot(p_real[:, 0], p_real[:, 1], p_real[:, 2], color='black', linewidth=2)
ax.plot(p_target[:, 0], p_target[:, 1], p_target[:, 2], color='red', linewidth=2)
error = np.linalg.norm(p_real - p_target, ord=2)
print(error)
print(q_real)
print(q_target)
plt.pause(0)


# T_world = None
# T_base_ur5 = None
# T_end_ur5 = None
# T_base_shape = T_data[0:4, 0:4]
# T_end_shape = T_data[0:4, (51*4-4):(51*4)]
# DrawAllFrame(T_world, T_base_ur5, T_end_ur5, T_base_shape, T_end_shape, ax)