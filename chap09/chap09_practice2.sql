-- 09 서브쿼리

-- DEPARTEMENTS 테이블에서 DEPARTMENT_NAME이 IT인 
-- DEPARTMENT_ID와 일치하는 EMPLOYEES 테이블의 FIRST_NAME, LAST_NAME, JOB_ID, SALARY를 조회
SELECT EM.FIRST_NAME, EM.LAST_NAME, EM.JOB_ID, EM.SALARY
  FROM EMPLOYEES EM
WHERE EM.DEPARTMENT_ID = (SELECT DP.DEPARTMENT_ID FROM DEPARTMENTS DP WHERE DP.DEPARTMENT_NAME = 'IT');

-- LOCATIONS 테이블에서 STATE_PROVINCE이 'CALIFORNIA' 인 LOCATION_ID와
-- 일치하는 DEPARTMENTS 테이블의 DEPARTMENT_ID, DEPARTMENT_NAME을 조회
SELECT DP.DEPARTMENT_ID, DP.DEPARTMENT_NAME
  FROM DEPARTMENTS DP
WHERE DP.LOCATION_ID = (SELECT L.LOCATION_ID FROM LOCATIONS L WHERE L.STATE_PROVINCE = 'California');

-- COUNTRIES 테이블에서 REGION_ID가 3인 COUNTRY_ID가 포함된 LOCATIONS 테이블의 CITY, STATE_PROVINCE, STREET_ADDRESS를 조회
SELECT L.CITY, L.STATE_PROVINCE, L.STREET_ADDRESS
  FROM LOCATIONS L
WHERE L.COUNTRY_ID = ANY (SELECT C.COUNTRY_ID FROM COUNTRIES C WHERE C.REGION_ID = 3);

-- DEPARTMENTS 테이블에서 MANAGER_ID가 NULL이 아닌 DEPARTMENT_ID와 일치하는 EMPLOYEES 테이블의 
-- FIRST_NAME, LAST_NAME, JOB_ID, SALARY를 조회
SELECT EM.FIRST_NAME, EM.LAST_NAME, EM.JOB_ID, EM.SALARY
  FROM EMPLOYEES EM
WHERE EM.DEPARTMENT_ID = ANY (SELECT DP.DEPARTMENT_ID FROM DEPARTMENTS DP WHERE DP.MANAGER_ID IS NOT NULL);

-- LOCATIONS 테이블에서 CITY가 'Seattle'를 포함하지 않는 LOCATION_ID와 일치하는 DEPARTMENTS 테이블의 DEPARTMENT_ID, DEPARTMENT_NAME을 조회
SELECT DP.DEPARTMENT_ID, DP.DEPARTMENT_NAME
  FROM DEPARTMENTS DP
WHERE DP.LOCATION_ID = ANY (SELECT L.LOCATION_ID FROM LOCATIONS L WHERE L.CITY != 'Seattle');

-- REGIONS 테이블에서 REGION_NAME이 'EUROPE' 인 REGION_ID가 일치하는 COUNTRIES 테이블에서 COUNTRY_ID가 포함된
-- LOCATIONS 테이블의 CITY, STATE_PROVINCE, STREET_ADDRESS를 조회
SELECT CITY, STATE_PROVINCE, STREET_ADDRESS
  FROM LOCATIONS
WHERE COUNTRY_ID IN (SELECT COUNTRY_ID FROM COUNTRIES WHERE REGION_ID
                                            = (SELECT REGION_ID FROM REGIONS WHERE REGION_NAME = 'Europe'));
