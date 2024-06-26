-- 13장 객체 종류
-- 데이터베이스를 위한 데이터를 저장한 데이터 사전
-- 테이블 : 1. 사용자 테이블과 2. 데이터 사전
-- 13-1
SELECT * FROM DICT;

set linesize 2000;
set pagesize 1000;

SELECT * FROM DICTIONARY;

-- USER_접두어를 가진 데이터 사전
SELECT TABLE_NAME
	FROM USER_TABLES
ORDER BY TABLE_NAME;




-- 13-8 HR계정이 소유한 인덱스 정보 조회
SELECT * FROM USER_INDEXES;
SELECT * FROM USER_IND_COLUMNS;
SELECT * FROM USER_INDEXES WHERE TABLE_NAME = 'EMP';

-- 13-10
		CREATE INDEX IDX_EMP_SAL ON EMP(SAL);
--		CREATE	인덱스	인덱스_테이블_컬럼	ON	테이블(컬럼);

-- 인덱스 컬럼 조회
SELECT * FROM EMP WHERE EMPNO = 7369;
SELECT * FROM EMP WHERE ENAME = 'SMITH';

DROP INDEX IDX_EMP_SAL;
SELECT * FROM USER_INDEXES WHERE TABLE_NAME = 'EMP';


-- 추가 DDL
CREATE TABLE customers
( customer_id number NOT NULL PRIMARY KEY,
  first_name			varchar2(10) NOT NULL,
  last_name				varchar2(10) NOT NULL,
  email						varchar2(10),
  phone_number	varchar2(20),
  regist_date			date
  );

-- DROP TABLE CUSTOMERS;
-- DML
INSERT INTO CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, REGIST_DATE)
VALUES (1, 'JIHEON', 'HA', 'JIHEON@', '010-134-1234', '2024/06/13');

INSERT INTO CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, REGIST_DATE)
VALUES (2, 'DAHYUN', 'LEE', 'DAHYUN@', '010-111-1234',  '2024/06/13');

INSERT INTO CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, REGIST_DATE)
VALUES (3, 'JUHO', 'JEONG', 'JEONG@', '010-2222-1234',  '2024/06/13');

INSERT INTO CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, REGIST_DATE)
VALUES (4, 'HANUL', 'LEE', 'HANUL@', '010-3333-1234',  '2024/06/13');

SELECT *
	FROM USER_INDEXES
WHERE TABLE_NAME = 'CUSTOMERS';

SELECT *
	FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'CUSTOMERS';

CREATE INDEX idx_customer_registdate
	ON	CUSTOMERS ( regist_date ) ;
	
	
select *
	from customers
where regist_date = '2024/06/13';

-- 고유인덱스
CREATE UNIQUE INDEX idx_customer_email
	ON	CUSTOMERS (EMAIL);

SELECT *
	FROM USER_INDEXES
WHERE TABLE_NAME = 'CUSTOMERS';





-- 테이블 생성
CREATE TABLE PRODUCTS
(
PRODUCT_ID					NUMBER NOT NULL PRIMARY KEY,
PRODUCT_NAME			VARCHAR2(10) NOT NULL,
REG_DATE						DATE,
WEIGHT							NUMBER,
PRICE								NUMBER
);
-- 데이터 삽입
INSERT INTO PRODUCTS	(PRODUCT_ID, PRODUCT_NAME, REG_DATE, WEIGHT, PRICE)
VALUES	(1,	'Computer',	'2021/01/01',	10,	1600000);
INSERT INTO PRODUCTS	(PRODUCT_ID, PRODUCT_NAME, REG_DATE, WEIGHT, PRICE)
VALUES	(2,	'Smartphone',	'2021/02/01',	0.2,	1000000);
INSERT INTO PRODUCTS	(PRODUCT_ID, PRODUCT_NAME, REG_DATE, WEIGHT, PRICE)
VALUES	(3,	'Television',	'2021/03/01',	20,	2000000);

SELECT * FROM PRODUCTS;			-- 데이터 확인



-- 13-3
-- VIEW	:	가상테이블	: SELECT 문을 저장한 객체
-- 편의성	:	SELECT 문의 복잡도 완화
-- 보안성	:	테이블의 일부 데이터만 노출
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME AS 직원명
			, E.DEPARTMENT_NAME
			, E.JOB_TITLE
			, MGR.FIRST_NAME || ' ' || MGR.LAST_NAME AS 관리자명
FROM EMP_DETAILS_VIEW E, EMPLOYEES MGR
WHERE E.MANAGER_ID = MGR.EMPLOYEE_ID
;
--13-15
CREATE OR REPLACE VIEW VW_EMP20
		AS (SELECT EMPNO, ENAME, JOB, DEPTNO
					FROM EMP
				WHERE DEPTNO = 20);

SELECT *
	FROM USER_VIEWS;
SELECT *
	FROM VW_EMP20;

SELECT VIEW_NAME, TEXT_LENGTH, TEXT
	FROM USER_VIEWS;

-- 1분 복습
-- 부서번호가 30인 사원정보의 모든 열을 출력하는 VM_EMP30ALL 뷰
-- 작성하는 SQL문 작성
CREATE OR REPLACE VIEW VM_EMP30ALL
		AS (SELECT *
					FROM EMP
				WHERE DEPTNO = 30);

SELECT * FROM USER_VIEWS;
DROP VIEW VW_EMP20;



-- 13-21 SAL 열 기준으로 정렬
SELECT ROWNUM, E.*
	FROM EMP E
