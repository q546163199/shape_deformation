import math
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

class robot_6DOF:

    d1 = 89.2 / 250
    d4 = 109.3 / 250
    d5 = 94.75 / 250
    d6 = 82.5 / 250
    a2 = -425 / 250
    a3 = -392 / 250
    alpha1 = np.pi / 2
    alpha4 = np.pi / 2
    alpha5 = -np.pi / 2

    def __init__(self, name, bias):
        self.name = name
        self.biasx = bias[0]
        self.biasy = bias[1]
        self.biasz = bias[2]

    def fkine(self, q):
        q = np.array(q).reshape(1, 6)
        q1 = q[0, 0]
        q2 = q[0, 1]
        q3 = q[0, 2]
        q4 = q[0, 3]
        q5 = q[0, 4]
        q6 = q[0, 5]

        A0 = np.array([[1, 0, 0, self.biasx],
                       [0, 1, 0, self.biasy],
                       [0, 0, 1, self.biasz],
                       [0, 0, 0, 1]])

        A1 = np.array([[math.cos(q1), 0,  math.sin(q1), 0],
                       [math.sin(q1), 0, -math.cos(q1), 0],
                       [0, 1, 0, self.d1],
                       [0, 0, 0, 1]])

        A2 = np.array([[math.cos(q2), -math.sin(q2), 0, self.a2 * math.cos(q2)],
                       [math.sin(q2),  math.cos(q2), 0, self.a2 * math.sin(q2)],
                       [0, 0, 1, 0],
                       [0, 0, 0, 1]])

        A3 = np.array([[math.cos(q3), -math.sin(q3), 0, self.a3 * math.cos(q3)],
                       [math.sin(q3),  math.cos(q3), 0, self.a3 * math.sin(q3)],
                       [0, 0, 1, 0],
                       [0, 0, 0, 1]])

        A4 = np.array([[math.cos(q4), 0,  math.sin(q4), 0],
                       [math.sin(q4), 0, -math.cos(q4), 0],
                       [0, 1, 0, self.d4],
                       [0, 0, 0, 1]])

        A5 = np.array([[math.cos(q5), 0, -math.sin(q5), 0],
                       [math.sin(q5), 0,  math.cos(q5), 0],
                       [0, -1, 0, self.d5],
                       [0,  0, 0, 1]])

        A6 = np.array([[math.cos(q6), -math.sin(q6), 0, 0],
                       [math.sin(q6),  math.cos(q6), 0, 0],
                       [0, 0, 1, self.d6],
                       [0, 0, 0, 1]])

        T0 = A0
        T1 = np.matmul(T0, A1)
        T2 = np.matmul(T1, A2)
        T3 = np.matmul(T2, A3)
        T4 = np.matmul(T3, A4)
        T5 = np.matmul(T4, A5)
        T6 = np.matmul(T5, A6)

        return T6, T5, T4, T3, T2, T1, T0


    def ikine(self, T):
        a = np.array([0, self.a2, self.a3, 0, 0, 0])
        d = np.array([self.d1, 0, 0, self.d4, self.d5, self.d6])
        alpha = np.array([np.pi/2, 0, 0, np.pi/2, -np.pi/2, 0])
        ##
        theta = np.zeros([8, 6])
        theta1 = np.zeros([1, 2])
        theta5 = np.zeros([2, 2])
        theta6 = np.zeros([2, 2])
        theta3 = np.zeros([4, 2])
        #

        nx = T[0][0]
        ny = T[1][0]
        nz = T[2][0]
        ox = T[0][1]
        oy = T[1][1]
        oz = T[2][1]
        ax = T[0][2]
        ay = T[1][2]
        az = T[2][2]
        px = T[0][3] - self.biasx
        py = T[1][3] - self.biasy
        pz = T[2][3] - self.biasz

        ## sovle joint1
        m = d[5] * ay - py
        n = ax * d[5] - px
        theta1[0][0] = math.atan2(m, n) - math.atan2(d[3], math.sqrt(math.pow(m, 2) + math.pow(n, 2) - math.pow(d[3], 2)))
        theta1[0][1] = math.atan2(m, n) - math.atan2(d[3], -math.sqrt(math.pow(m, 2) + math.pow(n, 2) - math.pow(d[3], 2)))

        ## solve joint5
        theta5[0, 0:2] = np.arccos(ax * np.sin(theta1) - ay * np.cos(theta1))
        theta5[1, 0:2] = -np.arccos(ax * np.sin(theta1) - ay * np.cos(theta1))

        ## solve joint6
        mm = nx * np.sin(theta1) - ny * np.cos(theta1)
        nn = ox * np.sin(theta1) - oy * np.cos(theta1)
        theta6 = np.arctan2(mm, nn) - np.arctan2(np.sin(theta5), 0)

        ## solve joint3
        mmm = d[4] * (np.sin(theta6) * (nx * np.cos(theta1) + ny * np.sin(theta1)) + np.cos(theta6) * (ox * np.cos(theta1) + oy * np.sin(theta1))) \
            - d[5] * (ax * np.cos(theta1) + ay * np.sin(theta1)) + px * np.cos(theta1) + py * np.sin(theta1)

        nnn = pz - d[0] - az * d[5] + d[4] * (oz * np.cos(theta6) + nz * np.sin(theta6))
        theta3[0:2, :] = np.arccos((np.power(mmm, 2) + np.power(nnn, 2) - np.square(a[1]) - np.square(a[2])) / (2 * a[1] * a[2]))
        theta3[2:4, :] = -np.arccos((np.power(mmm, 2) + np.power(nnn, 2) - np.square(a[1]) - np.square(a[2])) / (2 * a[1] * a[2]))

        ## solve joint2
        mmm_s2 = np.vstack((mmm, mmm))
        nnn_s2 = np.vstack((nnn, nnn))
        s2 = ((a[2] * np.cos(theta3) + a[1]) * nnn_s2 - a[2] * np.sin(theta3) * mmm_s2) / (np.power(a[1], 2) + np.power(a[2], 2) + 2 * a[1] * a[2] * np.cos(theta3))
        c2 = (mmm_s2 + a[2] * np.sin(theta3) * s2) / (a[2] * np.cos(theta3) + a[1])
        theta2 = np.arctan2(s2, c2)

        ## selltle joint angle
        theta[0:4, 0] = theta1[0, 0]
        theta[4:8, 0] = theta1[0, 1]
        theta[:, 1] = np.transpose([theta2[0, 0], theta2[2, 0], theta2[1, 0], theta2[3, 0], theta2[0, 1], theta2[2, 1], theta2[1, 1], theta2[3, 1]])
        theta[:, 2] = np.transpose([theta3[0, 0], theta3[2, 0], theta3[1, 0], theta3[3, 0], theta3[0, 1], theta3[2, 1], theta3[1, 1], theta3[3, 1]])
        theta[0: 2, 4] = theta5[0, 0]
        theta[2: 4, 4] = theta5[1, 0]
        theta[4: 6, 4] = theta5[0, 1]
        theta[6: 8, 4] = theta5[1, 1]
        theta[0: 2, 5] = theta6[0, 0]
        theta[2: 4, 5] = theta6[1, 0]
        theta[4: 6, 5] = theta6[0, 1]
        theta[6: 8, 5] = theta6[1, 1]

        ## solve joint4
        theta[:, 3] = np.arctan2(-np.sin(theta[:, 5]) * (nx * np.cos(theta[:, 0]) + ny * np.sin(theta[:, 0])) - np.cos(theta[:, 5]) * \
                                 (ox * np.cos(theta[:, 0]) + oy * np.sin(theta[:, 0])), oz * np.cos(theta[:, 5]) + nz * np.sin(theta[:, 5])) - theta[:, 1] - theta[:, 2]

        return np.array(theta)


    def plot(self, q):
        T6, T5, T4, T3, T2, T1, T0 = self.fkine(q)
        ##
        ax = plt.axes(projection='3d')
        # ax1 = Axes3D(fig)
        ax.plot([T0[0][3], T1[0][3], T2[0][3], T3[0][3], T4[0][3], T5[0][3], T6[0][3]],
                [T0[1][3], T1[1][3], T2[1][3], T3[1][3], T4[1][3], T5[1][3], T6[1][3]],
                [T0[2][3], T1[2][3], T2[2][3], T3[2][3], T4[2][3], T5[2][3], T6[2][3]],
                color='black', marker='*', linewidth=2)

        limit = 5 / 1
        ax.set_xlim3d(-limit, limit)
        ax.set_ylim3d(-limit, limit)
        ax.set_zlim3d(-limit, limit)

        return ax

    def circle(self, r):
        N = 10
        theta = np.linspace(0, np.pi, N)
        phi = np.linspace(0, 2*np.pi, N)

        x = np.zeros((N ** 2, 1))
        y = np.zeros((N ** 2, 1))
        z = np.zeros((N ** 2, 1))
        traj = np.zeros((N ** 2, 3))

        for i in range(N):
            for j in range(N):
                x[(N-1) * i + j] = r * np.sin(theta[i]) * np.cos(phi[j]) + self.biasx
                y[(N-1) * i + j] = r * np.sin(theta[i]) * np.sin(phi[j]) + self.biasy
                z[(N-1) * i + j] = r * np.cos(theta[i]) + self.biasz

                traj[(N-1) * i + j, 0:3] = np.array([x[(N-1) * i + j], y[(N-1) * i + j], z[(N-1) * i + j]]).reshape(1, 3)

        return traj
