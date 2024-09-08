# N a m e   :裴鲲鹏
# Student ID:202100172014
# Date&Time :2023/7/5 18:10

# 从sklearn库中导入不同模型方法
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import MinMaxScaler
from sklearn import neighbors
from sklearn.svm import SVC
from sklearn import tree
# 导入自动生成训练集和测试集的模块train_test_split
from sklearn.model_selection import train_test_split
# 导入指标计算相关
from sklearn.metrics import cohen_kappa_score
from sklearn.metrics import matthews_corrcoef
from sklearn.metrics import accuracy_score
from sklearn.metrics import roc_auc_score
# 评价分类模型的分类性能
from sklearn.metrics import classification_report
# 可视化指标
from sklearn.metrics import confusion_matrix
from sklearn.metrics import plot_roc_curve
# 运行基础部分导入
import warnings;warnings.filterwarnings("ignore")
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
import numpy as np
import shap

svm = SVC(decision_function_shape='ovo', kernel='linear', gamma=1e-5, C=8.3, random_state=57306, probability=True)
lr = LogisticRegression(penalty='l2', dual=False, tol=0.0001, C=9.5, fit_intercept=True, intercept_scaling=1,
                        class_weight='balanced', random_state=57306, solver='liblinear', max_iter=1000,
                        multi_class='auto')
rf = RandomForestClassifier(n_jobs=2, random_state=57306, class_weight='balanced', n_estimators=65, max_depth=10)
knn = neighbors.KNeighborsClassifier(n_jobs=2, n_neighbors=7, weights='distance', algorithm='auto', leaf_size=12, p=2)
dt = tree.DecisionTreeClassifier(criterion='entropy', random_state=57306, splitter='random', max_depth=23,
                                 class_weight='balanced')


def evaluate_accuracy(features, mod):
    """
       Evaluate the accuracy of specified objects.

       Sort all original features based on the SHAP values of different classifiers, and then arrange them in descending
       order to remove the features with the lowest SHAP values one by one and calculate the classification accuracy
       each time. Finally, select the combination of features with the highest classification accuracy as the input of
       the classifier.

       """
    x_selected = X_train[:, features]  # 由主到次增加特征列
    model0 = mod  # 实例化分类器，这里以逻辑回归为例
    model0.fit(x_selected, y_train)  # 训练分类器
    x_test_selected = X_test[:, features]  # 在测试集上选择相同的特征
    y_predict = model0.predict(x_test_selected)  # 预测
    return accuracy_score(y_test, y_predict)  # 计算准确率


def evaluation(y_test0, y_predict0):
    """
       Calculation of indicator parameters.

       Returns
            accuracy, precision, recall, f1_score, kappa

       """
    accuracy0 = classification_report(y_test0, y_predict0, output_dict=True)['accuracy']
    s = classification_report(y_test0, y_predict0, output_dict=True)['weighted avg']

    # 精确率，在所有被预测为正的样本中实际为正的样本的概率
    precision0 = s['precision']

    # 召回率，表示在实际为正的样本中被预测为正样本的概率
    recall0 = s['recall']

    # 三级指标:F1分数、Kappa系数
    f1_score0 = s['f1-score']
    kappa0 = cohen_kappa_score(y_test, y_predict0)

    return accuracy0, precision0, recall0, f1_score0, kappa0


