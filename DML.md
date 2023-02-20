---
marp: true
paginate: true
size: 4:3
---
# DML

DML(Data Manipulation Language)은 데이터를 추가,수정,삭제,조작하는 것을 말한다. 대부분의 RDBMS(RELATIONAL DATABASE MANAGEMENT SYSTEM)에서 사용된다.

- SELECT: 조회
- INSERT: 추가 
- UPDATE: 수정 
- DELETE: 삭제  
- MERGE: 머지 
- CALL: stored procedures 를 실행할 때 사용한다.  

추가(create), 조회(read), 수정(update), 삭제(delete)를 줄여서 CRUD 라고도 한다. 

---

> __[참고] CQRS(Command Query Responsibility Segregation)아키텍처 패턴__
> 
> CQRS에서는  CRUD를 'CUD'와 'R'을 Command와 Query로 구분하는 패턴이다. 이 문서는 백엔드 개발자를 위한 문서이므로 DML을 __Command__(insert, update, delete)와 __Query__(select)로 구분하여 설명한다. 
>
>CQRS 아키텍처에서는 __데이터 쓰기에 대한 책임과 데이터 읽기에 대한 책임이 분리__ 되어 업데이트는 명령을 실행하여 수행되고 데이터는 쿼리를 실행하여 검색된다. 

---

> __[참고] 트랜젝션__ 
> 
> 기본적으로 추가,수정,삭제 가 발생시 자동으로 데이터베이스에 저장되지 않으므로 'COMMIT' 문을 실행해야하며, 변경을 취소할 경우 'ROLLBACK' 문을 사용해야한다. 이러한 행위를 transaction 이라고 한다. (대다수의 DB 툴은 오토커밋 기능이 있다) 

---

## 1. Command: insert, update, delete

---

### 1.1. INSERT
```sql
INSERT INTO student (student_id, name, age)
VALUES (1, 'John Doe', 22);
```
---
### 1.2. UPDATE
```sql
UPDATE student
SET age = 23
WHERE student_id = 1;
```
---
### 1.3. DELETE
```sql
DELETE FROM student
WHERE student_id = 1;
```

❗delete시 where 조건을 깜빡하고 넣어주지 않으면 전체 데이터가 삭제되니 주의하자 

---

## 2. Query: select

select는 데이터를 조회 할 때 사용한다. 

---

### 2.1. SELECT [컬럼들...] FROM [테이블명]
```sql
SELECT *
FROM student
WHERE name = 'Matthew';
```
"*" 표시는 모든 컬럼 정보를 가져오라는 표시이다. 컬럼명을 명시하면 명시한 컬럼의 데이터만 불러온다. 'WHERE' 는 조회할 데이터의 조건을 적어주는 부분이다. 

---
### 2.2. WHERE: LIKE
```sql
SELECT *
FROM student
WHERE name LIKE '%Matthew%';
```
'=' 기호를 사용하면 전체가 일치하는 것을 찾지만, 'LIKE' 를 사용하면 일부분만 포함되어도 검색해준다. '%' 기호 넣어주는것 잊지말것.

---

### 2.3. WHERE: BETWEEN
```sql
SELECT *
FROM student
WHERE age BETWEEN 20 AND 25;
```
특정 구간을 검색할 때 BETWEEN을 사용한다. 

---

### 2.4. WHERE: AND / OR
```sql
SELECT *
FROM student
WHERE name = 'Matthew' AND age BETWEEN 20 AND 29;
```

---

### 2.5. ORDER BY
```sql
SELECT *
FROM student
WHERE name LIKE '%m%'
ORDER BY age DESC;
```
기본적으로 오름차순 정렬이며, 내림차순일 경우 DESC 를 사용한다. 

---

### 2.6. DBMS별 현재시간을 표시하는 방법
__MySQL:__
```sql
SELECT NOW();
```
__PostgreSQL:__
```sql
SELECT current_timestamp;
```
__Microsoft SQL Server:__
```sql
SELECT GETDATE();
```
__SQLite:__
```sql
SELECT strftime('%Y-%m-%d %H:%M:%S', 'now');
```

