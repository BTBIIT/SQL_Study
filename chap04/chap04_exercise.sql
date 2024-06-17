--4-1
DESC EMP;


--4-2, 3
DESC DEPT;
DESC SALGRADE;

--4-4
SELECT * FROM EMP;
SELECT * FROM EMP WHERE ROWNUM = 1; -- ��ü���� EMP���̺��� 
-- ROWNUM�� SELECT �ؿ� �����Ϳ� �Ϸù�ȣ�� ���̴� ���̴�.

-- 4-5
SELECT EMPNO, ENAME, DEPTNO -- ���ϴ� �� ���߼��� *
  FROM EMP;                 -- EMP���� 

-- 4-6 �ߺ� ����Ÿ�� �����ϴ� DISTINCT
SELECT DISTINCT DEPTNO
  FROM EMP;

-- 4-7 ���� ������
SELECT DISTINCT DEPTNO, JOB
  FROM EMP;

-- 4-8 ALL �ߺ��Ǵ� �� ���� ���� �״�� ���
SELECT ALL DEPTNO, JOB
  FROM EMP;
  
-- 4-9 ���� ������� ���
SELECT ENAME, SAL, SAL*12+COMM ANNSAL, COMM FROM EMP; -- ����̸� �޿� ���� (��Ī) �μ� 
SELECT ENAME, SAL, SAL*12+COMM "ANNSAL", COMM FROM EMP; -- ��Ī�� ����
SELECT ENAME, SAL, SAL*12+COMM AS ANNSAL, COMM FROM EMP;
SELECT ENAME, SAL, SAL*12+COMM AS "ANNSAL", COMM FROM EMP;
  
-- 4-10 ���� ������� ���
SELECT ENAME, SAL
       , SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL++SAL+SAL+COMM AS ANNSAL -- AS = ��Ī -> AS�� ���� ��ĭ�� ����ִ� �ɷ� �� �� ���� ������ ��κ� AS�� ����
       , COMM    -- �����, �޿�, ����, ����
  FROM EMP;
  
-- 4-11
SELECT ENAME, SAL, SAL*12+COMM AS ANNSAL, COMM FROM EMP;
--4-12 ���ϴ� ������� ��� �����͸� �����ϴ� ORDER BY
SELECT *
FROM EMP
ORDER BY SAL;

-- 4-12 1�� �ǽ� ��� ��ȣ ������ ��Ÿ�����ƶ�
SELECT *
FROM EMP
ORDER BY EMPNO;

-- 4-13 -- �޿� �� �������� : ���� �޴� ��� ��
SELECT *
FROM EMP
ORDER BY SAL DESC;

-- 4-13 �ֱ� �Ի��� ��� �� -- 1�нǽ�
SELECT *
FROM EMP
ORDER BY HIREDATE DESC;

-- 4-14 ������ ���� ���������� ���������� ���ÿ� ���
SELECT *
  FROM EMP
 ORDER BY DEPTNO ASC, SAL DESC; -- ���� DEPTNO(�μ���ȣ)�������� ���ĵ� �����Ϳ��� �� ���� SAL�� �������� ��������

-- 4-15 -- 1�нǽ�
SELECT DISTINCT JOB
FROM EMP;

-- 4-16 -- 1�нǽ�
SELECT EMPNO AS EMPLOYEE_NO
       , ENAME AS EMPLOYEE_NAME
       , JOB
       , MGR AS MANGER
       , HIREDATE 
       , SAL AS SALARY
       , COMM AS COMMISION
       , DEPTNO AS DEPARTMENT_NO
       FROM EMP
       ORDER BY DEPTNO DESC, ENAME;
       
-- ���̺� ��ü ��ȸ
SELECT *
    FROM DEPARTMENTS;
    
    
-- 2. Ư�� �÷��� ��ȸ
SELECT DEPARTMENT_ID
     , DEPARTMENT_NAME
  FROM DEPARTMENTS;

-- 3. ��Ī ����
SELECT DEPARTMENT_ID AS �μ�ID
     , DEPARTMENT_NAME AS �μ��̸�
  FROM DEPARTMENTS;
  
-- 4. �ߺ� ����
SELECT DISTINCT LOCATION_ID
  FROM DEPARTMENTS;
  
-- 5. ��� ����
SELECT FIRST_NAME, LAST_NAME
     , SALARY, SALARY+500
  FROM EMPLOYEES;

SELECT FIRST_NAME, LAST_NAME
     , SALARY, SALARY+500, SALARY * 1.1
     , SALARY -500, SALARY / 1.2
  FROM EMPLOYEES;
  
-- ���� ������ : ||
SELECT DEPARTMENT_ID ||' ' ||DEPARTMENT_NAME AS �μ��̸�-- ���ڿ� ����
    ,  DEPARTMENT_NAME || ' |' || DEPARTMENT_ID || '|' AS �μ���
  FROM DEPARTMENTS;

--1
SELECT *
FROM COUNTRIES;
--2
SELECT COUNTRY_ID, COUNTRY_NAME
FROM COUNTRIES;
--3
SELECT COUNTRY_ID AS "����ID", COUNTRY_NAME AS "������"
FROM COUNTRIES;
--4
SELECT DISTINCT REGION_ID
FROM COUNTRIES;
--5
SELECT COUNTRY_NAME ||'  ' || COUNTRY_ID 
FROM COUNTRIES;

--1
SELECT STREET_ADDRESS, CITY
  FROM LOCATIONS;
--2
SELECT JOB_ID, JOB_TITLE
  FROM JOBS;
--3 
SELECT JOB_TITLE, MIN_SALARY * 1.1 AS "�ּҿ���", MAX_SALARY * 1.1 AS "�ִ뿬��"
  FROM JOBS;
--4
SELECT FIRST_NAME || ' ' || LAST_NAME AS �̸�
  FROM EMPLOYEES;
--5
SELECT DISTINCT JOB_ID
  FROM EMPLOYEES;







