-- 09 SQL�� ��  �� �ٸ� SQL �� ��������

-- ���������� SQL���� �����ϴ� �� �ʿ��� �����͸� �߰��� ��ȸ�ϱ� ���� SQL�� ���ο���
-- ����ϴ� SELECT ���� �ǹ���. ���������� ��� ���� ����Ͽ� ����� �����ϴ� ������ ����������� ��
-- ���� �� SELECT ������ WHERE ���� ���ǽĿ� ���������� ����Ѵٸ� ��ü SELECT���� ������ ���� �����˴ϴ�.

-- ��� �̸��� JONES�� ����� �޿� ����ϱ�
SELECT SAL
  FROM EMP
WHERE ENAME = 'JONES';
-- �޿��� 29175���� ���� ��� ���� ����ϱ�
SELECT *
  FROM EMP
WHERE SAL > 2975;  

-- ���������� JONES���� ���� ������ �޴� ��� ���� ����ϱ�
SELECT *
  FROM EMP
WHERE SAL > (SELECT SAL
                        FROM EMP
                      WHERE ENAME = 'JONES');
-- �̸� ���ٷ�                      
SELECT * FROM EMP WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'JONES');

-- �������� Ư¡
-- �������� �����ڴ� ���� �� �Ǵ� ��ȸ ����� �����ʿ� ���̸� ��ȣ()�� ��� ���
-- ���������� SELECT ���� ����� ���� ���������� �� ���� ���� �ڷ����� ���� ������ ����
-- �� ���������� �� ��� �����Ͱ� �ϳ��� ���������� SELECT�� ���� ���� �ڷ����� ���� �ϳ� ����
-- ���������� �ִ� SELECT���� ��� ����� �Բ� ����ϴ� ���������� ������ ������ ȣȯ �����ؾ� ��
-- ���� �� ���������� ����� �����ڰ� �� �ϳ��� �����ͷθ� ������ ������ �����ڶ�� ���������ǰ�� �� ���� �ݵ�� �ϳ����� ��
-- �� ������ '���� �� �������� �� ������ ��������' ���� �ڼ��� ���캼 ����


-- SCOTT���� ���� �Ի��� ����� ����� ��ȸ -9-4
SELECT *
  FROM EMP
WHERE HIREDATE < (SELECT HIREDATE
                               FROM EMP
                               WHERE ENAME = 'SCOTT');
                               
-- 9-5 �������� �ȿ��� �Լ��� ����� ��� (EMP���̺�� DEPT ���̺��� ����)
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL
            , D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
     AND E.DEPTNO = 20
     AND E.SAL > (SELECT AVG(SAL) 
                          FROM EMP);
                          
                          
                          
                          
-- ������ ���������� ���� ��� ���� �������� ������ ���� ������ ����ŵ�ϴ�. �տ��� ���캻 ������ ���������� �޸� �������� ����� �������̹Ƿ� ������ �����ڴ� ����� �� ����
-- ������ �����ڸ� ����ؾ� ���������� ���� �� �ֽ��ϴ�. ������ ���� ������ ������ ����
-- IN                     :   ���������� �����Ͱ� ���������� ��� �� �ϳ��� ��ġ�� �����Ͱ� �ִٸ� true
-- ANY, SOME    :  ���������� ���ǽ��� �����ϴ� ���������� ����� �ϳ� �̻��̸� true
--  ALL                 :   ���������� ���ǽ��� ���������� ��� ��ΰ� �����ϸ� true
-- EXISTS            :    ���������� ����� �����ϸ� (��, ���� 1�� �̻��� ���) true


-- IN �����ڴ� �̹� 05�忡�� WHERE ���� �����ڸ� �ٷ�鼭 �Ұ��� �������̸� ������ ���� ���·� ����� ������.
-- 9-6
SELECT *
  FROM EMP
WHERE DEPTNO IN (20, 30);   -- �μ� ��ȣ�� 20�̰ų� 30�� ����� ������ ���
-- 9-7 �� �μ��� �ְ� �޿��� ������ �޿��� �޴� ��� ���� ����ϱ�
SELECT *
  FROM EMP
