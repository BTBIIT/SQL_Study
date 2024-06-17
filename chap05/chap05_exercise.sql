--5장 : 더 정확하고 다양하게 결과를 출력하는 WHERE 절과 연산자

--5-1 PAGE 94
SELECT *
  FROM EMP;

--5-2
SELECT *
  FROM EMP
 WHERE DEPTNO = 30;
 
 -- 1분 복습
 -- 사원번호가 7782인 사원정보만 나오도록 쿼리를 작성하세요.
 SELECT *
   FROM EMP
  WHERE EMPNO = 7782;
-- '=' 비교연산자 == 

--5-3 AND 연산자로 여러개의 조건식을 사용할 수 있음
SELECT *
  FROM EMP
 WHERE DEPTNO = 30
   AND JOB = 'SALESMAN';        --  논리 연산자 AND, OR
   
--사원번호가 7499이고 부서번호가 30인 사원 정보만 나오도록 쿼리를 작성
SELECT *
  FROM EMP
 WHERE EMPNO = 7499
   AND DEPTNO = 30;
-- 두번째 답
SELECT *
  FROM EMP
 WHERE EMPNO = 7499;

-- 5-4 OR 연산자로 여러개의 출력 조건 사용하기
SELECT *
  FROM EMP
 WHERE DEPTNO = 30
    OR JOB = 'CLERK';
-- 1분 복습 : 부서번호가 20이거나 직업이 SALESMAN인 사원정보 출력 쿼리 작성
SELECT *
  FROM EMP
 WHERE DEPTNO = 20
    OR JOB = 'SALESMAN';

-- 5-5 산술연산자 급여열에 12를 곱한 값이 36000 인 행을 출력
SELECT *
  FROM EMP
 WHERE SAL * 12 = 36000;

-- 5-6 비교연산자 : 급여가 3000 이상인 사원정보 출력
SELECT *
  FROM EMP
 WHERE SAL >= 3000;

-- 1분 복습 : 급여가 2500 이상이고 직업이 ANALYST인 행 출력
SELECT *
  FROM EMP
 WHERE SAL >= 2500
   AND JOB = 'ANALYST';

-- 5-7 문자도 대 소 비교 가능
SELECT *
  FROM EMP
 WHERE ENAME >= 'F';

-- 5-8
SELECT *
  FROM EMP
 WHERE ENAME <= 'FORD';

--5-9 같지않다 ('<>', '!=', '^=')
SELECT *
  FROM EMP
 WHERE SAL <> 3000;
 
--5-10 같지않다 ('<>', '!=', '^=')
SELECT *
  FROM EMP
 WHERE SAL != 3000; 
 
 --5-11 같지않다 ('<>', '!=', '^=')
SELECT *
  FROM EMP
 WHERE SAL ^= 3000;
 
-- 5-12 논리 부정 연산자
SELECT *
  FROM EMP
 WHERE NOT SAL = 3000;
 
-- 5-13 
-- IN 연산자 : 중요 ***
-- OR 연산자를 사용 여러 개 조건을 만족하는 데이터 출력
SELECT * 
FROM EMP
WHERE JOB = 'MANAGER'
   OR JOB = 'SALESMAN'
   OR JOB = 'CLERK';

--5-14
SELECT *
FROM EMP
WHERE JOB IN('MANAGER', 'SALESMAN','CLERK');


--5-15 등가 비교 연산자와 AND 사용
SELECT *
  FROM EMP
 WHERE JOB != 'MANAGER'
   AND JOB <> 'SALESMAN'
   AND JOB ^= 'CLERK';
-- 5-16
SELECT *
  FROM EMP
 WHERE JOB NOT IN('MANAGER','SALESMAN','CLERK');
-- 1분 복습
SELECT *
  FROM EMP
 WHERE DEPTNO IN (10,20);
 
 -- 5-17 대소 비교연산자
 SELECT *
   FROM EMP
  WHERE SAL >= 2000
    AND SAL <= 3000;
    
    
 -- 5-18   BETWEEN  A  AND  B  범위 많이 사용 
SELECT *
  FROM EMP
 WHERE SAL BETWEEN 2000 AND 3000;  -- >=,   <=
  
 -- 5-19  
SELECT *
  FROM EMP
 WHERE SAL NOT BETWEEN 2000 AND 3000;  -- >=,   <=
 
 
-- LIKE 연산자와 와일드카드 : 매우 중요
-- 5-20 -- 이름이 s로 시작하는 직원 출력
SELECT *
  FROM EMP
 WHERE ENAME LIKE 'S%'; -- 와일드카드 : 특수문자 OR 문자열 대체 OR 패턴
