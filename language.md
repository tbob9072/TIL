# 언어판별

## 1. 무엇을 어떻게 학습시킬 것인가?

> - 데이터가 주어졌더라도 무엇을 어떻게 학습시키는 것을 결정하는 것이 중요하다.
> - 알파벳을 사용하는 4개의 다른 언어마다 알파벳의 사용빈도가 다르기 때문에 사용빈도로 판단을 하면 된다.
> - 그렇기 때문에 주어진 데이터들을 각각의 알파벳을 열로 갖는 2차원 메트릭스로 만들어서 학습데이터를 만들면 된다.

```python
from sklearn import svm, metrics
import glob, os.path, re, json

def check_freq(fname) :
    
    # 파일을 읽어
    # 음절계산
    with open(fname, "r", encoding = "utf-8") as f :
        text = f.read()
    text = text.lower()    
    
    # 0 ~ 26까지 모두 0으로 세팅한 배열을 만듬
    cnt = [0 for n in range(0, 26)]
    
    # 문자를 아스키 코드로 바꾼 이유 : 알파벳을 아스키코드로 바꿔서 a값을 빼주면 위에 만든 배열의 인덱스값이 나옴
    code_a = ord("a") # 'a' = 97 (아스키 코드)
    code_z = ord("z") # 'z' = 122 (아스키 코드)
    
    for ch in text :
        n = ord(ch) # n - 97
        if code_a <= n <= code_z :
            cnt[n - code_a] += 1
    
    # 정규화
    total = sum(cnt)
    freq = list(map(lambda n : n / total, cnt))
    
    # 파일명 뽑아내기 (y값 추출하기 언어타입 찾는 것임)
    name = os.path.basename(fname)
    lang = re.match(r'^[a-z]{2,}', name).group()
    return freq, lang
    

def load_files(path) :
    freqs = []
    labels = []
    file_list = glob.glob(path)
    for fname in file_list :
        r = check_freq(fname)
        freqs.append(r[0])   # [0.223,3343]
        labels.append(r[1])  # 'en'
    return {"freqs" : freqs, "labels" : labels}

data = load_files('./lang/train/*.txt')
test = load_files('./lang/test/*.txt')

with open("./lang/freq.json", "w", encoding = "utf-8") as fp :
    json.dump([data, test], fp)
```

