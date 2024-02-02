# 정규화

## 1NF
- 데이터는 원자형이여야 한다. 

### 1NF 전 
- 학생별 수강과목 현황
  - 수강과목의 데이터들이 목록형태이다.

| 학번       | 이름   | 수강과목                         |
| ---------- | ------ | -------------------------------- |
| 95-1023001 | 서상석 | 경제학원론, 경제수학             |
| 95-1023002 | 김민우 | 경제학원론, 경제수학, 영화의이해 |
| 97-1023003 | 장미영 | 영화의이해, 경영학원론, 회계원론 |
| 96-4107001 | 이미라 | 데이터베이스, 자바               |
| 97-1402001 | 공영상 | 기초전자공학, 디지털논리설계     |

### 1NF 후
- 학생별 수강과목 현황
  - 정규화 후 [학번 + 이름] 이 후보키가 되었다.


| 학번       | 이름   | 수강과목       |
| ---------- | ------ | -------------- |
| 95-1023001 | 서상석 | 경제학원론     |
| 95-1023001 | 서상석 | 경제수학       |
| 95-1023002 | 김민우 | 경제학원론     |
| 95-1023002 | 김민우 | 경제수학       |
| 95-1023002 | 김민우 | 영화의이해     |
| 97-1023003 | 장미영 | 영화의이해     |
| 97-1023003 | 장미영 | 경영학원론     |
| 97-1023003 | 장미영 | 회계원론       |
| 96-4107001 | 이미라 | 데이터베이스   |
| 96-4107001 | 이미라 | 자바           |
| 97-1402001 | 공영상 | 기초전자공학   |
| 97-1402001 | 공영상 | 디지털논리설계 |

## 2NF
- 후보키에 종속적인 컬럼이 없어야 한다.

### 2NF 전
- 학생별 수강과목 중간고사 현황
  - (과목별 담당교수가 1인이라고 가정)
  - 후보키는 [학번 + 수강과목] 이다. 
  - '이름'은 '학번'종속적이다.
  - '담당교수'는 '수강과목'에 종속적이다.

| 학번       | 이름   | 수강과목       | 담당교수 | 성적 |
| ---------- | ------ | -------------- | -------- | ---- |
| 95-1023001 | 서상석 | 경제학원론     | 김인식   | 89   |
| 95-1023001 | 서상석 | 경제수학       | 강인호   | 57   |
| 95-1023002 | 김민우 | 경제학원론     | 김인식   | 56   |
| 95-1023002 | 김민우 | 경제수학       | 강인호   | 76   |
| 95-1023002 | 김민우 | 영화의이해     | 설민영   | 87   |
| 97-1023003 | 장미영 | 영화의이해     | 설민영   | 98   |
| 97-1023003 | 장미영 | 경영학원론     | 하지우   | 34   |
| 97-1023003 | 장미영 | 회계원론       | 나이성   | 56   |
| 96-4107001 | 이미라 | 데이터베이스   | 장필연   | 23   |
| 96-4107001 | 이미라 | 자바           | 조중연   | 45   |
| 97-1402001 | 공영상 | 기초전자공학   | 심기정   | 56   |
| 97-1402001 | 공영상 | 디지털논리설계 | 영상구   | 96   |

### 2NF 후

- 수강과목별 담당교수

| 수강과목       | 담당교수 |
| -------------- | -------- |
| 경제학원론     | 김인식   |
| 경제수학       | 강인호   |
| 영화의이해     | 설민영   |
| 경영학원론     | 하지우   |
| 회계원론       | 나이성   |
| 데이터베이스   | 장필연   |
| 자바           | 조중연   |
| 기초전자공학   | 심기정   |
| 디지털논리설계 | 영상구   |

- 수강생-과목별-중간고사 점수

| 학번       | 수강과목       | 성적 |
| ---------- | -------------- | ---- |
| 95-1023001 | 경제학원론     | 89   |
| 95-1023001 | 경제수학       | 57   |
| 95-1023002 | 경제학원론     | 56   |
| 95-1023002 | 경제수학       | 76   |
| 95-1023002 | 영화의이해     | 87   |
| 97-1023003 | 영화의이해     | 98   |
| 97-1023003 | 경영학원론     | 34   |
| 97-1023003 | 회계원론       | 56   |
| 96-4107001 | 데이터베이스   | 23   |
| 96-4107001 | 자바           | 45   |
| 97-1402001 | 기초전자공학   | 56   |
| 97-1402001 | 디지털논리설계 | 96   |

- 학생현황

| 학번       | 이름   | 전공       |
| ---------- | ------ | ---------- |
| 95-1023001 | 서상석 | 경제학     |
| 95-1023002 | 김민우 | 경제학     |
| 97-1023003 | 장미영 | 연극영화학 |
| 96-4107001 | 이미라 | 컴퓨터공학 |
| 97-1402001 | 공영상 | 전자공학   |

## 3NF

