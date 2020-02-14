import numpy as np
import matplotlib.pyplot as plt


def RK_sub(u, x, t):
    d = np.sin(t)
    dx = 2*x + u + d
    return dx


def Rk_main(u, x, t, h):
    u0 = u
    x0 = x
    K1 = RK_sub(u0, x0, t)
    K2 = RK_sub(u0 + h/2, x0 + h/2*K1, t)
    K3 = RK_sub(u0 + h/2, x0 + h/2*K2, t)
    K4 = RK_sub(u0 + h, x0 + h*K3, t)

    x = x0 + h/6*(K1 + 2*K2 + 2*K3 + K4)
    dx = (x - x0)/h
    return x, dx


## test code
start = 0; final = 1; h = 0.1
N = int((final - start) / h)
t = np.linspace(start, final, num=N+1)
print(t)
u = np.zeros([N+1, 1])
x = np.zeros([N+1, 1])
dx = np.zeros([N+1, 1])
u[0] = 0
x[0] = 0.1
dx[0] = 0.1
for i in range(N):
    x[i+1], dx[i+1] = Rk_main(u[i], x[i], t[i], h)
    u[i+1] = u[i] + np.sin(t[i])


plt.figure()
plt.subplot(131)
plt.plot(t, u, marker='*')

plt.subplot(132)
plt.plot(t, x, marker='*')

plt.subplot(133)
plt.plot(u, x, marker='*')
plt.show()



