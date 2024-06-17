--16-1 PL/SQL 구조

SET SERVEROUTPUT ON;					 --화면에 출력 활성화

BEGIN
	DBMS_OUTPUT.PUT_LINE('Hello, PL/SQL!');
END;


-- 주석 사용하기
DECLARE
--	변수이름		자료형				대입연산자	값 또는 값이 도출되는 여러 표현식;
	V_EMPNO NUMBER(4) 	:=		7788;
	V_ENAME VARCHAR2(10);
BEGIN
	V_ENAME := 'SCOTT';

 	DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
	DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);	

END;
/

--	상수를 선언할 때 자바는 FINAL // SQL은 CONSTANT
-- 상수에 값을 대입한 후 출력하기
DECLARE
	V_TAX		CONSTANT		NUMBER(1)	:=		3;
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_TAX		:	'	||	V_TAX);
END;
/


-- 변수의 값 저장하기
DECLARE
	V_DEPTNO NUMBER(2)	DEFAULT 10;		-- 기본값 10 설정
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_DEPTNO		:	'	||	V_DEPTNO);
END;
/

-- 변수에 NOT NULL 설정하고 값을 대입하고 출력하기
DECLARE
	V_DEPTNO	NUMBER(2) NOT NULL := 10;	-- 기본값 10 설정
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_DEPTNO		:	'	||	V_DEPTNO);
END;
/

-- NOT NULL 과 DEFAULT 같이 설정
DECLARE
	V_DEPTNO	NUMBER(2) NOT NULL DEFAULT 10;	-- 기본값 10 설정
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_DEPTNO		:	'	||	V_DEPTNO);
END;
/

DECLARE
	V_DEPTNO	NUMBER(2) NOT NULL DEFAULT 10;	-- 기본값 10 설정
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_DEPTNO		:	'	||	v_deptno);		-- 자바와 다르게 sql은 대소문자 구분을 하지 않음
END;
/
	
-- 식별자 이름 붙이는 규칙
--		대소문자를 구별하지 않음
--		같은 블럭 안에서 식별자는 고유해야 하며 중복 불가
--			문자로 시작, 30byte까지 사용가능

--	변수의 자료형	(중요)
--	스칼라	:	숫자, 문자열, 날짜 등과 같이 오라클에서 기본으로 정의해 놓은 자료형
--	참조형	: 	특정 테이블의 열의 자료형이나 하나의 행 구조를 참조

DECLARE
	V_DEPTNO		DEPT.DEPTNO%TYPE	:=		50;
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_DEPTNO		:	'	||	v_deptno);		-- 자바와 다르게 sql은 대소문자 구분을 하지 않음
END;
/

--16-10	-- 복습 필요
DECLARE
	V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
	SELECT DEPTNO, DNAME, LOC
		INTO V_DEPT_ROW
		FROM	DEPT
	WHERE	DEPTNO = 40;
	DBMS_OUTPUT.PUT_LINE('V_DEPTNO		:	'	||	V_DEPT_ROW.DEPTNO);
	DBMS_OUTPUT.PUT_LINE('V_DNAME		:	'	||	V_DEPT_ROW.DNAME);
	DBMS_OUTPUT.PUT_LINE('V_LOC				:	'	||	V_DEPT_ROW.LOC);
END;
/

SELECT * FROM DEPT WHERE DEPTNO = 40;

-- 16-3 조건 제어문			IF문 CASE 문 사용 가능
--	IF	-	THEN 문
-- END IF;				- -끝날때 사용
-- IFELSIF
--	ELSIF	조건식  THEN

-- 변수에 입력된 값이 홀수 인지 알아보기
DECLARE
	V_NUMBER	NUMBER	:=		14;
BEGIN
	IF MOD(V_NUMBER, 2)	=	1 THEN
		DBMS_OUTPUT.PUT_LINE('V_NUMBER 는 홀수 입니다.');
	END IF;
END;
/

DECLARE
	V_NUMBER	NUMBER	:=		14;
BEGIN
	IF MOD(V_NUMBER, 2)	=	1 THEN
		DBMS_OUTPUT.PUT_LINE('V_NUMBER 는 홀수 입니다.');
	ELSE
		DBMS_OUTPUT.PUT_LINE('V_NUMBER 는 짝수 입니다.');
	END IF;
END;
/

-- 입력한 점수가 어느 학좀인지 출력하기
DECLARE
	V_SCORE NUMBER := 87;
