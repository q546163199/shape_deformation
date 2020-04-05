from scipy.optimize import rosen, rosen_der
from ipopt import minimize_ipopt
import numpy as np
import scipy.optimize as opt
import time

start = time.time()

N = 100
x = np.empty([8, N])
y = np.empty([10, N])
A = np.random.rand(10, 8) * 10

for i in range(N):
    x[:, i] = np.random.rand(1, 8) * 3 + (np.random.rand() - 0.5) / 2.
    y[:, i] = A.dot(x[:, i])


def func(K):
    f = 0
    cost = 0
    K = K.reshape(10, 8)
    for j in range(N):
        cost = np.linalg.norm(y[:, j] - K.dot(x[:, j]))
        f = f + cost
    f = f / N
    return f


K0 = np.random.rand(80, 1)
# res = opt.minimize(func, K0, method='BFGS', options={'disp': True, 'maxiter': 30})
res = minimize_ipopt(func, K0, method='BFGS', options={'maxiter': 20})
print(res.x.shape)
print(A - res.x.reshape(10, 8))
end = time.time()
print(str(end - start))

