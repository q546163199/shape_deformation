import numpy as np
import matplotlib.pyplot as plt
import sys
sys.path.append('/home/qjm/ShapeDeformationProj/github/shape_deformation/python_package/custom_package')
sys.path.append('/home/qjm/ShapeDeformationProj/github/shape_deformation/python_package/robot_simulator')
from user_define import Euler2T, T2Euler, DrawAllFrame
from user_Fourier_curve import Fourier_curve_3D
from  robot_6DOF import robot_6DOF
import matlab.engine
eng = matlab.engine.start_matlab()
##
bias = [0, 0, 0]
robot = robot_6DOF('6DOF', bias)

##
xt = None
yt = None

##
number = 100
state0 = np.array([1, 2, 0, 0, 0, 0])
q0 = np.array([-2.53296143579338, -0.163830123946357, 1.18901198538923, 0.622267504464277, 1.76649902241177, -1.19463682364673])
para = np.zeros([24, 1]).tolist()
cable_length = np.float(6)

plt.ion()
plt.show()
for i in range(number):
    q = q0 + (np.random.rand(1, 6) - 0.5) / 5
    T6, T5, T4, T3, T2, T1, T0 = robot.fkine(q)
    angle = T2Euler(T6)
    lx = T6[0, 3] - state0[0]
    ly = T6[1, 3] - state0[1]
    lz = T6[2, 3] - state0[2]
    ax = angle[0]
    ay = angle[1]
    az = angle[2]
    state1 = (state0 + np.array([lx, ly, lz, ax, ay, az])).tolist()
    state0 = list(state0)

    [p_data, phi_data, T_data, para_temp] = eng.shape_3D(matlab.double(state0), matlab.double(state1), cable_length, matlab.double(para), nargout = 4)
    para = para_temp
    p_data = np.array(p_data)
    phi_data = np.array(phi_data)
    T_data = np.array(T_data)

    s, G, shape_Fourier = Fourier_curve_3D(p_data, cable_length, 5)
    print(np.linalg.norm(p_data - shape_Fourier, ord=2))

    ax = robot.plot(q)
    ax.plot(p_data[:, 0], p_data[:, 1], p_data[:, 2], color='red', linewidth=2)
    ax.plot(shape_Fourier[:, 0], shape_Fourier[:, 1], shape_Fourier[:, 2])
    plt.pause(0.01)

    T_world = np.eye(4)
    T_base_ur5 = T0
    T_end_ur5 = T6
    T_base_shape = T_data[0:4, 0:4]
    T_end_shape = T_data[0:4, (51*4-4):(51*4)]
    DrawAllFrame(T_world, T_base_ur5, T_end_ur5, T_base_shape, T_end_shape, ax)

    if xt is None:
        xt = q
    else:
        xt = np.vstack((xt, q))

    if yt is None:
        yt = np.transpose(s)
    else:
        yt = np.vstack((yt, np.transpose(s)))

np.savetxt(r'/home/qjm/ShapeDeformationProj/github/shape_deformation/robot_shape_demo/robot_shape_3D_python/datafile/xt.mat', xt)
np.savetxt(r'/home/qjm/ShapeDeformationProj/github/shape_deformation/robot_shape_demo/robot_shape_3D_python/datafile/yt.mat', yt)
plt.pause(10)