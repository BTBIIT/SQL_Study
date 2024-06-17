-- 7�� ������ �Լ��� ������ �׷�ȭ
-- 7-1
SELECT SUM(SAL)
  FROM EMP;
  
-- 7-2
SELECT ENAME, SUM(SAL) -- ������ ��
  FROM EMP
GROUP BY ENAME ;

SELECT DEPTNO, SUM(SAL) AS SUM -- �μ��� ���� �հ踦 ���� ������.
  FROM EMP;
--GROUP BY DEPTNO;



-- 7-3 ������ �Լ� : �ΰ� ���� ó��
SELECT SUM(COMM) AS "�߰� ���� �հ�"  -- NULL�� �ڵ����� ����ó�� ����, + ������ ������ �ְ� �ʹٸ� "" �� ������ ���������
  FROM EMP;
  
  
-- 7-4
SELECT SUM(DISTINCT SAL)
            , SUM(ALL SAL)
            , SUM(SAL) AS "<- ���� ��"
FROM EMP;

SELECT SAL FROM EMP;

-- 7-5 EMP ���̺� �� ����
SELECT COUNT(COMM)
            , COUNT(MGR)
FROM EMP;

SELECT COUNT(COMM)
            , COUNT(MGR)
            , COUNT(EMPNO)
            , COUNT(*)
            , COUNT(1)
FROM EMP;


-- 7-6 �μ���ȣ�� 30���� ������
SELECT COUNT(*) 
  FROM EMP
WHERE DEPTNO = 30;

--SELECT *
--  FROM EMP
--WHERE DEPTNO = 30;


7-7
SELECT COUNT(DISTINCT SAL) AS "�ߺ��� ���� SAL ��"
            , COUNT(ALL SAL) AS "�ߺ��� ���� SAL ��"
            , COUNT(SAL)        AS " <-  �Ȱ��� ��"
  FROM EMP;  -- NULL �����ʹ� ��ȯ �������� �ڵ� ����
  
  
-- 7-8 (7-9 �� ����)
SELECT COUNT(COMM)
  FROM EMP;  -- 4
  
--7-9
SELECT COUNT(COMM)
  FROM EMP 
WHERE COMM IS NOT NULL; -- 4


-- 7-10
SELECT MAX(SAL), MIN(SAL)
  FROM EMP
WHERE DEPTNO = 10;



--7-12 20�� �μ����� ����� �Ի��� �� �ֱ� �Ի��� ���
SELECT MAX(HIREDATE), MIN(HIREDATE)
  FROM EMP
WHERE DEPTNO = 20;


--7-14
SELECT CEIL(AVG(SAL)) --�ø���
            , FLOOR(AVG(COMM)) -- ������
            , SIGN( 10 -5 )  -- �� �� �� �Ǵ�            [1 = ��         -1 = ��        0 = ����]
            , SIGN( 5-10 )
  FROM EMP
WHERE DEPTNO = 30;

--7-15 DISTINCT �� �ߺ��� ������ �޿� ���� ��� �޿� ���ϱ�
SELECT AVG(DISTINCT SAL)
  FROM EMP
WHERE DEPTNO = 30;

-- 07 -2 �� ��� ���� ���ϴ� ���� ���� ����ϴ� GROUP BY ��
-- 7-16 ���� ������
SELECT CEIL(AVG(SAL)), '10' AS DEPTNO FROM EMP WHERE DEPTNO = 10
UNION
SELECT CEIL(AVG(SAL)), '20' AS DEPTNO FROM EMP WHERE DEPTNO = 20
UNION
SELECT CEIL(AVG(SAL)), '30' AS DEPTNO FROM EMP WHERE DEPTNO = 30;

-- GROUP BY�� ������ �̷��� ���� �� ����
SELECT CEIL(AVG(SAL)), DEPTNO
FROM EMP
GROUP BY DEPTNO;

-- 7-18 �μ���ȣ �� ��å�� ��� �޿�
SELECT DEPTNO, JOB, AVG(SAL)
  FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY  DEPTNO, JOB;
--7-19 GROUP BY ���� ���� ���� SELECT ���� ���� �� ���� �߻�
SELECT DEPTNO, JOB, AVG(SAL)
  FROM EMP
GROUP BY DEPTNO;

--7-20
SELECT DEPTNO
            , JOB
            , CEIL(AVG(SAL) OVER (ORDER BY DEPTNO))
