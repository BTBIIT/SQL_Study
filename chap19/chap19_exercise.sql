-- chapter19
-- 19장 저장 서브프로그램
-- 19-1


CREATE OR REPLACE PROCEDURE PRO_NOPAAM
IS
        V_EMPNO NUMBER (4)  :=  7788;
        V_ENAME VARCHAR2(10);
BEGIN
        V_ENAME :=  'SCOTT';
        DBMS_OUTPUT.PUT_LINE('V_EMPNO : '  || V_EMPNO);
        DBMS_OUTPUT.PUT_LINE('V_ENAME : '  || V_ENAME);
END;
/

SET SERVEROUTPUT ON;
/*
DECLARE
	TYPE REC_DEPT IS RECORD(
		DEPT_NO NUMBER(2) NOT NULL	:= 99,
		DNAME DEPT.DNAME%TYPE,
		LOC DEPT.LOC%TYPE
	);
	DEPT_REC REC_DEPT;
BEGIN
	DEPT_REC.DEPT_NO 		:= 99;
	DEPT_REC.DNAME := 'DATABASE';
	DEPT_REC.LOC				:= 'SEOUL';
	DBMS_OUTPUT.PUT_LINE('DEPTNO	:	'	||	DEPT_REC.DEPT_NO);
	DBMS_OUTPUT.PUT_LINE('DNAME	:	'	||	DEPT_REC.DNAME);
	DBMS_OUTPUT.PUT_LINE('LOC	:	'	||	DEPT_REC.LOC);
END;
*/

-- 실행 : EXCUTE  /  EXEC 명령어 사용
EXEC PRO_NOPAAM;
BEGIN
    PRO_NOPAAM;
END;
/

SELECT *
    FROM USER_SOURCE
WHERE NAME = 'PRO_NOPAAM';

DROP PROCEDURE PRO_NOPAAM;

-- 19-7
CREATE OR REPLACE PROCEDURE pro_param_in
(
        param1 IN NUMBER,
        param2 NUMBER,
        param3 NUMBER :=  3,
        param4 NUMBER DEFAULT 4
)
IS
BEGIN
        DBMS_OUTPUT.PUT_LINE('param1  : ' ||  param1);
        DBMS_OUTPUT.PUT_LINE('param2  : ' ||  param2);
        DBMS_OUTPUT.PUT_LINE('param3  : ' ||  param3);
        DBMS_OUTPUT.PUT_LINE('param4  : ' ||  param4);
END;
/


EXECUTE PRO_PARAM_IN(1,2,9,8);

EXECUTE PRO_PARAM_IN(1,2);        -- DEFALUT 값을 설정해주었기 때문에 에러가 나지 않음
--  19-11 파라미터 이름을 활용하여 프로시저에 값 입력하기
EXECUTE PRO_PARAM_IN(PARAM2 => 20, PARAM1 => 10);

-- OUT 모드 파라미터 정의하기
CREATE OR REPLACE PROCEDURE PRO_PARAM_OUT
(
        IN_EMPNO  IN  EMP.EMPNO%TYPE,
        OUT_ENAME OUT EMP.ENAME%TYPE,
        OUT_SAL OUT EMP.SAL%TYPE
)
IS
BEGIN
        SELECT ENAME, SAL INTO OUT_ENAME, OUT_SAL
          FROM EMP
        WHERE EMPNO = IN_EMPNO;
END PRO_PARAM_OUT;
/
SELECT ENAME, SAL FROM EMP;
-- TEST
DECLARE
        V_ENAME EMP.ENAME%TYPE;
        V_SAL EMP.SAL%TYPE;
BEGIN
        PRO_PARAM_OUT(7788, V_ENAME, V_SAL);
        DBMS_OUTPUT.PUT_LINE('ENAME : ' || V_ENAME);
        DBMS_OUTPUT.PUT_LINE('SAL : ' || V_SAL);
