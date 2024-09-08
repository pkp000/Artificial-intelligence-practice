# N a m e   :裴鲲鹏
# Student ID:202100172014
# Date&Time :2023/6/30 18:56

import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns; sns.set()
from csv import reader
from sklearn import metrics
from sklearn.metrics import confusion_matrix
from sklearn.ensemble import RandomForestClassifier

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

# 随机森林训练模型
model = RandomForestClassifier(n_estimators=1000)
model.fit(Xtrain, ytrain)
ypred = model.predict(Xtest)

# 可视化结果，计算模型指标
print(metrics.classification_report(ytest, ypred))

# 混淆矩阵
mat = confusion_matrix(ytest, ypred)
sns.heatmap(mat, square=True, annot=True, fmt='d', cbar=False)
plt.xlabel('predicted label')
plt.ylabel('true label')
plt.show()
