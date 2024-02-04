-------------------------------------------------------------------------------
-- 공통코드_마스터 common_code_master
-- 공통코드 common_code pk
-- 공통코드명 common_code_name
-- 설명 description

CREATE TABLE lms.common_code_master (
	common_code varchar(10) NOT NULL,
	common_code_name varchar(10) NOT NULL,
	description varchar(256) NULL,
	CONSTRAINT common_code_master_pk PRIMARY KEY (common_code)
);

-- Column comments
COMMENT ON TABLE lms.common_code_master IS '공통코드_마스터';
COMMENT ON COLUMN lms.common_code_master.common_code IS '공통코드';
COMMENT ON COLUMN lms.common_code_master.common_code_name IS '공통코드명';
COMMENT ON COLUMN lms.common_code_master.description IS '설명';

-------------------------------------------------------------------------------
-- 공통코드_상세 common_code_details
-- 공통코드 common_code pk
-- 상세코드 detail_code pk
-- 값_유형 value_type
-- 값1 value1
-- 값1_설명 value1_description
-- 값2 value2
-- 값2_설명 value2_description

CREATE TABLE lms.common_code_details (
	common_code varchar(10) NOT NULL,
	detail_code varchar(10) NOT NULL,
	value_type varchar(10) NOT NULL,
	value1 varchar(256) NOT NULL,
	value1_description varchar(256) NULL,
	value2 varchar(256) NULL,
	value2_description varchar(256) NULL,
	CONSTRAINT common_code_details_pk PRIMARY KEY (common_code, detail_code),
	CONSTRAINT common_code_details_common_code_master_fk FOREIGN KEY (common_code) REFERENCES lms.common_code_master(common_code)
);

COMMENT ON TABLE lms.common_code_details IS '공통코드_상세';
COMMENT ON COLUMN lms.common_code_details.common_code IS '공통코드';
COMMENT ON COLUMN lms.common_code_details.detail_code IS '상세코드';
COMMENT ON COLUMN lms.common_code_details.value_type IS '값_유형';
COMMENT ON COLUMN lms.common_code_details.value1 IS '값1';
COMMENT ON COLUMN lms.common_code_details.value1_description IS '값1_설명';
COMMENT ON COLUMN lms.common_code_details.value2 IS '값2';
COMMENT ON COLUMN lms.common_code_details.value2_description IS '값2_설명';

-------------------------------------------------------------------------------
-- 수강과목별 담당교수 subject_professor
-- 과목코드 subject_code pk
-- 과목명 subject_name
-- 담당교수 professor_name

CREATE TABLE lms.subject_professor (
	subject_code varchar(10) NOT NULL,
	subject_name varchar(256) NOT NULL,
	professor_name varchar(256) NOT NULL,
	CONSTRAINT subject_professor_pk PRIMARY KEY (subject_code)
);
COMMENT ON TABLE lms.ubject_professor IS '수강과목별 담당교수';

-- Column comments

COMMENT ON COLUMN lms.ubject_professor.subject_code IS '과목코드';
COMMENT ON COLUMN lms.ubject_professor.subject_name IS '과목명';
COMMENT ON COLUMN lms.ubject_professor.professor_name IS '담당교수';

-------------------------------------------------------------------------------
-- 학생 student
-- 학번 student_id
-- 이름 student_name
-- 학과코드 DEPARTMENT department
-- 단과대코드 COLLEAGE college


CREATE TABLE lms.student (
	student_id varchar(16) NOT NULL,
	student_name varchar(256) NOT NULL,
	department varchar(256) NULL,
	college varchar(256) NULL,
	CONSTRAINT student_pk PRIMARY KEY (student_id)
);
COMMENT ON TABLE lms.student IS '학생';

-- Column comments

COMMENT ON COLUMN lms.student.student_id IS '학번';
COMMENT ON COLUMN lms.student.student_name IS '이름';
COMMENT ON COLUMN lms.student.department IS '학과코드 DEPARTMENT';
COMMENT ON COLUMN lms.student.college IS '단과대코드 COLLEAGE';

-------------------------------------------------------------------------------
-- 수강생_과목별_중간고사 subject_midterm_exam
-- 학번 student_id pk fk
-- 과목코드 subject_code pk fk
-- 성적 score
-- 등급 GRADE grade

CREATE TABLE lms.subject_midterm_exam (
	student_id varchar(16) NOT NULL,
	subject_code varchar(10) NOT NULL,
	score integer NULL,
	grade varchar(10) NULL,
	CONSTRAINT subject_midterm_exam_unique UNIQUE (subject_code,student_id),
	CONSTRAINT subject_midterm_exam_subject_professor_fk FOREIGN KEY (subject_code) REFERENCES lms.subject_professor(subject_code),
	CONSTRAINT subject_midterm_exam_student_fk FOREIGN KEY (student_id) REFERENCES lms.student(student_id)
);
COMMENT ON TABLE lms.subject_midterm_exam IS '수강생_과목별_중간고사';

-- Column comments

COMMENT ON COLUMN lms.subject_midterm_exam.student_id IS '학번';
COMMENT ON COLUMN lms.subject_midterm_exam.subject_code IS '과목코드';
COMMENT ON COLUMN lms.subject_midterm_exam.score IS '성적';
COMMENT ON COLUMN lms.subject_midterm_exam.grade IS '등급';