END;
/
-- 19-14 IN - OUT 모드
CREATE OR REPLACE PROCEDURE PRO_PARAM_INOUT
(
        INOUT_NO  IN  OUT NUMBER
)
IS
BEGIN
        INOUT_NO  :=  INOUT_NO  * 2;
END;
/

DECLARE
        NO  NUMBER;
BEGIN
        NO  :=  5;
        PRO_PARAM_INOUT(NO);
        DBMS_OUTPUT.PUT_LINE('NO  : ' || NO);
END;
/
-- 19-16
CREATE OR REPLACE PROCEDURE PRO_ERR
IS
    ERR_NO  NUMBER;
BEGIN
    ERR_NO := 100;     -- := 로 해주어야하는데 = 을 씀
    DBMS_OUTPUT.PUT_LINE('ERR_NO  : ' ||  ERR_NO);
END;
/
SHOW ERROR;

SELECT *
    FROM USER_ERRORS
WHERE NAME = 'PRO_ERR';


-- 직원 평균 출력 프로시저
CREATE OR REPLACE PROCEDURE EMP_AVG_SALARY
(
        AVG_SALARY OUT NUMBER
)
AS
BEGIN
        SELECT AVG(SAL)
          INTO   AVG_SALARY
         FROM EMP;
END EMP_AVG_SALARY; 

DECLARE
        AVG_SAL NUMBER;
BEGIN
        EMP_AVG_SALARY(AVG_SAL);
        DBMS_OUTPUT.PUT_LINE(TRUNC(AVG_SAL));
END;
/


-- IF   ELSE 문 사용 프로시져
CREATE OR REPLACE PROCEDURE IF_SALARY
(
    SALARY IN NUMBER
)
AS
    AVG_SALARY NUMBER;
BEGIN
    SELECT AVG(SAL) INTO AVG_SALARY FROM EMP;
    
    IF SALARY >= AVG_SALARY THEN
        DBMS_OUTPUT.PUT_LINE('평균 이상');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('평균 미만');
    END IF;
END; 
/

EXECUTE IF_SALARY(2000);

SELECT HIRE_DATE, EMAIL
  FROM EMPLOYEES;
  
-- CASE 문사용 PROCEDURE
CREATE OR REPLACE PROCEDURE CASE_HIREDATE
(
    EMP_EMAIL   IN    EMPLOYEES.EMAIL%TYPE
)
AS
    HIRE_YEAR   NCHAR(2);
    TEXT_MSG    VARCHAR2(20);
BEGIN
    SELECT TO_CHAR(HIRE_DATE, 'YY') INTO HIRE_YEAR
      FROM EMPLOYEES
    WHERE EMAIL = EMP_EMAIL;
    
    CASE
              WHEN (HIRE_YEAR = '01') THEN TEXT_MSG := HIRE_YEAR || '년도에 입사';
              WHEN (HIRE_YEAR = '02') THEN TEXT_MSG := HIRE_YEAR || '년도에 입사';
              WHEN (HIRE_YEAR = '03') THEN TEXT_MSG := HIRE_YEAR || '년도에 입사';
              WHEN (HIRE_YEAR = '04') THEN TEXT_MSG := HIRE_YEAR || '년도에 입사';
              WHEN (HIRE_YEAR = '05') THEN TEXT_MSG := HIRE_YEAR || '년도에 입사';
              WHEN (HIRE_YEAR = '06') THEN TEXT_MSG := HIRE_YEAR || '년도에 입사';
              WHEN (HIRE_YEAR = '07') THEN TEXT_MSG := HIRE_YEAR || '년도에 입사';
              WHEN (HIRE_YEAR = '08') THEN TEXT_MSG := HIRE_YEAR || '년도에 입사';
              WHEN (HIRE_YEAR = '09') THEN TEXT_MSG := HIRE_YEAR || '년도에 입사';
              ELSE TEXT_MSG := '01 ~ 09 년도 이외에 입사';
    END CASE;
    DBMS_OUTPUT.PUT_LINE(TEXT_MSG);
END;
/

