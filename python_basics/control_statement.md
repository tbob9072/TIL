# 제어문

## 1. 종류

> 1. 조건문
>    - if
> 2. 반복문
>    - for
>    - while

## 2. if

> - 조건문의 조건은 Ture/False로만 나와야됨
> - 조건으로 `>=`, `<=`는 잘 안쓰는 것이 좋음 두번씩 연산을 돌기 때문에 속도가 느려짐
> - if문의 문제는 2가지 분기점만 갖는다는 것임

```python
# money == True 생략가능
money = True

if money :
    print("택시를 타고 가라")
else :
    print("걸어 가라")
>>> 택시를 타고 가라
    
    
# "", [] 등등 False표현 가능
if "" :
    print("참")
else :
    print("거짓")
>>> 거짓


# and, or 사용 가능
money = 2000
card = True
if money >= 3000 or card :
    print("택시를 타고 가라")
else :
    print("걸어가라")
>>> 택시를 타고 가라


# in, not in 사용
pocket = ['paper', 'cellphone', "money"]
if "money" in pocket :
    print("택시 타고 가라")
else :
    print("걸어가라")
>>> 택시를 타고 가라


# pass 사용 (가만히 있는 것)
pocket = ['paper', 'cellphone', "money"]
if "money" in pocket :
    pass
else :
    print("카드를 꺼내라")
>>> 


# elif 사용
pocket = ['paper', 'cellphone']
card = True
if 'money' in pocket:
     print("택시를 타고가라")
elif card: 
     print("택시를 타고가라")
else:
    print("걸어가라")
택시를 타고가라

# 조건부 표현식
message = "success" if score >= 60 else "failure"
```

## 3. while

> - 몇번 반복해야 될지는 모르겠지만 일정한 조건을 만족하면 멈추고 싶을 때 사용
> - 강제로 종료시킬 때는 `break`사용

```python
coffee = 10
money = 300
while money :
    print("돈을 받았으니 커피를 줍니다.")
    coffee = coffee - 1
    print(f"남은 커피의 양은 {coffee}개 입니다.")
    if coffee == 0 :
        print("커피가 다 떨어졌습니다. 판매를 중지합니다.")
        break
```

## 4. for

> - 반복횟수를 지정하여 반복하는 제어문
> - `continue`, `break`, `range()`와 주로 쓰인다
> - `range()`는 `range(시작 숫자, 범위에서 제외될 숫자)`로 사용함
>   - ex1) range(1, 6) = [1, 2, 3, 4, 5]
>   - ex2) list(range(6)) = [0, 1, 2, 3, 4, 5]

```python
# 튜플 매칭시키는 for문
a = [(1, 2), (3, 4), (5, 6)]
for (first, last) in a :
    print(first + last)
>>> 3
	7
    11
    
    
# 연습문제 : 5명의 학생 중 60점이 넘으면 합격, 이 때 합격판단 하기
marks = [90, 25, 67, 45, 80]
for i in marks :
    if i > 60 :
        print(f"{marks.index(i) + 1}번째 학생 '합격'")
    else :
        print(f"{marks.index(i) + 1}번째 학생 '불합격'")
>>> 1번째 학생 '합격'
	2번째 학생 '불합격'
	3번째 학생 '합격'
	4번째 학생 '불합격'
	5번째 학생 '합격'
    
    
# continue 사용 풀이
marks = [90, 25, 67, 45, 80]
for i in marks :
    if i < 60 :
        continue
    print(f"{marks.index(i) + 1}번째 학생 '합격'")
>>> 1번째 학생 '합격'
	3번째 학생 '합격'
	5번째 학생 '합격'
    

# range() 활용
sum = 0
for i in range(1,101) :
    sum = sum + i
print(sum)
>>> 5050

# 리스트 내포 사용
a = [1,2,3,4]
result = [num * 3 for num in a if num % 2 == 0]
print(result)
>>> [6, 12]
```