---

__Oracle__
```sql
SELECT SYSDATE FROM DUAL;
```
오라클에는 다른 DBMS에는 없는 'DUAL'이라는 테이블이 있다. DUAL 은 한 개의 빈 행을 가지는 가상의 테이블이라고 생각해도 좋다. 

---

### 2.7. UNION / UNION ALL

```sql
SELECT column1, column2, ...
FROM table1
UNION
SELECT column1, column2, ...
FROM table2;
```

UNION은 두 개의 조회쿼리 결과셋을 중복을 제거한 후 하나로 합쳐준다. 중복된 데이터를 유지하려면 UNION ALL을 사용하면 된다. UNION을 사용할 때 컬럼의 데이터타입과 갯수가 같아야 한다.

---

### 2.8. CASE

```sql
SELECT column1,
       column2,
       ...,
       CASE
         WHEN condition1 THEN result1
         WHEN condition2 THEN result2
         ...
         ELSE result_default
       END AS alias
FROM table_name;
```

CASE는 SQL문 내에서 사용하는 조건문이라 생각하면 된다. 문법이다. 어렵게 생각하지 말자. WHERE절에서도 사용할 수 있으나, 가능하면 사용하지 말자.

---
```sql
SELECT name,
       age,
       CASE
         WHEN age < 20 THEN 'Teenager'
         WHEN age BETWEEN 20 AND 29 THEN 'Young adult'
         WHEN age >= 30 THEN 'Adult'
       END AS age_group
FROM student;
```
나이에 따라 구분을 하는데 사용되었다. 

---

### 2.9. MERGE
MERGE문은 둘 이상의 테이블의 데이터를 단일 테이블로 결합하는 동시에 필요에 따라 데이터를 업데이트하거나 추가하는데 사용된다. 

아래 예제는 'join_condition'을 만족하는 데이터를 source_table에서 읽어서 taget_table에 업데이트를 해주거나, 조건에 맞는 데이터가 없는 경우 데이터를 target_table에 source_table 데이터를 추가해주는 merge문이다. 

```sql
MERGE INTO target_table
USING source_table
ON (join_condition)
WHEN MATCHED THEN
  UPDATE SET target_column1 = source_column1, target_column2 = source_column2, ...
WHEN NOT MATCHED THEN
  INSERT (target_column1, target_column2, ...)
  VALUES (source_column1, source_column2, ...);
```

---
__Merge문의 단점__
MERGE 문은 여러 테이블의 데이터를 결합하는 강력한 도구이지만 몇 가지 단점도 있을 수 있다.
- 성능: MERGE 문은 특히 큰 테이블에서 사용될 때 느리고 리소스를 많이 사용할 수 있다. __데이터 비교, 데이터 삽입 및 데이터 업데이트와 같은 여러 작업이 포함되며 모두 성능 저하가 있을 수 있다.__
- 동시성:  __작업이 중간에 중단되면 데이터 무결성 문제가 발생할 수 있으며 복구하기 어려울 수 있다.__
- 호환성: __MERGE 문은 모든 데이터베이스 시스템에서 지원되지 않으며__ 이를 지원하는 시스템 간에도 구문 및 동작에 차이가 있을 수 있다. 이로 인해 여러 데이터베이스 시스템에서 작동하는 이식 가능한 코드를 작성하기 어려울 수 있다.

---

### 2.10. 프로시저
프로시저를 지원하는 주요 데이터베이스는 다음과 같다. 
1. Oracle
2. Microsoft SQL Server
3. MySQL
4. PostgreSQL
5. IBM Db2
6. Sybase
7. Informix

---

__RDBMS마다 프로시저를 만들고 실행하는 구문이 다를 수 있으므로 자세한 내용은 특정 데이터베이스 시스템 메뉴얼을 참고하라.__  또한 일부 데이터베이스 시스템은 프로시저 지원 수준이 다를 수 있으므로 프로시저를 지원하는 데이터베이스 시스템을 선택할 때 특정 요구 사항과 요구 사항을 고려하는 것도 중요하다. 