/*
_ : 어떤 값이든 한개의 문자 데이터를 의미 
% : 길이와 상관 없이 모든 문자 데이터를 의미
*/
-- 사원이름에 두번째 글짜가 L인 사원만 출력
-- 5-21
SELECT *
 FROM EMP
WHERE ENAME LIKE '_L%'; -- 첫글자는 무조건 있어야함 _  -- L이 두번째여야함 _L -- 뒤에는 상관없음 _L%

-- 사원 이름에 AM이 포함된 사원 데이터 출력
-- 5-22
SELECT *
  FROM EMP
 WHERE ENAME LIKE '%AM%';
-- 반대조건
SELECT *
  FROM EMP
 WHERE ENAME NOT LIKE '%AM%';
 
 
-- 데이터로 _나 %문자가 포함되어있는 경우가 간혹 있음
INSERT INTO EMP VALUES
(7999,'A_ADAM','CLERK',    7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
COMMIT;
SELECT * FROM EMP; -- 들어간 자료 확인

SELECT * FROM EMP WHERE ENAME LIKE 'A_A%'; --이럴땐 이스케이프 문자를 써줘야함
SELECT * FROM EMP WHERE ENAME LIKE 'A\_A%' ESCAPE '\';


DELETE  FROM EMP WHERE ENAME LIKE 'A\_A%' ESCAPE '\';
COMMIT;
SELECT * FROM EMP;

--1
SELECT * 
  FROM EMPLOYEES
 WHERE FIRST_NAME = 'David';
--2
SELECT *
  FROM JOBS
 WHERE MIN_SALARY = 4000;
--3
SELECT *
  FROM JOBS
 WHERE MIN_SALARY > 8000;
--4
SELECT *
  FROM JOBS
 WHERE MAX_SALARY <= 10000;
--5
SELECT *
  FROM JOBS
 WHERE MIN_SALARY >= 4000 AND MAX_SALARY <=10000;
--6 
SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID = 'IT_PROG' AND SALARY > 5000;
 
 -- 5-24
SELECT ENAME, SAL, SAL * 12 + COMM AS ANNSAL, COMM
  FROM EMP;
 
 --5-25
 SELECT *
   FROM EMP
 WHERE COMM = NULL;  -- 실제로 데이터가 NULL로 입력된 것을 찾는것 (아무것도 없는 상태가 아닌 입력값이 NULL인거)
 
 -- 5-26
 SELECT *
   FROM EMP
 WHERE COMM IS NULL; 
 
 SELECT *
  FROM EMP
WHERE COMM IS NOT NULL;


-- 5-27 직속상관이 있는 사원 데이터만 출력
SELECT *
  FROM EMP
WHERE MGR IS NOT NULL; -- NULL 이 아니다 = 존재한다.

-- 5-28
SELECT *
  FROM EMP
WHERE SAL > NULL -- NULL은 존재 
    AND COMM IS NULL;

-- 5-29
SELECT *
  FROM EMP
WHERE SAL > NULL
        OR COMM IS NULL;
 
 
 -- 집합연산자 : UNION(중복을 허용하지 않는 합집합 = 교집합이 한번만 출력됨), 
 -- 집합연산자 : UNION ALL(중복을 허용하는 합집합), MINUS (차집합), INTERSECT(교집합)
--5-30 
 SELECT EMPNO, ENAME, SAL, DEPTNO 
   FROM EMP
WHERE DEPTNO = 10
UNION -- 합집합 -- 데이터, 쿼리가 같아야함 (열갯수 등)
SELECT EMPNO, ENAME, SAL, DEPTNO 
  FROM EMP
WHERE DEPTNO = 20;
 
 -- 5-35
 SELECT EMPNO, ENAME, SAL, DEPTNO 
   FROM EMP
WHERE DEPTNO = 10
UNION ALL -- 합집합 -- 데이터, 쿼리가 같아야함 (열갯수 등)
SELECT EMPNO, ENAME, SAL, DEPTNO 
  FROM EMP
WHERE DEPTNO = 10;
 
 --5-36
 SELECT EMPNO, ENAME, SAL, DEPTNO
   FROM EMP
MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
WHERE DEPTNO = 10;
 
 
 -- 5-37
 -- INTERSECT
 SELECT EMPNO, ENAME, SAL, DEPTNO
   FROM EMP
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
WHERE DEPTNO = 10;
 
 -- 연산자 우선순위
 -- 높은 순  : 산술 ( X, /, +, - 순)  >   비교연산자(대소 비교 (>,<), IS NULL, LIKE, IN)    >   BETWEEN >   논리 (NOT, AND, OR ...)
 
 
 SELECT *
  FROM EMP
WHERE ENAME LIKE '%S';
 
 SELECT  empno, ename, job, sal, deptno
   FROM  emp
 WHERE deptno = 30
      AND JOB = 'SALESMAN';
 
 SELECT empno, ename, sal, deptno
   FROM EMP
 WHERE deptno in (20,30) -- deptno = 20 OR deptno = 30;
     AND  sal > 2000;
     
SELECT empno, ename, sal, deptno
   FROM EMP
 WHERE deptno = 20 -- deptno = 20 OR deptno = 30;
     AND  sal > 2000     
UNION
SELECT empno, ename, sal, deptno
   FROM EMP
 WHERE deptno = 30 -- deptno = 20 OR deptno = 30;
     AND  sal > 2000;         
     
-------------------
SELECT *
  FROM EMP
WHERE SAL < 2000
        OR SAL > 3000;
     
SELECT ENAME, EMPNO, SAL, DEPTNO
  FROM EMP
WHERE ENAME LIKE '%E%'
     AND DEPTNO = 30
     AND SAL NOT BETWEEN 1000 AND 2000;
 
 
 --Q6
 SELECT *
   FROM EMP
WHERE COMM IS NULL -- 수당이 없음
     AND MGR IS NOT NULL -- 상급자 존재
     AND JOB IN ('MANAGER', 'CLERK')
     AND ENAME NOT LIKE '_L%';
 
 -- jobs 테이블에서 job_title 기준으로 정렬하여 직업조회
 SELECT *
   FROM JOBS ORDER BY JOB_TITLE;
 -- countries 테이블에서 country_name 기준 내림차순으로 정렬하여 조회
 SELECT *
 FROM COUNTRIES ORDER BY COUNTY_NAME DESC;
 -- employees 테이블에서 salary가 10000 ~ 12000 사이인 직원 조회
 SELECT *
   FROM EMPLOYEES 
 WHERE SALARY BETWEEN 10000 AND 12000;
 -- employees 테이블에서 job_id가 'IT_PROG' 와 'ST_MAN'인 직원 조회
 SELECT *
   FROM EMPLOYEES 
 WHERE JOB_ID IN ('IT_PROG', 'ST_MAN');
 -- employees 테이블에서 manager_id가 NULL인 직원 조회
 SELECT *
   FROM EMPLOYEES
 WHERE MANAGER_ID IS NULL;
 -- departments 테이블에서 manager_id가 NULL이 아닌 부서 조회
 SELECT *
   FROM DEPARTMENTS
 WHERE MANAGER_ID IS NOT NULL;
 -----------------------------------------------------------------------------------------------------------------------------
 -- employees  테이블에서 job_id가 'AD'로 시작하는 직원 조회
 SELECT *
 FROM EMPLOYEES
 WHERE JOB_ID LIKE 'AD%';
 
 -- employees 테이블에서  first_name에서 'ni'를 포함하는 직원 조회
 SELECT *
 FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%ni%';
 -- location 테이블에서 location_id, street_address, city에 대해 location_id가 3000이하인 데이터와 2000 이상인 데이터를 합집합(중복포함), 차집합, 교집합 한 결과 조회
 -- 합
 SELECT LOCATIONS.LOCATION_ID, LOCATIONS.STREET_ADDRESS, LOCATIONS.CITY
   FROM LOCATIONS
 WHERE LOCATION_ID >= 2000
UNION ALL
SELECT LOCATIONS.LOCATION_ID, LOCATIONS.STREET_ADDRESS, LOCATIONS.CITY
  FROM LOCATIONS
WHERE LOCATION_ID <= 3000;
-- 차
SELECT LOCATIONS.LOCATION_ID, LOCATIONS.STREET_ADDRESS, LOCATIONS.CITY
   FROM LOCATIONS
 WHERE LOCATION_ID >= 2000
MINUS
SELECT LOCATIONS.LOCATION_ID, LOCATIONS.STREET_ADDRESS, LOCATIONS.CITY
  FROM LOCATIONS
WHERE LOCATION_ID <= 3000;
--교
 SELECT LOCATIONS.LOCATION_ID, LOCATIONS.STREET_ADDRESS, LOCATIONS.CITY
   FROM LOCATIONS
 WHERE LOCATION_ID >= 2000
INTERSECT
SELECT LOCATIONS.LOCATION_ID, LOCATIONS.STREET_ADDRESS, LOCATIONS.CITY
  FROM LOCATIONS
WHERE LOCATION_ID <= 3000;
 
 
 
 
 
 
 
 
 