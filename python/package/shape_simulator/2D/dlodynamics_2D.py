import numpy as np
import scipy.optimize as opt
import matplotlib.pyplot as plt
from time import time
from copy import deepcopy
from numpy import square, pi, sin, cos
from robot_2DOF import robot_2DOF

L = 0.0
n = 4
N = 100
Lx = 0.0
Ly = 0.0
Theta1 = 0.0
Theta2 = 0.0


def dlodynamics_2D(x1, y1, x2, y2, langle, rangle, cable_length, init=np.ones((1, 2 * 4 + 2)) / 10):
    global L, n, N, Lx, Ly, Theta1, Theta2
    L = cable_length
    Lx = x2 - x1
    Ly = y2 - y1
    Theta1 = langle
    Theta2 = rangle

    con1 = {'type': 'eq', 'fun': constraint_eq}
    con2 = {'type': 'ineq', 'fun': constraint_ineq}
    cons = [con1]
    res = opt.minimize(cable_cost, init, method='SLSQP', constraints=cons, options={'disp': False})

    para_a = res.x
    px = x1
    py = y1
    DLO = np.array([px, py])
    DLOangle = np.array([0])
    numOfData = 99
    for k in range(numOfData):
        phi = para_a[0] + para_a[1] * L * k / numOfData
        for i in range(n):
            phi = phi + para_a[2 * i] * sin(2 * pi * i * k / numOfData) + para_a[2 * i + 1] * cos(2 * pi * i * k / numOfData)

        px = px + cos(phi) * L / numOfData
        py = py + sin(phi) * L / numOfData
        DLO = np.vstack((DLO, np.array([px, py])))
        DLOangle = np.vstack((DLOangle, phi))

    dloData = DLO
    return dloData, para_a


def cable_cost(a):
    a = a.reshape(1, -1)
    f = square(a[0, 1]) * L
    for i in range(n):
        f = f + square(a[0, 2 * i]) * square(2 * pi * i / L) * L / 2 + square(a[0, 2 * i + 1]) * square((2 * pi * i / L)) * L / 2
    return f


def constraint_eq(x):
    x = x.reshape(1, -1)
    ceq = np.arange(4, dtype=np.float)
    lx = 0
    ly = 0
    for k in range(N):
        phi = x[0, 0] + x[0, 1] * L * k / N
        for i in range(n):
            phi = phi + x[0, 2 * i] * sin(2 * pi * i * k / N) + x[0, 2 * i + 1] * cos(2 * pi * i * k / N)

        lx = lx + cos(phi) * L / N
        ly = ly + sin(phi) * L / N

    theta1 = x[0, 0]
    theta2 = x[0, 0] + x[0, 1] * L

    for i in range(n):
        theta1 = theta1 + x[0, 2 * i + 1]
        theta2 = theta2 + x[0, 2 * i + 1]

    ceq[0] = lx - Lx
    ceq[1] = ly - Ly
    ceq[2] = theta1 - Theta1
    ceq[3] = theta2 - Theta2

    return ceq


def constraint_ineq(x):
    cineq = None
    return cineq


if __name__ == '__main__':
    tic = time()
    para0 = np.ones((1, 2 * 4 + 2)) / 10
    shape, para1 = dlodynamics_2D(0.0, 0.0, 0.7, 0.0, np.pi/6, -np.pi/6, 1.0, para0)
    plt.xlim([-0.1, 0.8])
    plt.ylim([-0.1, 0.8])
    plt.scatter(shape[:, 0], shape[:, 1])
    plt.axis('square')
    plt.grid()
    print(time() - tic)
    plt.pause(0)