BEGIN
	IF V_SCORE >= 90 THEN
		DBMS_OUTPUT.PUT_LINE('A학점');
	ELSIF V_SCORE >=80 THEN
		DBMS_OUTPUT.PUT_LINE('B학점');
	ELSIF V_SCORE >=70 THEN
		DBMS_OUTPUT.PUT_LINE('C학점');
	ELSIF V_SCORE >=60 THEN
		DBMS_OUTPUT.PUT_LINE('D학점');
	END IF;
		
END;
/




-- 문제 1) 직원번호가 7900인 직원정보를 출력해보세요
DECLARE
	V_NO			EMP.EMPNO%TYPE;
	V_NAME	EMP.ENAME%TYPE;
	V_SAL			EMP.SAL%TYPE;
BEGIN
	SELECT EMPNO, ENAME, SAL
		INTO V_NO, V_NAME, V_SAL
	FROM EMP
	WHERE EMPNO = 7900;
	DBMS_OUTPUT.PUT_LINE('직원번호가 7900 인 직원정보		:	' || V_NO	||'    ' || V_NAME|| '    ' || V_SAL);
END;
/



-- 문제2 직원정보가 7900인 직원정보를 ROWTYPE 변수를 활용하여 데이터 출력해보세요
DECLARE
	V_EMP_ROW EMP%ROWTYPE;
BEGIN
	SELECT *
		INTO V_EMP_ROW
	  FROM EMP
	WHERE EMPNO = 7900;
	DBMS_OUTPUT.PUT_LINE('직원 번호		:	' || V_EMP_ROW.EMPNO);
	DBMS_OUTPUT.PUT_LINE('직원 이름		:	' || V_EMP_ROW.ENAME);
	DBMS_OUTPUT.PUT_LINE('직원 급여		:	' || V_EMP_ROW.SAL);
END;
/
SELECT * FROM EMP WHERE EMPNO = 7900;




-- 문 3 EMP, DEPT 조인해서 EMPNO 7900인 사람의 정보를 출력해보세요

DECLARE
	V_EMPNO	EMP.EMPNO%TYPE;
	V_ENAME	EMP.ENAME%TYPE;
	V_DEPTNO	DEPT.DEPTNO%TYPE;
	V_DNAME	DEPT.DNAME%TYPE;
BEGIN
	SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME
		INTO V_EMPNO, V_ENAME, V_DEPTNO, V_DNAME
		FROM EMP E, DEPT D
	WHERE E.DEPTNO = D.DEPTNO
		AND E.EMPNO = 7900;
	DBMS_OUTPUT.PUT_LINE(V_EMPNO || '    ' || V_ENAME || '     '|| V_DEPTNO|| '     ' || V_DNAME);
END;
/


SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME
	FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.EMPNO = 7900;


DECLARE
	V_SAL 			EMP.SAL%TYPE;
	V_EMPNO 		EMP.EMPNO%TYPE;
	V_LEVEL			VARCHAR2(4);
BEGIN
	SELECT EMPNO, SAL
	INTO V_EMPNO, V_SAL
	FROM EMP
	WHERE EMPNO = 7369;
	IF V_SAL >= 10000 THEN
		V_LEVEL := '상';
	ELSIF V_SAL >= 5000 THEN
		V_LEVEL := '중';
	ELSE
		V_LEVEL := '하';
	END IF;
	DBMS_OUTPUT.PUT_LINE(V_LEVEL);
END;
/


-- CASE 문 사용
DECLARE
	V_SCORE NUMBER :=87;
BEGIN
	CASE TRUNC(V_SCORE/10)
		WHEN	10	THEN
			DBMS_OUTPUT.PUT_LINE('A');
		WHEN	9	THEN
			DBMS_OUTPUT.PUT_LINE('A');
		WHEN	8	THEN
			DBMS_OUTPUT.PUT_LINE('B');
		WHEN	7	THEN
			DBMS_OUTPUT.PUT_LINE('C');
		WHEN	6	THEN
			DBMS_OUTPUT.PUT_LINE('D');
		ELSE
			DBMS_OUTPUT.PUT_LINE('F');
		END CASE;
END;
/

DECLARE
	V_SCORE	NUMBER	:= 87;
BEGIN
	CASE
		WHEN V_SCORE >= 90 THEN DBMS_OUTPUT.PUT_LINE('A 학점');
		WHEN V_SCORE >= 80 THEN DBMS_OUTPUT.PUT_LINE('B 학점');
		WHEN V_SCORE >= 70 THEN DBMS_OUTPUT.PUT_LINE('C 학점');
		WHEN V_SCORE >= 60 THEN DBMS_OUTPUT.PUT_LINE('D 학점');
		ELSE 											DBMS_OUTPUT.PUT_LINE('F 학점');
	END CASE;
END;
/