- 후보키가 아닌 컬럼에 종속적이지 않아야 한다.

### 3NF 전
- 학생별 수강과목 중간고사 현황 (2NF 예제에서 '단과대', '학과'컬럼 추가)
  - [학번 + 수강과목]이 후보키이다.
  - '학과'는 '단과대'에 종속적이다..

| 학번       | 이름   | 수강과목       | 담당교수 | 성적 | 단과대     | 학과           |
| ---------- | ------ | -------------- | -------- | ---- | ---------- | -------------- |
| 95-1023001 | 서상석 | 경제학원론     | 김인식   | 89   | 사회과학대 | 경제학과       |
| 95-1023001 | 서상석 | 경제수학       | 강인호   | 57   | 사회과학대 | 경제학과       |
| 95-1023002 | 김민우 | 경제학원론     | 김인식   | 56   | 사회과학대 | 경제학과       |
| 95-1023002 | 김민우 | 경제수학       | 강인호   | 76   | 사회과학대 | 경제학과       |
| 95-1023002 | 김민우 | 영화의이해     | 설민영   | 87   | 사회과학대 | 경제학과       |
| 97-1023003 | 장미영 | 영화의이해     | 설민영   | 98   | 예술대학   | 영화영상학과   |
| 97-1023003 | 장미영 | 경영학원론     | 하지우   | 34   | 예술대학   | 영화영상학과   |
| 97-1023003 | 장미영 | 회계원론       | 나이성   | 56   | 예술대학   | 영화영상학과   |
| 96-4107001 | 이미라 | 데이터베이스   | 장필연   | 23   | 공과대학   | 정보통신공학과 |
| 96-4107001 | 이미라 | 자바           | 조중연   | 45   | 공과대학   | 정보통신공학과 |
| 97-1402001 | 공영상 | 기초전자공학   | 심기정   | 56   | 공과대학   | 전자공학과     |
| 97-1402001 | 공영상 | 디지털논리설계 | 영상구   | 96   | 공과대학   | 전자공학과     |

### 3NF 후

- 아래 2개 테이블은 2NF 결과와 동일
  - 수강과목별 담당교수
  - 수강생-과목별-중간고사 점수

- 학생현황 
  - '학과코드'로 [단과대별 학과] 테이블로 비식별 관계를 가지게 되었다.

| 학번       | 이름   | 학과           | 학과코드 |
| ---------- | ------ | -------------- | -------- |
| 95-1023001 | 서상석 | 경제학과       | S001     |
| 95-1023002 | 김민우 | 경제학과       | S001     |
| 97-1023003 | 장미영 | 영화영상학과   | M001     |
| 96-4107001 | 이미라 | 정보통신공학과 | T001     |
| 97-1402001 | 공영상 | 전자공학과     | T002     |

- 단과대별 학과
  - '학과'가 후보키이긴 하지만 데이터 관리 편의를 위해 '학과코드' 후보키를 신설하였다.
  - 단과대별 학과 정보 컬럼을 이용하는 다른 테이블들은 '학과코드' 로 비식별관계를 맺으면 된다.
  - '코드'는 유추하기 쉬운 조합으로 구성하면 좋다.

| 학과코드 | 학과           | 단과대       |
| -------- | -------------- | ------------ |
| S001     | 경제학과       | 사회과학대학 |
| M001     | 영화영상학과   | 예술대학     |
| T001     | 정보통신공학과 | 공과대학     |
| T002     | 전자공학과     | 공과대학     |


## BCNF

- 후보키가 아닌 컬럼에 이행적이지 않아야 한다. 

### BCNF 전

- 학생별 수강과목 중간고사 현황(교육부 지정 등급 반영)
  - '등급'은 '성적' 종속적이다. 
  - '등급'은 특정 기준에 의해 '성적' 데이터로부터 이행적이다.

| 학번       | 이름   | 수강과목       | 담당교수 | 성적 | 단과대     | 학과           | 등급 |
| ---------- | ------ | -------------- | -------- | ---- | ---------- | -------------- | ---- |
| 95-1023001 | 서상석 | 경제학원론     | 김인식   | 89   | 사회과학대 | 경제학과       | B    |
| 95-1023001 | 서상석 | 경제수학       | 강인호   | 57   | 사회과학대 | 경제학과       | F    |
| 95-1023002 | 김민우 | 경제학원론     | 김인식   | 56   | 사회과학대 | 경제학과       | F    |
| 95-1023002 | 김민우 | 경제수학       | 강인호   | 76   | 사회과학대 | 경제학과       | C    |
| 95-1023002 | 김민우 | 영화의이해     | 설민영   | 87   | 사회과학대 | 경제학과       | B    |
| 97-1023003 | 장미영 | 영화의이해     | 설민영   | 98   | 예술대학   | 영화영상학과   | A    |
| 97-1023003 | 장미영 | 경영학원론     | 하지우   | 34   | 예술대학   | 영화영상학과   | F    |
| 97-1023003 | 장미영 | 회계원론       | 나이성   | 56   | 예술대학   | 영화영상학과   | F    |
| 96-4107001 | 이미라 | 데이터베이스   | 장필연   | 23   | 공과대학   | 정보통신공학과 | F    |
| 96-4107001 | 이미라 | 자바           | 조중연   | 45   | 공과대학   | 정보통신공학과 | F    |
| 97-1402001 | 공영상 | 기초전자공학   | 심기정   | 56   | 공과대학   | 전자공학과     | F    |
| 97-1402001 | 공영상 | 디지털논리설계 | 영상구   | 96   | 공과대학   | 전자공학과     | A    |

