f = open('mulcam.txt', 'w')
 open(파일명, 쓰기모드 w, 읽기모드 r)

for i in range(10) :
    f.write(f"This is line {i}. \n")

f.close()


# 같은 동작인데 다르게 작동
 with 는 열고 닫고를 자동으로 해줌
 with open('mulcam2.txt', 'w') as f:
    for i in range(10) :
        f.write(f"This is line {i}. \n")

# 파일을 읽어보자

with open('mulcam.txt', 'r') as f :
    lines = f.readlines()
    for line in lines :
       print(line.strip())