SELECT * FROM EMPLOYEES WHERE EMAIL = 'SKING';
EXECUTE CASE_HIREDATE('SKING');

-- IN OUT 파라미터 
CREATE OR REPLACE PROCEDURE IN_OUT_EMP
(
    EMP_NAME IN OUT VARCHAR2
)
AS
BEGIN
        SELECT FIRST_NAME || ' ' || LAST_NAME INTO EMP_NAME
          FROM EMPLOYEES
        WHERE FIRST_NAME = EMP_NAME OR LAST_NAME = EMP_NAME;
          EMP_NAME := '직원 : '  || EMP_NAME;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
              EMP_NAME := '직원 : 없음';
END;
/

DECLARE
    EMP_NAME VARCHAR2(20)  := 'Kang';
BEGIN
    IN_OUT_EMP(EMP_NAME);
    
    DBMS_OUTPUT.PUT_LINE(EMP_NAME);
END;


--  CURSOR를 이용해 EMPLOYEES 테이블에 JOB_ID가 IT_PROG인 직원의 FIRST_NAME과 LAST_NAME을 공백을 두고 결합하여 출력하는 프로시저 정의
CREATE OR REPLACE PROCEDURE CURSOR_IT_PROG
IS
    FNAME VARCHAR2(20);
    LNAME VARCHAR2(20);
    JOBID  VARCHAR2(20);
    CURSOR EMP_CURSOR IS 
            SELECT FIRST_NAME, LAST_NAME, JOB_ID
              FROM EMPLOYEES;
BEGIN
    OPEN EMP_CURSOR;
    LOOP
            FETCH EMP_CURSOR INTO FNAME, LNAME, JOBID;
            EXIT WHEN EMP_CURSOR%NOTFOUND;
            IF JOBID = 'IT_PROG' THEN 
                DBMS_OUTPUT.PUT_LINE(FNAME ||' '|| LNAME);
            END IF;
    END LOOP;
END;
/

SELECT FIRST_NAME, LAST_NAME, JOB_ID
  FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

EXECUTE CURSOR_IT_PROG();

-- Q1 IF ELSIF ELSE 문을 사용하여 JOBS 테이블의 최저, 최대 SALARY 평균 값을 이용하여 
-- 입력받은 SALARY가 최저 평균 이하인지 최대 평균이상인지 평균 구간인지 출력하는 프로시저 정의
CREATE OR REPLACE PROCEDURE IF_MINMAX_SALARY
(
  SALARY IN NUMBER
)
AS
      MINSALARY JOBS.MIN_SALARY%TYPE;
      MAXSALARY JOBS.MAX_SALARY%TYPE;
BEGIN
    SELECT AVG(MIN_SALARY), AVG(MAX_SALARY)
      INTO MINSALARY, MAXSALARY
      FROM JOBS;
    
    IF SALARY  <= MINSALARY THEN
        DBMS_OUTPUT.PUT_LINE('최저 평균 이하');
    ELSIF SALARY >= MAXSALARY THEN
        DBMS_OUTPUT.PUT_LINE('최대 평균 이상');
    ELSE
        DBMS_OUTPUT.PUT_LINE('평균 구간');
    END IF;
END;
/
SELECT MAX(MAX_SALARY) FROM JOBS; -- 40000
SELECT TRUNC(AVG(MAX_SALARY)) FROM JOBS;  --14231
SELECT MIN(MAX_SALARY) FROM JOBS;   -- 5000

SELECT MAX(MIN_SALARY) FROM JOBS; -- 20080
SELECT TRUNC(AVG(MIN_SALARY)) FROM JOBS; -- 7131
SELECT MIN(MIN_SALARY) FROM JOBS;   -- 2008
EXECUTE IF_MINMAX_SALARY(10000);
EXECUTE IF_MINMAX_SALARY(2008);
EXECUTE IF_MINMAX_SALARY(40000);

SELECT * FROM NLS_DATABASE_PARAMETERS
WHERE PARAMETER = 'NLS_CHARACTERSET';

