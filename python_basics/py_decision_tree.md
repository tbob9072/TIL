# 1. 결정 트리 (Decision tree)

> - tree = node(질문) + edge(분기)
> - node = 속성
>   - 범주형 : y/n이기 때문에 분류하기 편함
>   - 연속형 : >80과 같이 기준을 정하기 때문에 경계선에 있는 값들이 오류로 작용할 수 있음 (정확도가 낮아짐)
> - 탐색적 작업에 활용도가 높음
> - 결정트리는 속성 하나를 가지고 질문하는 형태이기 때문에 대각선의 형태로는 나오지 않고, 축과 평행선으로 나누는 작업을 반복함
> - 가지를 생성할 때는 불순도를 낮추는 방향으로 진행해야되며 그것이 최대화 되도록 해야됨 = Information gain (IG)
> - 대표적인 알고리즘
>   - C5.0 : Information gain
>   - CHAID : 카이제곱, F검정
>   - CART : Gini index

```python
# 결정트리 실습
from sklearn.datasets import load_breast_cancer
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split

cancer = load_breast_cancer()
X_train, X_test, y_train, y_test = train_test_split(
    cancer.data, cancer.target, stratify = cancer.target, random_state = 42)
    
tree = DecisionTreeClassifier(random_state = 0)
tree.fit(X_train, y_train)

print("훈련 세트 정확도: {: .3f}".format(tree.score(X_train, y_train)))
print("테스트 세트 정확도: {: .3f}".format(tree.score(X_test, y_test)))


# max_depth 설정
tree = DecisionTreeClassifier(random_state = 0, max_depth= 4)
tree.fit(X_train, y_train)

print("훈련 세트 정확도: {: .3f}".format(tree.score(X_train, y_train)))
print("테스트 세트 정확도: {: .3f}".format(tree.score(X_test, y_test)))

# 그래프
from sklearn.tree import export_graphviz
export_graphviz(tree, out_file="tree.dot", class_names=["악성", "양성"], feature_names=cancer.feature_names, impurity=False, filled=True)

import graphviz
with open("tree.dot") as f :
    dot_graph = f.read()
display(graphviz.Source(dot_graph))

# 특성 중요도 파악
import matplotlib.pyplot as plt
import numpy as np

def plot_feature_importances_cancer(model) :
    n_features = cancer.data.shape[1]
    plt.barh(np.arange(n_features), model.feature_importances_, align = 'center')
    plt.yticks(np.arange(n_features), cancer.feature_names)
    plt.xlabel("특성중요도")
    plt.ylabel("특성")
    plt.ylim(-1, n_features)
    
plot_feature_importances_cancer(tree)
```

