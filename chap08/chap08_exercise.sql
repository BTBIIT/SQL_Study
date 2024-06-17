-- 8��  īƼ�� ��
SELECT * FROM EMP; -- 14
SELECT * FROM DEPT; -- 4
SELECT * FROM EMP, DEPT; -- 56��

SELECT *
  FROM EMP, DEPT
ORDER BY EMPNO;

-- 8-2 ���� ����
SELECT *
  FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
ORDER BY EMPNO;

--8-3
SELECT E.EMPNO, E.ENAME, D.DEPTNO,  D.DNAME, D.LOC
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO, E.EMPNO;

SELECT *
FROM JOBS J, JOB_HISTORY H
WHERE J.JOB_ID = H.JOB_ID;

SELECT J.JOB_ID, J.JOB_TITLE, H.START_DATE,  H.END_DATE
FROM JOBS J, JOB_HISTORY H
WHERE J.JOB_ID = H.JOB_ID(+);

SELECT JOB_ID
            , MIN(START_DATE) START_DATE
            , MAX(END_DATE) MAX_DATE
  FROM JOB_HISTORY
GROUP BY JOB_ID;



SELECT J.JOB_ID, J.JOB_TITLE, H.START_DATE,  H.END_DATE
FROM JOBS J
                     , (SELECT JOB_ID
                            , MIN(START_DATE) START_DATE
                            , MAX(END_DATE) END_DATE
                            FROM JOB_HISTORY
                            GROUP BY JOB_ID) H
WHERE J.JOB_ID = H.JOB_ID(+);

SELECT COUNT (*) FROM JOBS;

SELECT * FROM EMPLOYEES;
--
SELECT E.EMPLOYEE_ID, E.LAST_NAME
            , D.DEPARTMENT_NAME
FROM  EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);

SELECT *
  FROM LOCATIONS L;
  
SELECT *
  FROM LOCATIONS L , COUNTRIES C
WHERE L.COUNTRY_ID = C.COUNTRY_ID; -- ��������

SELECT * 
   FROM COUNTRIES;

-- 8-4 �� ���̺��� �����ڵ尡 �����ѹ��ñ�
SELECT COUNTRY_ID
  FROM LOCATIONS L , COUNTRIES C
WHERE L.COUNTRY_ID = C.COUNTRY_ID; --column ambiguously defined = > ��� �ִ� COUNTRY_ID �̴�? ��� ��

SELECT L.COUNTRY_ID
            , C.COUNTRY_ID, C.COUNTRY_NAME
  FROM LOCATIONS L , COUNTRIES C
WHERE L.COUNTRY_ID = C.COUNTRY_ID; --column ambiguously defined = > ��� �ִ� COUNTRY_ID �̴�? ��� ��

-- 8-5
SELECT EMPNO, ENAME, D.DEPTNO, DNAME, LOC
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO, E.EMPNO;

--8-6 �޿��� 3õ �̻��� ���� ������ �μ� ������ ���� ���� ���
SELECT EMPNO, ENAME, D.DEPTNO, DNAME, LOC
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL >=3000;

-- 1�к���, EMP, DEPT ����������
-- �޿��� 2500 �����̰�, �����ȣ�� 9999 ������ ������ ���
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO
            , D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL <= 2500
AND E.EMPNO <= 9999
ORDER BY E.EMPNO;


-- �� ���� : � ���� �̿��� ���
SELECT * FROM EMP;

-- 8-7 �޿� ������ �����ϴ� ���ǽ����� ����
SELECT * 
  FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

SELECT *
  FROM EMPLOYEES E, JOBS J
WHERE E.SALARY BETWEEN J.MIN_SALARY AND J.MAX_SALARY;

SELECT *
  FROM EMPLOYEES E, JOB_HISTORY H
WHERE E.HIRE_DATE BETWEEN H.START_DATE AND H.END_DATE;

-- ��ü ����
SELECT * 
  FROM EMP E;
  
SELECT E.EMPNO, E.ENAME AS "�����", M.ENAME AS "�����ڸ�" 
  FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO;


