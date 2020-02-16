import numpy as np
import scipy.optimize as opt


def objective(x):
    x1 = x[0]
    x2 = x[1]
    x3 = x[2]
    cost = np.square(x1) + np.square(x2) + np.square(x3) + 8
    return cost


def constraint_eq(x):
    c = np.arange(2, dtype=np.float)
    c[0] = -x[0] - x[1]**2 + 2
    c[1] = x[1] + 2*x[2]**2 - 3
    return c


def constraint_ineq(x):
    c = np.arange(2, dtype=np.float)
    c[0] = np.square(x[0]) - x[1] + np.square(x[2])
    c[1] = 20 - x[0] - np.square(x[1]) - np.power(x[2], 3)
    return c


x0 = np.random.rand(1, 3)
b = (0.0, None)
bnds = (b, b, b)
con1 = {'type': 'eq', 'fun': constraint_eq}
con2 = {'type': 'ineq', 'fun': constraint_ineq}
cons = [con1, con2]
res = opt.minimize(objective, x0, method='SLSQP', bounds=bnds, constraints=cons, options={'disp': True})
print(res.x)
