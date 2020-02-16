import numpy as np
import scipy.optimize as opt


def func(x):
    x1 = x[0]
    x2 = x[1]
    fun = 100 * np.square(x2 - np.square(x1)) + np.square(1 - x1)
    return fun


def constraint_eq(x):
    c1 = 2 * x[0] + x[1] - 1
    return c1


def constraint_ineq(x):
    c2 = 1 - x[0] - 2*x[1]
    return c2


con1 = {'type': 'eq', 'fun': constraint_eq}
con2 = {'type': 'ineq', 'fun': constraint_ineq}
cons = [con1, con2]
x0 = np.array([0.5, 0])
res = opt.minimize(func, x0, method='SLSQP', constraints=cons, options={'disp': True})
print(res.x)

