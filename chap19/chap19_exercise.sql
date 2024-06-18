-- chapter19
-- 19�� ���� �������α׷�
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

-- ���� : EXCUTE  /  EXEC ���ɾ� ���
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

EXECUTE PRO_PARAM_IN(1,2);        -- DEFALUT ���� �������־��� ������ ������ ���� ����
--  19-11 �Ķ���� �̸��� Ȱ���Ͽ� ���ν����� �� �Է��ϱ�
EXECUTE PRO_PARAM_IN(PARAM2 => 20, PARAM1 => 10);

-- OUT ��� �Ķ���� �����ϱ�
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
-- 19-14 IN - OUT ���
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
    ERR_NO := 100;     -- := �� ���־���ϴµ� = �� ��
    DBMS_OUTPUT.PUT_LINE('ERR_NO  : ' ||  ERR_NO);
END;
/
SHOW ERROR;

SELECT *
    FROM USER_ERRORS
WHERE NAME = 'PRO_ERR';


-- ���� ��� ��� ���ν���
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


-- IF   ELSE �� ��� ���ν���
CREATE OR REPLACE PROCEDURE IF_SALARY
(
    SALARY IN NUMBER
)
AS
    AVG_SALARY NUMBER;
BEGIN
    SELECT AVG(SAL) INTO AVG_SALARY FROM EMP;
    
    IF SALARY >= AVG_SALARY THEN
        DBMS_OUTPUT.PUT_LINE('��� �̻�');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('��� �̸�');
    END IF;
END; 
/

EXECUTE IF_SALARY(2000);

SELECT HIRE_DATE, EMAIL
  FROM EMPLOYEES;
  
-- CASE ����� PROCEDURE
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
              WHEN (HIRE_YEAR = '01') THEN TEXT_MSG := HIRE_YEAR || '�⵵�� �Ի�';
              WHEN (HIRE_YEAR = '02') THEN TEXT_MSG := HIRE_YEAR || '�⵵�� �Ի�';
              WHEN (HIRE_YEAR = '03') THEN TEXT_MSG := HIRE_YEAR || '�⵵�� �Ի�';
              WHEN (HIRE_YEAR = '04') THEN TEXT_MSG := HIRE_YEAR || '�⵵�� �Ի�';
              WHEN (HIRE_YEAR = '05') THEN TEXT_MSG := HIRE_YEAR || '�⵵�� �Ի�';
              WHEN (HIRE_YEAR = '06') THEN TEXT_MSG := HIRE_YEAR || '�⵵�� �Ի�';
              WHEN (HIRE_YEAR = '07') THEN TEXT_MSG := HIRE_YEAR || '�⵵�� �Ի�';
              WHEN (HIRE_YEAR = '08') THEN TEXT_MSG := HIRE_YEAR || '�⵵�� �Ի�';
              WHEN (HIRE_YEAR = '09') THEN TEXT_MSG := HIRE_YEAR || '�⵵�� �Ի�';
              ELSE TEXT_MSG := '01 ~ 09 �⵵ �̿ܿ� �Ի�';
    END CASE;
    DBMS_OUTPUT.PUT_LINE(TEXT_MSG);
END;
/

SELECT * FROM EMPLOYEES WHERE EMAIL = 'SKING';
EXECUTE CASE_HIREDATE('SKING');

-- IN OUT �Ķ���� 
CREATE OR REPLACE PROCEDURE IN_OUT_EMP
(
    EMP_NAME IN OUT VARCHAR2
)
AS
BEGIN
        SELECT FIRST_NAME || ' ' || LAST_NAME INTO EMP_NAME
          FROM EMPLOYEES
        WHERE FIRST_NAME = EMP_NAME OR LAST_NAME = EMP_NAME;
          EMP_NAME := '���� : '  || EMP_NAME;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
              EMP_NAME := '���� : ����';
END;
/

DECLARE
    EMP_NAME VARCHAR2(20)  := 'Kang';
