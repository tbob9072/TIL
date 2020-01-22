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

from sklearn.tree import export_graphviz
with open("tree.dot") as f :
    dot_graph = f.read()
display(graphviz.Source(dot_graph))