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

    if from_telegram.get('message') is not None:
        chat_id = from_telegram.get('message').get('from').get('id')
        text = from_telegram.get('message').get('text')
        # requests.get(f"{app_url}/sendMessage?chat_id={chat_id}&text={text}")
        
        # 명령어 확인 만들기
        if from_telegram.get('message').get('photo') is not None:
            # 클로바 코드 요기에 작성!
            # 1. 우선 파일의 id값을 가져온다.
            file_id = from_telegram.get('message').get('photo')[-1].get('file_id')
            

            # 2. 가져온 파일 아이디로 실제 파일을 가져온다.
            file_res = requests.get(f'{app_url}/getFile?file_id={file_id}')
            # 3. file path를 뽑아내서 저장
            file_path = file_res.json().get('result').get('file_path')
            # 4. 최종적으로 해당파일의 경로를 찾아서 저장
            file_url = f'https://api.telegram.org/file/bot{token}/{file_path}'
            # 5. 유저가 넣은 사진이 있는 주소로 요청을 보내서 가져오자!
            real_file_res = requests.get(file_url, stream=True)

            headers = {
                "X-Naver-Client-Id": naver_client_id,
                "X-Naver-Client-Secret": naver_client_secret
            }
            
            clova_res = requests.post(
                'https://openapi.naver.com/v1/vision/celebrity',
                headers=headers,
                files= {
                    'image': real_file_res.raw.read()
                }
            )
            
            # 닮은 유명인의 수가 있을 경우!
            if clova_res.json().get('info').get('faceCount'):
                celebrity = clova_res.json().get('faces')[0].get('celebrity')
                reply = f"{celebrity.get('value')} - {celebrity.get('confidence')*100}%"
            else :
                reply = '인식된 사람이 없습니다.'
        else :
            # text가 왔을 때 실행
            if text == '/명령어' :
                order_list = '/로또 /번역 *사진파일 전송*'
                reply = order_list
                
            # 만약에 사용자가 /로또라고 입력을 하면 로또번호 6자리 뽑아서 보내주기
            elif text == '/로또' :
                numbers = list(range(1, 46))
                picked_num = random.sample(numbers, 6)
                picked_num.sort()
                picked_num = ' '.join(map(str,picked_num))
                reply = f"당신의 행운의 번호는 {picked_num}입니다."
                
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

            else : 
                reply = "아직 이해할 수 없어요. 곧 배워 올게요!! \n사용 가능한 명령어는 '/명령어'를 통해 확인하세요."
        
        requests.get(f"{app_url}/sendMessage?chat_id={chat_id}&text={reply}")

    

    return '', 200


if __name__ == '__main__':
    app.run(debug=True)

