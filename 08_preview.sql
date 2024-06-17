-- FROM���� ���� ���̺� �����ϱ�
SELECT *
  FROM EMP, DEPT
ORDER BY EMPNO;

-- �� �̸��� ���ϴ� ���ǽ����� �����ϱ�
SELECT *
  FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO --DEPTNO �� ���� 14�� �׸� ���
ORDER BY EMPNO;

-- ���̺��� ��Ī ����
SELECT *
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;


SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
            , D.DNAME, D.LOC
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;


-- 08-2
-- ���� ���̺��� �� �̸��� ���� �� ������
-- �� ���̺� �μ� ��ȣ�� �Ȱ��� �� �̸����� ���ԵǾ� ���� �� ������ ���ϴ�.
SELECT EMPNO, ENAME, DEPTNO, DNAME, LOC
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
-- colum ambiguously defined

-- 8-5 �� �̸��� ������ ���̺� �̸��� �Բ� ����� ��
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO, E.EMPNO;

-- WHERE ���� ���ǽ� �߰��Ͽ� ��� ���� �����ϱ�
SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
     AND SAL >= 3000;

SELECT *
  FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

SELECT E.EMPNO, E.ENAME, C.MGR, E.JOB
  FROM EMP E, copy_emp C
WHERE E.MGR = C.EMPNO;

-- ���� ���̺��� �� �� ����Ͽ� ��ü �����ϱ�
SELECT E1.EMPNO, E1.ENAME, E1.MGR
            , E2.EMPNO AS MGR_EMPNO
            , E2.ENAME AS MGR_ENAME
  FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO;


-- ���� ���� �ܺ� ���� �̸��� ���ؼ� 
-- ���� �ܺ� ���� (LEFT OUTER JOIN) WHERE TABLE1.COL1 = TABLE2.COL1(+)
-- ������ �ܺ� ���� (RIGHT OUTER JOIN) WHERE TABLE1.COL1(+) = TABLE2.COL1

-- ���� �ܺ� ���� ����ϱ�
SELECT E1.EMPNO, E1.ENAME, E1.MGR
            , E2.EMPNO AS MGR_EMPNO
            , E2.ENAME AS MGR_ENAME
  FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+)
ORDER BY E1.EMPNO;


-- ������ �ܺ� ���� ����ϱ�
SELECT E1.EMPNO, E1.ENAME, E1.MGR
            , E2.EMPNO AS MGR_EMPNO
            , E2.ENAME AS MGR_ENAME
  FROM EMP E1, EMP E2
WHERE E1.MGR(+) = E2.EMPNO
ORDER BY E1.EMPNO;





























