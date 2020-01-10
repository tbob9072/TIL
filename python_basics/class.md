# 클래스

## 1. 구조

> - 클래스 = 속성(특성, 변수) + 메소드(기능, 함수)

## 2. 생성과정

> - Class명 obj = new Class명()
>
>   - 구조 : Stack -- heap -- code
>
>   1. Cal : 클래스를 작성한다 
>   2. obj : stack에 'obj'라는 변수를 저장하고 값에 null을 줌
>   3. new : heap에 code부분의 class를 객체화하여 메모리 할당해 줌 (메소드는 이때 잡힘 -> 앞으로 변할 필요 없기 때문) (함수는 instance로 지정함)
>   4. Cal()  : 메모리에 할당된 객체에 속성을 지정해줌 (초기화)
>   5.  = : Stack과 heap을 연결해줌
>
> - 파이썬에서는 obj = Cal()(생성자함수) 형식으로 적어야됨
>
> - Cal()의 역할 : 속성변수 초기화 -> 파이썬에서는 `__init__`(생성자 함수)
>
> - Class 정의 시 self의 역활 
>
>   - 함수를 호출 했을 경우 함수는 Class부분으로 넘어가서 수행해야되는데 속성값들은 heap에 그대로 남아있다. 그래서 Class에서 속성값들 정의할 때 self.x같이 표현하고, heap에서 요청이 들어왔을 경우 속성값들을 heap에서 가져와서 사용할 수 있게 해준다.
>
> - 가변길이(*변수명)
>
>   - 함수정의 시 변수에 `*변수명`으로 설정하면 튜플로 자동으로 받음

## 3. 객체지향 프로그래밍

> 1. 객체 추출 = 역할정하기
> 2. Class별 표현 도식화 하기
> 3. Class 만들기
> 4. Class를 활용하여 Object만들기

```python
# 클래스 만들기 예제
class Student :
    def __init__(self, hak, name, k, e, m) :
        self.sname = "홍길동"
        self.total = 0
        self.haknu = hak
        self.sname = name
        self.kor = k
        self.eng = e
        self.math = m
        
        
    def add(self) :
        self.total = self.kor + self.eng + self.math
        return self.total
        pass
    
    def display(self) :
        self.add()
        print(self.sname, ":", self.total)
        
s1 = Student(hak = 1, name = "홍길동", k = 25, e = 34, m = 56)
s1.display()
홍길동 : 115


s2 = Student(hak = 2, name = "이길동", k = 70, e = 84, m = 96)
s2.display()
이길동 : 250
```

## 4. 클래스 간의 공통코드 처리(계층구조)

> - Object와 Class간의 관계는 Class -> 복수의 Object를 갖을 수 있음 (중복을 피하기 위해서)
> - 반면 Class간의 공통코드는 어떻게 압축가능할까?
> - '상속'개념을 활용하여 클래스에서 클래스로 매쏘드를 전달해주면 됨
> - 부모(super Class) <-- 자식(sub Class)로 상속한다. (화살표가 반대 방향)
> - 부모클래스만이 자식클래스에게 구성요소를 상속할지말지 결정할 권한이 있음 (주기 싫으면 부모가 private로 설정하면 됨)
> - 자식클래스가 부모클래스의 구성요소를 삭제할 수 없다. 하지만 자기자신에게 코드를 추가하거나 변경하면 확장하여 사용할 수 있음. 
> - 메서드 오버라이딩
>   - 부모클래스의 메서드가 맘에 안들때 그 함수를 재정의 하여 덮어 씌울 수 있음
> - 코드의 재활용성 때문에 상속을 활용하는 경우도 있지만, 자식클래스를 제어하기 위하여 부모클래스를 사용하기도 함

```python
# 클래스상속 예제
class FStudent(Student) :
    pass

fs = FStudent(hak = 3, name = "김길동", k = 50, e = 70, m = 86)
fs.display()
김길동 : 206
    
# 메소드 오버라이딩
class FStudent(Student) :
    
    def display(self):
        self.add()
        print(">>>>>>총점:", self.total)
    pass

fs = FStudent(hak = 3, name = "김길동", k = 50, e = 70, m = 86)
fs.display()
>>>>>>총점: 206
```





