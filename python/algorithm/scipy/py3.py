import numpy as np
import scipy.optimize as opt


def func(x):
    x1 = x[0]
    x2 = x[1]
    x3 = x[2]
    fun = (x1 - 3.69)**2 + (x2 - 2)**2 + (x3 - x2*(x1**2) - 1.5)**2
    return fun


x0 = np.array([1, 1, 1])
res = opt.minimize(func, x0, method='SLSQP', options={'disp': True})
print(res.x)
