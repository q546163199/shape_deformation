import scipy.optimize as opt
import numpy as np
import matplotlib.pyplot as plt
import time
from mpl_toolkits.mplot3d import Axes3D
import sys
sys.path.append("../custom_algorithm")
# sys.path.append('/home/qjm/ShapeDeformationProj/github/shape_deformation/python_package/robot_simulator')
from user_define import Euler2T, T2Euler, DrawAllFrame
#
L = 2
Rf = 1       # Flexural coefficient
Rt = 1       # Torsional coefficient
Re = 0.0     # extension coefficient
D = 0.0      # weight par m
N = 50
s0 = 0
s1 = L
ds = (s1 - s0) / N
kmax = 2             # Use 2nd order approximation
n = 2 * kmax + 2     # number of parameters per varaible
#
state0 = np.array([-0.2, -0.2, 0, 0, 0, 0])
lx = 0.4
ly = 0.4
lz = -0.3
ax = np.pi / 4
ay = np.pi / 2 + np.pi / 8 + np.pi / 4
az = np.pi / 4
state1 = (state0 + np.array([lx, ly, lz, ax, ay, az]))


#
def f_evaluate(s, a, f0):
    e = np.arange(n, dtype=np.float)
    e[0] = 1
    e[1] = s
    for i in range(3, n+1):
        if i % 2 == 1:
            k = (i - 1) / 2
            e[i-1] = np.sin(2 * np.pi * k * s / L)
        if i % 2 == 0.0:
            k = (i - 2) / 2
            e[i-1] = np.cos(2 * np.pi * k * s / L)

    f = f0
    for i in range(n):
        f = f + a[i] * e[i]

    return f


def f_derivate(s, a):
    e = np.arange(n, dtype=np.float)
    e[0] = 0
    e[1] = 1
    for i in range(3, n+1):
        if i % 2 == 1:
            k = (i - 1) / 2
            e[i-1] = (2 * np.pi * k / L) * np.cos(2 * np.pi * k * s / L)

        if i % 2 == 0:
            k = (i - 2) / 2
            e[i - 1] = -(2 * np.pi * k / L) * np.sin(2 * np.pi * k * s / L)

    df = 0
    for i in range(n):
        df = df + a[i]*e[i]
    return df


def CalcPosition(s, param):
    param = param.reshape(1, -1)
    a_phi = param[0, 0:n]
    a_theta = param[0, n + 0:2 * n]
    a_epsilon = param[0, 3 * n + 0:4 * n]
    # a_phi = param[0:n, 0]
    # a_theta = param[n + 0:2 * n, 0]
    # a_epsilon = param[3 * n + 0:4 * n, 0]
    p = np.array([[state0[0]],
                  [state0[1]],
                  [state0[2]]])
    epsilon_l = 0.0

    for i in range(int((s-s0)/ds) + 1):
        sc = ds * i
        if Re != 0.0:
            epsilon_l = f_evaluate(sc, a_epsilon, 0.0)

        theta_l = f_evaluate(sc, a_theta, state0[4])
        phi_l = f_evaluate(sc, a_phi, state0[3])
        zeta = np.array([[np.sin(theta_l) * np.cos(phi_l)],
                        [np.sin(theta_l) * np.sin(phi_l)],
                        [np.cos(theta_l)]])

        p = p + (1 + epsilon_l) * zeta * ds
    return p


def CalcOrientation(s, param):
    param = param.reshape(1, -1)
    a_phi = param[0, 0:n]
    a_theta = param[0, n + 0:2 * n]
    a_psi = param[0, 2 * n + 0:3 * n]
    phi = f_evaluate(s, a_phi, state0[3])
    theta = f_evaluate(s, a_theta, state0[4])
    psi = f_evaluate(s, a_psi, state0[5])

    PHI = np.array([[phi],
                    [theta],
                    [psi]])
    return PHI


def RotAxeAngle(axe, angle):
    if axe == 'x':
        T = np.array([[1, 0, 0, 0],
                      [0, np.cos(angle), -np.sin(angle), 0],
                      [0, np.sin(angle),  np.cos(angle), 0],
                      [0, 0, 0, 1]])

    if axe == 'y':
        T = np.array([[np.cos(angle), 0, np.sin(angle), 0],
                      [0, 1, 0, 0],
                      [-np.sin(angle), 0, np.cos(angle), 0],
                      [0, 0, 0, 1]])

    if axe == 'z':
        T = np.array([[np.cos(angle), -np.sin(angle), 0, 0],
                      [np.sin(angle), np.cos(angle), 0, 0],
                      [0, 0, 1, 0],
                      [0, 0, 0, 1]])
    return np.array(T)


def costfun(param):
    param = param.reshape(1, -1)
    Uflex = 0
    Utor = 0.0
    Uext = 0.0
    Ugrav = 0.0

    for i in range(N + 1):
        # Compute kappa ^ 2 = (dtheta / ds) ^ 2 + sin ^ 2(theta) * (dphi / ds) ^ 2
        s = ds * i
        a_phi = param[0, 0:n]
        a_theta = param[0, n:2*n]
        theta = f_evaluate(s, a_theta, state0[4])
        dtheta = f_derivate(s, a_theta)
        dphi = f_derivate(s, a_phi)
        kappa_2 = dtheta**2 + (np.sin(theta)**2) * (dphi**2)
        Uflex = Uflex + Rf * kappa_2 * ds

        # Compute omega ^ 2 = ((dphi / ds) * cos(theta) + dpsi / ds) ^ 2
        a_psi = param[0, 2 * n + 0:3 * n]
        dpsi = f_derivate(s, a_psi)
        omega_2 = (dphi * np.cos(theta) + dpsi)**2
        Utor = Utor + Rt * omega_2 * ds

        # Compute the extensional energy
        if Re is not 0.0:
            a_epsilon = param[0, 3 * n + 0:4 * n]
            epsilon = f_evaluate(s, a_epsilon, 0.0)
            Uext = Uext + Re * (epsilon**2) * ds

        if D is not 0.0:
            x = state0[0]
            epsilon_l = 0.0
            for j in range(int((s-s0)/ds)+1):
                sl = ds * j
                if Re is not 0.0:
                    epsilon_l = f_evaluate(sl, a_epsilon, 0.0)

                theta_l = f_evaluate(sl, a_theta, state0[4])
                phi_l = f_evaluate(sl, a_phi, state0[3])
                x = x + (1 + epsilon_l) * np.sin(theta_l) * np.cos(phi_l) * ds

            Ugrav = Ugrav + D * x * ds
    C = 0.5 * Uflex + 0.5 * Utor + 0.5 * Uext + Ugrav
    return C


