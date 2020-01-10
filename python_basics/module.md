# 모듈

> - 함수, 변수, 클래스를 모아 놓은 파일
> - 모듈 안에 `if __name__ == "__main__"`를 넣고 밑에 테스트 코드를 넣어두면 `import`할 때는 나오지 않고, 직접 실행할 때는 수행되는 코드임
> - 모듈안에 데이터, 클래스, 함수에 접근 가능함

```python
# 예시
import mod1
print(mod1.add(3,4))
>>> 7

# 방법2
from mod1 import add
add(3, 4)
>>> 7

# 방법3
from mod1 import add, sub
sub(4, 1)
>>> 3

# if __name__ == "__main__"
def add(a, b): 
    return a+b

def sub(a, b): 
    return a-b

if __name__ == "__main__":
    print(add(1, 4))
    print(sub(4, 2))

# mod2
PI = 3.141592

class Math: 
    def solv(self, r): 
        return PI * (r ** 2) 

def add(a, b): 
    return a+b 

--------------------------------------------------------

import mod2
print(mod2.PI)
>>> 3.141592

a = mod2.Math()
print(a.solv(2))
>>> 12.566368

print(mod2.add(mod2.PI, 4.4))
>>> 7.541592
```



# 내장함수

