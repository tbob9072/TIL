# 내방식

""" with open('mulcam.txt', 'r') as f :
    lines = f.readlines()
    mid = []
    for line in lines :
        mid.append(int(line.strip()))

mid.sort(reverse=True)

with open('mulcam.txt', 'w') as f :
    for i in mid :
        f.write(f"{i} \n") """

# 불러오기
with open('mulcam.txt', 'r') as f :
    lines = f.readlines()

# 뒤집기
lines.reverse()

# line 저장하기
with open('mulcam.txt', 'w') as f :
    f.writelines(lines)

