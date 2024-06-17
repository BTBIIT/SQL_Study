-- 7장 다중행 함수와 데이터 그룹화
-- 7-1
SELECT SUM(SAL)
  FROM EMP;
  
-- 7-2
SELECT ENAME, SUM(SAL) -- 오류가 남
  FROM EMP
GROUP BY ENAME ;

SELECT DEPTNO, SUM(SAL) AS SUM -- 부서별 월급 합계를 보고 싶을때.
  FROM EMP;
--GROUP BY DEPTNO;



-- 7-3 다중행 함수 : 널값 제외 처리
SELECT SUM(COMM) AS "추가 수당 합계"  -- NULL은 자동으로 제외처리 해줌, + 열값에 공백을 주고 싶다면 "" 로 문장을 묶어줘야함
  FROM EMP;
  
  
-- 7-4
SELECT SUM(DISTINCT SAL)
            , SUM(ALL SAL)
            , SUM(SAL) AS "<- 같은 값"
FROM EMP;

SELECT SAL FROM EMP;

-- 7-5 EMP 테이블 행 갯수
SELECT COUNT(COMM)
            , COUNT(MGR)
FROM EMP;

SELECT COUNT(COMM)
            , COUNT(MGR)
            , COUNT(EMPNO)
            , COUNT(*)
            , COUNT(1)
FROM EMP;


-- 7-6 부서번호가 30번인 직원수
SELECT COUNT(*) 
  FROM EMP
WHERE DEPTNO = 30;

--SELECT *
--  FROM EMP
--WHERE DEPTNO = 30;


7-7
SELECT COUNT(DISTINCT SAL) AS "중복값 제외 SAL 수"
            , COUNT(ALL SAL) AS "중복값 포함 SAL 수"
            , COUNT(SAL)        AS " <-  똑같은 값"
  FROM EMP;  -- NULL 데이터는 반환 개수에서 자동 제외
  
  
-- 7-8 (7-9 와 동일)
SELECT COUNT(COMM)
  FROM EMP;  -- 4
  
--7-9
SELECT COUNT(COMM)
  FROM EMP 
WHERE COMM IS NOT NULL; -- 4


-- 7-10
SELECT MAX(SAL), MIN(SAL)
  FROM EMP
WHERE DEPTNO = 10;



--7-12 20번 부서에서 사원의 입사일 중 최근 입사일 출력
SELECT MAX(HIREDATE), MIN(HIREDATE)
  FROM EMP
WHERE DEPTNO = 20;


--7-14
SELECT CEIL(AVG(SAL)) --올림값
            , FLOOR(AVG(COMM)) -- 내림값
            , SIGN( 10 -5 )  -- 양 음 수 판단            [1 = 양         -1 = 음        0 = 같음]
            , SIGN( 5-10 )
  FROM EMP
WHERE DEPTNO = 30;

--7-15 DISTINCT 로 중복을 제거한 급여 열의 평균 급여 구하기
SELECT AVG(DISTINCT SAL)
  FROM EMP
WHERE DEPTNO = 30;

-- 07 -2 절 결과 값을 원하는 열로 묶어 출력하는 GROUP BY 절
-- 7-16 집합 연산자
SELECT CEIL(AVG(SAL)), '10' AS DEPTNO FROM EMP WHERE DEPTNO = 10
UNION
SELECT CEIL(AVG(SAL)), '20' AS DEPTNO FROM EMP WHERE DEPTNO = 20
UNION
SELECT CEIL(AVG(SAL)), '30' AS DEPTNO FROM EMP WHERE DEPTNO = 30;

-- GROUP BY로 묶으면 이렇게 줄일 수 있음
SELECT CEIL(AVG(SAL)), DEPTNO
FROM EMP
GROUP BY DEPTNO;

-- 7-18 부서번호 및 직책별 평균 급여
SELECT DEPTNO, JOB, AVG(SAL)
  FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY  DEPTNO, JOB;
--7-19 GROUP BY 절에 없는 열을 SELECT 절에 포함 시 오류 발생
SELECT DEPTNO, JOB, AVG(SAL)
  FROM EMP
GROUP BY DEPTNO;

--7-20
SELECT DEPTNO
            , JOB
            , CEIL(AVG(SAL) OVER (ORDER BY DEPTNO))
