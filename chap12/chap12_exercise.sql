--12장 DDL Data Definition Language

CREATE TABLE EMP_DDL
(EMPNO       NUMBER(4)
, ENAME      VARCHAR2(10)
, JOB             VARCHAR2(9)
, MGR           NUMBER(4)
, HIREDATE  DATE
, SAL              NUMBER(7,2)
, COMM        NUMBER(7,2)
, DEPTNO       NUMBER(2)
);


-- DDL 문은 자동으로 COMMIT이 됨

-- 테이블 명 / 열 명 생성규칙
-- 1. 숫자로 시작불가, 2. 영어는 30자, 한글은 15자 -- 한글은 인코딩이 깨질 수 있으므로 잘 안하는게 좋음
-- 3. 같은 소유자 소유의 테이블 이름 중복 불가
-- 4. 특수문자 $, #, _ 를 사용할 수 있다. ex) EMP#90_OB
-- 6. SELECT, FROM 등은 테이블 이름으로 사용 불가 (근데 DUAL은 되더라)

-- 기존 테이블 열 구종화 데이터를 복사하여 새 테이블 생성하기
CREATE TABLE DEPT_DDL
         AS SELECT * FROM DEPT;
         
DESC DEPT_DDL;

-- 다른 테이블의 일부를 복사하여 테이블 생성하기
CREATE TABLE EMP_DDL_30
        AS  SELECT * FROM EMP WHERE DEPTNO = 30;
        
-- 기존 테이블의 열 구조만 복사하여 새 테이블 생성
CREATE TABLE EMPDEPT_DDL
        AS  SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE
                        ,   E.SAL, E.COMM, D.DEPTNO, D.DNAME, D.LOC
                FROM EMP E, DEPT D
            WHERE 1<>1;
SELECT * FROM EMPDEPT_DDL;

-- 12-6 EMP 테이블 복사하여 테이블 수정 연습
CREATE TABLE EMP_ALTER
         AS SELECT * FROM EMP;
         
SELECT * FROM EMP_ALTER;

-- 12-7 컬럼 추가(ADD)
ALTER TABLE EMP_ALTER
        ADD HP VARCHAR(20);
        
SELECT * FROM EMP_ALTER;



-- 12-8 컬럼명 변경(RENAME)
ALTER TABLE EMP_ALTER
       RENAME COLUMN HP TO TEL;
SELECT * FROM EMP_ALTER;


-- 데이터 확장
ALTER TABLE EMP_ALTER
MODIFY EMPNO NUMBER(5); -- 데이터 확장은 되지만 데이터 축소는 불가
SELECT * FROM EMP_ALTER;

-- 컬 삭제
ALTER TABLE EMP_ALTER
DROP COLUMN TEL;
SELECT * FROM EMP_ALTER;

-- 테이블 이름 변경
RENAME EMP_ALTER TO EMP_RENAME;

DESC EMP_ALTER;
DESC EMP_RENAME;

SELET * FROM EMP_RENAME;

TRUNCATE TABLE EMP_RENAME;
DROP TABLE EMP_RENAME;

-- Q1
CREATE TABLE EMP_HW
(EMPNO       NUMBER(4)
, ENAME      VARCHAR2(10)
, JOB             VARCHAR2(9)
, MGR           NUMBER(4)
, HIREDATE  DATE
, SAL              NUMBER(7,2)
, COMM        NUMBER(7,2)
, DEPTNO       NUMBER(2)
);

-- Q2
SELECT * FROM EMP_HW;
ALTER TABLE EMP_HW
ADD BIGO VARCHAR(20);
DESC EMP_HW;

-- Q3
ALTER TABLE EMP_HW
MODIFY BIGO VARCHAR(30);
DESC EMP_HW;
--Q4
ALTER TABLE EMP_HW
RENAME COLUMN BIGO TO REMARK;
DESC EMP_HW;
--Q5
INSERT INTO EMP_HW 
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, NULL 
  FROM EMP; 
SELECT * FROM EMP_HW;
--Q6
TRUNCATE TABLE EMP_HW;
DROP TABLE EMP_HW;


