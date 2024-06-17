--5�� : �� ��Ȯ�ϰ� �پ��ϰ� ����� ����ϴ� WHERE ���� ������

--5-1 PAGE 94
SELECT *
  FROM EMP;

--5-2
SELECT *
  FROM EMP
 WHERE DEPTNO = 30;
 
 -- 1�� ����
 -- �����ȣ�� 7782�� ��������� �������� ������ �ۼ��ϼ���.
 SELECT *
   FROM EMP
  WHERE EMPNO = 7782;
-- '=' �񱳿����� == 

--5-3 AND �����ڷ� �������� ���ǽ��� ����� �� ����
SELECT *
  FROM EMP
 WHERE DEPTNO = 30
   AND JOB = 'SALESMAN';        --  �� ������ AND, OR
   
--�����ȣ�� 7499�̰� �μ���ȣ�� 30�� ��� ������ �������� ������ �ۼ�
SELECT *
  FROM EMP
 WHERE EMPNO = 7499
   AND DEPTNO = 30;
-- �ι�° ��
SELECT *
  FROM EMP
 WHERE EMPNO = 7499;

-- 5-4 OR �����ڷ� �������� ��� ���� ����ϱ�
SELECT *
  FROM EMP
 WHERE DEPTNO = 30
    OR JOB = 'CLERK';
-- 1�� ���� : �μ���ȣ�� 20�̰ų� ������ SALESMAN�� ������� ��� ���� �ۼ�
SELECT *
  FROM EMP
 WHERE DEPTNO = 20
    OR JOB = 'SALESMAN';

-- 5-5 ��������� �޿����� 12�� ���� ���� 36000 �� ���� ���
SELECT *
  FROM EMP
 WHERE SAL * 12 = 36000;

-- 5-6 �񱳿����� : �޿��� 3000 �̻��� ������� ���
SELECT *
  FROM EMP
 WHERE SAL >= 3000;

-- 1�� ���� : �޿��� 2500 �̻��̰� ������ ANALYST�� �� ���
SELECT *
  FROM EMP
 WHERE SAL >= 2500
   AND JOB = 'ANALYST';

-- 5-7 ���ڵ� �� �� �� ����
SELECT *
  FROM EMP
 WHERE ENAME >= 'F';

-- 5-8
SELECT *
  FROM EMP
 WHERE ENAME <= 'FORD';

--5-9 �����ʴ� ('<>', '!=', '^=')
SELECT *
  FROM EMP
 WHERE SAL <> 3000;
 
--5-10 �����ʴ� ('<>', '!=', '^=')
SELECT *
  FROM EMP
 WHERE SAL != 3000; 
 
 --5-11 �����ʴ� ('<>', '!=', '^=')
SELECT *
  FROM EMP
 WHERE SAL ^= 3000;
 
-- 5-12 �� ���� ������
SELECT *
  FROM EMP
 WHERE NOT SAL = 3000;
 
-- 5-13 
-- IN ������ : �߿� ***
-- OR �����ڸ� ��� ���� �� ������ �����ϴ� ������ ���
SELECT * 
FROM EMP
WHERE JOB = 'MANAGER'
   OR JOB = 'SALESMAN'
   OR JOB = 'CLERK';

--5-14
SELECT *
FROM EMP
WHERE JOB IN('MANAGER', 'SALESMAN','CLERK');


--5-15 � �� �����ڿ� AND ���
SELECT *
  FROM EMP
 WHERE JOB != 'MANAGER'
   AND JOB <> 'SALESMAN'
   AND JOB ^= 'CLERK';
-- 5-16
SELECT *
  FROM EMP
 WHERE JOB NOT IN('MANAGER','SALESMAN','CLERK');
-- 1�� ����
SELECT *
  FROM EMP
 WHERE DEPTNO IN (10,20);
 
 -- 5-17 ��� �񱳿�����
 SELECT *
   FROM EMP
  WHERE SAL >= 2000
    AND SAL <= 3000;
    
    
 -- 5-18   BETWEEN  A  AND  B  ���� ���� ��� 
SELECT *
  FROM EMP
 WHERE SAL BETWEEN 2000 AND 3000;  -- >=,   <=
  
 -- 5-19  
SELECT *
  FROM EMP
 WHERE SAL NOT BETWEEN 2000 AND 3000;  -- >=,   <=
 
 
-- LIKE �����ڿ� ���ϵ�ī�� : �ſ� �߿�
-- 5-20 -- �̸��� s�� �����ϴ� ���� ���
SELECT *
  FROM EMP
 WHERE ENAME LIKE 'S%'; -- ���ϵ�ī�� : Ư������ OR ���ڿ� ��ü OR ����
