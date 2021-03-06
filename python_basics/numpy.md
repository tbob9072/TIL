# numpy

> - 자료구조를 지원해주는 패키지
>
> - 행렬구조를 지원함
>
> - 메모리관리를 효율적으로 하는데 도움이 됨
>
> - numpy 형식으로 바꾼 것을 ndarray라고 부름 (n demenstional이라는 의미)
>
> - ndarray에서는 실수(float)형 자료들을 정수(int)형으로 바꾸면 뒤에 소숫점 아래 수는 버리고 값을 출력해줌
>
> - ndarray의 덧셈 뺄셈은 각 자리에 맞춰서 빼고 더해줌
>
>   ```python
>   arry1 = np.array([10, 20, 30, 40])
>   arry2 = np.array([1, 2, 3, 4])
>   arry1 + arry2
>   >>> array([11, 22, 33, 44])
>   ```
>
> - 곱하기 나누기는 각 자리마다 해줌
>
>   ```python
>   arry1 * 2
>   >>> array([20, 40, 60, 80])
>   
>   arry1 / 2
>   >>> array([ 5., 10., 15., 20.])
>   ```
>
> - 반복 for문없이 ndarray객체가 되면 여러가지 매서드를 자동으로 제공한다
>
>   - ex) .sum(), .mean(), .max(), .dot(), transpose()(전치행렬) 등등
>
> ```python
> # 다양한 기능
> # 1
> a2 = np.arange(10, 100, 10).reshape(3,3)
> a2
> array([[10, 20, 30],
>        [40, 50, 60],
>        [70, 80, 90]])
> 
> # 2
> a2[1] = np.array([45, 55, 65])
> a2
> 
> # 3 -> 앞의 묶음은 행의 값들, 뒤에 묶음은 열의 값들로 인식함
> a2[[0, 2], [0, 1]]
> array([10, 80])
> 
> # 필터대신 조건식
> a = np.array([1,2,3,4,5,6])
> a[a>3]
> >>> array([4, 5, 6])
> 
> # 슬라이싱
> b = np.array([1, 10, 20, 30, 40, 50])
> b[1:4]
> >>> array([10, 20, 30])
> ```
>
> - serial 형식의 데이터는 처리를 못해서 pandas에서 지원하는 라이브러리를 활용해야됨



