import numpy as np
import matplotlib.pyplot as plt
import math
from robot_3DOF import robot_3DOF
##

length = [1, 1, 1]
bias = [0.2, 0.3]
robot = robot_3DOF('robot', length, bias, 2)

plt.ion()
plt.show()

N = 200
theta = np.linspace(0, 2*np.pi, N)
pitch = np.deg2rad(210)

traj = []
for i in range(N):
    traj.append([0.2 + 0.3 * math.cos(theta[i]), 0.3 + 0.3 * math.sin(theta[i])])
traj = np.array(traj)

for i in range(N):
    p3 = [traj[i, 0], traj[i, 1]]
    q = robot.ikine(p3, pitch + theta[i])
    robot.plot(q)
    plt.plot(traj[1:i, 0], traj[1:i, 1], linestyle='--', color='red', lw=2)
    plt.xlim((-1.5, 1.5))
    plt.ylim((-1.5, 1.5))
    plt.pause(0.01)
    ##
    rad = q.sum() - np.pi
    print(np.rad2deg(rad), '  ', robot.fkine(q))
    # print(robot.fkine(q))
