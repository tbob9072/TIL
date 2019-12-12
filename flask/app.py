from flask import Flask    # Flask 모듈을 불러옴
import random
from flask import render_template
from flask import request
import requests
app = Flask(__name__)      # app이라는 변수에 담음

@app.route('/')            # @는 데코레이터임, 내용은 /(루트경로)로 접근하는 길을 만들어줌
def hello_world():         # 접근하면 지금 이 함수를 실행해 주라는 의미
    return 'Hello, World!'

@app.route('/mulcam')
def mulcam():
    return 'This is mulcam'

@app.route('/greeting/<string:name>') # 다이나믹 라우팅 -> string타입이고 변수명은 name임
def greeting(name) :
    return f'Hello, {name}!'

@app.route('/cube/<int:num>')
def cube(num):
    result = num**3
    return str(result)

@app.route('/lunch/<int:people>')
def lunch(people):
    menu = ['빵', '피자', '햄버거']
    order = random.sample(menu, people)
    return str(order)

@app.route('/html')
def html() :
    return '<h1>안녕하세요!!!</h1>'

@app.route('/html_file')
def html_file():
    return render_template('html_file.html')

@app.route('/hi/<string:name>')
def hi(name):
    return render_template('hi.html', your_name = name)

@app.route('/naver')
def naver() :
    return render_template('naver.html')

@app.route('/ping')
def ping():
    return render_template('ping.html')

@app.route('/pong')
def pong():
    name = request.args.get('name')
    message = request.args.get('message')
    return render_template('pong.html', name = name, message = message)

@app.route('/whoru')
def whoru():
    return render_template('whoru.html')

@app.route('/result')
def result():
    name = request.args.get('name')
    ele = ['외모', '재력', '성격', '인기', '간지', '춤실력', '노래실력', '운동']
    yele1 = random.sample(ele, 1)
    
    while True :
        yele2 = random.sample(ele, 1)
        if yele2 != yele1 :
            break
    
    while True :
        yele3 = random.sample(ele, 1)
        if yele3 != yele1 and yele3 != yele2 :
            break
    yele1 = ' '.join(map(str,yele1))
    yele2 = ' '.join(map(str,yele2))
    yele3 = ' '.join(map(str,yele3))

    quan = ['듬뿍', '가득', '폭발', '폭풍', '없음', '조금']
    yquan1 = random.sample(quan, 1)
    yquan2 = random.sample(quan, 1)
    yquan3 = random.sample(quan, 1)
    yquan1 = ' '.join(map(str,yquan1))
    yquan2 = ' '.join(map(str,yquan2))
    yquan3 = ' '.join(map(str,yquan3))

    return render_template('result.html', name = name, yele1 = yele1, yele2 = yele2, yele3 = yele3, yquan1 = yquan1, yquan2 = yquan2, yquan3 = yquan3)


@app.route('/ascii')
def ascii() :
    return render_template('ascii.html')


@app.route('/ascii_result')
def ascii_result():

    # 1. form 태그로 날린 데이터(word)를 받는다.
    word = request.args.get('word')
    # 2. word를 가지고 ascii_art API 요청 주소로 요청을 보낸다.
    result = requests.get(f'http://artii.herokuapp.com/make?text={word}').text
    # 3. API 응답 결과를 html 파일에 담아서 보여준다.
    return render_template('ascii_result.html', result = result)

@app.route('/lotto_check')
def lotto_check():
    return render_template('lotto_check.html')

@app.route('/lotto_result')
def lotto_result():
    lotto_round = request.args.get('lotto_round')
   
    response = requests.get(f'https://dhlottery.co.kr/common.do?method=getLottoNumber&drwNo={lotto_round}')
    lotto = response.json() # json형태로 온 파일을 그냥 사용하면 str으로 됨. 그래서 json을 사용하여 딕셔너리 형태로 가져옴

    winner = []
    # 1. for문을 활용한다.
    for i in range(1, 7):
        winner.append(lotto[f'drwtNo{i}'])

    # 2. List Comprehension
    # winner = [lotto[f'drwtNo{i}'] for i in range(1, 7)]

    # drwtNo6 = lotto["drwtNo6"] # 방법 1 : 키값이 없을 때 error가 남
    # drwtNo6 = lotto.get("drwtNo6") # 방법 2 : 키값이 없을 때 none으로 출력됨 

    numbers = request.args.get('numbers') #string
    numbers = numbers.split() # list (string형태로) - ['1', '2', '3', '4', '5', '6']
    numbers_int = []

    for number in numbers :
        numbers_int.append(int(number))

    matched = len(set(winner) & set(numbers_int))    # 교집합을 찾아 몇개가 일치하는지 matched에 저장한다.
    if matched == 6 :
        result = '1등입니다!!!'
    elif matched == 5 :
        if lotto["bnusNo"] in numbers_int :
            result = '2등입니다!!'
        else :
            result = '3등입니다!'
    elif matched == 4 :
        result = '4등입니다.'
    elif matched == 3 :
        result = '5등입니다.'
    else :
        result = '꽝입니다.'
    

    return render_template('lotto_result.html', 
        lotto_round=lotto_round, winner=winner, result = result, numbers = numbers_int
    )




if __name__ == '__main__':   #파일이 직접 실행됐을 때만 작동하는 코드임
    app.run(debug = True)