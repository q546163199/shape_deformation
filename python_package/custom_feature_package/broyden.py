import numpy as np

def transpose(x):
    x = np.transpose([x])
    return x


def byoyden(xt, yt, gamma, case):
    N = np.size(xt, 0)
    ut = np.diff(xt, axis=0)
    ut = np.vstack((np.zeros((1, np.size(xt, 1))) + 0.01, ut))
    dt = np.diff(yt, axis=0)
    dt = np.vstack((np.zeros((1, np.size(yt, 1))) + 0.01, dt))
    At0 = np.random.rand(np.size(yt, 1),  np.size(xt, 1))

    if case == 1:
        for i in range(N):
            At = At0 + gamma * (transpose(dt[i, :]) - At0.dot(transpose(ut[i, :]))).dot([ut[i, :]]) / np.square(np.linalg.norm([ut[i, :]], ord=2))
            At0 = At
        return At






## test code
N = 300
A = np.random.rand(3, 4) * 2
xt = None
yt = None
for i in range(N):
    x = np.random.rand(1, 4)
    y = A.dot(x.transpose())

    if xt is None:
        xt = x
    else:
        xt = np.vstack((xt, x))

    if yt is None:
        yt = y.transpose()
    else:
        yt = np.vstack((yt, y.transpose()))

At = byoyden(xt, yt, 0.2, 1)
error = A - At
print(error)