WHERE SAL IN (SELECT MAX(SAL)   FROM EMP   GROUP BY DEPTNO); -- MAX(SAL) 2850, 3000, 5000 �� ��µ�
-- ANY, SOME ������
-- ���������� ��ȯ�� ���� ��� �� �� ���������� ���ǽ��� ����� ����� �ϳ��� true��� �������� ���ǽ��� true�� ��ȯ���ִ� ������ �Դϴ�.
-- �������� ��� �� �� �ϳ��� ���ǽĿ� �¾ƶ������� ���������� ���ǽ��� ���� �Ǿ� ��� ����� �ȴٴ� ������ �տ��� ���� �� IN �����ڿ� ������� �� �� ����
-- ���������� ���Ҷ� ANY �� SOME �����ڸ� � �� ������ (=)�� �Բ� ����ϸ� IN �����ڿ� ��Ȯ�� ���� ����� ������.
SELECT *
  FROM EMP
WHERE SAL = ANY (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO); -- IN�� ����ѰͰ� ���� ����
-- ANY�� ��񱳿����ڿ� ������� ���� ��� = > 30�� �μ� ������� �ִ� �޿����� ���� �޿��� �޴� ��� ���� ����ϱ�
SELECT *
  FROM EMP
WHERE SAL < ANY (SELECT SAL FROM EMP WHERE DEPTNO = 30) -- 30�� ������� �ִ�޿����� ���� �޿��� ���� : DEPTNO�� 30�� ������� �޿��� ��µ�����
                                                                                                                      --  ANY�� �ϳ��� �����ϴ� ��쿡 ���ؼ� TRUE 2850 �޷����� ���� ��� ���
ORDER BY SAL, EMPNO;                 

SELECT SAL FROM EMP WHERE DEPTNO = 30;                                  --����ϸ� 1600 1250 1250 2850 1500 950�� ��µ� -- MAX�� �Ƚᵵ �Ǵ� ���� �� �� ����

-- �ݴ�� 30�� �μ� ������� �ּ� �޿����� ���� �޿��� �޴� ��� ������ ���
SELECT *
  FROM EMP
WHERE SAL > ANY (SELECT SAL FROM EMP WHERE DEPTNO = 30);    -- ���������� ANY�� �������� MIN �Լ��� ���� �ʾƵ� �Ǵ� ���� Ȯ���� �� ����

/*
SOME ������ ����ϱ�
*/
SELECT *
  FROM EMP
WHERE SAL = SOME (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO); -- ANY, IN �� ����

-- ALL ������
-- ANY �� SOME�� �޸� ���������� ��� ����� ���ǽĿ� �¾� �������߸� ���������� ���ǽ��� TRUE�� �Ǵ� ������
-- �μ���ȣ�� 30���� ������� �ּ� �޿����� �� ���� �޿��� �޴� ����� ���
SELECT *
  FROM EMP
WHERE SAL < ALL (SELECT SAL FROM EMP WHERE DEPTNO = 30);  -- 1600 1250 1250 2850 1500 950 ���� ���� �޴� ��� ��� = ��� �����ؾ��ϹǷ� 950���� ���� ���

SELECT *
  FROM EMP
WHERE SAL > ALL(SELECT SAL FROM EMP WHERE DEPTNO = 30); -- ���������� 2850���� ���� �޴� ����� ���

-- EXISTS ������
-- EXISTS �����ڴ� ���� Ư���� �������ε� ���������� ��� ���� �ϳ� �̻� �����ϸ� ���ǽ��� ��� TRUE
-- �������� ������ ��� FALSE �� �Ǵ� ������ ���� TRUE�� �Ǵ� ����� Ȯ��
-- 9-16 �������� ��� ���� �����ϴ� ���
SELECT *
  FROM EMP
WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO = 10); -- DEPT ���̺��� 10�� �μ��� DNAME�� ���� �����ϸ� SELECT * FROM EMP; �� ����϶� ��� �Ͱ� ����
SELECT *  FROM EMP;

SELECT *
  FROM EMP
WHERE EXISTS(SELECT DNAME FROM DEPT WHERE DEPTNO = 50);  -- DEPT ���̺��� 50�� �μ��� DNAME�� ���� �����ϸ� SELECT * FROM EMP�� ����϶� = �ϳ��� ������ ������� ����
-- 1�� ����
SELECT *
FROM EMP 
WHERE HIREDATE < ALL (SELECT HIREDATE FROM EMP WHERE DEPTNO = 10);

-- 9-4 ���� ���� ���� ���� ���߿� ��������
-- 9-18 ���� ���� ���� ���� ���߿� ��������
SELECT *
  FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO); -- �ǹ� �ִ� ����� �ƴ����� ���߿� ���� ������ ��� ������� ����صδ� ���� ����
SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO; 


