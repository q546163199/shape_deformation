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
    num = len(args)
    lw = 1
    if num == 4:
        T_world = args[0]
        T_base_UR5 = args[1]
        T_end_UR5 = args[2]
        ax = args[3]
        DrawFrame(T_world, 0.5, lw, ax)
        DrawFrame(T_base_UR5, 0.5, lw, ax)
        DrawFrame(T_end_UR5, 0.5, lw, ax)
    elif num == 6:
        T_world = args[0]
        ax = args[5]
        if args[1] is not None:
            T_base_UR5 = args[1]
            DrawFrame(T_base_UR5, 0.5, lw, ax)
        if args[2] is not None:
            T_end_UR5 = args[2]
            DrawFrame(T_end_UR5, 0.5, lw, ax)

        T_base_shape = args[3]
        T_end_shape = args[4]

        DrawFrame(T_world, 0.5, lw, ax)
        DrawFrame(T_base_shape, 0.5, lw, ax)
        DrawFrame(T_end_shape, 0.5, lw, ax)
    else:
        print('Invalid dimension input, please try again')

