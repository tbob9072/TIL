#!/usr/bin/env python3
import cgi
from botengine import make_reply
# 입력 양식의 글자 추출하기 --- (※1)
form = cgi.FieldStorage()
# 메인 처리 --- (※2)
def main():
    m = form.getvalue("m", default="")
    if   m == "" : show_form()
    elif m == "say" : api_say()
# 사용자의 입력에 응답하기 --- (※3)
def api_say():
    print("Content-Type: text/plain; charset=utf-8")
    print("")
    txt = form.getvalue("txt", default="")
    if txt == "": return
    res = make_reply(txt)
    print(res)
# 입력 양식 출력하기 --- (※4)
def show_form():
    print("Content-Type: text/html; charset=utf-8")
    print("")
    print("""
    <html>
    <meta charset="utf-8">
    <body>
    	<title>Page Title</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Yeon+Sung&display=swap" rel="stylesheet">
    <style>
        .np  { font-family: 'Yeon Sung', cursive;}
        h1   { background-color:lightgreen; }
        div  { padding:10px; }
        span { border-radius: 12px; background-color: lightgray; padding:4px; }
        .bot { text-align: left; font-family: 'Yeon Sung', cursive; font-size: 30px}
        .usr { text-align: right; font-family: 'Yeon Sung', cursive; font-size: 15px}
        .usr1 { text-align: right; font-family: 'Yeon Sung', cursive; font-size: 30px}
    </style>
    <div>
        <h1 class="np"> &nbsp&nbsp나의 귀여운 챗봇~</h1>
        <div id="chat"></div>
        <div class='usr'><input id="txt" size="40">
        <button onclick="say()">전송</button></div>
        <script>
        var url = "./chatbot.py";
        function say() {
        var txt = $('#txt').val();
        $.get(url, {"m":"say","txt":txt},
            function(res) {
            var html = "<div class='usr1'><span>" + esc(txt) +
                "</span>: 나</div><div class='bot'> 봇:<span>" + 
                esc(res) + "</span></div>";
            $('#chat').html($('#chat').html()+html);
            $('#txt').val('').focus();
            });
        }
        function esc(s) {
            return s.replace('&', '&amp;').replace('<','&lt;')
                    .replace('>', '&gt;');
        }  
        </script>
    </div>
    </body>
    </html>
    """)
main()