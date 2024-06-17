-- 6 �� 
-- ���� �����͸� �����ϴ� �����Լ� page 130
-- 6-1  
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
 FROM EMP;
 
 
 -- 6-2
 SELECT *
   FROM EMP
 WHERE UPPER(ENAME) = UPPER('scott'); -- �ҹ��ڷ� �ȿ� �Է��ص� UPPER �Լ��� �޾� �빮�ڰ� ��
 
 SELECT *
   FROM EMP
WHERE LOWER(ENAME) = LOWER('SCOTT'); -- ���� ����

-- 6-3
SELECT *
  FROM EMP
WHERE UPPER(ENAME) LIKE UPPER('%Scott%'); -- LIKE�� ���� ����ϴ� ��찡 ����

-- 6-4 : ���ڿ� ���̸� ���ϴ� LENGTH �Լ�
SELECT ENAME, LENGTH(ENAME)
  FROM EMP;
  
--6-5 : ��� �̸��� ���̰� 5 �̻��� ���� ����Ͻÿ� -> WHERE ������ LENGTH�Լ��� ����� �� ����
 SELECT ENAME, LENGTH(ENAME)
   FROM EMP
 WHERE LENGTH(ENAME) >= 5;

-- 6-6
SELECT LENGTH('�ѱ�'), LENGTHB('�ѱ�')
  FROM DUAL;

SELECT SYSDATE FROM DUAL;


-- ��å �̸��� 6���� �̻��� ������ ��� ���� �ۼ�
SELECT JOB, LENGTH(JOB)
  FROM EMP
WHERE LENGTH(JOB) >=6;


-- ���ڿ� �Ϻθ� �����ϴ� SUBSTR �Լ� SUBSTR(�÷���, ������ġ, �������) �Լ�
SELECT JOB, SUBSTR(JOB, 1, 2) -- NUMBERING�� 1���� ���� ���� 0�� �ƴ� 1���� ����
  FROM EMP;

--6-7
SELECT JOB, SUBSTR(JOB, 1, 2) -- NUMBERING�� 1���� ���� ���� 0�� �ƴ� 1���� ����
            --, SUBSTR(JOB, 3, 2) -- 3��°���� 2����
            --, SUBSTR(JOB, 5) -- ������ ���̸� �������� ������ ���δ� ������
            , SUBSTR(JOB, -5) -- �ڿ������� ������ġ�� COUNT �� -5���� ������ 
  FROM EMP;

SELECT JOB
            , SUBSTR(JOB, -LENGTH(JOB)) -- ó������ ������ �߶������
            , SUBSTR(JOB, -LENGTH(JOB),2) -- ó������ 2����
            , SUBSTR(JOB, -3) -- �ڿ��� 3��°���� ������
  FROM EMP;

-- INSTR
SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1
            , INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_1 -- ������ ��ġ ã��  5��°���� ã�Ƽ� �� ���� L�� ������ ��ġ ��ȯ
            , INSTR('HELLO, ORACLE!', 'L',2,2) AS INSTR_1 --4 2��°���� ã�Ƽ� 2��°�� L�� ������ ��ġ ��ȯ
  FROM DUAL;


-- 6-10
SELECT *
  FROM EMP
WHERE INSTR(ENAME, 'S') > 0 ;

-- 6-11
SELECT *
  FROM EMP
WHERE ENAME LIKE '%S%';

-- 6-12  REPLACE
SELECT '010-1234-5678' AS REPLACE_BEFORE
              ,REPLACE('010-1234-5678', '-', ' ') AS REPLACE_1
              ,REPLACE('010-1234-5678','-') AS REPLACE_2
  FROM DUAL;
  
  
  -- LPAD, RPAD
SELECT 'Oracle'
            , LPAD('Oracle', 10,'#') AS LPAD_1
            , RPAD('Oracle', 10, '*') AS RPAD1
            , LPAD('Oracle', 10) AS LPAD_1
            , RPAD('Oracle', 10) AS RPAD1
  FROM DUAL;

-- 6-14 �������� ����ŷ ó��
-- SUBSTR(JUMIN, 1, 7)
SELECT RPAD('971225-', 14, '*') AS RPADF_MNO
            , RPAD('010-1234-', 13, '*') AS RPAD_PHONE
  FROM DUAL;

