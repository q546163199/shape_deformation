import numpy as np
import matplotlib.pyplot as plt
import math

## elbow_up = 1
## elbow_down = 2

class robot_3DOF:
    def __init__(self, name, length, bias, elbow_case):
        self.name = name
        self.link1_length = length[0]
        self.link2_length = length[1]
        self.link3_length = length[2]
        self.biasx = bias[0]
        self.biasy = bias[1]
        self.elbow_case = elbow_case

    def fkine(self, q):
        l1 = self.link1_length
        l2 = self.link2_length
        l3 = self.link3_length
        q1 = q[0]
        q2 = q[1]
        q3 = q[2]
        ##
        p1x = l1 * np.cos(q1) + self.biasx
        p1y = l1 * np.sin(q1) + self.biasy
        p2x = l1 * np.cos(q1) + l2 * np.cos(q1 + q2) + self.biasx
        p2y = l1 * np.sin(q1) + l2 * np.sin(q1 + q2) + self.biasy
        p3x = l1 * np.cos(q1) + l2 * np.cos(q1 + q2) + l3 * np.cos(q1 + q2 + q3) + self.biasx
        p3y = l1 * np.sin(q1) + l2 * np.sin(q1 + q2) + l3 * np.sin(q1 + q2 + q3) + self.biasy

        posi = [p1x, p1y, p2x, p2y, p3x, p3y]
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

    def ikine(self, p3, pitch):
        l1 = self.link1_length
        l2 = self.link2_length
        l3 = self.link3_length
        p3x = p3[0]
        p3y = p3[1]
        p2x = p3x - l3 * np.cos(pitch)
        p2y = p3y - l3 * np.sin(pitch)
        x = p2x - self.biasx
        y = p2y - self.biasy
        p2 = np.array([p2x, p2y])
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
        q3 = pitch - (q1 + q2)

        if q3 < 0:
            q = []
            print('The position is not in the workspace, pleast try it again')
            return

        q = [q1, q2, q3]
        return np.array(q)

    def plot(self, q):
        l1 = self.link1_length
        l2 = self.link2_length
        l3 = self.link3_length
        ##
        posi = self.fkine(q)
        p1x = posi[0]
        p1y = posi[1]
        p2x = posi[2]
        p2y = posi[3]
        p3x = posi[4]
        p3y = posi[5]

        plt.cla()
        plt.plot([self.biasx, p1x, p2x, p3x], [self.biasy, p1y, p2y, p3y], color='black', linestyle='-', lw=2, marker='*')
        axis_limit = l1 + l2 + l3 + max(self.biasx, self.biasy) / 2
        plt.axis('square')
        plt.xlim((-0.2, axis_limit))
        plt.ylim((-0.2, axis_limit))

#
# function
# circle(obj, radius, bias)
# n = 100;
# theta = linspace(0, 2 * pi, n);
# for i=1:n
# traj(i, 1) = radius * cos(theta(i)) + bias.x;
# traj(i, 2) = radius * sin(theta(i)) + bias.y;
# end
# plot(traj(:, 1), traj(:, 2), '--', 'linewidth', 2)
# end
#
# function
# handle = rectangle(obj, p1x, p1y, p2x, p2y)
# % %
# % ---------- p2
# % | |
# % | |
# % p1 - --------
# % %
# p1.x = p1x;
# p1.y = p1y;
# p2.x = p2x;
# p2.y = p2y;
# % %
# handle = plot([p1.x p2.x p2.x p1.x p1.x], [p1.y p1.y p2.y p2.y p1.y], 'k-', 'linewidth', 2);
# end
#
# function
# handle = workspace(obj)
# maxlength = obj.link1_length + obj.link2_length + obj.link3_length + sqrt(obj.biasx ^ 2 + obj.biasy ^ 2);
# N = 200;
# theta = linspace(0, 2 * pi, N);
# for i=1:N
# x(i) = maxlength * cos(theta(i));
# y(i) = maxlength * sin(theta(i));
# end
# handle = plot(x, y, '--b', 'linewidth', 2);
# end
#
# end
# end
