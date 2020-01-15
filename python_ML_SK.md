# 파이썬을 활용한 머신러닝

## 1. 머신러닝 절차

> 1. 데이터 수집
>
> 2. 수집된 데이터 전처리 
>
>    (EDA)
>
> 3. 훈련데이터/테스트데이터 분할
>
> 4. 학습알고리즘적용(회귀분석, SVM, 인공신경망, 결정트리, 군집화 ...)
>
> 5. 학습모형 만들어짐
>
> 6. 학습모형 평가

## 2. Scikit learn (딥러닝은 지원 안함)

> - 파일을 로드했을 때 scikit-learn에서 제공하는 Bunch스타일로 값을 리턴해주기로 함 
> - Iris 예제
>
> ~~~python
> # 데이터 불러오기
> from sklearn.datasets import load_iris
> iris_dataset = load_iris()
> 
> # 데이터 분할하기
> from sklearn.model_selection import train_test_split
> X_train, X_test, Y_train, Y_test = train_test_split(iris_dataset['data'], iris_dataset['target'], random_state = 0)
> # train_test_split(X, Y)로 입력이 된다고 치고, X와 Y가 각각 train, test 2개씩 나오게됨 그걸 튜플형태로 묶어준 것임
> 
> # ndarray형식은 .shape로 몇행 몇열인지 알아 볼 수 있음
> X_train.shape
> (112, 4)
> X_test.shape
> (38, 4)
> 
> # EDA
> pd.plotting.scatter_matrix(iris_df, c = Y_train, figsize = (15, 15), marker = 'o', hist_kwds = {'bins':20}, s = 60, alpha = 8, cmap = mglearn.cm3)
> >>> 결과 확인하기
> 
> # knn
> from sklearn.neighbors import KNeighborsClassifier
> # knn모델을 변수에 넣어서
> knn = KNeighborsClassifier(n_neighbors = 1)
> # 그 변수에 fit 메서드를 사용하여 train데이터를 넣어줌
> knn.fit(X_train, Y_train)
> # 그 다음 test 데이터로 예측을 해봄
> Y_pred = knn.predict(X_test)
> Y_pred
> # score 매서드는 학습한 내용으로 test셋을 돌려보고 정확도를 알려줌
> knn.score(X_test, Y_test)
> 
> ~~~
>
> 
>
> 
>
> 

