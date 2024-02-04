-- common_code_master
INSERT INTO lms.common_code_master (common_code,common_code_name,description) VALUES
	 ('GRADE','성적등급 코드','교육부 지정 등급구간'),
	 ('DEPARTMENT','학과 코드',''),
	 ('COLLEGE','단과대 코드',''),
	 ('CODE_TYPE','값 유형','공통코드 값 유형');

-- common_code_details
INSERT INTO lms.common_code_details (common_code,detail_code,value_type,value1,value1_description,value2,value2_description) VALUES
	 ('GRADE','A','between','90','이상','100','미만'),
	 ('GRADE','B','between','80','이상','90','미만'),
	 ('GRADE','C','between','70','이상','80','미만'),
	 ('GRADE','D','between','60','이상','70','미만'),
	 ('GRADE','F','between','0','이상','60','미만'),
	 ('DEPARTMENT','S001','code','경제학과','','',''),
	 ('DEPARTMENT','M001','code','영화영상학과','','',''),
	 ('DEPARTMENT','T001','code','정보통신공학과','','',''),
	 ('DEPARTMENT','T002','code','전자공학과','','',''),
	 ('COLLEGE','S','code','사회과학대학','','','');
INSERT INTO lms.common_code_details (common_code,detail_code,value_type,value1,value1_description,value2,value2_description) VALUES
	 ('COLLEGE','M','code','예술대학','','',''),
	 ('COLLEGE','T','code','공과대학','','',''),
	 ('CODE_TYPE','between','code','구간','구간에 따라 값이 변하는 경우','',''),
	 ('CODE_TYPE','code','code','코드','특정 값인 경우','',''),
	 ('CODE_TYPE','case','code','케이스','특정 값에 따라 코드가 부여되는 경우','','');

-- subject_professor
INSERT INTO lms.subject_professor (subject_code,subject_name,professor_name) VALUES
	 ('S001-001','경제학원론','김인식'),
	 ('S001-002','경제수학','강인호'),
	 ('M001-001','영화의이해','설민영'),
	 ('S001-003','경영학원론','하지우'),
	 ('S001-004','회계원론','나이성'),
	 ('T002-001','데이터베이스','장필연'),
	 ('T002-002','자바','조중연'),
	 ('T001-001','기초전자공학','심기정'),
	 ('T001-002','디지털논리설계','영상구');

-- student
INSERT INTO lms.student (student_id,student_name,department,college) VALUES
	 ('95-1023001','서상석','S001','S'),
	 ('95-1023002','김민우','S001','S'),
	 ('97-1023003','장미영','M001','M'),
	 ('96-4107001','이미라','T001','T'),
	 ('97-1402001','공영상','T002','T');

-- subject_midterm_exam
INSERT INTO lms.subject_midterm_exam (student_id,subject_code,score,grade) VALUES
	 ('95-1023001','S001-001',89,'B'),
	 ('95-1023001','S001-002',57,'F'),
	 ('95-1023002','S001-001',56,'F'),
	 ('95-1023002','S001-002',76,'C'),
	 ('95-1023002','M001-001',87,'B'),
	 ('97-1023003','M001-001',98,'A'),
	 ('97-1023003','S001-003',34,'F'),
	 ('97-1023003','S001-004',56,'F'),
	 ('96-4107001','T002-001',23,'F'),
	 ('96-4107001','T002-002',45,'F');
INSERT INTO lms.subject_midterm_exam (student_id,subject_code,score,grade) VALUES
	 ('97-1402001','T001-001',56,'F'),
	 ('97-1402001','T001-002',96,'A');
