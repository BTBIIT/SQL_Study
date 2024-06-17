-- 174 PAGE - Q1 
-- 6-1
-- ����� ���
SELECT EMPNO
            , RPAD(SUBSTR(EMPNO, 1,2), 4 ,'*') AS MASKING_EMPNO
            , ENAME
            , RPAD(SUBSTR(ENAME,1,1), LENGTH(ENAME), '*') AS MASKING_ENAME
  FROM EMP
WHERE LENGTH(ENAME) =5;
-- �� ���
SELECT EMPNO,
              RPAD(SUBSTR(EMPNO, 1, 2), 4, '*') AS MASKING_EMPNO,
              ENAME,
              RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS MASKING_ENAME
FROM  EMP
 WHERE LENGTH(ENAME) >= 5
   AND LENGTH(ENAME) < 6; 

-- 174 PAGE -  Q2
-- 6-2
-- ����� ���
SELECT EMPNO, ENAME, SAL
            , TRUNC(SAL/21.5, 2) AS DAY_PAY
            , ROUND(SAL/21.5/8, 1) AS TIME_PAY
  FROM EMP;
  
-- �� ���
SELECT EMPNO, ENAME, SAL
            , TRUNC((SAL/21.5),2) AS DAY_PAY
            , ROUND((SAL/21.5)/8,1) AS TIME_PAY
FROM EMP;

-- 175 PAGE -Q3
-- 6-3
-- ����� ���
SELECT EMPNO, ENAME, HIREDATE
            , TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '������'), 'YYYY-MM-DD') AS R_JOB
            , NVL(TO_CHAR(COMM), 'N/A') AS COMM
            , NVL2(COMM, '����������', '����') AS COMM_YN
            , NVL2(COMM, TO_CHAR(COMM), 'N/A') AS COMM
FROM EMP;
-- �� ���
SELECT EMPNO, ENAME, HIREDATE
            , TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE,3), '������'),'YYYY-MM-DD') AS R_JOB
           -- NVL() : NULL ���� Ư���� ������ ġȯ�ϴ� �Խ�
            , NVL(TO_CHAR(COMM), 'N/A') AS COMM
            --NVL2() : NULL ���� NULL �ƴ� ���� ġȯ
            , NVL2(COMM, '����������', '����') AS COMM_YN
            , NVL2(COMM, TO_CHAR(COMM), 'N/A') AS COMM
  FROM EMP;
  
  
SELECT '1 + 2' FROM DUAL; 
SELECT 1 + '2' FROM DUAL;
SELECT 1 + TO_NUMBER('2') FROM DUAL;
SELECT 1+2 FROM DUAL;  
-- 175 PAGE -Q4
-- 6-4
SELECT EMPNO, ENAME, MGR
    -- CASE() : ������ �� ���� ó�� �Լ�
     , CASE
           WHEN MGR IS NULL THEN '0000'
           WHEN SUBSTR(MGR, 1, 2) = '75' THEN '5555'
           WHEN SUBSTR(MGR, 1, 2) = '76' THEN '6666'
           WHEN SUBSTR(MGR, 1, 2) = '77' THEN '7777'
           WHEN SUBSTR(MGR, 1, 2) = '78' THEN '8888'
           ELSE TO_CHAR(MGR)
       END AS CHG_MGR
  FROM EMP;

-- ����� ��� 2
SELECT EMPNO, ENAME, MGR
        -- DECODE : �����Ͱ� ���� ���� ��ġ�ϸ� ġȯ ���� ����ϰ�
        --                    ��ġ���� ������ �⺻ ���� ����ϴ� ���� �� ó�� �Լ�                     
     , DECODE(SUBSTR(MGR,1,2), NULL, '0000', 
                    75, '5555', 76, '6666',
                    77, '7777', 78, '8888', TO_CHAR(MGR)) AS CHG_MGR
  FROM EMP; 
-- �� ���
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
 
 -- �����Լ�
SELECT FIRST_NAME, SALARY
-- RANK() : ���� ���ϴ� �÷������� ���� 
            , RANK() OVER(ORDER BY SALARY DESC) AS RANK -- ���� ������ �ǳ� ��� ���� ���� ���
            , DENSE_RANK() OVER(ORDER BY SALARY DESC) AS DENSE_RANK -- ���� ������ �ǳ� ���� �ʰ� ���� ���� ���
            , ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS ROW_NUMBER -- ���� ���� ��� ���� �׳� ������� ���
  FROM EMPLOYEES;
  
