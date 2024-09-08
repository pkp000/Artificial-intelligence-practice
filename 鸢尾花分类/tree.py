# N a m e   :裴鲲鹏
# Student ID:202100172014
# Date&Time :2023/7/1 14:58

import numpy as np
import matplotlib.pyplot as plt
from csv import reader
from sklearn import tree
from sklearn.tree import DecisionTreeClassifier

# 数据读入，读取.csv文件
with open('.\\iris.csv', 'r') as csvfile:
    readers = reader(csvfile, delimiter=',')
    a = list(readers)

    # 数据提取处理，数据特征 X 为第二三四五列；标签 y 为第六列
    b = np.delete(np.array(a), 0, axis=0)
    X = np.delete(b, [0, 5], axis=1)
    y = np.delete(b, [0, 1, 2, 3, 4], axis=1)

    # 将标签 y 字符串用数字代表
    y[y == 'setosa'] = 0
    y[y == 'versicolor'] = 1
    y[y == 'virginica'] = 2

# 类型转换
X = X.astype(float)

# 类型转换，维度转换
y = y.astype(int).ravel()

# 决策树训练
model = DecisionTreeClassifier(criterion='entropy', max_depth=10).fit(X, y)

# 单点预测
X_test = [[4.8, 3.4, 1.6, 0.2]]
y_predict = model.predict(X_test)

# 单点预测结果，并将数字标签 y 再换回字符串标签
y_predict1 = y_predict.astype(str)
y_predict1[y_predict == 0] = 'setosa'
y_predict1[y_predict == 1] = 'versicolor'
y_predict1[y_predict == 2] = 'virginica'
print(y_predict1)

# 画出决策树过程
fig = plt.figure(figsize=(25, 20))
tree.plot_tree(model)
plt.show()
