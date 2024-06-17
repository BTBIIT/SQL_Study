-- 9�� ��������
-- 9-1 JONES�� ����� �޿� ���
SELECT SAL
  FROM EMP
WHERE ENAME = 'JONES';

-- 9-2 �޿��� 2975���� ���� ��� ���� ���
SELECT *
  FROM EMP
WHERE SAL > 2975;

 -- �̴� ������ ����
 SELECT *
   FROM EMP
WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'JONES');

-- �������� Ư¡
-- 1. ��ȣ�� ���������
-- 2. Ư���� ��� ���� ������������ ORDER BY�� ����� �� ���� -- > ������ ������
-- 3. �������� �񱳴��� ������ ������ �ڷ��� ���
-- 4. ���������� ������, �������̳Ŀ� ���� ������ ���
SELECT *
  FROM EMPLOYEES
 WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEES
               WHERE FIRST_NAME = 'Adam') ;  -- David ������ ����
-- 1�� ���� -- ������� �߿��� ��� �̸��� ALLEN�� ����� �߰����纸�� ���� �߰������� �޴� ��� ����
SELECT *
  FROM EMP 
WHERE COMM > (SELECT COMM FROM EMP WHERE ENAME = 'ALLEN');

-- 9-4
SELECT *
  FROM EMP
WHERE HIREDATE < (SELECT HIREDATE FROM EMP WHERE ENAME = 'SCOTT');
-- �������� Ư¡
-- �������� �����ڴ� ���� �� �Ǵ� ��ȸ ����� �����ʿ� ���̸� ��ȣ()�� ��� ���
-- ���������� SELECT ���� ����� ���� ���������� �� ���� ���� �ڷ����� ���� ������ ����
-- �� ���������� �� ��� �����Ͱ� �ϳ��� ���������� SELECT�� ���� ���� �ڷ����� ���� �ϳ� ����
-- ���������� �ִ� SELECT���� ��� ����� �Բ� ����ϴ� ���������� ������ ������ ȣȯ �����ؾ� ��
-- ���� �� ���������� ����� �����ڰ� �� �ϳ��� �����ͷθ� ������ ������ �����ڶ�� ���������ǰ�� �� ���� �ݵ�� �ϳ����� ��
-- �� ������ '���� �� �������� �� ������ ��������' ���� �ڼ��� ���캼 ����

SELECT SALARY
  FROM EMPLOYEES
WHERE HIRE_DATE = '2006/01/03';

SELECT *
  FROM EMPLOYEES
WHERE SALARY = (SELECT SALARY FROM EMPLOYEES WHERE HIRE_DATE = '20060103');

SELECT *
  FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE HIRE_DATE = '20060103');

-- ������ ���������� �Լ�
-- 9-5 ����������� ��ձ޿����� ���� �ӹ޴� ����� ���
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL
            , D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
     AND E.DEPTNO = 20
     AND E.SAL > (SELECT AVG(SAL)  FROM EMP);

SELECT *
  FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

-- 1�к���
-- ��ü ����� ��� �޿����� �۰ų� ���� �޿��� �ް� �ִ� 
-- 20�� �μ��� ��� �� �μ� ������ ���ϵ���
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL
            , D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
     AND E.DEPTNO = 20
     AND E.SAL <= (SELECT AVG(SAL)  FROM EMP);

-- ������ �������� ������ : IN, ANY/SOME, ALL, EXISTS
--9-6
SELECT *
  FROM EMP
WHERE DEPTNO IN (20, 30);

SELECT DEPTNO, MAX(SAL)
  FROM EMP
GROUP BY DEPTNO;

-- 9-7 �� �μ��� �ְ� �޿��� ������ �޿��� �޴� ��� ���� ���
SELECT *
  FROM EMP
WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

-- ANY SOME ������
-- 9-9
SELECT *
  FROM EMP
