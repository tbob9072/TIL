# 파이썬 기초

## 1. Requests를 이용한 web crawling

### 1-1. Requests 설치

> - terminal을 실행하여 pip을 이용하여 requests를 설치한다.
> - mac사용자의 경우 pip3인 경우가 있기때문에 pip3인지 확인하고 pip을 업데이트해준다.

~~~bash
# mac 사용자의 경우 가끔 일어나는 일이니 실행하자
$ pip3 install --update pip

# requests 설치
$ pip install requests

# 설치목록 확인하기
$ pip list
~~~



### 1-2. VS code로 요청보내기

> - VS code를 실행하여 requests를 사용하여 url에 요청을 보내보자.

~~~python
import requests

response = requests.get("https://www.naver.com").text
# get은 html파일로 가져와라 라는 명령어임

print(response)
# 응답이 온것을 확인해보자.

# 실행 해보기 -> terminal창으로 가기
# $ python req_and_res.py 입력해보기
~~~



## 2. String format

> - string format은 pyformat과 f-string 두 가지이다.

~~~python
import random

name = "김재현"
english_name = "Kim"

#pyformat
print("안녕하세요, {}입니다. My name is {}".format(name, english_name))

#f-string
print(f"안녕하세요, {name}입니다. My name is {english_name}")


numbers = list(range(1, 46))
lotto = random.sample(numbers, 6)
print(f"오늘의 행운의 번호는 {sorted(lotto)} 입니다.")
~~~



