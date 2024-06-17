-- �����̺��� �̸��� �ڷ����� ���� ���� ã�� �� �� ���� �������� ������� ���ִ� ��� NATURAL JOIN ���
SELECT E.EMPNO, E.ENAME, E.MGR, E.HIREDATE, E.SAL, E.COMM
            , DEPTNO, D.DNAME, D.LOC
  FROM EMP E NATURAL JOIN DEPT D
ORDER BY DEPTNO, E.EMPNO;

-- JOIN ~ USING ������� ������ִ� ���ι�� NATURAL JOIN�� �ڵ����� ���� ���� ���� �����ϴ� �Ͱ� �޸� 
-- USING Ű���忡 ���� �������� ����� ���� ����Ͽ� ����մϴ�.
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM
            , DEPTNO, D.DNAME, D.LOC
  FROM EMP E JOIN DEPT D USING (DEPTNO) -- ���⼭�� DEPTNO�� �������� ���� ����
WHERE SAL >= 3000
ORDER BY DEPTNO, E.EMPNO;
-- WHERE ���� �ִ� ���� ���ǽ��� ON Ű���� ���� �ۼ��� ���� ���� ���ǽ��� ON�� ����ϰ� �� ���� ������� �ɷ����� ����
-- WHERE ���ǽ��� ���� ����ϴ� ���
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM
            , E.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
WHERE SAL <= 3000
ORDER BY E.DEPTNO, EMPNO;

-- ���� �ܺ� ���� 
-- ����       :    WHERE TABLE1.COL1 = TABLE2.COL1(+)
-- SQL-99   :    FROM TABLE 1 LEFT OUTER JOIN TABLE2 ON (���� ���ǽ�)

-- ������ �ܺ� ���� 
-- ����       :    WHERE TABLE1.COL1(+) = TABLE2.COL1
-- SQL-99   :    FROM TABLE 1 RIGHT OUTER JOIN TABLE2 ON (���� ���ǽ�)

-- ��ü �ܺ� ����
-- ����       :   �⺻ ������ ���� (UNION ���� �����ڸ� Ȱ��)
-- SQL-99   :   FROM TABLE 1 FULL OUTER JOIN TABLE2 ON (���� ���ǽ�)


-- ���� �ܺ� ������ SQL-99�� �ۼ��ϱ�
SELECT E1.EMPNO, E1.ENAME, E1.MGR
            , E2.EMPNO AS MGR_EMPNO
            , E2.ENAME AS MGR_ENAME
  FROM EMP E1 LEFT OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO)
ORDER BY E1.EMPNO;
-- ���� �ܺ� ������ ���� �������� �ۼ�
SELECT E1.EMPNO, E1.ENAME, E1.MGR
            , E2.EMPNO AS MGR_EMPNO
            , E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+)
ORDER BY E1.EMPNO;

-- ������ �ܺ� ������ SQL-99�� �ۼ��ϱ�
SELECT E1.EMPNO, E1.ENAME, E1.MGR
            , E2.EMPNO AS MGR_EMPNO
            , E2.ENAME AS MGR_ENAME
  FROM EMP E1 RIGHT OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO)
ORDER BY E1.EMPNO, MGR_EMPNO;
-- ������ �ܺ� ������ ���� �������� �ۼ�
SELECT E1.EMPNO, E1.ENAME, E1.MGR
            , E2.EMPNO AS MGR_EMPNO
            , E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR(+) = E2.EMPNO
ORDER BY E1.EMPNO;

-- ��ü �ܺ� ���� �� ����, ������ �ܺ� ������ ��� ������ �� ���ʿ��� null�� ���� �����ʿ��� null�� ��� ��θ� ����ϴ� ���
-- ���� �ܺ� �������δ�  UNION ���� �����ڸ� ����Ͽ� ���� ������ ������ ����� ��ġ�� ����� �����߽��ϴ�. ������ 
-- SQL-99 ����� �ܺ������� FULL OUTER JOIN ~ ON Ű����� ��� �ܺ� ���ε� ����� ���� ����� �� �ֽ��ϴ�
SELECT E1.EMPNO, E1.ENAME, E1.MGR
            , E2.EMPNO AS MGR_EMPNO
            , E2.ENAME AS MGR_ENAME
  FROM EMP E1 FULL OUTER JOIN EMP E2 ON (E1.MGR  = E2.EMPNO)
ORDER BY E1.EMPNO;

-- 08-practice 01 �� SQL-99 ��� ����
SELECT E.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO) -- FROM ������ EMP�� DEPT�� ���� �� JOIN ON���� ���� ������ ��� �� ����
WHERE SAL > 2000                                                      -- WHERE ������ �� ������ ���ؼ��� ���͸��ϸ� ������ ����
ORDER BY E.DEPTNO;
-- 08-practice 01�� SQL-99��� ������
SELECT E.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO                                    -- WHERE ������ DEPTNO�� ���� ��쿡 ���ؼ� ������ �ɾ���
AND SAL > 2000                                                         -- ���� AND ������ ���� �߰����� ������ �ɾ 2000 �޷� �̻��� ��쿡�� ���
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

--08 practice 03�� SQL-99 ��� ���� -- ������ �ܺ������� �̿��ϴ� ������� DEPT D�� ����� �ϴ� ��� ���� RIGHT JOIN (���� ������)�� ��
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM EMP E RIGHT JOIN  DEPT D ON (E.DEPTNO = D.DEPTNO)
ORDER BY E.DEPTNO;

--08 practice 03�� SQL-99 ��� ������ -- ���� SQL - 99�� �ƴ� ������� �ڵ��Ҷ� ����� �Ǵ� �ʿ� +�� �ٿ�����
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
                ON (E.DEPTNO = D.DEPTNO) -- ���ؿ��� DEPT ���� ���������ϸ鼭
              LEFT OUTER JOIN SALGRADE S -- ���ÿ� SALGRADE�� EMP�� �������ķ� �����
                ON (E.SAL BETWEEN S.LOSAL AND S.HISAL)
              LEFT OUTER JOIN EMP E2      -- ���� �Ȱ��� ���� ȣ���Ͽ�  �����ȣ�� EMPNO �� �������� ȣ��
                ON (E.MGR = E2.EMPNO)
ORDER BY D.DEPTNO, E.EMPNO;  -- ���� DEPTNO�� EMPNO�� ���Ͽ� ����

--SQL-99 ���� ��� -- �� ����� �� �� �������� �ִµ�...
SELECT D.DEPTNO, D.DNAME,
       E.EMPNO, E.ENAME, E.MGR, E.SAL, E.DEPTNO,
       S.LOSAL, S.HISAL, S.GRADE,
       E2.EMPNO AS MGR_EMPNO, E2.ENAME AS MGR_ENAME
  FROM EMP E, DEPT D, SALGRADE S, EMP E2
 WHERE E.DEPTNO(+) = D.DEPTNO
   AND E.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
   AND E.MGR = E2.EMPNO(+)
ORDER BY D.DEPTNO, E.EMPNO; 


