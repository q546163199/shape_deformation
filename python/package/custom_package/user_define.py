import numpy as np
import matplotlib.pyplot as plt
import sys
import math

from mpl_toolkits.mplot3d import Axes3D

def Euler2T(angle):
    x = angle[0]
    y = angle[1]
    z = angle[2]

    Rx = np.array([[1, 0, 0, 0],
                   [0, np.cos(x), -np.sin(x), 0],
                   [0, np.sin(x),  np.cos(x), 0],
                   [0, 0, 0, 1]])

    Ry = np.array([[np.cos(y), 0, np.sin(y), 0],
                   [0, 1, 0, 0],
                   [-np.sin(y), 0, np.cos(y), 0],
                   [0, 0, 0, 1]])
    Rz = np.array([[np.cos(z), -np.sin(z), 0, 0],
                   [np.sin(z), np.cos(z), 0, 0],
                   [0, 0, 1, 0],
                   [0, 0, 0, 1]])

    T = np.matmul(np.matmul(Rz, Ry), Rx)
    return T

def T2Euler(T):
    x = np.arctan2(T[2, 1], T[2, 2])
    y = np.arctan2(-T[2, 0], np.sqrt(np.square(T[2, 1]) + np.square(T[2, 2])))
    z = np.arctan2(T[1, 0], T[0, 0])
    angle = np.array([x, y, z])
    return angle


def Euler2Quad(angle):
    roll = angle[0]
    pitch = angle[1]
    yaw = angle[2]
    cy = np.cos(yaw * 0.5)
    sy = np.sin(yaw * 0.5)
    cp = np.cos(pitch * 0.5)
    sp = np.sin(pitch * 0.5)
    cr = np.cos(roll * 0.5)
    sr = np.sin(roll * 0.5)
    w = cy * cp * cr + sy * sp * sr
    x = cy * cp * sr - sy * sp * cr
    y = sy * cp * sr + cy * sp * cr
    z = sy * cp * cr - cy * sp * sr
    quad = np.array([w, x, y, z])
    return quad


def Quqd2Euler(quad):
    q0 = quad[0]
    q1 = quad[1]
    q2 = quad[2]
    q3 = quad[3]

    roll = np.arctan2(2 * (q2*q3 + q0*q1), q0**2 - q1**2 - q2**2 + q3**2)
    pitch = np.arcsin(2 * (q0*q2 - q1*q3))
    yaw = np.arctan2(2 * (q1*q2 + q0*q3), q0**2 + q1**2 - q2**2 - q3**2)
    return roll, pitch, yaw


def DrawFrame(T, scalor, lw, ax):
    m, n = np.shape(T)
    if m != 4:
        print('Invalid dimension of T')
        return

    if n != 4:
        print('Invalid dimension of T')
        return

    x = np.array([T[0][3], 0])
    y = np.array([T[1][3], 0])
    z = np.array([T[2][3], 0])
    ax.scatter3D(x[0], y[0], z[0])

    k = 0
    x[1] = x[0] + scalor * T[0][k]
    y[1] = y[0] + scalor * T[1][k]
    z[1] = z[0] + scalor * T[2][k]
    ax.plot3D([x[0], x[1]], [y[0], y[1]], [z[0], z[1]], color='red', label='x', linestyle='-', linewidth=lw)

    k = 1
    x[1] = x[0] + scalor * T[0][k]
    y[1] = y[0] + scalor * T[1][k]
    z[1] = z[0] + scalor * T[2][k]
    ax.plot3D([x[0], x[1]], [y[0], y[1]], [z[0], z[1]], color='green', label='y', linestyle='-', linewidth=lw)

    k = 2
    x[1] = x[0] + scalor * T[0][k]
    y[1] = y[0] + scalor * T[1][k]
    z[1] = z[0] + scalor * T[2][k]
    ax.plot3D([x[0], x[1]], [y[0], y[1]], [z[0], z[1]], color='blue', label='z', linestyle='-', linewidth=lw)


def DrawAllFrame(*args):
    lw = 1
    ax = args[5]
    if args[0] is not None:
        T_world = args[0]
        DrawFrame(T_world, 0.5, lw, ax)

    if args[1] is not None:
        T_base_ur5 = args[1]
        DrawFrame(T_base_ur5, 0.5, lw, ax)

    if args[2] is not None:
        T_end_ur5 = args[2]
        DrawFrame(T_end_ur5, 0.5, lw, ax)

    if args[3] is not None:
        T_base_shape = args[3]
        DrawFrame(T_base_shape, 0.5, lw, ax)

    if args[4] is not None:
        T_end_shape = args[4]
        DrawFrame(T_end_shape, 0.5, lw, ax)


if __name__ == '__main__':
    angle = np.array([0.31, 0.52, 1.3])
    quad = Euler2Quad(angle)
    quad1 = np.array([-0.99114048481, -0.00530699081719, 0.00178255140781, -0.133612662554])
    angle1 = Quqd2Euler(quad)
    print(angle1)
    print(np.rad2deg(Quqd2Euler(quad1)))




