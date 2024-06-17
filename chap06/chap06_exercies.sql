-- 6 장 
-- 문자 데이터를 가공하는 문자함수 page 130
-- 6-1  
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
 FROM EMP;
 
 
 -- 6-2
 SELECT *
   FROM EMP
 WHERE UPPER(ENAME) = UPPER('scott'); -- 소문자로 안에 입력해도 UPPER 함수를 받아 대문자가 됨
 
 SELECT *
   FROM EMP
WHERE LOWER(ENAME) = LOWER('SCOTT'); -- 위와 동일

-- 6-3
SELECT *
  FROM EMP
WHERE UPPER(ENAME) LIKE UPPER('%Scott%'); -- LIKE와 같이 사용하는 경우가 많음

-- 6-4 : 문자열 길이를 구하는 LENGTH 함수
SELECT ENAME, LENGTH(ENAME)
  FROM EMP;
  
--6-5 : 사원 이름의 길이가 5 이상인 행을 출력하시오 -> WHERE 절에도 LENGTH함수를 사용할 수 있음
 SELECT ENAME, LENGTH(ENAME)
   FROM EMP
 WHERE LENGTH(ENAME) >= 5;

-- 6-6
SELECT LENGTH('한글'), LENGTHB('한글')
  FROM DUAL;

SELECT SYSDATE FROM DUAL;


-- 직책 이름이 6글자 이상인 데이터 출력 쿼리 작성
SELECT JOB, LENGTH(JOB)
  FROM EMP
WHERE LENGTH(JOB) >=6;


-- 문자열 일부를 추출하는 SUBSTR 함수 SUBSTR(컬럼명, 시작위치, 추출길이) 함수
SELECT JOB, SUBSTR(JOB, 1, 2) -- NUMBERING이 1부터 시작 따라서 0이 아닌 1부터 시작
  FROM EMP;

--6-7
SELECT JOB, SUBSTR(JOB, 1, 2) -- NUMBERING이 1부터 시작 따라서 0이 아닌 1부터 시작
            --, SUBSTR(JOB, 3, 2) -- 3번째부터 2글자
            --, SUBSTR(JOB, 5) -- 끝나는 길이를 말해주지 않으면 전부다 가져옴
            , SUBSTR(JOB, -5) -- 뒤에서부터 시작위치를 COUNT 함 -5부터 끝까지 
  FROM EMP;

SELECT JOB
            , SUBSTR(JOB, -LENGTH(JOB)) -- 처음부터 끝까지 잘라오세요
            , SUBSTR(JOB, -LENGTH(JOB),2) -- 처음부터 2조각
            , SUBSTR(JOB, -3) -- 뒤에서 3번째부터 끝까지
  FROM EMP;

-- INSTR
SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1
            , INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_1 -- 나오는 위치 찾기  5번째부터 찾아서 그 다음 L이 나오는 위치 반환
            , INSTR('HELLO, ORACLE!', 'L',2,2) AS INSTR_1 --4 2번째부터 찾아서 2번째로 L이 나오는 위치 반환
  FROM DUAL;


-- 6-10
SELECT *
  FROM EMP
WHERE INSTR(ENAME, 'S') > 0 ;

-- 6-11
SELECT *
  FROM EMP
WHERE ENAME LIKE '%S%';

-- 6-12  REPLACE
SELECT '010-1234-5678' AS REPLACE_BEFORE
              ,REPLACE('010-1234-5678', '-', ' ') AS REPLACE_1
              ,REPLACE('010-1234-5678','-') AS REPLACE_2
  FROM DUAL;
  
  
  -- LPAD, RPAD
SELECT 'Oracle'
            , LPAD('Oracle', 10,'#') AS LPAD_1
            , RPAD('Oracle', 10, '*') AS RPAD1
            , LPAD('Oracle', 10) AS LPAD_1
            , RPAD('Oracle', 10) AS RPAD1
  FROM DUAL;

-- 6-14 개인정보 마스킹 처리
-- SUBSTR(JUMIN, 1, 7)
SELECT RPAD('971225-', 14, '*') AS RPADF_MNO
            , RPAD('010-1234-', 13, '*') AS RPAD_PHONE
  FROM DUAL;