WHERE SAL = ANY (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

-- 30�� �μ� ������� �ִ� �޿����� ���� �޿��� �޴� ������� ����ϱ�
SELECT *
  FROM EMP
WHERE SAL < ANY (SELECT SAL FROM EMP WHERE DEPTNO = 30)
ORDER BY SAL, EMPNO; -- 2850���� �۰� �޴� ���

-- < ANY ���������� MAX �Լ��� ����� ���

-- 30�� �μ� ������� �ּұ޿� ���� ���� �޿��� �޴� ���
SELECT *
  FROM EMP
WHERE SAL > ANY (SELECT SAL FROM EMP WHERE DEPTNO = 30)
ORDER BY SAL, EMPNO; 
-- ALL ������ : ��� ����
-- 9-14 �μ� ��ȣ�� 30���� ������� �ּ� �޿� ���� �� ���� �޿��� �޴� ���
SELECT *
  FROM EMP
WHERE SAL < ALL (SELECT SAL FROM EMP WHERE DEPTNO = 30);
-- 9-15 �μ� ��ȣ�� 30���� ��� ���� �ִ� �޿� ���� �� ���� �޿��� �޴� ���
SELECT *
  FROM EMP
WHERE SAL > ALL (SELECT SAL FROM EMP WHERE DEPTNO = 30);

-- EXISTS ������ : �������� ��� ���� �����ϴ� ���
-- �ǽ� 9-16
SELECT * 
  FROM EMP
WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO = 10);

-- ���� �࿬���� ���
-- EMP ���̺��� ��� �߿� 10�� �μ��� ���� ��� ����� ���� 
-- ���� �Ի��� ��� ������ ���

SELECT *
  FROM EMP
WHERE HIREDATE < ALL(SELECT HIREDATE FROM EMP WHERE DEPTNO = 10);

-- ��� ����
-- : ���������� �������� ���� ���� ��� ���� �ϴ� ����
-- ����� �Ѹ��̶� �ִ� �μ��� ���
SELECT DNAME
  FROM DEPT D
WHERE  EXISTS ( SELECT 1 FROM EMP WHERE DEPTNO = D.DEPTNO);
-- �÷����f�� ? = ����� ­��?
SELECT EMPNO FROM EMP WHERE DEPTNO = 10;
SELECT EMPNO FROM EMP WHERE DEPTNO = 20;
SELECT EMPNO FROM EMP WHERE DEPTNO = 30;
SELECT EMPNO FROM EMP WHERE DEPTNO = 40;

SELECT * FROM EMP ;

-- ���� ���� �������� ���߿� ��������
-- 9-18
SELECT *
  FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)  FROM EMP GROUP BY DEPTNO);

SELECT DEPTNO, MAX(SAL)  FROM EMP GROUP BY DEPTNO;
/*
-- ����ϴµ� �μ��ڵ� ������ �������� �����Ͽ� ����ϴ� ������ �ۼ��ϼ���
SELECT DEPTNO, ENAME, SAL
  FROM EMP e
 WHERE SAL = (SELECT MAX(SAL) 
                FROM EMP 
               WHERE DEPTNO = e.DEPTNO)
 ORDER BY DEPTNO;               


                          
                          
-- SELECT���� �������� :  ��Į������ , �������
SELECT E.EMPNO, E.ENAME, E.DEPTNO
     , (SELECT DNAME FROM DEPT WHERE DEPTNO = E.DEPTNO) DNAME
  FROM EMP E;

SELECT E.EMPNO, E.ENAME, E.DEPTNO
     , D.DNAME  
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO;
*/
-- SELECT ���� �������� = ��Į������
SELECT E.EMPNO, E.ENAME, E.DEPTNO
            ,D.DNAME, (SELECT DNAME FROM DEPT WHERE DEPTNO = E.DEPTNO) AS DNAME
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
  
-- �� �μ��� �ִ� �޿��� �޴� ����� �μ��ڵ�, �̸�, �޿���
-- ����ϴµ� �μ��ڵ� ������ �������� �����Ͽ� ����ϴ� ������ �ۼ��ϼ���
SELECT DEPTNO, ENAME, SAL
  FROM EMP E