BEGIN
    IN_OUT_EMP(EMP_NAME);
    
    DBMS_OUTPUT.PUT_LINE(EMP_NAME);
END;


--  CURSOR�� �̿��� EMPLOYEES ���̺��� JOB_ID�� IT_PROG�� ������ FIRST_NAME�� LAST_NAME�� ������ �ΰ� �����Ͽ� ����ϴ� ���ν��� ����
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

-- Q1 IF ELSIF ELSE ���� ����Ͽ� JOBS ���̺��� ����, �ִ� SALARY ��� ���� �̿��Ͽ� 
-- �Է¹��� SALARY�� ���� ��� �������� �ִ� ����̻����� ��� �������� ����ϴ� ���ν��� ����
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
        DBMS_OUTPUT.PUT_LINE('���� ��� ����');
    ELSIF SALARY >= MAXSALARY THEN
        DBMS_OUTPUT.PUT_LINE('�ִ� ��� �̻�');
    ELSE
        DBMS_OUTPUT.PUT_LINE('��� ����');
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

SELECT LENGTHB('�ȳ�') FROM DUAL;
-- AL32UTF8 �ѱ� 3BYTE
-- KO16KSC5601  : �ϼ��� �ѱ� 2BYTE
-- KO16MSWIN949 : ������ �ѱ� 2BYTE


--  19-19 �Լ� ����ϱ�
CREATE OR REPLACE FUNCTION FUNC_AFTERTAX
(
        SAL IN NUMBER
)
RETURN NUMBER       -- �����ڷ���

IS  
        TAX NUMBER  :=  0.05;
BEGIN
        RETURN    ROUND(SAL - (SAL * TAX));
           
END FUNC_AFTERTAX;
/

SELECT FUNC_AFTERTAX(3000) FROM DUAL;

SELECT ENAME, SAL BEFORESAL, FUNC_AFTERTAX(SAL) AS AFTERSAL
  FROM EMP;
---- ��� �Ϥ���

-- ��Ű�� �����ϱ�
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

-- ��Ű�� ���� �����ϱ�
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

-- ���ν��� �����ε� �ϱ�
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


-- �ǽ� 19-30

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

-- �ǽ� 19-31 --
SELECT TO_CHAR(sysdate, 'DY') FROM DUAL;

CREATE TABLE EMP_TRG
    AS SELECT * FROM EMP;

SELECT * FROM EMP_TRG;

CREATE OR REPLACE TRIGGER NODML_WEEKEND
BEFORE
INSERT OR UPDATE OR DELETE ON EMP_TRG
BEGIN
        IF TO_CHAR(SYSDATE, 'DY') IN ('��','��') THEN
              IF INSERTING THEN
                  RAISE_APPLICATION_ERROR(-20000, '�ָ� ������� �߰� �Ұ�');
            ELSIF UPDATING THEN
                  RAISE_APPLICATION_ERROR(-20001, '�ָ� ������� ���� �Ұ�');
            ELSIF DELETING THEN
                  RAISE_APPLICATION_ERROR(-20002, '�ָ� ������� ���� �Ұ�');
           ELSE
                  RAISE_APPLICATION_ERROR(-20003, '�ָ� ������� ���� �Ұ�');
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
    TABLE_NAME VARCHAR2(10),    -- DML ����� ���̺� �̸�
    DML_TYPE VARCHAR2(10),          -- INSERT, UPDATE, DELETE 
    EMPNO NUMBER(4),                          -- DML ����� �� ��� ��ȣ
    USER_NAME VARCHAR2(30),        -- DML�� ������ USER �̸�
    CHANGE_DATE DATE                    -- DML ����� ��¥
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


-- �Լ� 
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
-- 2) �μ���ȣ�� �Է��ϸ� �ش� �μ����� �ٹ��ϴ� ��� ���� ��ȯ�ϴ� �Լ��� �����Ͻÿ�.
--   (�Լ��� get_emp_count)
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