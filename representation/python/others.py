import open3d as o3d
import numpy as np
import copy
import time
import os
from math import acos, atan2
from PFH_FPFH_EFPFH import build_point_cloud


def method1(pcd, knn=20):
    # refer to 'Curvature and Density based Feature Point Detection for Point Cloud Data'
    modified = copy.deepcopy(pcd)
    points = np.asarray(modified.points)
    normals = np.asarray(modified.normals)
    points_num = np.size(points, 0)

    w_neighbor = np.zeros(points_num)
    w_angle = np.zeros(points_num)
    w = np.zeros(points_num)
    H = np.zeros(points_num)

    pcd_tree = o3d.geometry.KDTreeFlann(modified)
    for i in range(points_num):
        [k, idx, _] = pcd_tree.search_knn_vector_3d(points[i], knn)

        # First step: calclulate w_neighbor
        error = []
        for j in range(knn):
            norm = np.linalg.norm([points[i][0] - points[idx[j]][0],
                                   points[i][1] - points[idx[j]][1],
                                   points[i][2] - points[idx[j]][2]], ord=2)
            error.append(norm)
        w_neighbor[i] = sum(error) / knn

        # Second step: calculate w_angle
        p_average = [points[idx, 0].mean(),
                     points[idx, 1].mean(),
                     points[idx, 2].mean()]

        augument_matrix = points[idx, :] - np.tile(p_average, (knn, 1))
        C = np.transpose(augument_matrix).dot(augument_matrix)
        eigenValue, featureVector = np.linalg.eig(C)
        H[i] = np.min(eigenValue) / eigenValue.sum()
        theta = []
        for j in range(knn):
            costheta = normals[i].dot(normals[idx[j]]) / np.linalg.norm(normals[i]) / np.linalg.norm(normals[idx[j]])
            if costheta > 1:
                costheta = 1
            theta.append(acos(costheta))
        w_angle[i] = sum(theta) / knn

        # Third step: calculate w
        lambdaH = 200
        lambdan = 2
        dcp = 0.85
        w[i] = dcp * (lambdaH * H[i] + w_angle[i]) / (lambdan * w_neighbor[i])

    return w_neighbor, w_angle, w


if __name__ == '__main__':
    for i in range(1):
        tic = time.time()
        fileName = '\\' + str(i + 1) + '_filling.txt'
        pcd = build_point_cloud(fileName)

        w_neighbor, w_angle, w = method1(pcd)
        savePath = os.getcwd() + '\data' + '\\' + str(i + 1) + '_method1.txt'
        np.savetxt(savePath, w, fmt='%3.5f')

        print(time.time() - tic)


