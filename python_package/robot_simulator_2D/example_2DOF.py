import numpy as np
import matplotlib.pyplot as plt
import math
from robot_2DOF import robot_2DOF
##

length = [1, 1]
bias = [0.2, 0.3]
robot = robot_2DOF('robot', length, bias, 2)

plt.ion()
plt.show()

N = 200
theta = np.linspace(0, 2*np.pi, N)

traj = []
for i in range(N):
    traj.append([0.7 + 0.3 * math.cos(theta[i]), 0.8 + 0.3 * math.sin(theta[i])])
traj = np.array(traj)

for i in range(N):
    p2 = [traj[i, 0], traj[i, 1]]
    q = robot.ikine(p2)
    robot.plot(q)
    plt.plot(traj[1:i, 0], traj[1:i, 1], linestyle='--', color='red', lw=2)
    plt.xlim((-1.5, 1.5))
    plt.ylim((-1.5, 1.5))
    plt.pause(0.01)
    ##
    rad = q.sum() - np.pi
    print(np.rad2deg(rad), '  ', robot.fkine(q))