SELECT LENGTHB('안녕') FROM DUAL;
-- AL32UTF8 한글 3BYTE
-- KO16KSC5601  : 완성형 한글 2BYTE
-- KO16MSWIN949 : 조합형 한글 2BYTE


--  19-19 함수 사용하기
CREATE OR REPLACE FUNCTION FUNC_AFTERTAX
(
        SAL IN NUMBER
)
RETURN NUMBER       -- 리턴자료형

IS  
        TAX NUMBER  :=  0.05;
BEGIN
        RETURN    ROUND(SAL - (SAL * TAX));
           
END FUNC_AFTERTAX;
/

SELECT FUNC_AFTERTAX(3000) FROM DUAL;

SELECT ENAME, SAL BEFORESAL, FUNC_AFTERTAX(SAL) AS AFTERSAL
  FROM EMP;
---- 사용 완ㅇ료

-- 패키지 생성하기
CREATE OR REPLACE PACKAGE PKG_EXAMPLE
IS
        SPEC_NO NUMBER := 10;
        FUNCTION FUNC_AFTERTAX(SAL NUMBER)  RETURN NUMBER;
        PROCEDURE PRO_EMP(IN_EMPNO IN EMP.EMPNO%TYPE);
        PROCEDURE PRO_DEPT(IN_DEPTNO IN DEPT.DEPTNO%TYPE);
END;
/


SELECT TEXT
  FROM USER_SOURCE
WHERE TYPE = 'PACKAGE'
  AND NAME = 'PKG_EXAMPLE';


DESC PKG_EXAMPLE;

-- 패키지 본문 생성하기
-- 19-27
CREATE OR REPLACE PACKAGE BODY PKG_EXAMPLE
IS
      BODY_NO NUMBER := 10;
    
    FUNCTION FUNC_AFTERTAX(SAL NUMBER)
    RETURN NUMBER
    IS
          TAX NUMBER := 0.05;
    BEGIN
          RETURN SAL - ROUND((SAL * TAX));
    END FUNC_AFTERTAX;
    
    PROCEDURE PRO_EMP(IN_EMPNO IN EMP.EMPNO%TYPE)
      IS
            OUT_ENAME EMP.ENAME%TYPE;
            OUT_SAL EMP.SAL%TYPE;
        BEGIN 
            SELECT ENAME, SAL
                INTO  OUT_ENAME, OUT_SAL
              FROM EMP
            WHERE EMPNO = IN_EMPNO;
            DBMS_OUTPUT.PUT_LINE('ENAME : ' || OUT_ENAME);
            DBMS_OUTPUT.PUT_LINE('SAL : ' || OUT_SAL);
        END PRO_EMP;
      
    PROCEDURE PRO_DEPT(IN_DEPTNO IN DEPT.DEPTNO%TYPE)
      IS
            OUT_DNAME DEPT.DNAME%TYPE;
            OUT_LOC         DEPT.LOC%TYPE;
      BEGIN
            SELECT DNAME, LOC
               INTO  OUT_DNAME, OUT_LOC
              FROM DEPT
            WHERE DEPTNO = IN_DEPTNO;
            DBMS_OUTPUT.PUT_LINE('DNAME : ' ||  OUT_DNAME);
            DBMS_OUTPUT.PUT_LINE('LOC : ' ||  OUT_LOC);
      END PRO_DEPT;

END;
/

-- 프로시저 오버로드 하기
CREATE OR REPLACE PACKAGE pkg_overload
IS
    PROCEDURE pro_emp(in_empno IN  EMP.EMPNO%TYPE);
    PROCEDURE pro_emp(in_ename IN  EMP.ENAME%TYPE);
