import numpy as np
import matplotlib.pyplot as plt


def RK_sub(x, y):
    dy = y - 2*x/y
    return dy

def Rk_main(x, y, h):
    x0 = x
    y0 = y
    K1 = RK_sub(x0, y0)
    K2 = RK_sub(x0 + h/2, y0 + h/2*K1)
    K3 = RK_sub(x0 + h/2, y0 + h/2*K2)
    K4 = RK_sub(x0 + h, y0 + h*K3)

    y = y0 + h/6*(K1 + 2*K2 + 2*K3 + K4)
    dy = (y - y0)/h
    return y, dy


## test code
start = 0; final = 1; h = 0.1
N = int((final - start) / h)
t = np.linspace(start, final, num=N, endpoint=False)
print(t)
x = np.zeros([N+1, 1])
x[0] = 0
y = np.zeros([N+1, 1])
y[0] = 1
dy = np.zeros([N+1, 1])
dy[0] = 0

for i in range(N):
    y[i+1], dy[i+1] = Rk_main(x[i], y[i], h)
    x[i+1] = x[i] + h

plt.figure()
plt.plot(x, y, 'r-', marker='*')
plt.show()