> __[참고] MySQL과 MariaDB 간 호환성__
> 일반적으로 대략 95~98% 정도의 호환성을 가지는 것으로 추정된다. 

---

### 2.11. GROUP BY와 그룹함수
집계 함수라고도 하는 그룹 함수는 테이블의 데이터를 요약하는 데 사용되는 SQL의 함수 유형이다. 그룹 함수는 데이터의 여러 행에 대해 계산을 수행하고 단일 결과를 반환하는 데 사용된다. 주요그룹함수는 다음과 같다:
1. COUNT: 특정 조건을 충족하는 테이블의 행 수를 반환합니다.
2. SUM: 테이블의 특정 열의 합계를 반환합니다.
3. AVG: 테이블의 특정 열의 평균을 반환합니다.
4. MIN: 테이블의 특정 컬럼의 최소값을 반환한다.
5. MAX: 테이블의 특정 열의 최대값을 반환합니다.

---
이러한 함수는 하나 이상의 열을 기반으로 테이블의 행을 그룹화할 수 있는 GROUP BY 절에서 사용할 수 있다. 예를 들어 테이블의 데이터를 연도별로 그룹화하고 각 연도의 총 매출을 계산할 수 있습니다.

```sql
SELECT year, SUM(sales)
FROM sales_data
GROUP BY year;
```

이 쿼리는 sales_data 테이블에서 매년 총 매출을 반환한다.

---
그룹 함수는 일련의 행에서 작동하고 단일 결과를 반환하므로 __그룹 함수를 사용하여 데이터의 개별 행을 검색할 수 없다는 점에 유의해야 한다.__ 그룹 함수의 결과와 함께 데이터의 개별 행을 검색해야 하는 경우 하위 쿼리 또는 JOIN 절을 사용할 수 있다.

### HAVING

HAVING 절은 GROUP BY로 그룹화한 집계 데이터의 결과를 필터링하기 위해 함께 사용된다. 다음은 SQL에서 GROUP BY 및 HAVING 절을 사용하는 방법의 예 이다.

```sql
SELECT student_id, AVG(grade) AS average_grade
FROM student_grades
GROUP BY student_id
HAVING AVG(grade) > 50;
```

---
### 2.12. ORDER BY

```sql
SELECT student_id, AVG(grade) AS average_grade
FROM student_grades
GROUP BY student_id
ORDER BY average_grade DESC;
```
기본적으로 오름차순(ASC)으로 정렬하며, 내리차순시에는 'DESC'를 사용한다. 

---
### 2.13. Subquery
대부분의 RDBMS는 서브쿼리(subquery)를 지원한다. 
```sql
SELECT student_id, 
    (SELECT AVG(grade) FROM student_grades WHERE student_id = s.student_id) AS average_grade
FROM student_grades s
GROUP BY student_id;
```

이 예에서 하위 쿼리 __SELECT AVG(grade) FROM student_grades WHERE student_id = s.student_id__ 는 각 학생의 평균 성적을 계산하고, 외부 쿼리는 student_id와 평균 성적을 검색한다. 

GROUP BY 절은 student_grads 테이블의 행을 student_id별로 그룹화한다.

---

## 3. 실습용 샘플 데이터

```sql
-- Create the student table
CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT NOT NULL
);

-- Insert sample data into the student table
INSERT INTO student (student_id, name, age)
VALUES
    (1, 'John Doe', 22),
    (2, 'Jane Doe', 24),
    (3, 'Jim Smith', 21),
    (4, 'Sarah Johnson', 23),
    (5, 'Mike Brown', 20);
```
---
```sql
-- Create the student_grades table
CREATE TABLE student_grades (
    student_id INT NOT NULL,
    subject VARCHAR(20) NOT NULL,
    grade INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);

-- Insert sample data into the student_grades table
INSERT INTO student_grades (student_id, subject, grade)
VALUES
    (1,'economics', 80),
    (1,'math', 90),
    (1,'education', 95),
    (2,'physics', 85),
    (2,'math', 90),
    (3,'statistics', 75),
    (3,'math', 80),
    (4,'math', 90),
    (4,'education', 95),
    (5,'math', 85);
```