def constraint_ineq(param):
    c = None
    return c


def constraint_eq(param):
    ceq = np.arange(9, dtype=np.float)
    param = param.reshape(1, -1)
    # a_phi = param[0:n, 0]
    # a_theta = param[n + 0:2 * n, 0]
    # a_psi = param[2 * n + 0:3 * n, 0]
    # a_epsilon = param[3 * n + 0:4 * n, 0]
    a_phi = param[0, 0:n]
    a_theta = param[0, n + 0:2 * n]
    a_psi = param[0, 2 * n + 0:3 * n]
    a_epsilon = param[0, 3 * n + 0:4 * n]

    # Constraints at s = s0
    i = 0
    ceq[i] = state0[3] - f_evaluate(s0, a_phi, state0[3])
    i = i + 1
    ceq[i] = state0[4] - f_evaluate(s0, a_theta, state0[4])
    i = i + 1
    ceq[i] = state0[5] - f_evaluate(s0, a_psi, state0[5])
    if Re != 0.0:
        i = i + 1
        ceq[i] = f_evaluate(s0, a_epsilon, 0.0)

    # Constraints at s = s1
    # Orientations
    i = i + 1
    ceq[i] = state1[3] - f_evaluate(s1, a_phi, state0[3])
    i = i + 1
    ceq[i] = state1[4] - f_evaluate(s1, a_theta, state0[4])
    i = i + 1
    ceq[i] = state1[5] - f_evaluate(s1, a_psi, state0[5])

    # Positions
    p = CalcPosition(s1, param)
    i = i + 1
    ceq[i] = lx - (p[0] - state0[0])
    i = i + 1
    ceq[i] = ly - (p[1] - state0[1])
    i = i + 1
    ceq[i] = lz - (p[2] - state0[2])
    return ceq


def plotDLO(param):
    param = param.reshape(1, -1)
    T = np.eye(4)
    P_dat = None
    PHI_dat = None
    T_dat = None

    for i in range(N+1):
        s = ds * i
        P = CalcPosition(s, param)
        PHI = CalcOrientation(s, param)
        # T = RotAxeAngle('z', PHI[2])*RotAxeAngle('y', PHI[1])*RotAxeAngle('x', PHI[0])
        T = RotAxeAngle('z', PHI[2]).dot(RotAxeAngle('y', PHI[1])).dot(RotAxeAngle('x', PHI[0]))
        T[0:3, 3] = P.reshape(1, 3)

        if P_dat is None:
            P_dat = P
        else:
            P_dat = np.hstack((P_dat, P))

        if PHI_dat is None:
            PHI_dat = PHI
        else:
            PHI_dat = np.hstack((PHI_dat, PHI))

        if T_dat is None:
            T_dat = T
        else:
            T_dat = np.vstack((T_dat, T))

    P_dat = np.transpose(P_dat)
    PHI_dat = np.transpose(PHI_dat)
    return np.array(P_dat), np.array(PHI_dat), np.array(T_dat)


if __name__ == '__main__':
    start = time.time()
    param0 = np.ones((1, 4 * n)) / 3.759
    con1 = {'type': 'ineq', 'fun': constraint_ineq}
    con2 = {'type': 'eq', 'fun': constraint_eq}
    cons = [con2]
    res = opt.minimize(costfun, param0, method='SLSQP', constraints=cons, options={'disp': True, 'maxiter': 100})
    param1 = res.x
    print(res)
    #
    # param1 = np.array([0.24667206,  0.39269908,  0.06684409, -0.20733783, -0.0307971,
    #                  -0.03933423,  0.41423463,  1.37444679, -0.78153947, -0.39259707,
    #                  -0.03932026, -0.02163755, -0.20218397,  0.39269908, -0.08884203,
    #                  0.16295191,  0.03920437,  0.03923206,  0.2660282,  0.2660282,
    #                  0.2660282,  0.2660282,  0.2660282,  0.2660282])

    [p_dat, PHI_dat, T_dat] = plotDLO(param1)
    #
    plt.ion()
    plt.show()
    ax = plt.axes(projection='3d')
    ax.plot(p_dat[:, 0], p_dat[:, 1], p_dat[:, 2], color='black', linewidth=3)
    ax.set_xlim3d(-0.5, 1)
    ax.set_ylim3d(-0.5, 1)
    ax.set_zlim3d(-0.8, 1)
    T_world = np.eye(4)
    T_base_ur5 = None
    T_end_ur5 = None
    T_base_shape = T_dat[0:4, 0:4]
    T_end_shape = T_dat[(51 * 4 - 4):(51 * 4), 0:4]
    DrawAllFrame(T_world, T_base_ur5, T_end_ur5, T_base_shape, T_end_shape, ax)
    # print(T_base_shape)
    # print(T_end_shape)
    end = time.time()
    print(end - start)
    plt.pause(100)





