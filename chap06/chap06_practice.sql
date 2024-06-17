-- 174 PAGE - Q1 
-- 6-1
-- 강사님 답안
SELECT EMPNO
            , RPAD(SUBSTR(EMPNO, 1,2), 4 ,'*') AS MASKING_EMPNO
            , ENAME
            , RPAD(SUBSTR(ENAME,1,1), LENGTH(ENAME), '*') AS MASKING_ENAME
  FROM EMP
WHERE LENGTH(ENAME) =5;
-- 내 답안
SELECT EMPNO,
              RPAD(SUBSTR(EMPNO, 1, 2), 4, '*') AS MASKING_EMPNO,
              ENAME,
              RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS MASKING_ENAME
FROM  EMP
 WHERE LENGTH(ENAME) >= 5
   AND LENGTH(ENAME) < 6; 

-- 174 PAGE -  Q2
-- 6-2
-- 강사님 답안
SELECT EMPNO, ENAME, SAL
            , TRUNC(SAL/21.5, 2) AS DAY_PAY
            , ROUND(SAL/21.5/8, 1) AS TIME_PAY
  FROM EMP;
  
-- 내 답안
SELECT EMPNO, ENAME, SAL
            , TRUNC((SAL/21.5),2) AS DAY_PAY
            , ROUND((SAL/21.5)/8,1) AS TIME_PAY
FROM EMP;

-- 175 PAGE -Q3
-- 6-3
-- 강사님 답안
SELECT EMPNO, ENAME, HIREDATE
            , TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB
            , NVL(TO_CHAR(COMM), 'N/A') AS COMM
            , NVL2(COMM, '수당존재함', '없음') AS COMM_YN
            , NVL2(COMM, TO_CHAR(COMM), 'N/A') AS COMM
FROM EMP;
-- 내 답안
SELECT EMPNO, ENAME, HIREDATE
            , TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE,3), '월요일'),'YYYY-MM-DD') AS R_JOB
           -- NVL() : NULL 값을 특정한 값으로 치환하는 함스
            , NVL(TO_CHAR(COMM), 'N/A') AS COMM
            --NVL2() : NULL 값과 NULL 아닌 값을 치환
            , NVL2(COMM, '수당존재함', '없음') AS COMM_YN
            , NVL2(COMM, TO_CHAR(COMM), 'N/A') AS COMM
  FROM EMP;
  
  
SELECT '1 + 2' FROM DUAL; 
SELECT 1 + '2' FROM DUAL;
SELECT 1 + TO_NUMBER('2') FROM DUAL;
SELECT 1+2 FROM DUAL;  
-- 175 PAGE -Q4
-- 6-4
SELECT EMPNO, ENAME, MGR
    -- CASE() : 복잡한 논리 조건 처리 함수
     , CASE
           WHEN MGR IS NULL THEN '0000'
           WHEN SUBSTR(MGR, 1, 2) = '75' THEN '5555'
           WHEN SUBSTR(MGR, 1, 2) = '76' THEN '6666'
           WHEN SUBSTR(MGR, 1, 2) = '77' THEN '7777'
           WHEN SUBSTR(MGR, 1, 2) = '78' THEN '8888'
           ELSE TO_CHAR(MGR)
       END AS CHG_MGR
  FROM EMP;

-- 강사님 답안 2
SELECT EMPNO, ENAME, MGR
        -- DECODE : 데이터가 조건 값과 일치하면 치환 값을 출력하고
        --                    일치하지 않으면 기본 값을 출력하는 조건 논리 처리 함수                     
     , DECODE(SUBSTR(MGR,1,2), NULL, '0000', 
                    75, '5555', 76, '6666',
                    77, '7777', 78, '8888', TO_CHAR(MGR)) AS CHG_MGR
  FROM EMP; 
-- 내 답안
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
 
 -- 순위함수
SELECT FIRST_NAME, SALARY
-- RANK() : 내가 원하는 컬럼순으로 정렬 
            , RANK() OVER(ORDER BY SALARY DESC) AS RANK -- 공통 순위는 건너 띄어 다음 순위 출력
            , DENSE_RANK() OVER(ORDER BY SALARY DESC) AS DENSE_RANK -- 공통 순위는 건너 띄지 않고 다음 순위 출력
            , ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS ROW_NUMBER -- 공통 순위 상관 없이 그냥 순서대로 출력
  FROM EMPLOYEES;
  