-- 6-15 �� �� ���̿� ������ ||
SELECT CONCAT(EMPNO, ENAME)
            , CONCAT(EMPNO, CONCAT(' | ', ENAME))
            , EMPNO || ' | ' || ENAME
  FROM EMP
WHERE DEPTNO = 10;

-- 6-16
SELECT TRIM('      __Oracle__          ') as T  --  TRIM = ��������
            , TRIM(LEADING FROM '      __Oracle__          ') AS LTRIM  -- ���� ���� ����
            , TRIM(TRAILING FROM '      __Oracle__          ') AS RTRIM -- ���� ���� ����
            , TRIM(BOTH FROM '      __Oracle__          ') AS TRIM          -- ���� ���� ����
  FROM  DUAL;


-- 6-17
SELECT TRIM('_' FROM '__Oracle__') as T  --  TRIM = _ ����
            , TRIM(LEADING '_' FROM '__Oracle__') AS LTRIM  -- ���� _ ����
            , TRIM(TRAILING '_' FROM '__Oracle__') AS RTRIM -- ���� _ ����
            , TRIM(BOTH '_' FROM '__Oracle__') AS TRIM          -- ���� _ ����
  FROM  DUAL;
  
  -- 6-18
SELECT TRIM('      __Oracle__          ') as T  --  TRIM = ��������
            , LTRIM( '      __Oracle__          ') AS LTRIM  -- ���� ���� ����
            , RTRIM('      __Oracle__          ') AS RTRIM -- ���� ���� ����
            , LTRIM( '__Oracle__','_') AS LTRIM  -- ���� ���� ����
            , RTRIM('__Oracle__','_') AS RTRIM -- ���� ���� ����
FROM DUAL;
            
            
-- jobs ���̺��� job_title�� �ҹ��ڿ� �빮�ڷ� ��ȯ�� job_title�� ��ȸ
SELECT UPPER(JOB_TITLE), LOWER(JOB_TITLE)
  FROM JOBS;
-- employees ���̺��� first_name ù 1 ���ڿ� last_name ��ȸ
SELECT SUBSTR(FIRST_NAME,1,1), LAST_NAME
  FROM EMPLOYEES;
-- employees ���̺��� job_id�� 'REP' �� �κ��� 'REPRESENTATIVE'�� �ٲ㼭 ��ȸ
SELECT REPLACE(JOB_ID,'REP','REPRESENTATIVE')
  FROM EMPLOYEES;
-- employees  ���̺��� first_name ù 1���ڿ� last_name�� �߰��� ������ �ΰ� �ϳ��� �����Ͽ� ��ȸ
SELECT CONCAT(SUBSTR(FIRST_NAME,1,1), CONCAT(' ',LAST_NAME))
  FROM EMPLOYEES;
-- employees ���̺��� first_name�� last_name�� ���̸� ���ļ� ��ȸ
SELECT LENGTH(FIRST_NAME) + LENGTH(LAST_NAME) AS SUM
  FROM EMPLOYEES;
-- employees ���̺��� job_id�� job_id�� 'A' ���� ��ġ  ��ȸ  
SELECT JOB_ID, INSTR(JOB_ID, 'A')
  FROM EMPLOYEES;
-- locations ���̺� city�� 15�ڸ� ���ڿ��� �ٲٰ�, �� ������ '.'���� ǥ���Ͽ� ��ȸ
SELECT LPAD(CITY, 15, '.'), RPAD(CITY, 15, '.')
  FROM LOCATIONS;
-- locations ���̺��� city�� ���ʺ��� 'S'���ڸ� ���� �Ͱ� �����ʺ��� 'e' ���ڸ� ���� ����� ��ȸ
SELECT CITY, LTRIM(CITY, 'S'), RTRIM(CITY,'e')
FROM LOCATIONS
WHERE CITY LIKE 'S%' OR CITY LIKE '%e';
  
  
  --06 - 3�� ���� �Լ�
SELECT ROUND(1234.5678)     AS ROUND -- �Ҽ��� ù° �ڸ����� �ݿø� ���ּ���.
            , ROUND(1234.5678,0) AS ROUND -- �Ҽ��� ù° �ڸ����� �ݿø� ���ּ���.
            , ROUND(1234.5678,1) AS ROUND -- �Ҽ��� ��° �ڸ����� �ݿø� ���ּ���.
            , ROUND(1234.5678,2) AS ROUND -- �Ҽ��� ��° �ڸ����� �ݿø� ���ּ���.
            , ROUND(1234.5678,-1) AS ROUND -- �ڿ��� ù° �ڸ����� �ݿø� ���ּ���.
            , ROUND(1234.5678,-2) AS ROUND -- �ڿ��� ��° �ڸ����� �ݿø� ���ּ���.
  FROM DUAL;
  
    --06 - 3�� ���� �Լ�
