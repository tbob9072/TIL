# 파이썬(Python)

## 1. 컴퓨터 작동방식

> - User -> **S/W(Application)** -> System S/W (Windows, Linux) -> H/W (3 tier 방식)
> - 일반적으로 개발하는 부분은 **Application**임
> - S/W = 프로그램 = 명령어들(Instruction) + 데이터(Data)
> - 명령어들이 실행되기 전에 데이터가 먼저 준비되어 있어야함
> - cpu는 연산장치와 제어장치로 이뤄져있음
> - cpu가 제어를 하는 동안에는 연산을 쉬는 중임. 이시간을 활용하는 기법을 쓰레드라고함

### System S/W와 언어

> - Windows
>   - GUI : 그래픽을 통하여 명령을 전달
>   - TCP : 웹 통신을 위한 규격
>   - 명령프롬포트 : 텍스트로 명령을 전달
> - SDK (Software Development Kit) : 운영체제에 맞춰 개발환경을 설정해주는 것
>   - Runtime(실행환경) 
>   - Library
>   - Utility
> - IDE (Integrated Development Environment)
>   - Spider, Jupyter notebook 등 개발툴
> - anaconda는 Python SDK와 IDE를 묶어서 제공함



## 2. 파이썬

> - 명령어들을 표현하는 도구 = 프로그래밍 언어
> - Application들이 다양한 구조를 갖게 되면서 특화된 언어들의 필요성이 대두됨 (분석, 웹서비스, 일반 Application 등)



## 3. Jupyter notebook 사용

> 1. anaconda powershell 실행
> 2. `cd c:\py_code`입력
> 3. `jupyter notebook`입력
> 4. 브라우저에서 jupyter notebook 실행 확인하기

### 기본적인 사용 방법

> - code, markdown을 활용하여 작성가능
> - ctrl+m 동시에 누르고 손 떼고 l 누르면 줄번호 표시 가능





## 4. 자료형

> - Program이 주기억장치로 넘어오는 순간 Process가 됨
> - 이는 cpu에서 실행가능한이라는 의미임
> - Program과 Process가 실행되기 위해서는 Data가 준비되어야 함
> - 일반적인 방법으로 Data는 변수로 저장됨
> - 변수 = 문자, 숫자, 논리형
> - 타입을 나누는 이유는 명령어를 실행함에 있어서 안정적 수행하기 위해서임
> - 그래서 실행 전 컴파일이라는 과정을 거치는데 이는 명령어에 맞는 타입의 데이터가 들어왔는지 확인하는 것임

### 데이터 저장 방식

> - X1, X2, X3 ... 처럼 변수를 설정하면 주기억장치에 각각 저장이 됨 (순서도 상관없음)
> - X = [1, 2, 3, 4 ...] 처럼 변수하나에 여러값을 넣으면 여러 값들을 연속적으로 저장하고, X라는 변수를 저장하여 여러값 중 시작하는 값의 주소를 X의 값으로 설정해줌 (X의 값은 포인터라는 개념임)
> - 포인터는 주소를 값으로 갖는 것임
> - 그래서 인덱스가 0으로 시작하는 이유는 X의 주소값으로 부터 0번째 떨어진 값이라는 의미임
> - 포인터로 관리되는 변수들 (복합체)
>   - 배열 = Data를 여러개 갖는 것
>   - 함수 = Code를 여러개 갖는 것
>   - 객체 = Data와 Code를 갖는 것
>   - 복합체들은 주소가 없을 때 Null값을 리턴해줌
> - 주기억장치는 프로세스별로 code + data로 구분을 지어 할당을 함
> - 저장되는 데이터의 종류는 크게 3가지로 구분지음
>   - Stack : 쓰고버리는 데이터를 저장하는 곳
>   - Heap : 주로 객체를 저장하는 곳
>   - Static : 프로세스와 처음부터 끝까지 같이가는 데이터를 저장하는 곳



