import numpy as np
from numpy.linalg import inv
import matplotlib.pyplot as plt
import sys
import math
from mpl_toolkits.mplot3d import Axes3D


def Fourier_curve_2D(shape, length, N):
    L = np.size(shape, 0)
    P = 4 * N + 2
    c = np.zeros([2*L, 1])
    G_temp = np.empty(shape=[2, 0])
    F_temp = np.empty(shape=[2, 4])
    G = np.empty(shape=[0, P])
    rho = np.zeros([L, 1])
    shape_Fourier = np.zeros((shape.shape))

    ## calculate c
    for i in range(L):
        c[2*i + 0] = shape[i, 0]
        c[2*i + 1] = shape[i, 1]

    ## calculate G
    for i in range(L):
        rho[i] = i/L * length
        for j in range(1, N+1):
            F_temp[:, :] = np.array([[np.cos(j*rho[i]), np.sin(j*rho[i]), 0, 0],
                                     [0, 0, np.cos(j*rho[i]), np.sin(j*rho[i])]])
            G_temp = np.hstack((G_temp, F_temp))
            # print(type(F_temp))

        G_temp = np.hstack((G_temp, np.eye(2)))
        G = np.vstack((G, G_temp))
        G_temp = np.empty(shape=[2, 0])

    ## calculate s
    s = np.linalg.inv(np.transpose(G).dot(G)).dot(np.transpose(G)).dot(c)

    ## calculate shape
    shape_temp = G.dot(s)
    for i in range(L):
        shape_Fourier[i, 0] = shape_temp[2*i]
        shape_Fourier[i, 1] = shape_temp[2*i + 1]

    return s, G, shape_Fourier


def Fourier_curve_3D(shape, length, N):
    L = np.size(shape, 0)
    P = 6 * N + 3
    c = np.zeros([3*L, 1])
    G_temp = np.empty(shape=[3, 0])
    F_temp = np.empty(shape=[3, 6])
    G = np.empty(shape=[0, P])
    rho = np.zeros([L, 1])
    shape_Fourier = np.zeros((shape.shape))

    # calculate c
    for i in range(L):
        c[3*i + 0] = shape[i, 0]
        c[3*i + 1] = shape[i, 1]
        c[3*i + 2] = shape[i, 2]

    # calculate G
    for i in range(L):
        rho[i] = (i+1)/L * length
        for j in range(1, N+1):
            F_temp[:, :] = np.array([[np.cos(j*rho[i]), np.sin(j*rho[i]), 0, 0, 0, 0],
                                     [0, 0, np.cos(j*rho[i]), np.sin(j*rho[i]), 0, 0],
                                     [0, 0, 0, 0, np.cos(j*rho[i]), np.sin(j*rho[i])]])
            G_temp = np.hstack((G_temp, F_temp))

        G_temp = np.hstack((G_temp, np.eye(3)))
        G = np.vstack((G, G_temp))
        G_temp = np.empty(shape=[3, 0])

    # calculate s
    s = np.linalg.inv(np.transpose(G).dot(G)).dot(np.transpose(G)).dot(c)

    # calculate shape
    shape_temp = G.dot(s)
    for i in range(L):
        shape_Fourier[i, 0] = shape_temp[3*i + 0]
        shape_Fourier[i, 1] = shape_temp[3*i + 1]
        shape_Fourier[i, 2] = shape_temp[3*i + 2]

    return s, G, shape_Fourier


# test code
if __name__ == '__main__':
    shape = np.loadtxt('p_data')
    s, G, shape_Fourier = Fourier_curve_3D(shape, 6, 20)
    print(np.linalg.norm(shape - shape_Fourier, ord=2))
    plt.ion()
    plt.show()
    ax = plt.axes(projection='3d')
    ax.plot(shape[:, 0], shape[:, 1], shape[:, 2])
    ax.plot(shape_Fourier[:, 0], shape_Fourier[:, 1], shape_Fourier[:, 2])
    plt.pause(5)
