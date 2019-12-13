from flask import Flask
from flask import request
from flask import render_template
from decouple import config
import requests
import random

app = Flask(__name__)

token = config('TELEGRAM_BOT_TOKEN')
app_url = f'https://api.telegram.org/bot{token}'

naver_client_id = config('NAVER_CLIENT_ID')
naver_client_secret = config('NAVER_CLIENT_SECRET')


""" @app.route('/write')
def hello():
    return render_template('write.html')

@app.route('/send')
def send():
    message = request.args.get('message')
    message_url = f"{app_url}/sendMessage?chat_id={chat_id}&text={message}"
    requests.get(message_url)
    return '메세지 전송 완료했어요!' """

@app.route(f'/{token}', methods=["post"])
def telegram():
    # 1. request print 해보기
    from_telegram = request.get_json()

    chat_id = from_telegram.get('message').get('from').get('id')
    text = from_telegram.get('message').get('text')
    # requests.get(f"{app_url}/sendMessage?chat_id={chat_id}&text={text}")
    
    # 명령어 확인 만들기
    if text == '/명령어' :
        order_list = '/로또 /번역'
        reply = order_list
        requests.get(f"{app_url}/sendMessage?chat_id={chat_id}&text={reply}")
    # 만약에 사용자가 /로또라고 입력을 하면 로또번호 6자리 뽑아서 보내주기
    elif text == '/로또' :
        numbers = list(range(1, 46))
        picked_num = random.sample(numbers, 6)
        picked_num.sort()
        picked_num = ' '.join(map(str,picked_num))
        reply = f"당신의 행운의 번호는 {picked_num}입니다."
        requests.get(f"{app_url}/sendMessage?chat_id={chat_id}&text={reply}")
    elif text[0:4] == "/번역 " :  # /번역 번역할 문장
        headers = {
            'X-Naver-Client-Id': naver_client_id,
            'X-Naver-Client-Secret': naver_client_secret
        }
        data = {
            'source': 'en',
            'target': 'ko',
            'text': text[4:]
        }
        papago_url = 'https://openapi.naver.com/v1/papago/n2mt'
        papago_res = requests.post(papago_url, data = data, headers = headers)
        papago_res = papago_res.json()
        reply = papago_res.get("message").get("result").get("translatedText")
        requests.get(f"{app_url}/sendMessage?chat_id={chat_id}&text={reply}")
    else : 
        requests.get(f"{app_url}/sendMessage?chat_id={chat_id}&text=아직 이해할 수 없어요. 곧 배워 올게요!!")

    return '', 200


if __name__ == '__main__':
    app.run(debug=True)