END;
/
CREATE OR REPLACE PACKAGE BODY pkg_overload
IS 

    PROCEDURE pro_emp(in_empno IN  EMP.EMPNO%TYPE)
    IS
        out_ename EMP.ENAME%TYPE;
        out_sal EMP.SAL%TYPE;
    BEGIN
        SELECT ENAME, SAL INTO out_ename, out_sal
          FROM EMP
         WHERE EMPNO = in_empno;
         DBMS_OUTPUT.PUT_LINE('ENAME : ' || out_ename);
         DBMS_OUTPUT.PUT_LINE('SAL : ' || out_sal);
    END pro_emp;
    
    PROCEDURE pro_emp(in_ename IN  EMP.ENAME%TYPE)
   IS
        out_ename EMP.ENAME%TYPE;
        out_sal EMP.SAL%TYPE;
    BEGIN
        SELECT ENAME, SAL INTO out_ename, out_sal
          FROM EMP
         WHERE ENAME = in_ename;
         
         DBMS_OUTPUT.PUT_LINE('ENAME : ' || out_ename);
         DBMS_OUTPUT.PUT_LINE('SAL : ' || out_sal);
    END pro_emp;
END;
/


-- 실습 19-30

BEGIN
    DBMS_OUTPUT.PUT_LINE('-- PKG_EXAMPLE.FUNC_AFTERTAX(3000) --');
    DBMS_OUTPUT.PUT_LINE('AFTER-TAX : '   ||  PKG_EXAMPLE.FUNC_AFTERTAX(3000));

    DBMS_OUTPUT.PUT_LINE('-- PKG_EXAMPLE.PRO_DEPT(10) --');
    PKG_EXAMPLE.PRO_DEPT(10);

    DBMS_OUTPUT.PUT_LINE('-- PKG_EXAMPLE.pro_emp(7788) --');
    PKG_EXAMPLE.PRO_EMP(7788);
 
    DBMS_OUTPUT.PUT_LINE('-- pkg_overload.pro_emp(7788) --');
    pkg_overload.pro_emp(7788);
END;
/

-- 실습 19-31 --
SELECT TO_CHAR(sysdate, 'DY') FROM DUAL;

CREATE TABLE EMP_TRG
    AS SELECT * FROM EMP;

SELECT * FROM EMP_TRG;

CREATE OR REPLACE TRIGGER NODML_WEEKEND
BEFORE
INSERT OR UPDATE OR DELETE ON EMP_TRG
BEGIN
        IF TO_CHAR(SYSDATE, 'DY') IN ('토','일') THEN
              IF INSERTING THEN
                  RAISE_APPLICATION_ERROR(-20000, '주말 사원정보 추가 불가');
            ELSIF UPDATING THEN
                  RAISE_APPLICATION_ERROR(-20001, '주말 사원정보 수정 불가');
            ELSIF DELETING THEN
                  RAISE_APPLICATION_ERROR(-20002, '주말 사원정보 삭제 불가');
           ELSE
                  RAISE_APPLICATION_ERROR(-20003, '주말 사원정보 변경 불가');
            END IF;
       END IF;
END;
/
--DROP TABLE EMP_TRG;
-- DROP TRIGGER TRG_EMP_LOG;
SELECT * FROM EMP_TRG WHERE EMPNO = 7788;

UPDATE EMP_TRG SET SAL = 3500 WHERE EMPNO = 7788;

CREATE TABLE EMP_TRG_LOG
(
    TABLE_NAME VARCHAR2(10),    -- DML 수행된 테이블 이름
    DML_TYPE VARCHAR2(10),          -- INSERT, UPDATE, DELETE 
    EMPNO NUMBER(4),                          -- DML 대상이 된 사원 번호
    USER_NAME VARCHAR2(30),        -- DML을 수행한 USER 이름
    CHANGE_DATE DATE                    -- DML 수행된 날짜
);


