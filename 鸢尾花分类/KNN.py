# N a m e   :裴鲲鹏
# Student ID:202100172014
# Date&Time :2023/6/30 18:14

import numpy as np
from csv import reader
from sklearn import neighbors

# 数据读入，读取.csv文件
with open('.\\iris.csv', 'r') as csvfile:

    readers = reader(csvfile, delimiter=',')
    a = list(readers)

    # 去掉表头后随机化，便于后续划分训练集和预测集
    a = np.delete(np.array(a), 0, axis=0)
    rng = np.random.default_rng()
    a = rng.permutation(a)

    # 将有限的数据分成训练集(0~129)和预测集(130~150)
    b = np.delete(np.array(a), list(range(130, 150)), axis=0)
    c = np.delete(np.array(a), list(range(0, 130)), axis=0)

    # 训练集数据提取处理，数据特征 X 为第二三四五列；标签 y 为第六列
    X = np.delete(b, [0, 5], axis=1)
    y = np.delete(b, [0, 1, 2, 3, 4], axis=1)

    # 将标签 y 字符串用数字代表
    y[y == 'setosa'] = 0
    y[y == 'versicolor'] = 1
    y[y == 'virginica'] = 2

# 特征 X 类型转换
Xtrain = X.astype(float)

# 标签 y 类型转换，维度转换
ytrain = y.astype(int).ravel()

# 同理划分预测集
Xtest = np.delete(c, [0, 5], axis=1)
Xtest = Xtest.astype(float)
ytest = np.delete(c, [0, 1, 2, 3, 4], axis=1)
ytest[ytest == 'setosa'] = 0
ytest[ytest == 'versicolor'] = 1
ytest[ytest == 'virginica'] = 2
ytest = ytest.astype(int).ravel()

# KNN训练
knn = neighbors.KNeighborsClassifier(weights='distance')
knn.fit(Xtrain, ytrain)

# 单点预测
X_test = [[4.5, 3.3, 1.7, 0.21]]
y_predict = knn.predict(X_test)

# 单点预测结果，并将数字标签 y 再换回字符串标签
y_predict1 = y_predict.astype(str)
y_predict1[y_predict == 0] = 'setosa'
y_predict1[y_predict == 1] = 'versicolor'
y_predict1[y_predict == 2] = 'virginica'
print(y_predict1)

# score计算预测的准确率
score = knn.score(Xtest, ytest)
print(score)
