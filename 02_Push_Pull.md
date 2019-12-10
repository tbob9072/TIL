# Push & Pull

## 1. Push & Pull?

> - Push란 PC의 작업물을 github로 업로드하는 행위
> - Pull이란 github에 저장되어있는 작업물을 PC로 다운로드 하는 행위



## 2. 기본 세팅

### (1) 원격 저장소에서 작업 디렉토리 복제 : `git clone`

- 기존에 github에 올려놓은 디렉토리를 새로운 PC로 복제한다. **(최초 1회)**

- `git clone`을 작성하고 뒤에 복제할 디렉토리의 주소를 입력한다.

  ```bash
  $ git clone https://github.com/tbob9072/TIL.git
  ```



## 3.  코드 불러오기

### (1) 작업 전 준비상태 확인하기 : `git status`

- 코드를 불러오기 전 working tree가 비었는지 항상 확인해야한다.

  ```bash
  $ git status
  On branch master
  Your branch is up to date with 'origin/master'.
  
  nothing to commit, working tree clean
  ```



### (2) 원격 저장소에서 코드 불러오기 : `git pull`

- `pull`을 활용하여 원격저장소에서 코드를 불러온다.

- `pull`은 원격 저장소와 현재 작업 PC의 차이점을 없애준다.

  ```bash
  $ git pull origin master
  ```

  

### (3) 작업이 잘되었는지 확인하기 : `git log`

- 코드가 잘 불러와졌는지 확인하기 위해 `log`를 사용한다.

  ```bash
  $ git log
  commit 239d0492c762d090ecb388feb3cfbb1e1e69f541 (HEAD -> master, origin/master, origin/HEAD)
  Author: tbob <tbob9072@gmail.com>
  Date:   Tue Dec 10 10:51:10 2019 +0900
  
      Modify quiz.txt
  
  commit abe42380dc39c47b1a1892bb86913eb7f1c45b84
  Author: tbob <tbob9072@gmail.com>
  Date:   Tue Dec 10 10:45:04 2019 +0900
  
      Add quiz.txt
  
  commit 349b5e840b3b4d582b242caa1225cff487c56e42
  Author: tbob <tbob9072@gmail.com>
  Date:   Tue Dec 10 10:41:14 2019 +0900
  
      Add new.md
  
  commit 0086c03bd60a97ab43fbc4257e6c49d354f09f64
  Author: tbob <tbob9072@gmail.com>
  Date:   Tue Dec 10 10:18:52 2019 +0900
  
      Add homework.txt
  
  commit 231bcb6fe32d1bed4471301fdbcce0383199aab7
  Author: tbob <tbob9072@gmail.com>
  Date:   Tue Dec 10 09:31:28 2019 +0900
  
      add TIL file
  
  commit 5a0e5ca9b70b949c9992d20fcfb9992d67d2cb1e
  Author: tbob <tbob9072@gmail.com>
  Date:   Mon Dec 9 17:33:14 2019 +0900
  
      first commit
  
  ```

- 코드가 너무 길다면 `--oneline`을 사용한다.

  ```bash
  $ git log --oneline
  239d049 (HEAD -> master, origin/master, origin/HEAD) Modify quiz.txt
  abe4238 Add quiz.txt
  349b5e8 Add new.md
  0086c03 Add homework.txt
  231bcb6 add TIL file
  5a0e5ca first commit
  ```

- -1을 사용해서 마지막 로그만 확인가능하다.

  ```bash
  $ git log -1
  commit 239d0492c762d090ecb388feb3cfbb1e1e69f541 (HEAD -> master, origin/master, origin/HEAD)
  Author: tbob <tbob9072@gmail.com>
  Date:   Tue Dec 10 10:51:10 2019 +0900
  
      Modify quiz.txt
  ```



## 4. 작업이 완료된 후 재 업로드

### (1) `01_Github_TIL.md`파일 : `git push`

- Github 원격 저장소에 push한다.

  ```bash
  $ git push origin master
  ```



## 5. 그 외 명령어

- 코드를 수정 한 후 어떤 수정사항이 있는지 확인 : `git diff`

  ```bash
  $ git diff
  diff --git a/quiz.txt b/quiz.txt
  index e69de29..78ebf18 100644
  --- a/quiz.txt
  +++ b/quiz.txt
  @@ -0,0 +1,3 @@
  +1. O
  +2. X
  +3. X
  \ No newline at end of file
  ```

- 코드내용 확인 : `cat`

  ```bash
  $ cat quiz.txt
  1. O
  2. X
  3. X
  ```

  