SELECT E.EMPLOYEE_ID, E.FIRST_NAME || ' ' || E.LAST_NAME AS "�����"
            , E.MANAGER_ID, M.FIRST_NAME || ' ' || M.LAST_NAME AS "�����ڸ�"
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID;



-- 14 �� �ܺ����� ���� ���� ���� ���
SELECT E.EMPNO, E.ENAME AS "�����", M.ENAME AS "�����ڸ�" 
  FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO(+); -- LEFT OUTER JOIN ���ʿ� �������� ��°�

SELECT * FROM EMP E;
-- 8-10
SELECT E.EMPNO, E.ENAME AS "�����", M.ENAME AS "�����ڸ�" 
  FROM EMP E, EMP M
WHERE E.MGR(+) = M.EMPNO; -- RIGHT OUTER JOIN �����ʿ� �������� ��°�



-- COUNTRIES ���̺�� LOCATIONS ���̺��� COUNTRY_ID �������� �����Ͽ�
-- COUNTRY_NAME, STATE_PROVINCE, STREET_ADDRESSF�� ��ȸ
SELECT *
  FROM COUNTRIES C, LOCATIONS L
WHERE C.COUNTRY_ID = L.COUNTRY_ID
ORDER BY C.COUNTRY_NAME, L.STATE_PROVINCE, L.STREET_ADDRESS;

-- JOBS ���̺�� JOB_HISTORY ���̺��� JOB_ID�������� �����Ͽ�
-- JOB_ID, JOB_TITLE, START_DATE, END_DATE�� ��ȸ
SELECT J.JOB_ID, J.JOB_TITLE, H.START_DATE, H.END_DATE
  FROM JOBS J, JOB_HISTORY H
WHERE J.JOB_ID = H.JOB_ID;

-- EMPLOYEES ���̺�� DEPARTEMENTS ���̺��� DEPARTMENT_ID �������� �����ϰ�
-- EMPLOYESS ���̺�� JOBS ���̺��� JOB_ID �������� �����Ͽ�
-- FIRST_NAME, LAST_NAME, DEPARTMENT_NAME, JOB_TITLE�� ��ȸ
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, E.JOB_TITLE
  FROM (SELECT EM.FIRST_NAME, EM.LAST_NAME, EM.DEPARTMENT_ID, J.JOB_ID, J.JOB_TITLE 
                FROM EMPLOYEES EM, JOBS J 
                WHERE EM.JOB_ID = J.JOB_ID) E
                        , DEPARTMENTS  D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;


-- COUNTRIES ���̺�� LOCATIONS ���̺��� LOCATIONS�� COUNTRY_ID�� �������� �ܺ������Ͽ�
-- COUNTRY_ID, COUNTRY_NAME, CITY�� ��ȸ
SELECT C.COUNTRY_ID, C.COUNTRY_NAME, L.CITY
  FROM COUNTRIES C, LOCATIONS L
WHERE C.COUNTRY_ID = L.COUNTRY_ID(+)
ORDER BY C.COUNTRY_ID;

-- EMPLOYEES ���̺�� DEPARTEMENTS ���̺��� DEPARTMENTS ���̺��� DEPARTMENT_ID
-- �������� �ܺ� �����Ͽ� EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_NAME��
-- EMPLOYEE_ID�� �������� �����Ͽ� ��ȸ
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
  FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.EMPLOYEE_ID(+) = D.DEPARTMENT_ID
ORDER BY E.FIRST_NAME, D.DEPARTMENT_NAME;

-- EMPLOYEES ���̺��� MANAGER_ID�� EMPLOYEE_ID�� �������� ��ü ������ ��
-- ������ FIRST_NAME�� LAST_NAME�� �����ϰ�
-- �������� FIRST_NAME �� LAST_NAME�� �����Ͽ�
-- EMPLOYEE_ID�� �������� �����Ͽ� ��ȸ
SELECT E1.FIRST_NAME || ' ' || E1.LAST_NAME AS "�����̸�"
            , E2.FIRST_NAME || ' ' || E2.LAST_NAME AS "�������̸�"
  FROM EMPLOYEES E1, EMPLOYEES E2
WHERE E1.EMPLOYEE_ID = E2.MANAGER_ID
ORDER BY E1.EMPLOYEE_ID;


