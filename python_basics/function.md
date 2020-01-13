# 내장함수

## 1. filter

> - 첫 번째 인수에 함수이름, 두 번째 인수로 그 함수에 들어갈 반복가능한 자료형을 넣어줌
> - 들어가는 함수는 True/False에 관한 함수이어야 한다.

```python
# 일반적인 방식
def positive(l): 
    result = [] 
    for i in l: 
        if i > 0: 
            result.append(i) 
    return result

print(positive([1,-3,2,0,-5,6]))
[1, 2, 6]

#filter 방식
def positive(x):
    return x > 0

print(list(filter(positive, [1, -3, 2, 0, -5, 6])))
[1, 2, 6]

# lambda를 사용하여 축약
list(filter(lambda x: x > 0, [1, -3, 2, 0, -5, 6]))
[1, 2, 6]
```

## 2. map

> - 기본적으로 filter와 동일하지만 들어가는 함수가 True/False에 관한 문제가 아니라 연산들도 넣을 수 있다.

```python
list(map(lambda a: a*2, [1, 2, 3, 4]))
[2, 4, 6, 8]
```

## 3. zip

> - 동일한 개수로 이뤄진 자료형을 묶어 튜플로 만들어주는 함수

```python
list(zip([1, 2, 3], [4, 5, 6]))
[(1, 4), (2, 5), (3, 6)]
list(zip([1, 2, 3], [4, 5, 6], [7, 8, 9]))
[(1, 4, 7), (2, 5, 8), (3, 6, 9)]
list(zip("abc", "def"))
[('a', 'd'), ('b', 'e'), ('c', 'f')]
```



# 외장함수

## 1. sys함수

> - sys.path를 활용하여 library 경로를 확인하고, append활용해서 path를 추가 하여 모듈 경로를 추가할 수 있음

```python
# 경로 확인
sys.path
['C:\\py_data',
 'C:\\Users\\student\\Anaconda3\\python37.zip',
 'C:\\Users\\student\\Anaconda3\\DLLs',
 'C:\\Users\\student\\Anaconda3\\lib',
 'C:\\Users\\student\\Anaconda3',
 '',
 'C:\\Users\\student\\AppData\\Roaming\\Python\\Python37\\site-packages',
 'C:\\Users\\student\\Anaconda3\\lib\\site-packages',
 'C:\\Users\\student\\Anaconda3\\lib\\site-packages\\win32',
 'C:\\Users\\student\\Anaconda3\\lib\\site-packages\\win32\\lib',
 'C:\\Users\\student\\Anaconda3\\lib\\site-packages\\Pythonwin',
 'C:\\Users\\student\\Anaconda3\\lib\\site-packages\\IPython\\extensions',
 'C:\\Users\\student\\.ipython']
 
 # 경로 추가
sys.path.append("C:/doit/mymod")
```

## 2. pickle

> - pickle은 객제의 형태를 그대로 유지하면서 파일에 저장하고 불러올 수 있게 하는 모듈

```python
# 저장하기
import pickle
f = open("test.txt", 'wb')
data = {1: 'python', 2: 'you need'}
pickle.dump(data, f)
f.close()

# 불러오기
import pickle
f = open("test.txt", 'rb')
data = pickle.load(f)
print(data)
{2:'you need', 1:'python'}
```

## 3. glob

> - 특정디렉터리에 있는 파일이름 모두를 알려줌

```python
# 실습
import glob
glob.glob("c:\py_data/*")

['c:\\py_data\\day01_python기본문법.ipynb',
 'c:\\py_data\\day02_python기본문법_자료형.ipynb',
 'c:\\py_data\\day03_python_basic_data_form.ipynb',
 'c:\\py_data\\Day4_클래스.ipynb',
 'c:\\py_data\\mod1.py',
 'c:\\py_data\\Untitled.ipynb',
 'c:\\py_data\\__pycache__']
```



# 정규표현식

> - 문자열의 패턴을 지정
> - 패턴이 일치하는 문자열에 대하여 대체, 찾기 등 기능을 적용

```python
import re

data = """
park 800905-1049118
kim 700905-1059119
"""

pat = re.compile("(\d{6})[-]\d{7}")
print(pat.sub("\g<1>-*******", data))

>>> park 800905-*******
	kim 700905-*******

```

## 1. 문자 클래스 []

> - []사이의 문자들과 하나라도 매치됨을 의미함
> - [*-%] 처럼 안에 `-`을 사용하면 두 문자사이의 범위를 말한다
>   - ex) [a-c] = [abc]
> - `^`는 정규표현식에서 not이라는 의미를 갖는다.

## 2. dot(.)

> - 줄바꿈 문자인 `\n`을 제외한 모든 만자와 매ㅣ됨을 의미한다
> - a.b는 `a + 모든문자 + b`라는 의미이다.
> - 반면 a[.]b는 `a.b`만을 의미한다.

## 3. 반복(*, +)

> - `*`을 사용하면 0번부터 무한대까지 반복됨을 의미한다.
>   - ca*t = ct, cat, caat, caaat, caaaat ....
> - `+`는 1번부터 무한대 까지이다.
>   - ca+t = cat, caat, caaat ...

## 4. 반복 ({m, n}, ?)

> - 반복 횟수를 고정하는 표현
>   - ca{2}t = caat
>   - ca{2,5} = caat, caaat, caaaat, caaaaat

## 5. ?

> - {0,1}과 동일, 있어도되고 없어도됨
>   - ab?c = abc, ac

