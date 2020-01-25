import numpy as np
import matplotlib.pyplot as plt
import sys
import math
from robot_UR5 import robot_UR5
sys.path.append('/home/qjm/ShapeDeformationProj/GIthub/shape_deformation/python_package/custom_feature_package')
from user_define_package import DrawAllFrame

bias = [0.1, 0.2, 0.3]
robot = robot_UR5('UR5', bias)

q = np.deg2rad([30, 30, 30, 20, 60, 50])
[T6, T5, T4, T3, T2, T1, T0] = robot.fkine(q)
angle = robot.ikine(T6)

for i in range(6):
    error = T6 - robot.fkine(angle[i, :])[0]
    print(np.linalg.norm(error, ord=2))

##
plt.ion()
plt.show()
ax = robot.plot(q)

##
T_world = np.eye(4)
T_base_UR5 = T0
T_end_UR5 = T6
DrawAllFrame(T_world, T_base_UR5, T_end_UR5, ax)
plt.pause(20)