-- SQL 99 
-- NATURAL JOIN : � ���� ���
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE
            , E.SAL, E.COMM, DEPTNO, D.DNAME, D.LOC
  FROM EMP E NATURAL JOIN DEPT D;       -- � ������ �Ƚ��൵ // �� WHERE ������ ������ �������� �ʾƵ� ����� ��

SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE
            , E.SAL, E.COMM, DEPTNO, D.DNAME, D.LOC
  FROM EMP E NATURAL JOIN DEPT D       -- ����� ó�� ���ָ� ������ ������ ��
ORDER BY DEPTNO, E.EMPNO;


-- JOIN ~ USING
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE
            , E.SAL, E.COMM, DEPTNO, D.DNAME, D.LOC
  FROM EMP E JOIN DEPT D USING (DEPTNO)
WHERE SAL >= 3000
ORDER BY DEPTNO, E.EMPNO;
-- JOIN ~ ON ��� ��
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE
            , E.SAL, E.COMM, E.DEPTNO, D.DNAME, D.LOC
  FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO) -- ���� SELECT�ʿ��� �޴� �κ��� ���� ó�� �������� �Ѵ�.
WHERE SAL >= 3000
ORDER BY DEPTNO, E.EMPNO;

-- ���� ������� ������ ��� �� (��ǥ����) ��� ����� ��
SELECT E.EMPNO, E.ENAME, E.MGR, M.ENAME AS �����ڸ�
  FROM EMP E , EMP M
WHERE E.MGR = M.EMPNO(+);

-- 8-14 �� ����� SQL-99 �ܺ������� ���� ��Ÿ�� ��
SELECT E.EMPNO, E.ENAME, E.MGR, M.ENAME AS �����ڸ�
  FROM EMP E LEFT OUTER JOIN EMP M ON (E.MGR = M.EMPNO); -- 14��
-- ���� ������ �����̸�?
SELECT E.EMPNO, E.ENAME, E.MGR, M.ENAME AS �����ڸ�
  FROM EMP E RIGHT OUTER JOIN EMP M ON (E.MGR = M.EMPNO); -- 21��
-- ���� FULL �����̸�?
  SELECT E.EMPNO, E.ENAME, E.MGR, M.ENAME AS �����ڸ�
  FROM EMP E FULL OUTER JOIN EMP M ON (E.MGR = M.EMPNO); -- 22��
  
  
SELECT E.EMPNO, E.ENAME, E.MGR, M.ENAME AS �����ڸ� , D.DNAME
  FROM EMP E LEFT OUTER JOIN EMP M ON (E.MGR = M.EMPNO)
    JOIN  DEPT D ON (E.DEPTNO = D.DEPTNO);
    
    
    
    
-- 1�� ����
-- JOIN ~ USING         EMP, DEPT ���� SQL 99 ��� DEPTNO
-- �޿��� 3000 �̻��̸�, ���� ����� �ݵ�� �־�� �մϴ�.
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM
            , D.DNAME, D.LOC
  FROM EMP E  JOIN DEPT D USING (DEPTNO)
WHERE E.SAL >= 3000 AND E.MGR IS NOT NULL
ORDER BY DEPTNO, E.EMPNO;

--239PAGE
-- 08-practice 01 �� SQL-99 ��� ����
SELECT E.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)   -- FROM ������ EMP�� DEPT�� ���� �� JOIN ON���� ���� ������ ��� �� ����
WHERE SAL > 2000                                                                    -- WHERE ������ �� ������ ���ؼ��� ���͸��ϸ� ������ ����
ORDER BY E.DEPTNO;

-- 08-practice 01�� SQL-99��� ������
SELECT E.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO                                             -- WHERE ������ DEPTNO�� ���� ��쿡 ���ؼ� ������ �ɾ���
AND SAL > 2000                                                                        -- ���� AND ������ ���� �߰����� ������ �ɾ 2000 �޷� �̻��� ��쿡�� ���
ORDER BY E.DEPTNO;

