import cv2
import numpy as np
import matplotlib.pyplot as plt


def get_mse(records_real, records_predict):
    """
    均方误差 估计值与真值 偏差
    """
    num = records_real.shape[0] * records_real.shape[1] * records_real.shape[2]
    error = np.linalg.norm(records_real.reshape(-1, 1) - records_predict.reshape(-1, 1).astype(np.uint8), ord=2) / num
    return error


def svd_decrease(img, sval_nums):
    width = img.shape[0]
    length = img.shape[1]
    channel = img.shape[2]

    img_temp = img.reshape(width, length * channel)
    U, Sigma, VT = np.linalg.svd(img_temp)

    img_restruct = (U[:, 0:sval_nums]).dot(np.diag(Sigma[0:sval_nums])).dot(VT[0:sval_nums, :])
    img_restruct = img_restruct.reshape(width, length, channel)
    return U, Sigma, VT, img_restruct


def cv_imread(file_path=""):
    img_mat = cv2.imdecode(np.fromfile(file_path, dtype=np.uint8), -1)
    return img_mat


if __name__ == "__main__":
    img = cv_imread(r'D:\GitHub\shape_deformation\representation\python\data\pic1.jpeg')

    U, Sigma, VT, img_restruct1 = svd_decrease(img, sval_nums=60)
    U, Sigma, VT, img_restruct2 = svd_decrease(img, sval_nums=120)

    print(get_mse(img, img_restruct1))
    print(get_mse(img, img_restruct2))

    fig, ax = plt.subplots(1, 3, figsize=(24, 32))
    ax[0].imshow(img)
    ax[0].set(title="src")
    ax[1].imshow(img_restruct1.astype(np.uint8))
    ax[1].set(title="nums of sigma = 60")
    ax[2].imshow(img_restruct2.astype(np.uint8))
    ax[2].set(title="nums of sigma = 120")
    plt.show()
