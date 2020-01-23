import numpy as np
import matplotlib.pyplot as plt
from robot_UR5 import robot_UR5
import sys
sys.path.append(r'/home/qjm/ShapeDeformationProj/GIthub/shape_deformation/python_package/custom_feature_package')
from user_define_package import DrawAllFrame, Euler2T


##
bias = [0, 0, 0]
robot = robot_UR5('UR5', bias)

##
traj = robot.circle(np.float(0.5))
row, col = np.shape(traj)

for i in range(12, 80):
    T = Euler2T(np.array([0.1, 0.1, 0.1]))
    T[0, 3] = traj[i, 0]
    T[1, 3] = traj[i, 1]
    T[2, 3] = traj[i, 2]

    q = robot.ikine(T)
    ax = robot.plot(q[2, :])
    T_world = np.eye(4)
    T_base_UR5 = np.eye(4)
    T_end_UR5 = T
    DrawAllFrame(T_world, T_base_UR5, T_end_UR5, ax)
    plt.pause(0.01)

plt.pause(0)

