import torch
import torch.nn.functional as F
import matplotlib.pyplot as plt
import numpy as np

# load data
yt = np.loadtxt(r'/home/qjm/ShapeDeformationProj/github/shape_deformation/robot_shape_demo/robot_shape_3D_python/datafile/xt.mat')
xt = np.loadtxt(r'/home/qjm/ShapeDeformationProj/github/shape_deformation/robot_shape_demo/robot_shape_3D_python/datafile/yt.mat')
N = np.size(xt, 0)
x = torch.Tensor(xt)
y = torch.Tensor(yt)

# define nn
class Net(torch.nn.Module):
    def __init__(self, n_feature, n_hidden, n_output):
        super(Net, self).__init__()
        self.hidden = torch.nn.Linear(n_feature, n_hidden)
        self.predict = torch.nn.Linear(n_hidden, n_output)

    def forward(self, x):
        x = F.relu(self.hidden(x))
        x = self.predict(x)
        return x


# train nn
# net = Net(np.size(x, 1), 500, np.size(y, 1))
net = torch.nn.Sequential(torch.nn.Linear(np.size(x, 1), 500),
                          torch.nn.ReLU(),
                          torch.nn.Linear(500, np.size(y, 1)))
optimizer = torch.optim.SGD(net.parameters(), lr=0.01, momentum=0.8)
loss_func = torch.nn.MSELoss()

for t in range(3000):
    prediction = net(x)
    loss = loss_func(prediction, y)
    optimizer.zero_grad()
    loss.backward()
    optimizer.step()

    if t % 50 == 0:
        print(loss.data)

# save nn
torch.save(net.state_dict(), './net_structure/net_params.pkl')
# load nn
net1 = torch.nn.Sequential(torch.nn.Linear(33, 500),
                           torch.nn.ReLU(),
                           torch.nn.Linear(500, 6))
net1.load_state_dict(torch.load('./net_structure/net_params.pkl'))

test = torch.Tensor(np.random.rand(1, 33))
print(net(test).detach().numpy())
print(net1(test).detach().numpy())