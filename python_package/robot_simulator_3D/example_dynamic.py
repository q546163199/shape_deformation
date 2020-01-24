import numpy as np
import matplotlib.pyplot as plt
from robot_UR5 import robot_UR5
import sys
sys.path.append('/home/qjm/ShapeDeformationProj/GIthub/shape_deformation/python_package/custom_feature_package')
from user_define_package import DrawAllFrame, Euler2T
##
bias = [0.1, 0.1, 0.1]
robot = robot_UR5('UR5', bias)

##
N = 100
q = (np.ones([6, 1]) / 3)

plt.ion()
plt.show()

for i in range(N):
    q = q + np.ones([6, 1]) / 10000 * i
    [T6, T5, T4, T3, T2, T1, T0] = robot.fkine(q)
    ax = robot.plot(q)
    ##
    T_base = T0
    T_world = np.eye(4)
    T_end = T6
    DrawAllFrame(T_world, T_base, T_end, ax)
    angle = robot.ikine(T6)
    for j in range(8):
        error = T6 - robot.fkine(angle[j, :])[0]
        print(np.linalg.norm(error, ord=2))
    plt.pause(0.01)

plt.pause(0)
