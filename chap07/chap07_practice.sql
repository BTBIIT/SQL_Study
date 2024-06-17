-- 212 PAGE Q1
SELECT DEPTNO, FLOOR(AVG(SAL)) AS AVG_SAL
            , MAX(SAL) AS MAX_SAL
            , MIN(SAL) AS MIN_SAL
            , COUNT(SAL) AS CNT
  FROM EMP
GROUP BY DEPTNO;

-- 212PAGE Q2
SELECT JOB, COUNT(*)
  FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 3;

-- 212PAGE Q3
SELECT SUBSTR(HIREDATE,1,4) AS HIRE_YEAR
            , DEPTNO
            , COUNT(DEPTNO) AS CNT
  FROM EMP
GROUP BY  SUBSTR(HIREDATE,1,4), DEPTNO;

-- ����� ��
SELECT TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR
            , DEPTNO
            , COUNT(*) AS CNT
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')
            , DEPTNO;


-- 212PAGE Q4
SELECT NVL2(COMM, 'O', 'X') AS EXIST_COM
            , COUNT(NVL2(COMM, 'O', 'X')) AS CNT
FROM EMP
GROUP BY NVL2(COMM, 'O', 'X');



-- 212PAGE Q5
SELECT NVL(TO_CHAR(DEPTNO), ' ') AS DEPTNO
            , NVL(SUBSTR(HIREDATE,1,4),' ') AS HIRE_YEAR
            , COUNT(SUBSTR(HIREDATE,1,4)) AS CNT
            , MAX(SAL) AS MAX_SAL
            , SUM(SAL) AS SUM_SAL
            , AVG(SAL) AS AVG_SAL
FROM EMP
GROUP BY ROLLUP(DEPTNO, SUBSTR(HIREDATE,1,4));
-- ����� ��
SELECT  DECODE(GROUPING(DEPTNO), 1,'�Ѱ�', DEPTNO)  AS DEPTNO
            , DECODE(GROUPING(TO_CHAR(HIREDATE, 'YYYY')), 1, 
                            DECODE(GROUPING(DEPTNO), 1,' ', '�Ұ�'),
                        TO_CHAR(HIREDATE,'YYYY') )AS HIREDATE
            , COUNT(*) AS CNE
            , MAX(SAL) AS MAX_SAL
            , SUM(SAL) AS SUM_SAL
            , TRUNC(AVG(SAL)) AS AVG_SAL
            
            
  FROM EMP
GROUP BY ROLLUP(DEPTNO, TO_CHAR(HIREDATE, 'YYYY'));
-- �ѿ����� ����
SELECT DECODE(GROUPING(DEPTNO), 1, ' ', DEPTNO) AS DEPTNO
            , DECODE(GROUPING(TO_CHAR(HIREDATE, 'YYYY')), 1,
                DECODE(GROUPING(DEPTNO), 1, ' ', ' '), TO_CHAR(HIREDATE, 'YYYY')) AS HIRE_YEAR
            , COUNT(*) AS CNT
            , MAX(SAL) AS MAX_SAL
            , SUM(SAL) AS SUM_SAL
            , ROUND(AVG(SAL), 5) AS AVG_SAL
  FROM EMP
GROUP BY ROLLUP(DEPTNO, TO_CHAR(HIREDATE, 'YYYY'));

-- 1. �μ���ȣ 10���� ������� �����ȣ, ����̸�, ������ ����Ͻÿ�
SELECT EMPNO AS "�����ȣ", ENAME AS "����̸�", DEPTNO AS "�μ���ȣ" 
FROM EMP;

--2 �����ȣ 7369�� ����� �����ȣ ����̸� ������ ���
SELECT EMPNO AS "�����ȣ", ENAME AS "����̸�", DEPTNO AS "�μ���ȣ" 
  FROM EMP
WHERE EMPNO = 7369;

--2 �����ȣ 7300���� ũ�� 7400���� ���� ��� �̸�, �Ի���, �μ���ȣ ���
SELECT ENAME ����̸�, HIREDATE �Ի���, DEPTNO �μ���ȣ
  FROM EMP
WHERE EMPNO > 7300 AND EMPNO <7400;

-- 4 EMPLOYEE ��� ������ �����ȣ ���� ������������ �˻��Ͻÿ�
SELECT *
  FROM EMP 
ORDER BY EMPNO DESC;

-- 5 �̸��� S�� �����ϴ� ��� ����� �����ȣ�� �̸��� ����Ͻÿ�
SELECT *
  FROM EMP
WHERE ENAME LIKE 'S%';







