-- 6-15 두 열 사이에 파이프 ||
SELECT CONCAT(EMPNO, ENAME)
            , CONCAT(EMPNO, CONCAT(' | ', ENAME))
            , EMPNO || ' | ' || ENAME
  FROM EMP
WHERE DEPTNO = 10;

-- 6-16
SELECT TRIM('      __Oracle__          ') as T  --  TRIM = 공백제거
            , TRIM(LEADING FROM '      __Oracle__          ') AS LTRIM  -- 왼쪽 공백 제거
            , TRIM(TRAILING FROM '      __Oracle__          ') AS RTRIM -- 우측 공백 제거
            , TRIM(BOTH FROM '      __Oracle__          ') AS TRIM          -- 양쪽 공백 제거
  FROM  DUAL;


-- 6-17
SELECT TRIM('_' FROM '__Oracle__') as T  --  TRIM = _ 제거
            , TRIM(LEADING '_' FROM '__Oracle__') AS LTRIM  -- 왼쪽 _ 제거
            , TRIM(TRAILING '_' FROM '__Oracle__') AS RTRIM -- 우측 _ 제거
            , TRIM(BOTH '_' FROM '__Oracle__') AS TRIM          -- 양쪽 _ 제거
  FROM  DUAL;
  
  -- 6-18
SELECT TRIM('      __Oracle__          ') as T  --  TRIM = 공백제거
            , LTRIM( '      __Oracle__          ') AS LTRIM  -- 왼쪽 공백 제거
            , RTRIM('      __Oracle__          ') AS RTRIM -- 우측 공백 제거
            , LTRIM( '__Oracle__','_') AS LTRIM  -- 왼쪽 공백 제거
            , RTRIM('__Oracle__','_') AS RTRIM -- 우측 공백 제거
FROM DUAL;
            
            
-- jobs 테이블에서 job_title과 소문자와 대문자로 변환한 job_title을 조회
SELECT UPPER(JOB_TITLE), LOWER(JOB_TITLE)
  FROM JOBS;
-- employees 테이블에서 first_name 첫 1 문자와 last_name 조회
SELECT SUBSTR(FIRST_NAME,1,1), LAST_NAME
  FROM EMPLOYEES;
-- employees 테이블에서 job_id가 'REP' 인 부분을 'REPRESENTATIVE'로 바꿔서 조회
SELECT REPLACE(JOB_ID,'REP','REPRESENTATIVE')
  FROM EMPLOYEES;
-- employees  테이블에서 first_name 첫 1문자와 last_name을 중간에 공백을 두고 하나로 결합하여 조회
SELECT CONCAT(SUBSTR(FIRST_NAME,1,1), CONCAT(' ',LAST_NAME))
  FROM EMPLOYEES;
-- employees 테이블에서 first_name과 last_name의 길이를 합쳐서 조회
SELECT LENGTH(FIRST_NAME) + LENGTH(LAST_NAME) AS SUM
  FROM EMPLOYEES;
-- employees 테이블에서 job_id와 job_id에 'A' 문장 위치  조회  
SELECT JOB_ID, INSTR(JOB_ID, 'A')
  FROM EMPLOYEES;
-- locations 테이블 city를 15자리 문자열로 바꾸고, 빈 공간을 '.'으로 표현하여 조회
SELECT LPAD(CITY, 15, '.'), RPAD(CITY, 15, '.')
  FROM LOCATIONS;
-- locations 테이블에서 city의 왼쪽부터 'S'문자를 지운 것과 오른쪽부터 'e' 문자를 지운 결과를 조회
SELECT CITY, LTRIM(CITY, 'S'), RTRIM(CITY,'e')
FROM LOCATIONS
WHERE CITY LIKE 'S%' OR CITY LIKE '%e';
  
  
  --06 - 3절 숫자 함수
