-- HOMEWORK
SET SERVEROUTPUT ON;				
-- SET SERVEROUTPUT ON 테스트
/*
DECLARE
	TYPE REC_DEPT IS RECORD(
		DEPT_NO NUMBER(2) NOT NULL	:= 99,
		DNAME DEPT.DNAME%TYPE,
		LOC DEPT.LOC%TYPE
	);
	DEPT_REC REC_DEPT;
BEGIN
	DEPT_REC.DEPT_NO 		:= 99;
	DEPT_REC.DNAME := 'DATABASE';
	DEPT_REC.LOC				:= 'SEOUL';
	DBMS_OUTPUT.PUT_LINE('DEPTNO	:	'	||	DEPT_REC.DEPT_NO);
	DBMS_OUTPUT.PUT_LINE('DNAME	:	'	||	DEPT_REC.DNAME);
	DBMS_OUTPUT.PUT_LINE('LOC	:	'	||	DEPT_REC.LOC);
END;
/
*/

-- 	문제 5 ) 1부터 숫자중 홀수 10개만 출력하기
--	(IF  조건문 없이 반복문  BASIC LOOP 와 WHILE LOOP 각각의 방법으로 출력해보세요)

-- Q1-1. BASIC 루프 문제
DECLARE
		V_NUM NUMBER := 1;						-- 초기식
		V_COUNT NUMBER := 1;
BEGIN
		LOOP
				EXIT WHEN V_COUNT > 10;		-- 조건식
				DBMS_OUTPUT.PUT_LINE(V_NUM);
				V_NUM := V_NUM + 2;
				V_COUNT := V_COUNT +1;
		END LOOP;
END;
/
-- Q-1-2. WHILE 로 풀기
DECLARE
		V_NUM		NUMBER := 1;	-- 초기식
		V_COUNT 	NUMBER := 0;		
BEGIN
		WHILE V_COUNT < 10 LOOP -- 조건식
		DBMS_OUTPUT.PUT_LINE(V_NUM);
		V_NUM := V_NUM +2;
		V_COUNT := V_COUNT + 1;
		END LOOP;
END;
/

--	문제6) 사원테이블에서 30 번 부서인 사원의 사원번호, 이름, 직책 출력하기  (cursor 사용)
-- (v_emp.EMPNO || '  ' || v_emp.ENAME || '  ' || v_emp.job)
--	1. 선언 OPEN   FETCH CLOSE      2. FOR   IN 
-- Q2-1
DECLARE
		V_EMP EMP%ROWTYPE;
		CURSOR C1 IS
				SELECT * FROM EMP WHERE DEPTNO = 30;
BEGIN
		OPEN C1;
		LOOP
				FETCH C1 INTO V_EMP;
				EXIT WHEN C1%NOTFOUND;
				DBMS_OUTPUT.PUT_LINE(V_EMP.EMPNO || '  ' || V_EMP.ENAME || '  ' || V_EMP.job);
		END LOOP;
		CLOSE C1;
END;
/

-- Q2-2 FOR IN 을 써서 만들 것
DECLARE 
		V_EMP EMP%ROWTYPE;
		CURSOR C1 IS 
			SELECT * FROM EMP WHERE DEPTNO = 30;
BEGIN
		FOR i IN C1 LOOP
			DBMS_OUTPUT.PUT_LINE(i.EMPNO || ' ' || i.ENAME || ' ' || i.JOB);
		END LOOP;
END;
/
