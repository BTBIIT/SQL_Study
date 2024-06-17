--chap 13 
-- 데이터 사전 뷰는 용도에 따라 이름 앞에 다음과 같은 접두어를 지정하여 분류함
--  USER_XXXX   :   현재 데이터베이스에 접속한 사용자가 소유한 객체 정보
--  ALL_XXXX      :   현재 데이터베이스에 접속한 사용자가 소유한 객체 또는 다른 사용자가 소유한 객체 중 사용 허가를 받은 객체, 즉 사용 가능한 모든 객체 정보
-- DBA_XXXX     :    데이터베이스 관리를 위한 정보 (데이터베이스 관리 권한을 가진 SYSTEM, SYS 사용자만 열람 가능)
-- V$_XXXX        :    데이터 베이스 성능 관련 정보 (x$_XXXX 테이블의 뷰)

-- 데이터  사전에는 데이터베이스 메모리 성능 사용자 권한 객체 등 오라클 데이터베이스 운영에 중요한 데이터가 보관되어 있음 만약 이 데이터에 문제가 발생한다면
-- 오라클 데이터베이스 사용이 불가능해질 수도 있음
-- 따라서 오라클 데이터베이스는 사용자가 데이터 사전 정보에 직접 접근하거나 작업하는 것을 허용하지 않고, 그 대신 데이터 사전 뷰를 제공하여 SELECT 문으로 정보 열람을 할 수 있게 해둠

-- 13-1
SELECT * FROM DICT;
-- 동일한 명령어 인듯
SELECT * FROM DICTIONARY;

-- USER_접두어를 가진 데이터 사전
-- 계정이 가지고 있는 객체 정보 살펴보기(USER_ 접두어 사용)
SELECT TABLE_NAME
  FROM USER_TABLES;
  
-- ALL_ 접두어를 가진 데이터 사전
SELECT OWNER, TABLE_NAME
  FROM ALL_TABLES;
-- ALL_TABLES에는 USER_TABLES와 달리 OWNER열이 하나 더있음 이 열은 테이블을 소유한 사용자를 명시함, 
-- 앞장에서 아용한 DUAL 테이블은 오라클 관리 계정 SYS 소유이고 HR계정은 이 테이블을 허가 받은 것


-- DBA_ 접두어를 가진 데이터 사전
SELECT * FROM DBA_TABLES;       -- 사용 권한이 없는 사용자는 존재하지 않습니다 오류를 나타냄 table or view does not exist
SELECT * FROM DBA_TABLES;       -- 우측 상단에서 SYS로 계정 변경 후 실행 했을 때는 나타남

-- 인덱스 사용하기
-- HR 유저가 소유한 인덱스 정보 알아보기
SELECT *
    FROM USER_INDEXES;
-- HR 유저가 소유한 인덱스 컬럼 정보 알아보기
SELECT *
    FROM USER_IND_COLUMNS;

-- 인덱스 생성 EMP 테이블의 SAL 열에 인덱스를 생성하기
CREATE INDEX IDX_EMP_SAL -- table or view does not exist" 라는 문구가 보인다면 SYS를 HR로 변경해보자 
    ON  EMP(SAL);                       -- 쿼리에 언급된 테이블이나 뷰가 없을때 나타나는 메세지다.

-- 인덱스 삭제
DROP INDEX IDX_EMP_SAL;

SELECT * FROM USER_IND_COLUMNS; -- 인덱스의 정보를 확인하는 법 INDEX_NAME   TABLE_NAME  COLUMN_NAME COLUMN_POSITION COLUMN_LENGTH   CHAR_LENGTH DESCEND로 나타남

-- 뷰란? 가상테이블을 부르는 명칭으로 하나 이상의 테이블을 조회하는 SELECT문을 저장한 객체를 의미함. SELECT문을 저장하기 때문에 물리적 데이터를 따로 저장하지는 않음
SELECT EMPNO, ENAME, JOB, DEPTNO
    FROM EMP
WHERE DEPTNO = 20;
-- ==>
SELECT *
    FROM(SELECT EMPNO, ENAME, JOB, DEPTNO
                    FROM EMP
                WHERE DEPTNO = 20);
                
-- 뷰생성
CREATE VIEW VW_EMP20
    AS (SELECT EMPNO, ENAME, JOB, DEPTNO
                FROM EMP
            WHERE DEPTNO = 20);
SELECT *
    FROM USER_VIEWS;
    
SELECT VIEW_NAME, TEXT_LENGTH, TEXT
    FROM USER_VIEWS;
    
-- 생성한 뷰 조회하기
SELECT *
    FROM VW_EMP20;
-- 뷰의 사용 목적(편리성)
-- 1. 편리성 : SELECT 문의 복잡도를 완화하기 위해
-- 2. 보안성 : 테이블의 특정열을 노출하고 싶지 않을 경우

-- 생성한 뷰 삭제하기
DROP VIEW VW_EMP20;

-- 인라인 뷰를 사용한 TOP-N SQL 문
SELECT ROWNUM, E.*  -- ROWNUM이란 문자는 존재하지 않지만 해당 숫자가 나타나는 것을 확인할 수 있음
    FROM EMP E;             -- 이 경우 의사 열이라고 하는 특수 열임

-- EMP 테이블을 SAL 열 기준으로 정렬하기
SELECT ROWNUM, E.*
    FROM EMP E
ORDER BY SAL DESC;

-- 13-22 -- 위 테이블을 서브쿼리로 나타낼 때
SELECT ROWNYM, E.*
    FROM (SELECT *  FROM EMP E  ORDER BY SAL DESC) E;
    
--13-23 -- WITH 문을 사용할 때
WITH E AS (SELECT * FROM EMP ORDER BY SAL DESC)
SELECT ROWNUM, E.*
    FROM E;

--13-24 인라인 뷰로 TOP-N 추출하기 (서브쿼리 사용)
SELECT ROWNUM, E.*
    FROM(SELECT *   FROM EMP E  ORDER BY SAL DESC) E
WHERE ROWNUM <= 3;

-- 13-25 인라인 뷰로 TOP-N 추출하기 (WITH 절 사용)
WITH E AS (SELECT * FROM EMP ORDER BY SAL DESC) 
SELECT ROWNUM, E.*
    FROM E
WHERE ROWNUM <= 3;

-- 13-4
-- 시퀀스란?
-- 시퀀스는 오라클 데이터 베이스에서 특정 규



























