# N a m e   :裴鲲鹏
# Student ID:202100172014
# Date&Time :2023/7/1 16:27

import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns; sns.set()
from csv import reader
from sklearn.svm import SVC
from sklearn.metrics import confusion_matrix


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


# 训练，拟合SVM，后预测
model = SVC(kernel='rbf', C=1e5)
model.fit(Xtrain, ytrain)
ypred = model.predict(Xtest)

# 单点预测
X_test = [[5.8,2.7,5.1,1.9]]
y_predict = model.predict(X_test)

# 单点预测结果，并将数字标签 y 再换回字符串标签
y_predict1 = y_predict.astype(str)
y_predict1[y_predict == 0] = 'setosa'
y_predict1[y_predict == 1] = 'versicolor'
y_predict1[y_predict == 2] = 'virginica'
print(y_predict1)

# 混淆矩阵看可视化结果
mat = confusion_matrix(ytest, ypred)
sns.heatmap(mat, square=True, annot=True, fmt='d', cbar=False)
plt.xlabel('predicted label')
plt.ylabel('true label')
plt.show()