ORDER BY SAL DESC;

-- 인라인 뷰
-- 13-22
SELECT ROWNUM, E.*
	FROM (SELECT * FROM EMP ORDER BY SAL DESC) E;
-- 단순뷰 	:	하나의 테이블
-- 복합뷰	:	

WITH E AS (SELECT * FROM EMP ORDER BY SAL DESC)
	SELECT ROWNUM, E.*
FROM E;

-- TOP N
WITH E AS (SELECT * FROM EMP ORDER BY SAL DESC)
	SELECT ROWNUM, E.*
FROM E
WHERE ROWNUM <= 3;
-- 인라인 뷰
SELECT EE.RN, EE.EMPNO, EE.ENAME
FROM ( SELECT ROWNUM AS RN, E.* FROM (SELECT * FROM EMP ORDER BY SAL DESC) E) EE
WHERE ROWNUM <= 3;


SELECT EE.RN, EE.EMPNO, EE.ENAME, EE.SAL
FROM ( SELECT ROWNUM AS RN, E.* FROM (SELECT * FROM EMP ORDER BY SAL DESC) E) EE
WHERE EE.RN BETWEEN 11 AND 14;




-- 13- 4 시퀀스
SELECT MAX(EMPNO) + 1	
	FROM EMP;
	
	
CREATE TABLE DEPT_SEQUENCE
	AS SELECT *	FROM DEPT	WHERE 1<>1;
	
CREATE SEQUENCE SEQ_DEPT_SEQUENCE
	INCREMENT BY 10
	START WITH 10
	MAXVALUE 90
	MINVALUE 0
	NOCYCLE		-- 최댓값 도달 시 초기화 할 것인지 여부
	CACHE 2;
	
	
SELECT *
	FROM USER_SEQUENCES;
	
-- 시퀀스 사용
INSERT INTO DEPT_SEQUENCE (DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE', 'SEOUL');
SELECT * FROM DEPT_SEQUENCE ORDER BY DEPTNO;			-- MYSQL의 경우 AUTO 뭐시기 옵션이 있음

SELECT SEQ_DEPT_SEQUENCE.CURRVAL	FROM DUAL;	-- 마지막으로 생성된 시퀀스 확인

SELECT * FROM DEPT_SEQUENCE;
 
--13-32 
 -- SEQUENCE 옵션 조정
 ALTER SEQUENCE SEQ_DEPT_SEQUENCE
	INCREMENT BY 3
	MAXVALUE 99
	CYCLE;
SELECT * FROM USER_SEQUENCES;

SELECT * FROM DEPT_SEQUENCE ORDER BY DEPTNO DESC;




-- 13-5 동의어 SYNONYN
CREATE SYNONYM E
FOR EMP;

SELECT * FROM E;

DROP SYNONYM E;

-- 1. EMP 테이블과 같은 구조의 데이터를 저장하는 EMPIDX 테이블을 만들어보아라'
CREATE TABLE EMPIDX
	AS SELECT * FROM EMP; 
-- 2. 생성한 EMPIDX 테이블의 EMPNO 열에 IDX_EMPIDX_EMPNO 인덱스를 만들어보아라
CREATE INDEX IDX_EMPIDX_EMPNO
	ON EMPIDX(EMPNO);
-- 3. 마지막으로 인덱스가 잘 생성되었는지 적절한 데이터 사전 뷰를 통해 확인해 보아라
SELECT * FROM USER_INDEXES WHERE TABLE_NAME = 'EMPIDX';

-- Q2
CREATE OR REPLACE VIEW EMPIDX_OVER15K 
    AS (SELECT EMPNO, ENAME, JOB, DEPTNO, 
               SAL, NVL2(COMM, 'O', 'X') AS COMM 
          FROM EMPIDX 
         WHERE SAL > 1500); 
		 
		 
SELECT * FROM USER_VIEWS;


-- Q3 다음 세가지 SQL 문을 작성해보아라
-- 1 DEPT 테이블과 같은 열과 행 구성을 가지는 DEPTSEQ테이블을 작성해보세요.
CREATE TABLE DEPT_SEQ
	AS SELECT *	FROM DEPT;
--  DROP TABLE DEPT_SEQ;
--2 생성한 DEPTSEQ 테이블의 DEPTNO열에 사용할 시퀀스를 다음과 같이 특성에 맡게 생성해 보세요.
	CREATE SEQUENCE SEQ_DEPT_SEQ
	INCREMENT BY 1
	START WITH 1
	MAXVALUE 99
	MINVALUE 1
	NOCYCLE		-- 최댓값 도달 시 초기화 할 것인지 여부
	NOCACHE;
	
SELECT *
	FROM USER_SEQUENCES;
-- 3. 마지막으로 생성한 DEPT_SEQ를 사용하여 오른쪽과 같이 세 개의 부서를 차례대로 추가해 보세요.

INSERT INTO DEPT_SEQ (DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPT_SEQ.NEXTVAL, 'DATABASE', 'SEOUL');
INSERT INTO DEPT_SEQ (DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPT_SEQ.NEXTVAL, 'WEB', 'BUSAN');
INSERT INTO DEPT_SEQ (DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPT_SEQ.NEXTVAL, 'MOBILE', 'ILSAN');
SELECT * FROM DEPT_SEQ ORDER BY DEPTNO;			-- MYSQL의 경우 AUTO 뭐시기 옵션이 있음
COMMIT;