WHERE SAL = (SELECT MAX(SAL) FROM EMP WHERE DEPTNO = E.DEPTNO)
ORDER BY DEPTNO;
  
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO
            , D.DNAME, D.LOC
  FROM (SELECT * FROM EMP WHERE DEPTNO = 10 ) E10
            , (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;

-- WITH�� ���
WITH
        E10 AS  ( SELECT * FROM EMP WHERE DEPTNO = 10),
        D AS (SELECT * FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM E10, D
WHERE E10.DEPTNO = D.DEPTNO;

-- �ѹ� �� ������ : ��ȣ ���� ��������
SELECT *
  FROM EMP E1
WHERE SAL > (SELECT MIN(SAL) FROM EMP E2 WHERE E2.DEPTNO = E1.DEPTNO)
ORDER BY DEPTNO, SAL;


--9-21 SELECT ���� �������� ����ϱ�
SELECT EMPNO, ENAME, JOB, SAL
            , (SELECT GRADE FROM SALGRADE 
            WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE -- E.SAL�� LOSAL ~ HISAL�� ���� GRADE���� SALGRADE��� ��
            , DEPTNO
            , (SELECT DNAME FROM DEPT 
            WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME                             -- E.DEPTNO = DEPT.DEPTNO ���� ���� ���¿����� DNAME�� DNAME�̶�� ��
            , (SELECT ENAME FROM EMP
            WHERE EMP.EMPNO = E.MGR) MGR
  FROM EMP E;

-- ��ü ��� �� ALLEN�� ���� ��å(JOB)�� ������� ��� ����, �μ� ������ ������ ���� ����ϴ� SQL�� �ۼ��Ͻÿ�
SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
     AND JOB = (SELECT JOB FROM EMP WHERE ENAME = 'ALLEN'); 

-- ��ü ����� ��� �޿�(SAL)���� ���� �޿��� �޴� ������� ��� ����, �μ� ����, �޿� ��� ������ ����ϴ� SQL���� �ۼ�
-- (�� ����� �� �޿��� ���� ������ �����ϵ� �޿��� ���� ��� ��� ��ȣ�� �������� ���� �������� ����)
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE,D.LOC, E.SAL, S.GRADE
  FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO
     AND E.SAL BETWEEN S.LOSAL AND S.HISAL
     AND SAL > (SELECT AVG(SAL) FROM EMP)
ORDER BY E.SAL DESC, E.EMPNO;

-- 10�� �μ��� �ٹ��ϴ� ��� �� 30�� �μ����� �������� ���� ��å�� ���� ������� ��� ���� �μ� ������ ������ ���� ����ϴ� SQL���� �ۼ�
-- ���� 7839  KING    PRESIDENT 10  ACCOUNTING  NEWYORK     -->  7839����       ��       ��ǥ      10���μ�       ACCOUNTING�μ�        �������

SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC            -- �����ȣ(EMPNO)    ����̸�(ENAME)    �������(JOB)    �μ���ȣ(DEPTNO)    �μ���(DNAME)     �μ���ġ(LOC)
  FROM EMP E, DEPT D                                                                                         -- �ʿ��� TABLE
WHERE E.DEPTNO = D.DEPTNO                                                                         -- EMP TABLE�� DEPT TABLED���� DEPTNO�� ��ġ�ϴ� ��� �� ��
     AND E.DEPTNO = 10                                                                                        -- 10�� �μ��� �ٹ��ϴ� ����� ��
     AND JOB NOT IN (SELECT DISTINCT JOB FROM EMP WHERE DEPTNO = 30);  -- 30�� �μ����� �������� �ʴ� ��å�� ���� ��� -- DISTINCT�� ������ ��� ���� �ٸ� �ߺ��� ����





-- ��å�� SALESMAN�� ������� �ְ� �޿����� ���� �޿��� �޴� ������� ������� �޿���� ������ ������ ���� ����ϴ� SQL ���� �ۼ��ϼ���
-- �� ���������� Ȱ���� �� ������ �Լ��� ����ϴ� ����� ������� �ʴ� ����� ���� ��� ��ȣ�� �������� ������������ �����ϼ���.
-- EMPNO, ENAME, SAL, GRADE
-- ������ ��� O
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE                                                                                    -- �����ȣ      ����̸�        �޿�      �޿����
  FROM EMP E, SALGRADE S                                                                                                                    -- EMP TABLE, GRADE TABLE
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL                                                                                    -- �޿������ ������ S.LOSAL ~ H.SAL�̹Ƿ� �޿��� ������ ������
     AND E.SAL > ALL (SELECT DISTINCT SAL FROM EMP WHERE EMP.JOB = 'SALESMAN')          -- DISTINCT�� ������ ��� ���� �ٸ� �ߺ����� �־ �����ϱ����� ���� 1250,1600,1500 ��ȯ�̹Ƿ� ALL ���
ORDER BY E.EMPNO;                                                                                                                               -- EMPNO �������� (DEFAULT)

SELECT DISTINCT SAL FROM EMP WHERE EMP.JOB = 'SALESMAN';                                                -- 1250 1250 1500 1600 �� ��ȯ�ǹǷ� DISTINCT�� 1250 1500 1600���� ����(����? ������������)


-- ������ ��� X
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
     AND E.SAL > (SELECT MAX(SAL) FROM EMP WHERE EMP.JOB = 'SALESMAN')                      -- �Ѱ��� ���� 1600�� ��ȯ��
ORDER BY E.EMPNO;