--4-1
DESC EMP;


--4-2, 3
DESC DEPT;
DESC SALGRADE;

--4-4
SELECT * FROM EMP;
SELECT * FROM EMP WHERE ROWNUM = 1; -- 전체에서 EMP테이블에서 
-- ROWNUM은 SELECT 해온 데이터에 일련번호를 붙이는 것이다.

-- 4-5
SELECT EMPNO, ENAME, DEPTNO -- 원하는 열 다중선택 *
  FROM EMP;                 -- EMP에서 

-- 4-6 중복 데이타를 삭제하는 DISTINCT
SELECT DISTINCT DEPTNO
  FROM EMP;

-- 4-7 열이 여러개
SELECT DISTINCT DEPTNO, JOB
  FROM EMP;

-- 4-8 ALL 중복되는 열 제거 없이 그대로 출력
SELECT ALL DEPTNO, JOB
  FROM EMP;
  
-- 4-9 열에 연산식을 사용
SELECT ENAME, SAL, SAL*12+COMM ANNSAL, COMM FROM EMP; -- 사원이름 급여 연봉 (별칭) 인센 
SELECT ENAME, SAL, SAL*12+COMM "ANNSAL", COMM FROM EMP; -- 별칭의 사용법
SELECT ENAME, SAL, SAL*12+COMM AS ANNSAL, COMM FROM EMP;
SELECT ENAME, SAL, SAL*12+COMM AS "ANNSAL", COMM FROM EMP;
  
-- 4-10 열에 연산식을 사용
SELECT ENAME, SAL
       , SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL++SAL+SAL+COMM AS ANNSAL -- AS = 별칭 -> AS를 빼고 한칸을 띄워주는 걸로 할 수 있음 하지만 대부분 AS를 써줌
       , COMM    -- 사원명, 급여, 연봉, 수당
  FROM EMP;
  
-- 4-11
SELECT ENAME, SAL, SAL*12+COMM AS ANNSAL, COMM FROM EMP;
--4-12 원하는 순서대로 출력 데이터를 정렬하는 ORDER BY
SELECT *
FROM EMP
ORDER BY SAL;

-- 4-12 1분 실습 사원 번호 순으로 나타내보아라
SELECT *
FROM EMP
ORDER BY EMPNO;

-- 4-13 -- 급여 순 내림차순 : 많이 받는 사람 순
SELECT *
FROM EMP
ORDER BY SAL DESC;

-- 4-13 최근 입사한 사람 순 -- 1분실습
SELECT *
FROM EMP
ORDER BY HIREDATE DESC;

-- 4-14 각각의 열에 내림차순과 오름차순을 동시에 사용
SELECT *
  FROM EMP
 ORDER BY DEPTNO ASC, SAL DESC; -- 먼저 DEPTNO(부서번호)오름차순 정렬된 데이터에서 그 안의 SAL을 기준으로 내림차순

-- 4-15 -- 1분실습
SELECT DISTINCT JOB
FROM EMP;

-- 4-16 -- 1분실습
SELECT EMPNO AS EMPLOYEE_NO
       , ENAME AS EMPLOYEE_NAME
       , JOB
       , MGR AS MANGER
       , HIREDATE 
       , SAL AS SALARY
       , COMM AS COMMISION
       , DEPTNO AS DEPARTMENT_NO
       FROM EMP
       ORDER BY DEPTNO DESC, ENAME;
       
-- 테이블 전체 조회
SELECT *
    FROM DEPARTMENTS;
    
    
-- 2. 특정 컬럼만 조회
SELECT DEPARTMENT_ID
     , DEPARTMENT_NAME
  FROM DEPARTMENTS;

-- 3. 별칭 설정
SELECT DEPARTMENT_ID AS 부서ID
     , DEPARTMENT_NAME AS 부서이름
  FROM DEPARTMENTS;
  
-- 4. 중복 제외
SELECT DISTINCT LOCATION_ID
  FROM DEPARTMENTS;
  
-- 5. 산술 연산
SELECT FIRST_NAME, LAST_NAME
     , SALARY, SALARY+500
  FROM EMPLOYEES;

SELECT FIRST_NAME, LAST_NAME
     , SALARY, SALARY+500, SALARY * 1.1
     , SALARY -500, SALARY / 1.2
  FROM EMPLOYEES;
  
-- 연결 연산자 : ||
SELECT DEPARTMENT_ID ||' ' ||DEPARTMENT_NAME AS 부서이름-- 문자열 연결
    ,  DEPARTMENT_NAME || ' |' || DEPARTMENT_ID || '|' AS 부서명
  FROM DEPARTMENTS;

--1
SELECT *
FROM COUNTRIES;
--2
SELECT COUNTRY_ID, COUNTRY_NAME
FROM COUNTRIES;
--3
SELECT COUNTRY_ID AS "국가ID", COUNTRY_NAME AS "국가명"
FROM COUNTRIES;
--4
SELECT DISTINCT REGION_ID
FROM COUNTRIES;
--5
SELECT COUNTRY_NAME ||'  ' || COUNTRY_ID 
FROM COUNTRIES;

--1
SELECT STREET_ADDRESS, CITY
  FROM LOCATIONS;
--2
SELECT JOB_ID, JOB_TITLE
  FROM JOBS;
--3 
SELECT JOB_TITLE, MIN_SALARY * 1.1 AS "최소연봉", MAX_SALARY * 1.1 AS "최대연봉"
  FROM JOBS;
--4
SELECT FIRST_NAME || ' ' || LAST_NAME AS 이름
  FROM EMPLOYEES;
--5
SELECT DISTINCT JOB_ID
  FROM EMPLOYEES;