--9-19 �ζ��� �� ����ϱ�
-- FROM ���� ����ϴ� ���������� �ζ��� ���� �θ�
-- SELECT ���� ���� Ư�� ���� ������ �� �� ��Ī�� �־� ����� �� ����
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10, (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;


-- ������ FROM ���� �ʹ� ���� ���������� �����ϸ� �������̳� ������ ������ �� �ֱ� ������
-- WITH ���� ����ϱ⵵ ��

-- WITH �� ����ϱ� (�ֻ�ܿ� ���� �� ����)
WITH
E10 AS (SELECT * FROM EMP WHERE DEPTNO  = 10),
D     AS (SELECT * FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM E10, D
WHERE E10.DEPTNO = D.DEPTNO;

-- ��ȣ���� ��������
-- �������� ��� ���� �ٽ� ���������� �����ִ� ����� ��ȣ���� ���������� ������ ( �� ������ ����Ʈ���� ������ �� �� �־� ��� �󵵰� ���� ����)
-- ����
SELECT *
  FROM EMP E1
WHERE SAL > (SELECT MIN(SAL) FROM EMP E2 WHERE E2.DEPTNO = E1.DEPTNO) -- E2.DEPTNO �� E1.DEPTNO�� ������ ���̺��� MIN(SAL) �� �� EMP1 ���̺��� SAL ���� �� 
ORDER BY DEPTNO, SAL;                                                                                                      -- ���� DEPTNO SAL�� ����

-- 09-6 SELECT ���� ����ϴ� ��������
--9-21 SELECT ���� �������� ����ϱ�
SELECT GRADE  FROM SALGRADE, EMP E WHERE E.SAL BETWEEN LOSAL AND HISAL; --??
SELECT DNAME FROM EMP E, DEPT WHERE E.DEPTNO =DEPT.DEPTNO;
SELECT EMPNO, ENAME, JOB, SAL
            , (SELECT GRADE FROM SALGRADE WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE -- E.SAL�� LOSAL ~ HISAL�� ���� GRADE���� SALGRADE��� ��
            , DEPTNO
            , (SELECT DNAME FROM DEPT WHERE E.DEPTNO =DEPT.DEPTNO) AS DNAME                             -- E.DEPTNO = DEPT.DEPTNO ���� ���� ���¿����� DNAME�� DNAME�̶�� ��
  FROM EMP E;

SELECT DNAME FROM DEPT, EMP WHERE EMP.DEPTNO =DEPT.DEPTNO;

-- 262 ������ Q1
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

SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC            -- �����ȣ    ����̸�    �������    �μ���ȣ    �μ���     �μ���ġ
  FROM EMP E, DEPT D                                                                                         -- �ʿ��� TABLE
WHERE E.DEPTNO = D.DEPTNO                                                                         -- EMP TABLE�� DEPT TABLED���� DEPTNO�� ��ġ�ϴ� ��� �� ��
     AND E.DEPTNO = 10                                                                                        -- 10�� �μ��� �ٹ��ϴ� ����� ��
     AND JOB NOT IN (SELECT DISTINCT JOB FROM EMP WHERE DEPTNO = 30);  -- 30�� �μ����� �������� �ʴ� ��å�� ���� ��� -- DISTINCT�� ������ ��� ����





-- ��å�� SALESMAN�� ������� �ְ� �޿����� ���� �޿��� �޴� ������� ������� �޿���� ������ ������ ���� ����ϴ� SQL ���� �ۼ��ϼ���
-- �� ���������� Ȱ���� �� ������ �Լ��� ����ϴ� ����� ������� �ʴ� ����� ���� ��� ��ȣ�� �������� ������������ �����ϼ���.
-- EMPNO, ENAME, SAL, GRADE
-- ������ ��� O
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
     AND E.SAL > ALL (SELECT DISTINCT SAL FROM EMP WHERE EMP.JOB = 'SALESMAN')          -- DISTINCT�� ������ ��� ���� �ٸ� �ߺ����� �־ �����ϱ����� ����
ORDER BY E.EMPNO;

-- ������ ��� X
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
     AND E.SAL > (SELECT MAX(SAL) FROM EMP WHERE EMP.JOB = 'SALESMAN')                      -- �Ѱ��� ���� 1600�� ��ȯ��
ORDER BY E.EMPNO;




SELECT MAX(SAL) FROM EMP WHERE EMP.JOB = 'SALESMAN';
SELECT DISTINCT SAL FROM EMP WHERE EMP.JOB = 'SALESMAN';













































