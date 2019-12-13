from flask import Flask
from flask import request
from flask import render_template
from decouple import config
import requests

app = Flask(__name__)

token = config('TELEGRAM_BOT_TOKEN')
app_url = f'https://api.telegram.org/bot{token}'
chat_id = config('CHAT_ID')


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
    return '', 200


if __name__ == '__main__':
    app.run(debug=True)