SELECT TRUNC(1234.5678)     AS TRUNC -- �Ҽ��� ù° �ڸ����� ���� ���ּ���.
            , TRUNC(1234.5678,0) AS TRUNC1 -- �Ҽ��� ù° �ڸ����� ���� ���ּ���.
            , TRUNC(1234.5678,1) AS TRUNC1 -- �Ҽ��� ��° �ڸ����� ���� ���ּ���.
            , TRUNC(1234.5678,2) AS TRUNC2 -- �Ҽ��� ��° �ڸ����� ���� ���ּ���.
            , TRUNC(1234.5678,-1) AS TRUNC_M1 -- �ڿ��� ù° �ڸ����� ���� ���ּ���.
            , TRUNC(1234.5678,-2) AS TRUNC_M2 -- �ڿ��� ��° �ڸ����� ���� ���ּ���.
  FROM DUAL;
  
  -- 6-21
SELECT CEIL(3.14) -- �����ڸ����� �ø�
            , FLOOR(3.14) -- �����ڸ����� ����
            , CEIL(-3.14)
            , FLOOR(-3.14)
  FROM DUAL;
-- 6-22 ������ �Լ�
SELECT MOD(15,6) -- 3
            , MOD(10, 2) --0
            , MOD(11, 2) --1
  FROM DUAL;
  
  
  -- ��¥ �Լ�
-- 6-23
SELECT SYSDATE AS NOW
     , SYSDATE -1 AS YESTERDAY
     , SYSDATE +1 AS TOMORROW
  FROM DUAL;
-- 6-24
SELECT SYSDATE
           , ADD_MONTHS (SYSDATE,4) + 17
 FROM DUAL;
  
SELECT 12 * 38 FROM DUAL;
--6-25 �Ի� 10�ֳ�
SELECT EMPNO, ENAME, HIREDATE,
       ADD_MONTHS(HIREDATE, 120) AS WORK10YEAR
  FROM EMP;
SELECT  12 * 38 FROM DUAL;  -- 456

SELECT EMPNO, ENAME, HIREDATE,
       ADD_MONTHS(HIREDATE, 456) AS WORK38YEAR
  FROM EMP;
 
 -- 6- 26 �Ի� 38�� �̸��� ��� 
SELECT EMPNO, ENAME, HIREDATE,
       ADD_MONTHS(HIREDATE, 456) AS WORK38YEAR
  FROM EMP
 WHERE ADD_MONTHS(HIREDATE, 456) > SYSDATE;
  
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3) EMPL
  FROM DUAL;

-- 6-27
SELECT EMPNO, ENAME, HIREDATE, SYSDATE
    , MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS
    , TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS2
  FROM EMP;
  
 -- 6-28
SELECT SYSDATE
            , NEXT_DAY(SYSDATE, '������')
            , LAST_DAY(SYSDATE)
  FROM DUAL;
  
-- 6-29
SELECT SYSDATE
            , ROUND(SYSDATE, 'YYYY') AS FYYYY
            , ROUND(SYSDATE, 'Q') AS FYYYY
            , ROUND(SYSDATE, 'DDD') AS FYYYY
            , TRUNC(ROUND(SYSDATE, 'YYYY')) AS FYYYY
            , TRUNC(ROUND(SYSDATE, 'Q')) AS FYYYY
            , TRUNC(ROUND(SYSDATE, 'DDD')) AS FYYYY
  FROM DUAL;

SELECT SYSDATE
            , TRUNC(ROUND(SYSDATE, 'YYYY')) AS FYYYY
            , TRUNC(ROUND(SYSDATE, 'Q')) AS FYYYY
            , TRUNC(ROUND(SYSDATE, 'DDD')) AS FYYYY
  FROM DUAL;

  
-- 6-33  
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS')
            , TO_CHAR(SYSDATE, 'DAY') DAY
            , TO_CHAR(SYSDATE, 'DY') DY
            , TO_CHAR(SYSDATE, 'DD') DD
            , TO_CHAR(SYSDATE, 'MONTH') MONTH
            , TO_CHAR(SYSDATE, 'MON') MON
            , TO_CHAR(SYSDATE, 'MM') MM
  FROM DUAL;
  
  
  -- 6-34
