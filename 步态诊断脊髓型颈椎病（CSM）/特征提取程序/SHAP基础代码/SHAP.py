from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression
from sklearn import neighbors
from sklearn import tree
import pandas as pd
import numpy as np
from sklearn.preprocessing import MinMaxScaler
import matplotlib.pyplot as plt
import shap

svm = SVC(decision_function_shape='ovo', kernel='linear', gamma=1e-5, C=8.3, random_state=57306, probability=True)
lr = LogisticRegression(penalty='l2', dual=False, tol=0.0001, C=9.5, fit_intercept=True, intercept_scaling=1,
                        class_weight='balanced', random_state=57306, solver='liblinear', max_iter=1000, multi_class='auto')
rf = RandomForestClassifier(n_jobs=2, random_state=57306, class_weight='balanced', n_estimators=65, max_depth=10)
knn = neighbors.KNeighborsClassifier(n_jobs=2, n_neighbors=7, weights='distance', algorithm='auto', leaf_size=12, p=2)
dt = tree.DecisionTreeClassifier(criterion='entropy', random_state=57306, splitter='random', max_depth=23, class_weight='balanced')


if __name__ == '__main__':
    shap.initjs()
    data = pd.read_excel(r'（数据读取路径）', sheet_name='（数据表格读取）', header=0, skiprows=0)
    columns = np.array(data.columns)
    columns = columns.tolist()
    columns = columns[3:]
    X, y = data.iloc[:, 3:], data.iloc[:, 0]
    scaler = MinMaxScaler()   ##特征归一化处理
    scaler.fit(X)
    X = scaler.transform(X)
    X_summary = shap.kmeans(X, 10)
    model1 = svm    ##模型选择
    model = model1.fit(X, y)
    explainer = shap.KernelExplainer(model.predict, data=X_summary)
    shap_values = explainer.shap_values(X)
    plt.figure()
    ##SHAP值--特征重要性贡献排序绘图
    shap.summary_plot(shap_values, X, feature_names=columns,  plot_type="bar", max_display=45)
    plt.show()

