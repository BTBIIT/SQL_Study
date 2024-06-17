--chapter 15 사용자 관리

-- 스키마	:	데이터베이스에서 데이터간 관계, 구조, 제약조건 등
--					데이터를 저장, 관리하기 위해 정의한 데이터베이스 구조의 범위
--					데이터베이스에 접속한 사용자와 연결된 객체
--					
--					connnect sys/oracle as sysdba;
--					alter user hr identified by 1234 account unlock;

CREATE USER ORCLSTUDY
IDENTIFIED BY ORACLE;		-- HR에게는 유저 생성권한이 없음

CREATE TABLE TEMP(
	COL1	VARCHAR2(20),
	COL2	VARCHAR2(20)
);

GRANT SELECT ON TEMP TO ORCLSTUDY;	-- 객체(TABLE) 을 사용자에게 SELECT 권한을 줌
GRANT INSERT ON TEMP TO ORCLSTUDY;	-- 객체(TABLE) 을 사용자에게 INSERT 권한을 줌

REVOKE SELECT ,INSERT ON TEMP FROM ORCLSTUDY;

-- 		사용자 생성	:	CREATE	USER
-- 		권한 부여		:	GRANT
-- 		권한 취소		:	REVOKE
--		




-- 15장 사용자 관리

-- 스키마: 데이터베이스에서 데이터 간 관계, 구조, 제약조건 등
--        데이터를 저장, 관리하기 위해 정의한 데이터베이스 구조의 범위
--        - 데이타베이스에 접속한 사용자와 연결된 객체를 의미

-- connect sys/oracle as sysdba;
-- alter user hr identified by 1234 account unlock;

CREATE USER ORCLSTUDY
IDENTIFIED BY ORACLE;  -- ORA-01031: insufficient privileges

CREATE TABLE TEMP(
    COL1 VARCHAR2(20),
    COL2 VARCHAR2(20)
);

GRANT SELECT 
ON TEMP 
TO ORCLSTUDY;

GRANT INSERT ON TEMP TO ORCLSTUDY;

--GRANT SELECT, INSERT
--ON TEMP 
--TO ORCLSTUDY;

REVOKE SELECT, INSERT ON TEMP FROM ORCLSTUDY;

-- 사용자 생성: CREATE USER
--       권한 부여: GRANT
--       권한 취소: REVOKE

GRANT SELECT ON EMP TO PREV_HW;
GRANT SELECT ON DEPT TO PREV_HW;
GRANT SELECT ON SALGRADE TO PREV_HW;

REVOKE SELECT ON SALGRADE FROM PREV_HW;















































































































































































































