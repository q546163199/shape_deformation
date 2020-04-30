# -*- coding: utf-8 -*-
"""
Created on 2016/11/22
利用Numpy,Pandas和Matplotlib实现PCA,并可视化结果
@author: lguduy
"""

import numpy as np
import matplotlib.pyplot as plt


def pca(X, rate=0.95):
    # 计算中心化样本矩阵
    meanValue = np.ones((X.shape[0], 1)) * np.mean(X, axis=0)
    # 每个维度减去该维度的均值
    X = X - meanValue
    # 计算协方差矩阵
    C = np.transpose(X).dot(X) / (X.shape[0] - 1)
    # 计算特征值, 特征向量
    D, V = np.linalg.eig(C)
    # 将特征值按降序排序
    order = np.argsort(-D)
    # 将特征向量按照特征值大小进行降序排列
    V = V[:, order]
    # 将特征值构成的列向量按降序排列
    newD = D[order]
    # 特征值之和
    sumd = sum(newD)
    # 计算取特征值的个数
    cols = 0
    for j in range(newD.size):
        # 计算贡献率，贡献率 = 前n个特征值之和 / 总特征值之和
        i = sum(newD[0:j+1]) / sumd
        # 当贡献率大于rate时循环结束, 并记下取多少个特征值
        if i > rate:
            cols = j
            break
    # 取前cols个特征向量，构成变换矩阵T
    T = V[:, 0: cols + 1]
    # 用变换矩阵T对X进行降维
    newX = X.dot(T)
    # 降维后的矩阵再还原成原矩阵,看误差
    X_recovery = newX.dot(T.transpose()) + meanValue
    return newX, X_recovery


if __name__ == '__main__':
    matrix = np.array([[10, 15, 29],
                       [15, 46, 13],
                       [23, 21, 30],
                       [11, 9, 35],
                       [42, 45, 11],
                       [9, 48, 5],
                       [11, 21, 14],
                       [8, 5, 15],
                       [11, 12, 21],
                       [21, 20, 25]])

    newX, X_recovery = pca(matrix, rate=0.95)
    error = matrix - X_recovery
    print(np.linalg.norm(error))
    print(matrix - X_recovery)
