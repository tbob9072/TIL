### 함수

> - 전체 프로세스에서 반복적으로 등장하는 코드를 메인으로부터 분리한 후 따로 관리하는 것
> - main에서부터 시작한 cpu가 call함수가 나오면 지정해둔 함수구역으로 context가 변하여 함수영역으로 넘어감
> - 그렇기때문에 함수에는 지역변수가 존재할 수 있음
> - 또한 함수 마지막에 return을 적는 이유는 원래 context로 돌아가라는 의미임
> - 함수는 코드의 재사용에 초점이 맞춰져있기 때문에 데이터를 인수로 받아서 사용함 (인수는 무제한적으로 받아서 쓸 수 있음)
> - **함수의 return값은 반드시 하나이어야 한다** (즉, object화 시켜서 보내면 하나의 값 안에 여러가지 값을 넣어서 보낼 수 있음)



###  자료형 체계

> 1. 단일
>    1. 숫자
>    2. 문자열
>    3. 불(논리)
> 2. 복합(다수)
>    1. List
>    2. Tuple
>    3. Set
>    4. Dictionary



# 1. 리스트 자료형





# 2. 튜플자료형

> - 리스트와 모습은 비슷하지만 한번 결정되면 바꿀 수 없는 데이터형태
> - 함수에서 여러가지 값을 return할 때, 튜플로 주로 받음
> - 튜플 ()를 생략할 수 있음

```python
# 둘이 같은 것임 (튜플은 생략가능하기 때문에)
x , y = min_max(10,50)
(x, y) = min_max(10,50)

# ()생략
z = 1,2,3,4,5,6,7
type(z)
>>> tuple
```

# 3. 딕셔너리 자료형

> - 연관 Mapping을 사용하지만 인덱스보다 빠르지만 데이터를 많이 차지함
> - 관계형 데이터베이스에서 자료를 받아 올 때 비슷한 형태임으로 딕셔너리를 주로 사용함
> - 딕셔너리에서 값을 불러올 때에는 key값을 인덱스처럼 사용함 
> - key값과 value를 갖음
> - key값이 중복되면 나중에 입력된 값으로 인식함
> - key값은 list로 지정될 수 없음
> - **json자료와 완벽하게 호환됨**

#### 관계형 데이터 (RDB)

> - 테이블 구조의 데이터를 관리함
> - 데이터를 관리하는데 사용하는 언어는 SQL로 불리움
> - 관리하는 것은 RDBMS = Oracle, MySql ...
> - 모든 연산은 행을 기준으로 이루어짐

```python
# 값을 불러올 때 key값으로 불러옴
a = {1: 'a'}
a[1] = 'a'
a[2] = [1, 2, 3]
# a = {1: 'a', 2: [1, 2, 3]}

# key값은 list로 지정될 수 없음
a = {[1,2] : 'hi'}
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unhashable type: 'list'
        
# key값 뽑아보기
a = {'name': 'pey', 'phone': '0119993323', 'birth': '1118'}
a.keys()
>>> dict_keys(['name', 'phone', 'birth'])
# a.keys()는 리스트형태가 아니기때문에 호환이 어렵다. 그래서 보통은 list(a.keys())로 사용하는 경우가 많다.

# key안에 있는 value 뽑아보기
for val in a.keys():
    print(val)
>>> name
	phone
	birth
    
# key와 value한쌍으로 얻기
a.items()
>>> dict_items([('name', 'pey'), ('phone', '0119993323'), ('birth', '1118')])

#해당 key가 딕셔너리 안에 있는지 조사하기(in)
a = {'name':'pey', 'phone':'0119993323', 'birth': '1118'}
'name' in a
True
'email' in a
False
```



# 4. 집합자료형

> - 집합은 순서가 없고 중복을 허용하지 않는 자료형임
> - 단순히 안에 들어있는 데이터가 중요함
> - 범주형데이터로 이뤄진 자료에 대해서 범주를 파악할 때 활용할 수 있음
> - 집합자료 데이터들에 접근 할 때에는 list로 바꿔서 index로 접근하면 됨

```python
s2 = set("Hello")
s2
>>> {'e', 'H', 'l', 'o'}

# 교집합, 합집합 구하기
s1 = set([1, 2, 3, 4, 5, 6])
s2 = set([4, 5, 6, 7, 8, 9])

s1 & s2
>>> {4, 5, 6}
s1.intersection(s2)
>>> {4, 5, 6}

s1 | s2
>>> {1, 2, 3, 4, 5, 6, 7, 8, 9}
s1.union(s2)
>>> {1, 2, 3, 4, 5, 6, 7, 8, 9}
```



# 5. 불(bool)자료형

> - 참(True)과 거짓(False)을 나타내는 자료형
> - 단순히 참/거짓만을 비교하는 것이 아니라 각각의 데이터 형태마다 참/거짓을 매칭 시켜놓았음
>   - True : "python", [1, 2, 3], 1 ...
>   - False : "", {}, [], (), 0 ...