FROM EMP;
-- GROUP BY�� �� �� �� �� �� ����
-- 7-21
SELECT DISTINCT DEPTNO, CHG_SAL
   FROM (
     SELECT DEPTNO
          , CEIL( AVG(SAL) OVER (ORDER BY DEPTNO) ) AS CHG_SAL
       FROM EMP
);

SELECT DEPTNO
            , CEIL(AVG(SAL))
  FROM EMP
GROUP BY DEPTNO;


-- SELECT > FROM > WHERE > GROUP BY 

--7-22
SELECT DEPTNO
            , CEIL(AVG(SAL))
  FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2000     -- WHERE ���� HAVING�� ���� ��� ����
ORDER BY DEPTNO;


--7-23 �޿��� 
SELECT DEPTNO, JOB, AVG(SAL)
  FROM EMP
WHERE SAL <= 3000
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) > 2000;

-- STDEV ǥ������, VARIANCE �л�
--  �߰�����

-- EMPLOYEES ���̺��� SALARY�� 8000�̻��� ������ ���� ��ȸ
SELECT COUNT(*)
  FROM EMPLOYEES
WHERE SALARY > 8000;


-- EMPLOYEES ���̺��� HIRE_DATE�� 2007�� 01�� 01�� ������ ������ ���� ��ȸ
SELECT COUNT(HIRE_DATE)
  FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE) > '2007/01/01';

-- JOBS ���̺��� MAX_SALARY ���� �հ�� ����� ��ȸ
SELECT SUM(MAX_SALARY), AVG(MAX_SALARY)
  FROM JOBS;

-- EMPLOYEES  ���̺��� JOB_ID�� 'IT_PROG'�� ������ SALARY �հ�� ����� ��ȸ
SELECT SUM(SALARY), AVG(SALARY)
  FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

-- EMPLOYEES ���̺��� DEPARTMENT_ID�� 50~80 �� ������ FIRST_NAME, SALARY,
-- �׸��� COMMISION_PCT�� ��� ���� FIRST_NAME ���� �������� ��ȸ(NULL ���� 0���� ġȯ�� ��)

SELECT FIRST_NAME, LAST_NAME ,SALARY
            ,AVG(NVL(COMMISSION_PCT,0)) 
                             OVER (ORDER BY FIRST_NAME) AS COM_AVG
  FROM EMPLOYEES
WHERE DEPARTMENT_ID BETWEEN 50 AND 80;

SELECT first_name, last_name, salary
     , round(avg(nvl(commission_pct,0)) 
             over (order by first_name), 10.2)  com_avg   
     , nvl(commission_pct,0)
  FROM employees
 WHERE department_id between 50 and 80 
   and first_name = 'David'  ;

-- JOBS ���̺��� MAX SALARY �� �ּڰ���  �ִ��� ��ȸ
SELECT MIN(MAX_SALARY), MAX(MAX_SALARY)
  FROM JOBS;
-- JOBS ���̺��� JOB_TITLE 'Programmer'�� ������ Max_Salary ���� �ּڰ��� �ִ��� ��ȸ
SELECT MIN(MAX_SALARY), MAX(MAX_SALARY)
  FROM JOBS
WHERE JOB_TITLE = 'Programmer';

-- Employees ���̺��� Department_id�� 50�� �������� hiredate�� �ּڰ��� �ִ� ��ȸ
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

-- Employees ���̺��� department_id�� 100�� �������� frist_name, salary �׸��� salary�� �л� ���� hire_date ���� �������� ��ȸ

SELECT first_name, salary, 
       VARIANCE(salary) OVER ( ORDER BY hire_date ) 
  FROM employees
 WHERE department_id = 100;






-- 07-4 �׷�ȭ�� ���õ� ���� �Լ� = ROLLUP, CUBE, GROUPING SETS �Լ�
--07-24 ���� GROUP BY ���� ����� �׷�ȭ

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
  FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

-- 07-25 ROLLUP
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
  FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);

 --7-26  CUBE
 SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
  FROM EMP
 GROUP BY CUBE( DEPTNO, JOB )
 ORDER BY DEPTNO, JOB;

