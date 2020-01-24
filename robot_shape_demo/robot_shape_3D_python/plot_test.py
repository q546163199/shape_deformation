import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import sys
sys.path.append('/home/qjm/ShapeDeformationProj/github/shape_deformation/python_package/custom_feature_package')
from user_define_package import DrawAllFrame

p_data = np.loadtxt('p_data')
phi_data = np.loadtxt('phi_data')
T_data = np.loadtxt('T_data')

plt.ion()
plt.show()

ax = plt.axes(projection='3d')
ax.plot(p_data[:, 0], p_data[:, 1], p_data[:, 2])
ax.set_xlim3d(-5, 5)
ax.set_ylim3d(-5, 5)
ax.set_zlim3d(-5, 5)
T = np.array([[-0.951824224709527, -0.215406747948987,   0.218244308503453,   1.86510304766092],
              [-0.220054417855173,  0.975482731713992,   0.00308112158621450, 1.52780847532721],
              [-0.213557248620901, -0.0450929380928978, -0.975889301353192,  -0.784181787984638],
              [0,                  0,                   0,                   1]])

T_world = np.eye(4)
T_base_ur5 = np.eye(4)
T_end_ur5 = T
T_base_shape = T_data[0:4, 0:4]
T_end_shape = T_data[0:4, (51*4-4):(51*4)]
DrawAllFrame(T_world, T_base_ur5, T_end_ur5, T_base_shape, T_end_shape, ax)
plt.pause(20)
np.savetxt()