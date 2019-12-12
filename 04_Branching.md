# Branching

## 1. Branch란?

> - 개발의 편의를 위하여 원본파일을 건들지 않고 복사하여 진행하는 일종의 평행 개발공간이다.

![](http://woowabros.github.io/img/2017-10-30/git-flow_overall_graph.png)

그림 출처 : [우아한 형제들 기술블로그](http://woowabros.github.io/experience/2017/10/30/baemin-mobile-git-branch-strategy.html)

## 2. Branch 사용 코드

### 2-1. branch 생성 : `git branch 이름`

> - 원하는 이름의 브랜치를 생성한다.

```bash
$ git branch test
```



### 2-2. branch로 이동 : `git checkout 이름`

> - 원하는 브랜치로 이동한다.

```bash
$ git checkout test
```

- 추가 : `git check`의 기능은 단순히 브랜치에서만 쓰이는 것이아니라 특정시기로 이동하는 것이기 때문에 commit 시점을 확인하는데 쓰이기도 한다.



### 2-3. branch 삭제 : `git branch -d (or -D) 이름`

> - 브랜치를 삭제한다. 대문자의 경우 묻지도 따지지도 않고 삭제해준다.

```bash
$ git branch -d 이름
```



### 2-4. branch 합치기 : `git merge 이름`

> - 마스터 브랜치로 돌아와 `git merge`를 사용하여 합칠 브랜치를 선택적으로 merge할 수 있다.
> - merge 후 기존 branch는 삭제한다.

```bash
$ git merge test
```



### 2-5. branch 이력 확인하기 : `git log --oneline --graph`

> - 브랜치의 이력을 확인하기 위해선 `git log`를 사용하는 하지만 시각적으로 확인하기 위하여 `--graph`를 사용한다.

```bash
$ git log --oneline --graph
*   743ba4d (HEAD -> master, origin/master) Resolve conflict
|\
| * 4a9f4a2 Create junk.txt
* | 8105d22 Add junk.txt
|/
*   d0b5799 Merge branch 'master' of https://github.com/tbob9072/git
|\
| * e66f710 Create garbage.txt
* | e254684 Add dump.txt
|/
* eec0201 Create trash.txt
* 3c6be7d add chatbot.py
* 177a9be Add README.md
* 7a20d89 Add hello.py
```



### 2.6 추가 정보

> - merge의 종류는 3가지가 있다.
>   - Fast forward merge : 브랜치가 단순하게 마스터 보다 앞서 있어서 간단하게 합치는 것
>   - Auto merge : 마스터와 브랜치의 파일이 달라도 서로 다르다면 그냥 둘다 합쳐주는 것
>   - merge conflict : 같은 파일의 내용이 다른 경우 주로 발생하고 개발자가 직접 어느 버젼을 따를지 정해야함