SELECT ROUND(1234.5678)     AS ROUND -- 소수점 첫째 자리에서 반올림 해주세요.
            , ROUND(1234.5678,0) AS ROUND -- 소수점 첫째 자리에서 반올림 해주세요.
            , ROUND(1234.5678,1) AS ROUND -- 소수점 둘째 자리에서 반올림 해주세요.
            , ROUND(1234.5678,2) AS ROUND -- 소수점 세째 자리에서 반올림 해주세요.
            , ROUND(1234.5678,-1) AS ROUND -- 자연수 첫째 자리에서 반올림 해주세요.
            , ROUND(1234.5678,-2) AS ROUND -- 자연수 둘째 자리에서 반올림 해주세요.
  FROM DUAL;
  
    --06 - 3절 숫자 함수
SELECT TRUNC(1234.5678)     AS TRUNC -- 소수점 첫째 자리에서 버림 해주세요.
            , TRUNC(1234.5678,0) AS TRUNC1 -- 소수점 첫째 자리에서 버림 해주세요.
            , TRUNC(1234.5678,1) AS TRUNC1 -- 소수점 둘째 자리에서 버림 해주세요.
            , TRUNC(1234.5678,2) AS TRUNC2 -- 소수점 세째 자리에서 버림 해주세요.
            , TRUNC(1234.5678,-1) AS TRUNC_M1 -- 자연수 첫째 자리에서 버림 해주세요.
            , TRUNC(1234.5678,-2) AS TRUNC_M2 -- 자연수 둘째 자리에서 버림 해주세요.
  FROM DUAL;
  
  -- 6-21
SELECT CEIL(3.14) -- 정수자리에서 올림
            , FLOOR(3.14) -- 정수자리에서 버림
            , CEIL(-3.14)
            , FLOOR(-3.14)
  FROM DUAL;
-- 6-22 나머지 함수
SELECT MOD(15,6) -- 3
            , MOD(10, 2) --0
            , MOD(11, 2) --1
  FROM DUAL;
  
  
  -- 날짜 함수
-- 6-23
SELECT SYSDATE AS NOW
     , SYSDATE -1 AS YESTERDAY
     , SYSDATE +1 AS TOMORROW
  FROM DUAL;
-- 6-24
SELECT SYSDATE
           , ADD_MONTHS (SYSDATE,4) + 17
 FROM DUAL;
  
SELECT 12 * 38 FROM DUAL;
--6-25 입사 10주년
SELECT EMPNO, ENAME, HIREDATE,
       ADD_MONTHS(HIREDATE, 120) AS WORK10YEAR
  FROM EMP;
SELECT  12 * 38 FROM DUAL;  -- 456

SELECT EMPNO, ENAME, HIREDATE,
       ADD_MONTHS(HIREDATE, 456) AS WORK38YEAR
  FROM EMP;
 
 -- 6- 26 입사 38년 미만인 사원 
SELECT EMPNO, ENAME, HIREDATE,
       ADD_MONTHS(HIREDATE, 456) AS WORK38YEAR
  FROM EMP
 WHERE ADD_MONTHS(HIREDATE, 456) > SYSDATE;
  
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3) EMPL
  FROM DUAL;

-- 6-27
SELECT EMPNO, ENAME, HIREDATE, SYSDATE
    , MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS
    , TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS2
  FROM EMP;
  
 -- 6-28
SELECT SYSDATE
            , NEXT_DAY(SYSDATE, '월요일')
            , LAST_DAY(SYSDATE)
  FROM DUAL;
  
-- 6-29
SELECT SYSDATE
            , ROUND(SYSDATE, 'YYYY') AS FYYYY
            , ROUND(SYSDATE, 'Q') AS FYYYY
            , ROUND(SYSDATE, 'DDD') AS FYYYY
            , TRUNC(ROUND(SYSDATE, 'YYYY')) AS FYYYY
            , TRUNC(ROUND(SYSDATE, 'Q')) AS FYYYY
            , TRUNC(ROUND(SYSDATE, 'DDD')) AS FYYYY
  FROM DUAL;

SELECT SYSDATE
            , TRUNC(ROUND(SYSDATE, 'YYYY')) AS FYYYY
            , TRUNC(ROUND(SYSDATE, 'Q')) AS FYYYY
            , TRUNC(ROUND(SYSDATE, 'DDD')) AS FYYYY
  FROM DUAL;

  
