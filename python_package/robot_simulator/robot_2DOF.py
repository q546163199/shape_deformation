import numpy as np
import matplotlib.pyplot as plt
import math

## elbow_up = 1
## elbow_down = 2

class robot_2DOF:
    def __init__(self, name, length, bias, elbow_case):
        self.name = name
        self.link1_length = length[0]
        self.link2_length = length[1]
        self.biasx = bias[0]
        self.biasy = bias[1]
        self.elbow_case = elbow_case

    def fkine(self, q):
        l1 = self.link1_length
        l2 = self.link2_length
        q1 = q[0]
        q2 = q[1]
        ##
        p1x = l1 * np.cos(q1) + self.biasx
        p1y = l1 * np.sin(q1) + self.biasy
        p2x = l1 * np.cos(q1) + l2 * np.cos(q1 + q2) + self.biasx
        p2y = l1 * np.sin(q1) + l2 * np.sin(q1 + q2) + self.biasy

        posi = [p1x, p1y, p2x, p2y]
        return np.array(posi)

    def isField(self, p2):
        l1 = self.link1_length
        l2 = self.link2_length
        x = p2[0] - self.biasx
        y = p2[1] - self.biasy
        ##
        judge = (np.square(x) + np.square(y) - np.square(l1) - np.square(l2)) / (2 * l1 * l2)
        if np.abs(judge) > 1:
            isField = False
        else:
            isField = True
        return isField

    def ikine(self, p2):
        l1 = self.link1_length
        l2 = self.link2_length
        x = p2[0] - self.biasx
        y = p2[1] - self.biasy
        ##
        isField = self.isField(p2)
        if isField == False:
            q = []
            print('The position is not in the workspace, please try again')
            return
        ##
        c2 = (np.square(x) + np.square(y) - np.square(l1) - np.square(l2)) / (2 * l1 * l2)

        if self.elbow_case == 1:
            s2 = -np.sqrt(1 - np.square(c2))
        elif self.elbow_case == 2:
            s2 = np.sqrt(1 - np.square(c2))
        else:
            print('Elbow case wrong, please try again')
            return

        q2 = math.atan2(s2, c2)
        k1 = l1 + l2 * c2
        k2 = l2 * s2
        q1 = math.atan2(y, x) - math.atan2(k2, k1)
        q = [q1, q2]
        return np.array(q)

    def plot(self, q):
        l1 = self.link1_length
        l2 = self.link2_length
        ##
        posi = self.fkine(q)
        p1x = posi[0]
        p1y = posi[1]
        p2x = posi[2]
        p2y = posi[3]

        plt.cla()
        plt.plot([self.biasx, p1x, p2x], [self.biasy, p1y, p2y], color='black', linestyle='-', lw=2, marker='*')
        axis_limit = l1 + l2 + max(self.biasx, self.biasy)
        plt.axis('square')
        plt.xlim((-0.2, axis_limit))
        plt.ylim((-0.2, axis_limit))


if __name__ == '__main__':
    length = [1, 1]
    bias = [0.2, 0.3]
    robot = robot_2DOF('robot', length, bias, 2)

    plt.ion()
    plt.show()

    N = 200
    theta = np.linspace(0, 2 * np.pi, N)

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





