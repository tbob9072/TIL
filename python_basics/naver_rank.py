import requests
from bs4 import BeautifulSoup

response = requests.get("https://www.naver.com/").text
soup = BeautifulSoup(response, 'html.parser')

# select_one 매서드는 한개만
# select 매서드는 여러개
# 내 방법
""" for i in range(1, 21) :
    contents = soup.select(f"#PM_ID_ct > div.header > div.section_navbar > div.area_hotkeyword.PM_CL_realtimeKeyword_base > div.ah_roll.PM_CL_realtimeKeyword_rolling_base > div > ul > li:nth-child({i}) > a > span.ah_k")
    con = contents[0].text
    print(f"{i}순위 : {con}") """

# 선생님 방법
# css선택자 젤 뒤에 하위 클래스 집합을 적어주면됨 .ah_k처럼 그럼 자식들 중에 그 클래스명을 가진 친구들을 뽑아서 리스트에 담아줌
tags = soup.select("#PM_ID_ct > div.header > div.section_navbar > div.area_hotkeyword.PM_CL_realtimeKeyword_base > div.ah_roll.PM_CL_realtimeKeyword_rolling_base > div > ul .ah_k") 
with open('naver.txt', 'w', encoding="utf-8") as f :
    f.write('네이버 검색어 순위 \n')
    for i, tag in enumerate(tags) : # enumerate는 값과 인덱스를 같이 뱉어주는 친구임
        f.write(f"{i+1}, {tag.text} \n")