FROM EMP;
-- GROUP BY를 안 쓸 때 쓸 때 차이
-- 7-21
SELECT DISTINCT DEPTNO, CHG_SAL
   FROM (
     SELECT DEPTNO
          , CEIL( AVG(SAL) OVER (ORDER BY DEPTNO) ) AS CHG_SAL
       FROM EMP
);

SELECT DEPTNO
            , CEIL(AVG(SAL))
  FROM EMP
GROUP BY DEPTNO;


-- SELECT > FROM > WHERE > GROUP BY 

--7-22
SELECT DEPTNO
            , CEIL(AVG(SAL))
  FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2000     -- WHERE 절과 HAVING절 같이 사용 가능
ORDER BY DEPTNO;


--7-23 급여가 
SELECT DEPTNO, JOB, AVG(SAL)
  FROM EMP
WHERE SAL <= 3000
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) > 2000;

-- STDEV 표준편차, VARIANCE 분산
--  중간문제

-- EMPLOYEES 테이블에서 SALARY가 8000이상인 직원의 수를 조회
SELECT COUNT(*)
  FROM EMPLOYEES
WHERE SALARY > 8000;


-- EMPLOYEES 테이블에서 HIRE_DATE가 2007년 01월 01일 이후의 직원의 수를 조회
SELECT COUNT(HIRE_DATE)
  FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE) > '2007/01/01';

-- JOBS 테이블에서 MAX_SALARY 값의 합계와 평균을 조회
SELECT SUM(MAX_SALARY), AVG(MAX_SALARY)
  FROM JOBS;

-- EMPLOYEES  테이블에서 JOB_ID가 'IT_PROG'인 직원의 SALARY 합계와 평균을 조회
SELECT SUM(SALARY), AVG(SALARY)
  FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

-- EMPLOYEES 테이블에서 DEPARTMENT_ID가 50~80 인 직원의 FIRST_NAME, SALARY,
-- 그리고 COMMISION_PCT의 평균 값을 FIRST_NAME 정렬 기준으로 조회(NULL 값은 0으로 치환할 것)

SELECT FIRST_NAME, LAST_NAME ,SALARY
            ,AVG(NVL(COMMISSION_PCT,0)) 
                             OVER (ORDER BY FIRST_NAME) AS COM_AVG
  FROM EMPLOYEES
WHERE DEPARTMENT_ID BETWEEN 50 AND 80;

SELECT first_name, last_name, salary
     , round(avg(nvl(commission_pct,0)) 
             over (order by first_name), 10.2)  com_avg   
     , nvl(commission_pct,0)
  FROM employees
 WHERE department_id between 50 and 80 
   and first_name = 'David'  ;

-- JOBS 테이블에서 MAX SALARY 의 최솟값과  최댓값을 조회
SELECT MIN(MAX_SALARY), MAX(MAX_SALARY)
  FROM JOBS;
-- JOBS 테이블에서 JOB_TITLE 'Programmer'의 직업의 Max_Salary 값의 최솟값과 최댓값을 조회
SELECT MIN(MAX_SALARY), MAX(MAX_SALARY)
  FROM JOBS
WHERE JOB_TITLE = 'Programmer';

-- Employees 테이블에서 Department_id가 50인 데이터의 hiredate의 최솟값과 최댓값 조회
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

-- Employees 테이블에서 department_id가 100인 데이터의 frist_name, salary 그리고 salary의 분산 값을 hire_date 정렬 기준으로 조회

SELECT first_name, salary, 
       VARIANCE(salary) OVER ( ORDER BY hire_date ) 
  FROM employees
 WHERE department_id = 100;






-- 07-4 그룹화와 관련된 여러 함수 = ROLLUP, CUBE, GROUPING SETS 함수
--07-24 기존 GROUP BY 절만 사용한 그룹화

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
  FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

-- 07-25 ROLLUP
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
  FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);

 --7-26  CUBE
 SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
  FROM EMP
 GROUP BY CUBE( DEPTNO, JOB )
 ORDER BY DEPTNO, JOB;

