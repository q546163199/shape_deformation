import numpy as np
import scipy.optimize as opt


def objective(x):
    x1 = x[0]
    x2 = x[1]
    x3 = x[2]
    x4 = x[3]
    cost = x1 * x4 * (x1 + x2 + x3) + x3
    return cost

def constraint1(x):
    return x[0]*x[1]*x[2]*x[3] - 25.0

def constraint2(x):
    sum_sq = 40
    for i in range(4):
        sum_sq = sum_sq - x[i]**2
    return sum_sq


x0 = np.array([1, 5, 5, 1])
b = (1.0, 5.0)
bnds = (b, b, b, b)
con1 = {'type': 'ineq', 'fun': constraint1}
con2 = {'type': 'eq', 'fun': constraint2}
cons = [con1, con2]
res = opt.minimize(objective, x0, method='SLSQP', bounds=bnds, constraints=cons, options={'disp': True})
print(res.x)