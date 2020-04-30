import open3d as o3d
import numpy as np
import copy
from math import acos, atan2
import time
import os


def build_point_cloud(fileName):
    filePath = r'C:\Users\q5461\OneDrive\文档\GitHub\material\PCDset\point_cloud_filling\data'
    data = np.loadtxt(filePath + fileName)
    pcd = o3d.geometry.PointCloud()
    pcd.points = o3d.utility.Vector3dVector(data)
    pcd.paint_uniform_color((1, 0.706, 0))
    pcd.estimate_normals(search_param=o3d.geometry.KDTreeSearchParamHybrid(radius=0.5, max_nn=30))
    pcd.normalize_normals()

    # downpcd = pcd.voxel_down_sample(voxel_size=0.02)
    downpcd = pcd.uniform_down_sample(10)
    return downpcd


def PFH(pcd, knn=20):
    modified = copy.deepcopy(pcd)
    points = np.asarray(modified.points)
    normals = np.asarray(modified.normals)
    points_num = np.size(points, 0)

    u = np.empty((knn, 3))
    v = np.empty((knn, 3))
    w = np.empty((knn, 3))
    alpha = np.zeros((points_num * knn)).reshape(-1, 1)
    phi = np.zeros((points_num * knn)).reshape(-1, 1)
    theta = np.zeros((points_num * knn)).reshape(-1, 1)

    pcd_tree = o3d.geometry.KDTreeFlann(modified)

    for i in range(points_num):
        [k, idx, _] = pcd_tree.search_knn_vector_3d(points[i], knn)

        for j in range(knn):
            u[j] = normals[i]
            v[j] = np.cross(u[j], (points[idx[j]] - points[i]) / (np.linalg.norm((points[idx[j]] - points[i])) + 0.001))
            w[j] = np.cross(u[j], v[j])

            alpha[i * knn + j] = v[j].dot(normals[idx[j]])
            phi[i * knn + j] = u[j].dot((points[idx[j]] - points[i]) / (np.linalg.norm((points[idx[j]] - points[i])) + 0.001))
            theta[i * knn + j] = atan2(u[j].dot(normals[idx[j]]), w[j].dot(normals[idx[j]]))

    PFH_data = np.hstack((np.hstack((alpha, phi)), theta))
    return PFH_data


def FPFH(pcd, knn=20, radius=0.25):
    FPFH_data = o3d.registration.compute_fpfh_feature(pcd, o3d.geometry.KDTreeSearchParamHybrid(radius=radius, max_nn=knn))
    return FPFH_data.data.transpose()


def EFPFH(pcd):
    modified = copy.deepcopy(pcd)
    points = np.asarray(modified.points)
    normals = np.asarray(modified.normals)
    points_num = np.size(points, 0)

    u = np.empty((points_num, 3))
    v = np.empty((points_num, 3))
    w = np.empty((points_num, 3))
    alpha = np.zeros(points_num).reshape(-1, 1)
    phi = np.zeros(points_num).reshape(-1, 1)
    theta = np.zeros(points_num).reshape(-1, 1)

    p_average = [points[:, 0].mean(),
                 points[:, 1].mean(),
                 points[:, 2].mean()]

    points = np.vstack((points, p_average))
    modified.points = o3d.utility.Vector3dVector(points)
    modified.estimate_normals(search_param=o3d.geometry.KDTreeSearchParamHybrid(radius=0.1, max_nn=30))
    normals = np.asarray(modified.normals)

    for i in range(points_num):
        u[i] = normals[-1]
        v[i] = np.cross(u[i], (points[i] - points[-1]) / np.linalg.norm((points[i] - points[-1])))
        w[i] = np.cross(u[i], v[i])

        alpha[i] = v[i].dot(normals[i])
        phi[i] = u[i].dot((points[i] - points[-1]) / np.linalg.norm((points[i] - points[-1])))
        theta[i] = atan2(u[i].dot(normals[i]), w[i].dot(normals[i]))

    EFPFH_data = np.hstack((np.hstack((alpha, phi)), theta))
    return EFPFH_data


if __name__ == '__main__':
    for i in range(1):
        tic = time.time()
        fileName = '\\' + str(i + 1) + '_filling.txt'
        pcd = build_point_cloud(fileName)

        PFH_data = PFH(pcd)
        savePath = os.getcwd() + '\data' + '\\' + str(i + 1) + '_PFH.txt'
        np.savetxt(savePath, PFH_data, fmt='%3.5f')

        FPFH_data = FPFH(pcd, knn=100)
        savePath = os.getcwd() + '\data' + '\\' + str(i + 1) + '_FPFH.txt'
        np.savetxt(savePath, FPFH_data, fmt='%3.5f')

        EFPFH_data = EFPFH(pcd)
        savePath = os.getcwd() + '\data' + '\\' + str(i + 1) + '_EFPFH.txt'
        np.savetxt(savePath, EFPFH_data, fmt='%3.5f')

        print(time.time() - tic)