CREATE OR REPLACE TRIGGER TRG_EMP_LOG
AFTER
INSERT OR UPDATE OR DELETE ON EMP_TRG
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO EMP_TRG_LOG
        VALUES ('EMP_TRG', 'INSERT', :NEW.EMPNO, 
                          SYS_CONTEXT('USERENV', 'SESSION_USER'), SYSDATE);
    ELSIF UPDATING THEN
        INSERT INTO EMP_TRG_LOG
        VALUES ('EMP_TRG', 'UPDATE', :OLD.EMPNO, 
                          SYS_CONTEXT('USERENV', 'SESSION_USER'), SYSDATE);
    ELSIF DELETING  THEN
        INSERT INTO EMP_TRG_LOG
        VALUES ('EMP_TRG', 'DELTE', :OLD.EMPNO, 
                          SYS_CONTEXT('USERENV', 'SESSION_USER'), SYSDATE);
    END IF;
END;
/
--SELECT * FROM EMP_TRG_LOG;
INSERT INTO EMP_TRG
VALUES (9999, 'TESTEMP', 'CLERK', 7788, '2024-06-18', 1200, NULL, 20);
COMMIT;
SELECT * FROM EMP_TRG_LOG;
 --DROP TABLE EMP_TRG_LOG;
-- SELECT * FROM EMP_TRG WHERE MGR = 7788;
UPDATE EMP_TRG
SET SAL = 1300
WHERE MGR = 7788;

COMMIT;

SELECT * FROM EMP_TRG_LOG;


-- 함수 
CREATE OR REPLACE FUNCTION TO_YYYYMMDD(DT DATE)
RETURN VARCHAR2
IS
    CHAR_DATE VARCHAR2(20);
BEGIN
    CHAR_DATE := TO_CHAR(DT, 'YYYYMMDD');
    RETURN CHAR_DATE;
END;
/

SELECT TO_YYYYMMDD(SYSDATE) FROM DUAL;

CREATE OR REPLACE FUNCTION GET_AGE(DT DATE)
RETURN NUMBER
IS 
    AGE NUMBER;
BEGIN
    AGE := TRUNC(MONTHS_BETWEEN(                      TRUNC(SYSDATE), 
                                    TO_YYYYMMDD(TO_DATE('20010101', 'YYYYMMDD'))      ) / 12     );
    RETURN AGE;
END;
/

-- SELECT TRUNC(MONTHS_BETWEEN(                      TRUNC(SYSDATE), 
--                                    TO_YYYYMMDD(TO_DATE('20010101', 'YYYYMMDD'))      ) / 12     )
-- FROM DUAL;

-- SELECT TRUNC(SYSDATE) FROM DUAL;
-- SELECT TO_YYYYMMDD(TO_DATE('20010101', 'YYYYMMDD')) FROM DUAL;

SELECT GET_AGE('20010101') FROM DUAL;

CREATE OR REPLACE FUNCTION ADD_NUM( IN_NUM1 INTEGER, IN_NUM2 INTEGER  )
RETURN INTEGER
IS
BEGIN
        RETURN IN_NUM1 + IN_NUM2;
END;
/

SELECT ADD_NUM(23, 2) FROM DUAL;
SELECT COUNT(*) FROM EMP WHERE DEPTNO = 30;
-- 2) 부서번호를 입력하면 해당 부서에서 근무하는 사원 수를 반환하는 함수를 정의하시오.
--   (함수명 get_emp_count)
CREATE OR REPLACE FUNCTION GET_EMP_COUNT( IN_DEPTNO  INTEGER)
RETURN INTEGER
IS 
    CTM NUMBER;
BEGIN 
            SELECT COUNT(*) INTO CTM FROM EMP WHERE DEPTNO  = IN_DEPTNO;
RETURN CTM;
        
END;
/
SELECT COUNT(*) FROM EMP WHERE DEPTNO = 10;   -- 3
SELECT GET_EMP_COUNT(10) FROM DUAL;                   --3

SELECT COUNT(*) FROM EMP WHERE DEPTNO = 20;   --5
SELECT GET_EMP_COUNT(20) FROM DUAL;                   --5

SELECT COUNT(*) FROM EMP WHERE DEPTNO = 30;   --6
SELECT GET_EMP_COUNT(30) FROM DUAL;                   --6