SELECT TO_CHAR(SYSDATE, 'MM') MM
            , TO_CHAR(SYSDATE, 'MON') MON
            , TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') MON_JEN
            , TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH') MON_ENG
FROM DUAL;
  
  
-- 6-38 ��������
SELECT SAL, TO_CHAR(SAL, '999,999') SAL_1
     , TO_CHAR(SAL, '$999,999') SAL_1
     , TO_CHAR(SAL, 'L999,999') SAL_1
     , TO_CHAR(SAL, '0009999999') SAL_2
  FROM EMP;

-- ���ڿ� �� ���ڷ�  
SELECT TO_NUMBER('1,300', '999,999')  
     - TO_NUMBER('1,500', '999,999')
  FROM DUAL;

-- ���ڿ��� ��¥ ����Ÿ ��ȯ
SELECT TO_DATE('2024-06-05', 'YYYY-MM-DD') AS TODATE
     , TO_DATE('20240605', 'YYYY-MM-DD') AS TODATE2
  FROM DUAL;
   
-- 6-45
SELECT EMPNO, ENAME, SAL, COMM
     , SAL*12+NVL(COMM,0) AS ANNSAL
     , NVL2(COMM, '�ξƴ�', '����') N2
     --         �����ִٸ�, ������
     , NVL2(COMM, SAL*12+COMM, SAL*12) ANN_SAL
  FROM EMP;
   
   
 --6-47
SELECT EMPNO, ENAME, JOB, SAL
            , DECODE(JOB, 'MANAGER', SAL * 1.1,
                                        'SALESMAN', SAL * 1.05,
                                        SAL * 1,03) AS UPSAL
  FROM EMP;
   
SELECT EMPNO, ENAME, JOB, SAL
            , DECODE(JOB, 'MANAGER', SAL * 1.1,
                                        'SALESMAN', SAL * 1.05,
                                        'ANALYST', SAL,
                                        SAL * 1.03) AS UPSAL
  FROM EMP;   
   
-- CASE ��
SELECT EMPNO, ENAME, JOB, SAL
            , CASE JOB
                    WHEN 'MANAGER' THEN SAL * 1.1
                    WHEN 'SALESMAN' THEN SAL * 1.05
                    WHEN 'ANALYST' THEN SAL
                    ELSE SAL * 1.03
              END AS UPSAL
  FROM EMP;

SELECT EMPNO, ENAME, COMM
            , CASE WHEN COMM IS NULL THEN '�ش���� ����'
                         WHEN COMM = 0 THEN '���� ����'
                         WHEN COMM  > 0 THEN '���� :  ' || COMM
              END AS COMM_TEXT
  FROM EMP;

-- 174 PAGE -Q1
SELECT EMPNO,
              RPAD(SUBSTR(EMPNO, 1, 2), 4, '*') AS MASKING_EMPNO,
              ENAME,
              RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS MASKING_ENAME
FROM  EMP
 WHERE LENGTH(ENAME) >= 5
   AND LENGTH(ENAME) < 6; 


-- 174 PAGE -Q2
SELECT EMPNO, ENAME, SAL
            , TRUNC((SAL/21.5),2) AS DAY_PAY
            , ROUND((SAL/21.5)/8,1) AS TIME_PAY
FROM EMP;

-- 175 PAGE -Q3
SELECT EMPNO, ENAME, HIREDATE
            , TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE,3), '������'),'YYYY-MM-DD') AS R_JOB
            , NVL(TO_CHAR(COMM), 'N/A') AS COMM
  FROM EMP;

-- 175 PAGE -Q4
SELECT EMPNO, ENAME
            ,NVL(TO_CHAR(MGR), '  ') AS MGR
            ,CASE WHEN MGR IS NULL THEN '0000'
                        WHEN SUBSTR(MGR, 1,2) = 75 THEN '5555'
                        WHEN SUBSTR(MGR, 1,2) = 76 THEN '6666'
                        WHEN SUBSTR(MGR, 1,2) = 78 THEN '8888'
                        --ELSE SUBSTR(MGR, - LENGTH(MGR)) 
                        ELSE TO_CHAR(MGR)
               END AS CHG_MGR
FROM EMP;





