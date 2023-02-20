---
marp: true
paginate: true
size: 4:3
---

# SQL (Structured Query Language)

SQL은 관계형 데이터베이스(RDBMS)에서 스키마, 데이터를 다루기위한 특수목적의 언어이다. 크게 스키마를 정의하는 DDL과 데이터를 조작하는 DML로 구분한다.

에스큐엘 또는 시퀄이라고 발음한다. 실습에 필요한 데이터베이스를 설치하는 방법은 다음 영상을 참고한다.

[MariaDB를 도커로 세팅하기](https://youtu.be/2e28-TxKJM0)

---

# 실습용 데이터

**학생 정보**

| 학생아이디 | 이름          | 나이 |
| ---------- | ------------- | ---- |
| 1          | John Doe      | 22   |
| 2          | Jane Doe      | 24   |
| 3          | Jim Smith     | 21   |
| 4          | Sarah Johnson | 23   |
| 5          | Mike Brown    | 20   |

---

**성적 정보**

| 학생아이디 | 과목       | 점수 |
| ---------- | ---------- | ---- |
| 1          | economics  | 80   |
| 1          | math       | 90   |
| 1          | education  | 95   |
| 2          | physics    | 85   |
| 2          | math       | 90   |
| 3          | statistics | 75   |
| 3          | math       | 80   |
| 4          | math       | 90   |
| 4          | education  | 95   |
| 5          | math       | 85   |

---

# DDL

DDL(Data Definition Language)는 데이터베이스 스키마를 정의하는데 사용되는 명령어를 말한다. 여기서는 백엔드 개발자가 자주 사용하는 TABLE의 생성, 수정, 삭제에 대해 알아본다.

---

## 1. CREATE

예제를 먼저 보자:

```sql
CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT NOT NULL
);
```

위 예제는 crate table 명령어를 사용하여 "student" 테이블을 정의하고 있다. 테이블 내의 컬럼럼 괄호 사이에 쉼표로 구분된다. 컬럼은 '컬럼명 | 자료형 | 제약조건' 순으로 적어준다.

- PRIMARY KEY: 중복되지 않는 값만 넣을 수 있다. 테이블 내에 데이터를 조회할 때 기준이 되는 컬럼이다.

---

## 2. 자료형

테이블의 컬럼 생성시 필요한 데이터형에는 문자형, 숫자형, 날짜형으로 구분된다.

---

### 2.1. 문자

데이터베이스에서 문자는 주로 CHAR, VARCHAR 로 표현한다.

```sql
CHAR(n)
VARCHAR(n)
```

CHAR는 문자길이를 고정할 때 사용한다. 괄호안에 최대 문자길이를 숫자로 적어주면 된다. CHAR(1) 과 같이 적어주면 한 개 문자만 넣을 수 있음을 의미한다. 예를 들어, 성별을 의미하는 'M', 'F' 와 같이 한글자로 표현할 때 이와 같이 사용할 수 있다.

문자의 길이가 가변적으로 변화한다면 VARCHAR를 사용한다. CHAR는 최대 길이보다 부족한 문자를 입력할 경우 부족한 자리수만큼 공백을 채워 저장하므로 잘못 사용하면 저장소 낭비를 유발할 수 있다.

---

### 2.2. 숫자

데이터베이스별로 숫자를 표현하는 방법은 살짝 다르지만 대부분의 경우:

```sql
NUMERIC(precision, scale)
```

와 같이 표현한다. 예를들어, 12345.12 와 같이 정수 5자리, 소수2자리 숫자를 사용하고자 한다면:

```sql
NUMERIC(5,2)
```

오라클에서는 NUMBER를 사용한다.

```sql
NUMBER(precision, scale)
NUMBER(5,2)
```

---

### 2.3. 날짜

날짜, 시간을 표현할 때 사용하는 자료형이다.

```sql
DATE
TIMESTAMP
```

날짜형은 생일, 기념일 등과 같은 자료형에 사용이 되며, 데이터 생성일, 수정일을 저장하는 컬럼에도 많이 사용된다. DATE 는 날짜와 시간을 저장할 때 사용하지만 TIMESTAMP는 밀리세컨드(ms)까지 저장하므로 로그(log)와 같이 정밀한 시간을 요구하는 경우 사용한다.

---

## 3. FOREIGN KEY

---

### 3.1. FOREIGN KEY

student 테이블과 연결되는 student_grades 테이블을 생성해보면:

```sql
CREATE TABLE student_grades (
    student_id INT NOT NULL,
    subject VARCHAR(20) NOT NULL,
    grade INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);
```

> 'FOREIGN KEY (student_id) REFERENCES student(student_id)'

'student_id' 컬럼에 넣을 수 있는 값은 'student' 테이블의 'student_id' 컬럼에 값이 들어있어야 한다는 의미이다.

---

### 3.2. JOIN 문

foreign key로 연결된 테이블은 join문으로 데이터를 조회하는데 사용된다. (자세한 것은 DML 에서 설명)

```sql
SELECT student.*, student_grades.*
FROM student
JOIN student_grades
ON student.student_id = student_grades.student_id;
```

---

## 4. ALTER

컬럼을 추가하려면 'ALTER'문에 'ADD' 구문을 사용한다.

```sql
ALTER TABLE student
ADD COLUMN date_added DATE NOT NULL DEFAULT CURRENT_DATE;
```

예제는 'students' 테이블에 'date_add'컬럼을 추가해준다. '컬럼명 | 자료형 | 제약조건' 순으로 적어준다.

- NOT NULL: 빈값을 넣을 수 없다
- DEFAULT CURRENT_DATE: 값을 입력하지 않을 경우 기본값으로 CURRENT_DATE를 넣어준다.

---

## 5. DROP 과 TRUNCATE

DROP은 테이블 자체를 삭제할 때 사용하고 TRUNCATE는 테이블에 들어있는 데이터만 전체를 삭제할 때 사용한다.

```sql
DROP TABLE student;
DROP TABLE student_grades;
```

DROP을 사용하면 'students' 테이블 자체를 없앤다.

```sql
TRUNCATE TABLE student;
TRUNCATE TABLE student_grades;
```

TRUNCATE를 사용하면 'students' 테이블 구조만 남기고 모든 데이터를 삭제한다.

---

## 6. 툴 소개

🔗 [DBeaver 다운로드](https://dbeaver.io/download/)
🔗 [VSCode 확장: Database client](https://marketplace.visualstudio.com/items?itemName=cweijan.vscode-database-client2)


<style>
    table { font-size: 0.7em; }
</style>