### BCNF 후

- 아래 3개 테이블은 3NF와 동일
  - 수강과목별 담당교수
  - 학생현황
  - 단과대별 학과

- 수강생-과목별-중간고사 점수
  - '등급' 데이터에 대한 '성적'으로 부터의 이행 정보를 별도의 기준 테이블로 분리 관리한다.
  - 분리된 '등급기준표' 테이블과 관계를 맺지 않는다.

| 학번       | 수강과목       | 성적 | 등급 |
| ---------- | -------------- | ---- | ---- |
| 95-1023001 | 경제학원론     | 89   | B    |
| 95-1023001 | 경제수학       | 57   | F    |
| 95-1023002 | 경제학원론     | 56   | F    |
| 95-1023002 | 경제수학       | 76   | C    |
| 95-1023002 | 영화의이해     | 87   | B    |
| 97-1023003 | 영화의이해     | 98   | A    |
| 97-1023003 | 경영학원론     | 34   | F    |
| 97-1023003 | 회계원론       | 56   | F    |
| 96-4107001 | 데이터베이스   | 23   | F    |
| 96-4107001 | 자바           | 45   | F    |
| 97-1402001 | 기초전자공학   | 56   | F    |
| 97-1402001 | 디지털논리설계 | 96   | A    |

- 등급 기준표

| 등급 | 이상 | 미만 |
| ---- | ---- | ---- |
| A    | 90   | 101  |
| B    | 80   | 90   |
| C    | 70   | 80   |
| D    | 60   | 70   |
| F    | 0    | 60   |


## 최종결과

- 수강과목별 담당교수

| 수강과목 pk    | 담당교수 |
| -------------- | -------- |
| 경제학원론     | 김인식   |
| 경제수학       | 강인호   |
| 영화의이해     | 설민영   |
| 경영학원론     | 하지우   |
| 회계원론       | 나이성   |
| 데이터베이스   | 장필연   |
| 자바           | 조중연   |
| 기초전자공학   | 심기정   |
| 디지털논리설계 | 영상구   |

- 수강생-과목별-중간고사
  - '이름' 컬럼을 역정규화 하였다.

| 학번 pk,fk | 이름   | 수강과목 pk,fk | 성적 | 등급 |
| ---------- | ------ | -------------- | ---- | ---- |
| 95-1023001 | 서상석 | 경제학원론     | 89   | B    |
| 95-1023001 | 서상석 | 경제수학       | 57   | F    |
| 95-1023002 | 김민우 | 경제학원론     | 56   | F    |
| 95-1023002 | 김민우 | 경제수학       | 76   | C    |
| 95-1023002 | 김민우 | 영화의이해     | 87   | B    |
| 97-1023003 |        | 영화의이해     | 98   | A    |
| 97-1023003 |        | 경영학원론     | 34   | F    |
| 97-1023003 |        | 회계원론       | 56   | F    |
| 96-4107001 |        | 데이터베이스   | 23   | F    |
| 96-4107001 |        | 자바           | 45   | F    |
| 97-1402001 |        | 기초전자공학   | 56   | F    |
| 97-1402001 |        | 디지털논리설계 | 96   | A    |

- 학생현황

| 학번 pk    | 이름   | 학과           | 학과코드 |
| ---------- | ------ | -------------- | -------- |
| 95-1023001 | 서상석 | 경제학과       | S001     |
| 95-1023002 | 김민우 | 경제학과       | S001     |
| 97-1023003 | 장미영 | 영화영상학과   | M001     |
| 96-4107001 | 이미라 | 정보통신공학과 | T001     |
| 97-1402001 | 공영상 | 전자공학과     | T002     |

- 단과대별 학과

| 학과코드 pk | 학과           | 단과대       |
| ----------- | -------------- | ------------ |
| S001        | 경제학과       | 사회과학대학 |
| M001        | 영화영상학과   | 예술대학     |
| T001        | 정보통신공학과 | 공과대학     |
| T002        | 전자공학과     | 공과대학     |

- 등급 기준표

| 등급 pk | 이상 | 미만 |
| ------- | ---- | ---- |
| A       | 90   | 100  |
| B       | 80   | 90   |
| C       | 70   | 80   |
| D       | 60   | 70   |
| F       | 0    | 60   |