-- ROLLUP(A,B)
/******************************
    1. A 그룹 별 B 그룹 별 해당하는 결과출력
    2. A 그룹에 해당하는 결과 출력
    3. 전체 데이터 결과 출력
*******************************/
-- CUBE(A,B) - 해당 항목 모든 경우의 수를 모두 집계 출력 2^N 승으로 나옴 N=그룹 수
/******************************
    1. A 그룹 별 B 그룹 별 해당하는 결과출력
    2. A 그룹에 해당하는 결과 출력
    3. B 그룹에 해당하는 결과 출력
    3. 전체 데이터 결과 출력
*******************************/
-- 7- 27 DEPTNO 를 먼저 그룹화한 후 ROLLUP 함수에 JOB 지정하기
SELECT DEPTNO, JOB, COUNT(*)
  FROM EMP
 GROUP BY DEPTNO, ROLLUP(JOB);
 
 SELECT  JOB, DEPTNO, COUNT(*)
  FROM EMP
 GROUP BY JOB, ROLLUP(DEPTNO);
  
  
--7-29 GROUPING SETS 함수
SELECT DEPTNO, JOB, COUNT(*)
  FROM EMP
 GROUP BY GROUPING SETS(DEPTNO, JOB)
 ORDER BY DEPTNO, JOB;
 
 -- 7-30 DEPTNO, JOB 열의 그룹화 여부 확인  : GROUPING
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
     , GROUPING(DEPTNO)
     , GROUPING(JOB)
  FROM EMP
 GROUP BY ROLLUP( DEPTNO, JOB );   


SELECT DECODE(GROUPING(DEPTNO), 1, '총계', DEPTNO) AS DEPTNO
     , DECODE(GROUPING(JOB), 1, DECODE(GROUPING(DEPTNO),1,' ', '소계'), JOB) AS JOB
     , COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL)) AS AVG
    -- , GROUPING(DEPTNO)
    -- , GROUPING(JOB)
  FROM EMP
 GROUP BY ROLLUP( DEPTNO, JOB );  
 

SELECT DEPTNO
  FROM EMP
  GROUP BY DEPTNO;
  
-- 7-33
SELECT DEPTNO, ENAME
  FROM EMP
GROUP BY DEPTNO, ENAME;
-- LISTAGG WITHIN 활용
SELECT DEPTNO
            , LISTAGG(ENAME, ',')
              WITHIN GROUP (ORDER BY SAL DESC) AS ENAMES
  FROM EMP
GROUP BY DEPTNO;

-- 7-35 DECODE문을 활용하여 PIVOT 함수와 같은 출력 구현 -- 11 버전부터 추가된 것
SELECT DEPTNO
            , MAX(DECODE(JOB, 'CLERK', SAL)) AS "CLERK"
            , MAX(DECODE(JOB, 'SALESMAN', SAL)) AS "SALESMAN"
            , MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESIDENT"
            , MAX(DECODE(JOB, 'MANAGER', SAL)) AS "MANAGER"
            , MAX(DECODE(JOB, 'ANALYST', SAL)) AS "ANALYST"
  FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;


-- 7-36 PIVOT 함수
SELECT *
  FROM (  SELECT DEPTNO, JOB, SAL           -- 서브쿼리
                 FROM EMP  )
  PIVOT (MAX (SAL)
               FOR DEPTNO IN(10,20,30)  )
  ORDER BY JOB;

-- 7-37 부서별 직책 최고 급여 2차원 표 형태로 출력
SELECT *
  FROM (  SELECT JOB, DEPTNO, SAL     
                 FROM EMP  )
  PIVOT (MAX (SAL)
               FOR JOB IN('CLERK' AS "CLERK",
                                    'SALESMAN' AS "SALESMAN",
                                    'PRESIDENT' AS "PRESIDENT",
                                    'MANAGER' AS "MANAGER",
                                    'ANALYST' AS "ANALYST"
               )  )

  ORDER BY DEPTNO;

--7-39
SELECT *
    FROM(
            SELECT DEPTNO
                , MAX(DECODE(JOB, 'CLERK', SAL)) AS "CLERK"
                , MAX(DECODE(JOB, 'SALESMAN', SAL)) AS "SALESMAN"
                , MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESIDENT"
                , MAX(DECODE(JOB, 'MANAGER', SAL)) AS "MANAGER"
                , MAX(DECODE(JOB, 'ANALYST', SAL)) AS "ANALYST"
      FROM EMP
    GROUP BY DEPTNO
    ORDER BY DEPTNO
    )
    
    UNPIVOT(
        SAL FOR JOB IN (CLERK, SALESMAN, PRESIDENT, MANAGER, ANALYST)
    )

;


