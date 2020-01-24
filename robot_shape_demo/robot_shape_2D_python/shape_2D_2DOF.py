import matlab.engine
import numpy as np
import matplotlib.pyplot as plt
import math
import sys
sys.path.append('/home/qjm/ShapeDeformationProj/github/shape_deformation/python_package/robot_simulator_2D')
from robot_2DOF import robot_2DOF
eng = matlab.engine.start_matlab()
## robot init
length = [0.5, 0.5]
bias = [0, 0]
robot = robot_2DOF('robot', length, bias, 2)

## shape simulator initial parameters
cable_length = np.float(1)
para = [[0], [0], [0], [0], [0], [0], [0], [0], [0], [0]]

##
plt.ion()
plt.show()
for i in range(20):
    num = (np.random.rand(1) - 0.5) * 2
    p2 = np.array([0.3 + num * 0.1, 0.5 + num * 0.1])
    q = np.array(robot.ikine(p2))
    xleft = np.float(p2[0])
    yleft = np.float(p2[1])
    xright = np.float(1)
    yright = np.float(0.5)
    theta1 = np.float(q.sum())
    theta2 = np.float(0)
    ##
    shape, para_temp = eng.shape_2D(xleft, yleft, xright, yright, theta1, theta2, cable_length, matlab.double(para), nargout = 2)
    para = para_temp
    shape = np.array(shape)
    ##
    robot.plot(q)
    plt.plot(shape[:, 0], shape[:, 1])
    plt.pause(0.01)
plt.pause(0)