-- ROLLUP(A,B)
/******************************
    1. A �׷� �� B �׷� �� �ش��ϴ� ������
    2. A �׷쿡 �ش��ϴ� ��� ���
    3. ��ü ������ ��� ���
*******************************/
-- CUBE(A,B) - �ش� �׸� ��� ����� ���� ��� ���� ��� 2^N ������ ���� N=�׷� ��
/******************************
    1. A �׷� �� B �׷� �� �ش��ϴ� ������
    2. A �׷쿡 �ش��ϴ� ��� ���
    3. B �׷쿡 �ش��ϴ� ��� ���
    3. ��ü ������ ��� ���
*******************************/
-- 7- 27 DEPTNO �� ���� �׷�ȭ�� �� ROLLUP �Լ��� JOB �����ϱ�
SELECT DEPTNO, JOB, COUNT(*)
  FROM EMP
 GROUP BY DEPTNO, ROLLUP(JOB);
 
 SELECT  JOB, DEPTNO, COUNT(*)
  FROM EMP
 GROUP BY JOB, ROLLUP(DEPTNO);
  
  
--7-29 GROUPING SETS �Լ�
SELECT DEPTNO, JOB, COUNT(*)
  FROM EMP
 GROUP BY GROUPING SETS(DEPTNO, JOB)
 ORDER BY DEPTNO, JOB;
 
 -- 7-30 DEPTNO, JOB ���� �׷�ȭ ���� Ȯ��  : GROUPING
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
     , GROUPING(DEPTNO)
     , GROUPING(JOB)
  FROM EMP
 GROUP BY ROLLUP( DEPTNO, JOB );   


SELECT DECODE(GROUPING(DEPTNO), 1, '�Ѱ�', DEPTNO) AS DEPTNO
     , DECODE(GROUPING(JOB), 1, DECODE(GROUPING(DEPTNO),1,' ', '�Ұ�'), JOB) AS JOB
     , COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL)) AS AVG
    -- , GROUPING(DEPTNO)
    -- , GROUPING(JOB)
  FROM EMP
 GROUP BY ROLLUP( DEPTNO, JOB );  
 

SELECT DEPTNO
  FROM EMP
  GROUP BY DEPTNO;
  
-- 7-33
SELECT DEPTNO, ENAME
  FROM EMP
GROUP BY DEPTNO, ENAME;
-- LISTAGG WITHIN Ȱ��
SELECT DEPTNO
            , LISTAGG(ENAME, ',')
              WITHIN GROUP (ORDER BY SAL DESC) AS ENAMES
  FROM EMP
GROUP BY DEPTNO;

-- 7-35 DECODE���� Ȱ���Ͽ� PIVOT �Լ��� ���� ��� ���� -- 11 �������� �߰��� ��
SELECT DEPTNO
            , MAX(DECODE(JOB, 'CLERK', SAL)) AS "CLERK"
            , MAX(DECODE(JOB, 'SALESMAN', SAL)) AS "SALESMAN"
            , MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESIDENT"
            , MAX(DECODE(JOB, 'MANAGER', SAL)) AS "MANAGER"
            , MAX(DECODE(JOB, 'ANALYST', SAL)) AS "ANALYST"
  FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;


-- 7-36 PIVOT �Լ�
SELECT *
  FROM (  SELECT DEPTNO, JOB, SAL           -- ��������
                 FROM EMP  )
  PIVOT (MAX (SAL)
               FOR DEPTNO IN(10,20,30)  )
  ORDER BY JOB;

-- 7-37 �μ��� ��å �ְ� �޿� 2���� ǥ ���·� ���
SELECT *
  FROM (  SELECT JOB, DEPTNO, SAL     
                 FROM EMP  )
  PIVOT (MAX (SAL)
               FOR JOB IN('CLERK' AS "CLERK",
                                    'SALESMAN' AS "SALESMAN",
                                    'PRESIDENT' AS "PRESIDENT",
                                    'MANAGER' AS "MANAGER",
                                    'ANALYST' AS "ANALYST"
               )  )

  ORDER BY DEPTNO;

--7-39
SELECT *
    FROM(
            SELECT DEPTNO
                , MAX(DECODE(JOB, 'CLERK', SAL)) AS "CLERK"
                , MAX(DECODE(JOB, 'SALESMAN', SAL)) AS "SALESMAN"
                , MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESIDENT"
                , MAX(DECODE(JOB, 'MANAGER', SAL)) AS "MANAGER"
                , MAX(DECODE(JOB, 'ANALYST', SAL)) AS "ANALYST"
      FROM EMP
    GROUP BY DEPTNO
    ORDER BY DEPTNO
    )
    
    UNPIVOT(
        SAL FOR JOB IN (CLERK, SALESMAN, PRESIDENT, MANAGER, ANALYST)
    )

;