--08 practice 02�� SQL-99 ��� ����
SELECT E.DEPTNO, D.DNAME, ROUND(AVG(E.SAL),0) AS AVG_SAL
            , MAX(E.SAL) AS MAX_SAL
            , MIN(E.SAL) AS MIN_SAL
            , COUNT(*) AS CNT
  FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
GROUP BY E.DEPTNO, D.DNAME;
--SQL-99 ���(2)
SELECT DEPTNO,
       D.DNAME,
       TRUNC(AVG(SAL)) AS AVG_SAL,
       MAX(SAL) AS MAX_SAL,
       MIN(SAL) AS MIN_SAL,
       COUNT(*) AS CNT
  FROM EMP E JOIN DEPT D USING (DEPTNO)
GROUP BY DEPTNO, D.DNAME;
--08 practice 02�� SQL-99 ��� ������ -- ���� �ʿ�ڡڡ�
SELECT E.DEPTNO, D.DNAME, ROUND(AVG(E.SAL),0) AS AVG_SAL
            , MAX(E.SAL) AS MAX_SAL
            , MIN(E.SAL) AS MIN_SAL
            , COUNT(*) AS CNT
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
GROUP BY E.DEPTNO, D.DNAME;

--08 practice 03�� SQL-99 ��� ���� 
-- ������ �ܺ������� �̿��ϴ� ������� DEPT D�� ����� �ϴ� ��� ���� RIGHT JOIN (���� ������)�� ��
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
  FROM EMP E RIGHT JOIN  DEPT D ON (E.DEPTNO = D.DEPTNO)
ORDER BY E.DEPTNO;

--08 practice 03�� SQL-99 ��� ������ 
-- ���� SQL - 99�� �ƴ� ������� �ڵ��Ҷ� ����� �Ǵ� �ʿ� +�� �ٿ�����
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
  FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO
ORDER BY E.DEPTNO;

--08-practice 04�� -- ���� �ʿ�ڡڡ�
--SQL-99���
SELECT D.DEPTNO, D.DNAME
          , E.EMPNO, E.ENAME, E.MGR, E.SAL, E.DEPTNO
          , S.LOSAL, S.HISAL, S.GRADE
          , E2.EMPNO AS MGR_EMPNO
          , E2.ENAME AS MGR_ENAME
  FROM EMP E RIGHT OUTER JOIN DEPT D 
                ON (E.DEPTNO = D.DEPTNO)                            -- ���ؿ��� DEPT ���� ���������ϸ鼭
              LEFT OUTER JOIN SALGRADE S                           -- ���ÿ� SALGRADE�� EMP�� �������ķ� �����
                ON (E.SAL BETWEEN S.LOSAL AND S.HISAL)  -- E.SAL�� ������ S,LOSAL ~ S.HISAL ���� ��
              LEFT OUTER JOIN EMP E2                                    -- ���� �Ȱ��� ���� ȣ���Ͽ�  �����ȣ�� EMPNO �� �������� ȣ��
                ON (E.MGR = E2.EMPNO)                                  -- E.MGR (���)�� E2.EMPNO(���)�� ���� ����
ORDER BY D.DEPTNO, E.EMPNO;                                     -- ���� DEPTNO�� EMPNO�� ���Ͽ� ����

--SQL-99 ���� ��� -- �� ����� �� �� �������� �ִµ�...
SELECT D.DEPTNO, D.DNAME,
       E.EMPNO, E.ENAME, E.MGR, E.SAL, E.DEPTNO,
       S.LOSAL, S.HISAL, S.GRADE,
       E2.EMPNO AS MGR_EMPNO, E2.ENAME AS MGR_ENAME
  FROM EMP E, DEPT D, SALGRADE S, EMP E2                 -- 4������ ������
WHERE E.DEPTNO(+) = D.DEPTNO                                     -- E.DEPTNO�� D.DEPTNO�� ����
     AND E.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)       -- �׸��� E.SAL�� ������ S.LOSAL�� S.HISAL ���� ��
     AND E.MGR = E2.EMPNO(+)                                           -- �׸��� E,MGR = E2.EMPNO��
ORDER BY D.DEPTNO, E.EMPNO;                                       -- �̷��� �� ���̺��� D.DEPTNO�� E.EMPNO�� ���� ������
