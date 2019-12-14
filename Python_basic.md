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



## 3. Txt_write

> - 파일을 읽는 방법은  open(), close()를 사용하는 방식과 with로 두가지를 동시에 하는 방식이 있다.

~~~python
# open & close

f = open('mulcam.txt', 'w')
# 'w'는 쓰기모드로 불러오는 것이고, 'r'을 사용한다면 읽기모드로 불러오는 것이다.

for i in range(10) :
  f.write(f"This is line{i}. \n")
  
 f.close()
# 파이썬 3.8에서는 안써줘도 무방하지만 그래도 사용한다.


# with open()
# 쓰기
with open('mulcam.txt', 'r') as f :
  for i in range(10) :
    f.write(f"This is line {i}. \n")
# 읽기
with open('mulcam.txt', 'r') as f :
  lines = f.readlines()
  for line in lines :
    print(line.strip())
~~~

> - 추가로 txt파일을 불러와 뒤집어 보자. (.reverse()사용)

~~~python
# 불러오기
with open('mulcam.txt', 'r') as f :
  lines = f.readlines()
# 뒤집기
lines.reverse()
# 저장하기
with opne('mulcam.txt', 'w') as f :
  f.writelines(lines)
~~~



## 3. Beautifulsoup를 활용한 webcrawling

> - pip을 이용하여 beautifulsoup을 설치하자.

~~~bash
$ pip install beautifulsoup
~~~

> - requests와 beautifulsoup를 이용하여 네이버 검색어 순위를 긁어오자.

~~~python
import requests
from bs4 import BeautifulSoup

response = requests.get("https://www.naver.com/").text
soup = BeautifulSoup(response, 'html.parser')

# 방법 1.
for i in range(1, 21) :
  contens = soup.select(f"#PM_ID_ct > div.header > div.section_navbar > div.area_hotkeyword.PM_CL_realtimeKeyword_base > div.ah_roll.PM_CL_realtimeKeyword_rolling_base > div > ul > li:nth-child({i}) > a > span.ah_k")
  con = contents[0].text
  print(f"{i}순위 : {con}")
  
# 방법 2.
tags = soup.select("#PM_ID_ct > div.header > div.section_navbar > div.area_hotkeyword.PM_CL_realtimeKeyword_base > div.ah_roll.PM_CL_realtimeKeyword_rolling_base > div > ul .ah_k")
with open('naver.txt', 'w', encording = 'utf-8') as f :
  f.write('네이버 검색어 순위 \n')
  for i, tag in enumerate(tags) :
    f.write(f"{i+1}, {tag.text} \n")
~~~