if __name__ == '__main__':

    model1 = svm  # 模型选择
    print("\n Training option：\n " + str(model1) + '\n')
    print('Reading……')

    # 九维：非线性+时空  特征
    data9 = pd.read_excel(r'..\特征提取结果\非线性+时空.xlsx', sheet_name='time', header=0, skiprows=0)
    columns = np.array(data9.columns)
    columns = columns.tolist()  # 转换成列表
    columns = columns[1:]  # 切片操作：索引从0计，左闭右开[a:b)。就是说从第2位开始取
    X, y = data9.iloc[:, 1:], data9.iloc[:, 0]  # 读取指定行和列的数据：索引从0计，左闭右开[a:b)。X全行第2列至末；y全行第一列

    # 4*9 三十六维：非时域+小波  特征
    sheet_name = ['p2p', 'mean', 'rootAmplitude', 'std']
    for sheet in sheet_name:
        data36 = pd.read_excel(r'..\特征提取结果\时频域+小波.xlsx', sheet_name=sheet, header=0, skiprows=0)
        columns_i = np.array(data36.columns)
        columns_i = columns_i.tolist()
        columns_i = columns_i[2:]
        Xi = data36.iloc[:, 2:]

        # 合并成四十五维特征
        X = X.join(Xi)
        columns.extend(columns_i)

    print('Reading finished.\n\nCalculating shap and Training……:')
    # 特征归一化处理
    scaler = MinMaxScaler()
    scaler.fit(X)
    X = scaler.transform(X)
    X_summary = shap.kmeans(X, 10)

    # 特征重要性指标计算
    shap.initjs()  # 为了能够输出shap的图像

    # 训练模型
    model = model1.fit(X, y)

    # SHAP值--特征重要性贡献排序绘图
    explainer = shap.KernelExplainer(model.predict, data=X_summary)
    shap_values = explainer.shap_values(X)
    plt.figure()
    shap.summary_plot(shap_values, X, feature_names=columns, plot_type="bar", max_display=45)
    plt.show()

    # 根据shap值选取重要特征
    print('\nStarting to reorder X by feature criticality:')
    feature_importance = np.abs(shap_values).mean(axis=0)  # 取平均值来度量特征的重要性
    sorted_idx = np.argsort(feature_importance)[::-1]  # 对特征重要性进行排序
    sorted_features = X[:, sorted_idx]  # 排序后的特征
    print('Successfully finished.\n\nChange the original column index to:\n', sorted_idx)

    # 逐个删除次要特征并计算分类准确率
    accuracies = []
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)  # 划分训练集和测试集

    for i in range(len(sorted_features)):
        features_subset = sorted_idx[:i + 1]  # 逐渐添加特征
        accuracy = evaluate_accuracy(features_subset, model1)  # 用函数写的地方
        accuracies.append(accuracy)

    print('\nThe accuracy of adding each feature in sequence after sorting:\n', accuracies)

    # 找到使准确率最高的特征组合
    best_accuracy = max(accuracies)
    best_num_features = accuracies.index(best_accuracy)
    best_features = sorted_features[:, best_num_features]
    if best_features.shape == (35,):  # 特殊地，对只选取一个特征时要稍加处理
        best_features = best_features.reshape(-1, 1)

    # 归一化、降维后 正式训练并预测
    X_train, X_test, y_train, y_test = train_test_split(best_features, y, test_size=0.2, random_state=42)
    model = model1.fit(X_train, y_train)
    model_predict = model1.predict(X_test)

    # 计算各项指标
    print("\nThe classifiction Table display:\n")
    print(classification_report(y_test, model_predict), '\n')
    accuracy, precision, recall, f1_score, kappa = evaluation(y_test, model_predict)  # 用函数写的地方
    print('kappa coefficient:%.2f' % kappa)  # Kappa系数

    # 混淆矩阵
    sns.set()
    mat = confusion_matrix(y_test, model_predict)
    sns.heatmap(mat, square=True, annot=True, fmt='d', cbar=False)
    plt.xlabel('predicted label')
    plt.ylabel('true label')
    plt.show()

    # ROC曲线
    plot_roc_curve(model1, X_test, y_test)
    plt.show()

    # 计算马修斯相关系数
    MCC_coefficient = matthews_corrcoef(y_test, model_predict)
    print("MCC:%.2f" % MCC_coefficient)

    # 计算AUC值
    auc_value = roc_auc_score(y_test, model_predict)
    print("AUC value:%.2f" % auc_value)
