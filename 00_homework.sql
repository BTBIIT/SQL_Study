-- countires 테이블 조회
SELECT * 
  FROM COUNTRIES;

-- countires 테이블에서 country_id와 country_name 컬럼만 조회
SELECT COUNTRY_ID, COUNTRY_NAME
  FROM COUNTRIES;

-- countires 테이블에서 컬럼명 country_id를 국가ID, country_name을 국가명으로 조회
SELECT COUNTRY_ID AS "국가ID", COUNTRY_NAME AS "국가명"
  FROM COUNTRIES;

-- countries 테이블에서 region_id를 중복제외하고 조회
SELECT DISTINCT REGION_ID
  FROM COUNTRIES;

-- countires 테이블에서 country_name과 country_id를 연결하여 조회
SELECT COUNTRY_NAME | | '     ' || COUNTRY_ID AS 국가명_국가ID
  FROM COUNTRIES;
-- locations 테이블에서 street_address와 city 컬럼만 조회
SELECT STREET_ADDRESS, CITY
  FROM LOCATIONS;

-- jobs 테이블에서 jobs_id와 job_title 컬럼만 조회
SELECT JOB_ID, JOB_TITLE
  FROM JOBS;

-- jobs 테이블에서 job_title, min_salary, max_salary 컬럼을 최소연봉과 최대연봉을 10% 인상된 상태로 조회
SELECT JOB_TITLE, MIN_SALARY * 1.1, MAX_SALARY * 1.1
  FROM JOBS;

-- employees 테이블에서 first_name과 last_name을 연결하고 컬럼명을 이름으로 조회
SELECT FIRST_NAME ||'  '|| LAST_NAME AS 이름
  FROM EMPLOYEES;

-- employees 테이블에서 job_id를 중복제외하고 조회
SELECT DISTINCT JOB_ID
  FROM EMPLOYEES;
-- employees 테이블에서 first_name이 'David'인 직원 조회
SELECT * 
  FROM EMPLOYEES
 WHERE FIRST_NAME = 'David';
-- jobs 테이블에서 최소 월급이 4000달러인 직업 조회
SELECT JOB_ID
  FROM JOBS
WHERE MIN_SALARY = 4000;

-- jobs 테이블에서 최소 월급이 8000달러 초과인 직업 조회
SELECT JOB_ID
  FROM JOBS
WHERE MIN_SALARY > 8000;
-- jobs 테이블에서 최대 월급이 10000달러 이하인 직업 조회
SELECT JOB_ID
  FROM JOBS
WHERE MAX_SALARY <= 10000;
-- jobs 테이블에서 최소 월급이 4000이상이고 최대 월급이 10000 이하인 직업 조회
SELECT JOB_ID
  FROM JOBS
WHERE min_salary >= 4000 AND max_salary < 10000;
-- employee 테이블에서 job_id가 'IT-PROG'이면서 salary가 5000초과인 직원 조회
SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID = 'IT_PROG' AND SALARY > 5000;
 
 
 
 -- IS NULL 연산자
 SELECT ENAME, SAL, SAL*12 + COMM AS "ANNSAL", COMM
 FROM EMP;