### 예시

```python
x = 100
y = 200
a = 'Hello'
b = 4.76
x+a
-------------------------------------------------------------------------
TypeError                               Traceback (most recent call last)
<ipython-input-4-548205032ab4> in <module>
      1 x+y
----> 2 x+a

TypeError: unsupported operand type(s) for +: 'int' and 'str'
        
# operand는 피연산자를 의미
```

### 숫자형 사칙연산

```python
a = 3
b = 4
a+b
a*b
a/b
a**b # a의 b제곱
7%3  #  나눗셈 후 나머지를 반환
7/4
7//4 # 7을 4로 남은 몫을 반환
```

### 문자열

> - 문자열 = 문자들의 집합
> - `" "`,`' '`,`""" """`, `''' '''`로 문자형을 표현할 수 있음
> - 작은따옴표(')나 큰따옴표(")를 문장열 안에 넣고 싶으면 둘중 하나를 사용하여 문자열로 정의내리면 된다.
>   - `"Python's favorite food is perl"`
> - \를 사용하여 표현도 가능함
>   - `'Python\'s favorite food is perl'`
> - 멀티라인을 사용하고 싶을 때는 `""" """`또는 `''' '''`를 사용한다.
>   - `multiline='''
>     Life is too short
>     You need python
>     '''`
> - 문자열 자료도 연산자 사용이 가능함

```python
head = "python"
tail = " is fun!"
head + tail
'python is fun!'

print('-'*50)
--------------------------------------------------
```

> - 문자열은 인덱싱으로 문자열을 뽑아낼 수 있음
> - 파이썬에서는 문자열을 저장하면 object화 시켜서 저장함
> - 문자형 자료를 데이터 공간에 저장하고, 자주사용하는 코드들을 함께 저장해 줌
> - 그렇기 때문에 `변수명.함수()`식으로 사용이 가능하다.

```python
a = "Life is too short, You need Python"
a[3]
'e'
# -인덱싱은 뒤에서 부터라는 의미임 (-0은 없음 -1부터임)
a[-1]
'n'

# 앞에서 부터 2개씩 연산해 나감
b = a[0] + a[1] + a[2] + a[3]
b
'Life'

#슬라이싱
a[0:3]
'Lif'
# 0 <= a < 3 라는 의미임으로 a[3]인 4번째 단어는 제외된다.

# 앞뒤로 생략하면 처음까지 끝까지 라는 의미임
a[19:]
'You need Python'
a[:17]
'Life is too short'

# 슬라이싱에 -를 사용할 수 있음
a[19:-7]
'You need'

# 사용 예시
a = "20010331Rainy"
date = a[:8]
weather = a[8:]
date
'20010331'
weather
'Rainy'

# 문자열 삽입
",".join('abcd')
'a,b,c,d'

# 대문자/소문자로 바꾸기
a = "hi"
a.upper()
'HI'

a = "HI"
a.lower()
'hi'

# 공백 지우기
a = " hi "
a.strip()
'hi'

# 문자열 바꾸기
a = "Life is too short"
a.replace("Life", "Your leg")
'Your leg is too short'

# 문자열 나누기
a = "Life is too short"
a.split()
['Life', 'is', 'too', 'short']
b = "a:b:c:d"
b.split(':')
['a', 'b', 'c', 'd']
```

### 리스트

```python
# 리스트의 기본형태
a = []
b = [1, 2, 3]
c = ['Life', 'is', 'too', 'short']
d = [1, 2, 'Life', 'is']
e = [1, 2, ['Life', 'is']]

# 리스트의 더하기(합치기)
a = [1, 2, 3]
b = [4, 5, 6]
a + b
[1, 2, 3, 4, 5, 6]

# 리스트의 곱하기(반복)
a = [1, 2, 3]
a * 3
[1, 2, 3, 1, 2, 3, 1, 2, 3]
```