-- 6-33  
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS')
            , TO_CHAR(SYSDATE, 'DAY') DAY
            , TO_CHAR(SYSDATE, 'DY') DY
            , TO_CHAR(SYSDATE, 'DD') DD
            , TO_CHAR(SYSDATE, 'MONTH') MONTH
            , TO_CHAR(SYSDATE, 'MON') MON
            , TO_CHAR(SYSDATE, 'MM') MM
  FROM DUAL;
  
  
  -- 6-34
SELECT TO_CHAR(SYSDATE, 'MM') MM
            , TO_CHAR(SYSDATE, 'MON') MON
            , TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') MON_JEN
            , TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH') MON_ENG
FROM DUAL;
  
  
-- 6-38 숫자형식
SELECT SAL, TO_CHAR(SAL, '999,999') SAL_1
     , TO_CHAR(SAL, '$999,999') SAL_1
     , TO_CHAR(SAL, 'L999,999') SAL_1
     , TO_CHAR(SAL, '0009999999') SAL_2
  FROM EMP;

-- 문자열 을 숫자로  
SELECT TO_NUMBER('1,300', '999,999')  
     - TO_NUMBER('1,500', '999,999')
  FROM DUAL;

-- 문자열을 날짜 데이타 변환
SELECT TO_DATE('2024-06-05', 'YYYY-MM-DD') AS TODATE
     , TO_DATE('20240605', 'YYYY-MM-DD') AS TODATE2
  FROM DUAL;
   
-- 6-45
SELECT EMPNO, ENAME, SAL, COMM
     , SAL*12+NVL(COMM,0) AS ANNSAL
     , NVL2(COMM, '널아님', '널임') N2
     --         값이있다면, 없을때
     , NVL2(COMM, SAL*12+COMM, SAL*12) ANN_SAL
  FROM EMP;
   
   
 --6-47
SELECT EMPNO, ENAME, JOB, SAL
            , DECODE(JOB, 'MANAGER', SAL * 1.1,
                                        'SALESMAN', SAL * 1.05,
                                        SAL * 1,03) AS UPSAL
  FROM EMP;
   
SELECT EMPNO, ENAME, JOB, SAL
            , DECODE(JOB, 'MANAGER', SAL * 1.1,
                                        'SALESMAN', SAL * 1.05,
                                        'ANALYST', SAL,
                                        SAL * 1.03) AS UPSAL
  FROM EMP;   
   
-- CASE 문
SELECT EMPNO, ENAME, JOB, SAL
            , CASE JOB
                    WHEN 'MANAGER' THEN SAL * 1.1
                    WHEN 'SALESMAN' THEN SAL * 1.05
                    WHEN 'ANALYST' THEN SAL
                    ELSE SAL * 1.03
              END AS UPSAL
  FROM EMP;

SELECT EMPNO, ENAME, COMM
            , CASE WHEN COMM IS NULL THEN '해당사항 없음'
                         WHEN COMM = 0 THEN '수당 없음'
                         WHEN COMM  > 0 THEN '수당 :  ' || COMM
              END AS COMM_TEXT
  FROM EMP;

-- 174 PAGE -Q1
SELECT EMPNO,
              RPAD(SUBSTR(EMPNO, 1, 2), 4, '*') AS MASKING_EMPNO,
              ENAME,
              RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS MASKING_ENAME
FROM  EMP
 WHERE LENGTH(ENAME) >= 5
   AND LENGTH(ENAME) < 6; 


-- 174 PAGE -Q2
SELECT EMPNO, ENAME, SAL
            , TRUNC((SAL/21.5),2) AS DAY_PAY
            , ROUND((SAL/21.5)/8,1) AS TIME_PAY
FROM EMP;

-- 175 PAGE -Q3
SELECT EMPNO, ENAME, HIREDATE
            , TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE,3), '월요일'),'YYYY-MM-DD') AS R_JOB
            , NVL(TO_CHAR(COMM), 'N/A') AS COMM
  FROM EMP;

-- 175 PAGE -Q4
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