/*
_ : � ���̵� �Ѱ��� ���� �����͸� �ǹ� 
% : ���̿� ��� ���� ��� ���� �����͸� �ǹ�
*/
-- ����̸��� �ι�° ��¥�� L�� ����� ���
-- 5-21
SELECT *
 FROM EMP
WHERE ENAME LIKE '_L%'; -- ù���ڴ� ������ �־���� _  -- L�� �ι�°������ _L -- �ڿ��� ������� _L%

-- ��� �̸��� AM�� ���Ե� ��� ������ ���
-- 5-22
SELECT *
  FROM EMP
 WHERE ENAME LIKE '%AM%';
-- �ݴ�����
SELECT *
  FROM EMP
 WHERE ENAME NOT LIKE '%AM%';
 
 
-- �����ͷ� _�� %���ڰ� ���ԵǾ��ִ� ��찡 ��Ȥ ����
INSERT INTO EMP VALUES
(7999,'A_ADAM','CLERK',    7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
COMMIT;
SELECT * FROM EMP; -- �� �ڷ� Ȯ��

SELECT * FROM EMP WHERE ENAME LIKE 'A_A%'; --�̷��� �̽������� ���ڸ� �������
SELECT * FROM EMP WHERE ENAME LIKE 'A\_A%' ESCAPE '\';


DELETE  FROM EMP WHERE ENAME LIKE 'A\_A%' ESCAPE '\';
COMMIT;
SELECT * FROM EMP;

--1
SELECT * 
  FROM EMPLOYEES
 WHERE FIRST_NAME = 'David';
--2
SELECT *
  FROM JOBS
 WHERE MIN_SALARY = 4000;
--3
SELECT *
  FROM JOBS
 WHERE MIN_SALARY > 8000;
--4
SELECT *
  FROM JOBS
 WHERE MAX_SALARY <= 10000;
--5
SELECT *
  FROM JOBS
 WHERE MIN_SALARY >= 4000 AND MAX_SALARY <=10000;
--6 
SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID = 'IT_PROG' AND SALARY > 5000;
 
 -- 5-24
SELECT ENAME, SAL, SAL * 12 + COMM AS ANNSAL, COMM
  FROM EMP;
 
 --5-25
 SELECT *
   FROM EMP
 WHERE COMM = NULL;  -- ������ �����Ͱ� NULL�� �Էµ� ���� ã�°� (�ƹ��͵� ���� ���°� �ƴ� �Է°��� NULL�ΰ�)
 
 -- 5-26
 SELECT *
   FROM EMP
 WHERE COMM IS NULL; 
 
 SELECT *
  FROM EMP
WHERE COMM IS NOT NULL;


-- 5-27 ���ӻ���� �ִ� ��� �����͸� ���
SELECT *
  FROM EMP
WHERE MGR IS NOT NULL; -- NULL �� �ƴϴ� = �����Ѵ�.

-- 5-28
SELECT *
  FROM EMP
WHERE SAL > NULL -- NULL�� ���� 
    AND COMM IS NULL;

-- 5-29
SELECT *
  FROM EMP
WHERE SAL > NULL
        OR COMM IS NULL;
 
 
 -- ���տ����� : UNION(�ߺ��� ������� �ʴ� ������ = �������� �ѹ��� ��µ�), 
 -- ���տ����� : UNION ALL(�ߺ��� ����ϴ� ������), MINUS (������), INTERSECT(������)
--5-30 
 SELECT EMPNO, ENAME, SAL, DEPTNO 
   FROM EMP
WHERE DEPTNO = 10
UNION -- ������ -- ������, ������ ���ƾ��� (������ ��)
SELECT EMPNO, ENAME, SAL, DEPTNO 
  FROM EMP
WHERE DEPTNO = 20;
 
 -- 5-35
 SELECT EMPNO, ENAME, SAL, DEPTNO 
   FROM EMP
WHERE DEPTNO = 10
UNION ALL -- ������ -- ������, ������ ���ƾ��� (������ ��)
SELECT EMPNO, ENAME, SAL, DEPTNO 
  FROM EMP
WHERE DEPTNO = 10;
 
 --5-36
 SELECT EMPNO, ENAME, SAL, DEPTNO
   FROM EMP
MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
WHERE DEPTNO = 10;
 
 
 -- 5-37
 -- INTERSECT
 SELECT EMPNO, ENAME, SAL, DEPTNO
   FROM EMP
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
WHERE DEPTNO = 10;
 
 -- ������ �켱����
 -- ���� ��  : ��� ( X, /, +, - ��)  >   �񱳿�����(��� �� (>,<), IS NULL, LIKE, IN)    >   BETWEEN >   �� (NOT, AND, OR ...)
 
 
 SELECT *
  FROM EMP
WHERE ENAME LIKE '%S';
 
 SELECT  empno, ename, job, sal, deptno
   FROM  emp
 WHERE deptno = 30
      AND JOB = 'SALESMAN';
 
 SELECT empno, ename, sal, deptno
   FROM EMP
 WHERE deptno in (20,30) -- deptno = 20 OR deptno = 30;
     AND  sal > 2000;
     
SELECT empno, ename, sal, deptno
   FROM EMP
 WHERE deptno = 20 -- deptno = 20 OR deptno = 30;
     AND  sal > 2000     
UNION
SELECT empno, ename, sal, deptno
   FROM EMP
 WHERE deptno = 30 -- deptno = 20 OR deptno = 30;
     AND  sal > 2000;         
     
-------------------
SELECT *
  FROM EMP
WHERE SAL < 2000
        OR SAL > 3000;
     
SELECT ENAME, EMPNO, SAL, DEPTNO
  FROM EMP
WHERE ENAME LIKE '%E%'
     AND DEPTNO = 30
     AND SAL NOT BETWEEN 1000 AND 2000;
 
 
 --Q6
 SELECT *
   FROM EMP
WHERE COMM IS NULL -- ������ ����
     AND MGR IS NOT NULL -- ����� ����
     AND JOB IN ('MANAGER', 'CLERK')
     AND ENAME NOT LIKE '_L%';
 
 -- jobs ���̺��� job_title �������� �����Ͽ� ������ȸ
 SELECT *
   FROM JOBS ORDER BY JOB_TITLE;
 -- countries ���̺��� country_name ���� ������������ �����Ͽ� ��ȸ
 SELECT *
 FROM COUNTRIES ORDER BY COUNTY_NAME DESC;
 -- employees ���̺��� salary�� 10000 ~ 12000 ������ ���� ��ȸ
 SELECT *
   FROM EMPLOYEES 
 WHERE SALARY BETWEEN 10000 AND 12000;
 -- employees ���̺��� job_id�� 'IT_PROG' �� 'ST_MAN'�� ���� ��ȸ
 SELECT *
   FROM EMPLOYEES 
 WHERE JOB_ID IN ('IT_PROG', 'ST_MAN');
 -- employees ���̺��� manager_id�� NULL�� ���� ��ȸ
 SELECT *
   FROM EMPLOYEES
 WHERE MANAGER_ID IS NULL;
 -- departments ���̺��� manager_id�� NULL�� �ƴ� �μ� ��ȸ
 SELECT *
   FROM DEPARTMENTS
 WHERE MANAGER_ID IS NOT NULL;
 -----------------------------------------------------------------------------------------------------------------------------
 -- employees  ���̺��� job_id�� 'AD'�� �����ϴ� ���� ��ȸ
 SELECT *
 FROM EMPLOYEES
 WHERE JOB_ID LIKE 'AD%';
 
 -- employees ���̺���  first_name���� 'ni'�� �����ϴ� ���� ��ȸ
 SELECT *
 FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%ni%';
 -- location ���̺��� location_id, street_address, city�� ���� location_id�� 3000������ �����Ϳ� 2000 �̻��� �����͸� ������(�ߺ�����), ������, ������ �� ��� ��ȸ
 -- ��
 SELECT LOCATIONS.LOCATION_ID, LOCATIONS.STREET_ADDRESS, LOCATIONS.CITY
   FROM LOCATIONS
 WHERE LOCATION_ID >= 2000
UNION ALL
SELECT LOCATIONS.LOCATION_ID, LOCATIONS.STREET_ADDRESS, LOCATIONS.CITY
  FROM LOCATIONS
WHERE LOCATION_ID <= 3000;
-- ��
SELECT LOCATIONS.LOCATION_ID, LOCATIONS.STREET_ADDRESS, LOCATIONS.CITY
   FROM LOCATIONS
 WHERE LOCATION_ID >= 2000
MINUS
SELECT LOCATIONS.LOCATION_ID, LOCATIONS.STREET_ADDRESS, LOCATIONS.CITY
  FROM LOCATIONS
WHERE LOCATION_ID <= 3000;
--��
 SELECT LOCATIONS.LOCATION_ID, LOCATIONS.STREET_ADDRESS, LOCATIONS.CITY
   FROM LOCATIONS
 WHERE LOCATION_ID >= 2000
INTERSECT
SELECT LOCATIONS.LOCATION_ID, LOCATIONS.STREET_ADDRESS, LOCATIONS.CITY
  FROM LOCATIONS
WHERE LOCATION_ID <= 3000;
 
 
 
 
 
 
 
 
 