import requests

response = requests.get("https://www.naver.com").text
# get은 html파일로 가져와라 라는 명령어임

print(response)
# 응답이 온것을 확인해보자.

# 실행 해보기 -> bash창으로 가기
# $ python req_and_res.py 입력해보기



