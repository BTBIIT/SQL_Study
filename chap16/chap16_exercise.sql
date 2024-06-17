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



-- 16 -17
DECLARE
	V_NUM NUMBER := 0;		-- 초기식
BEGIN
	LOOP
		DBMS_OUTPUT.PUT_LINE('현재 V_NUM : '	||	V_NUM);
		V_NUM := V_NUM +1;		-- 증감식
		EXIT	WHEN V_NUM >4;		-- 조건식
	END LOOP;
END;
/

DECLARE
	V_NUM NUMBER := 0;		-- 초기식
BEGIN
	LOOP
		DBMS_OUTPUT.PUT_LINE('현재 V_NUM : '	||	V_NUM);
		V_NUM := V_NUM +1;		-- 증감식
		-- EXIT	WHEN V_NUM >4;		-- 조건식
		IF V_NUM > 4 THEN
			EXIT;
		END IF;
	END LOOP;
END;
/


-- WHILE LOOP
DECLARE 
	V_NUM NUMBER := 0;	-- 초기식
BEGIN
	WHILE V_NUM < 4 LOOP		-- 조건식
		DBMS_OUTPUT.PUT_LINE('현재 V_NUM : '	||	V_NUM);
		V_NUM := V_NUM +1;
	END LOOP;
END;
/

-- 16-19	FOR LOOP

BEGIN
	FOR i IN 0..4	 LOOP		-- 0 부터 4까지 포함		java for(int i = 0; i <=4;, i++){
		DBMS_OUTPUT.PUT_LINE('현재 i : '	||	i);
	END LOOP;
END;
/

BEGIN
	FOR i IN Reverse 0..4	 LOOP		-- 4부터 찍음
		DBMS_OUTPUT.PUT_LINE('현재 i : '	||	i);
	END LOOP;
END;
/
-- 16-21	CONTINUE 문
BEGIN
	FOR i IN 0..4 LOOP
		CONTINUE WHEN	MOD(i,2) = 1;			-- 2로 나눈 나머지가 1이면 아래 를 무시하고 넘어감
		DBMS_OUTPUT.PUT_LINE('현재 i : '	||	i);
	END LOOP;

END;
/

-- Q1 숫자 1부터 10까지 숫자 중 홀수만 출력하는 PL/SQL 문 작성
BEGIN
	FOR	i	IN 0..10 LOOP
		CONTINUE WHEN MOD (i,2) = 0;
		DBMS_OUTPUT.PUT_LINE('현재 i 의 값 : '	||	i);
	END LOOP;

END;
-- WHILE IF LOOP
DECLARE
	i	NUMBER	:=	0;
BEGIN
	WHILE	i	<	10 LOOP
		i	:=	i+1;
		IF	MOD(i,2)	=	0 THEN
			CONTINUE;
		END IF;
			DBMS_OUTPUT.PUT_LINE('현재 i 의 값 : '	||	i);
	END	LOOP;
END;
/*
Q2 DEPT 테이블의 DEPTNO와 자료형이 같은 변수 V_DEPTNO를 선언
그리고 V_DEPTNO 변수 값에 10, 20, 30, 40을 대입했을 때 
다음과 같이 부서 이름을 출력하는 프로그램을 작성해 보세요
단, 부서 번호가 10, 20, 30, 40이 아니면 N/A로 출력 할 것
IF문, CASE 문 두 가지 방식으로 풀어 볼 것
*/

DECLARE
	V_DEPTNO	DEPT.DEPTNO%TYPE :=	10;
	V_DNAME	DEPT.DNAME%TYPE; 
BEGIN
	
	IF V_DEPTNO = 10 THEN
		SELECT DNAME INTO V_DNAME FROM DEPT WHERE DEPTNO = 10;
		DBMS_OUTPUT.PUT_LINE('DNAME	:	'	||	V_DNAME);
	ELSIF	V_DEPTNO = 20 THEN
		SELECT DNAME INTO V_DNAME FROM DEPT WHERE DEPTNO = 20;
		DBMS_OUTPUT.PUT_LINE('DNAME	:	'	||	V_DNAME);
	ELSIF	V_DEPTNO = 30 THEN
		SELECT DNAME INTO V_DNAME FROM DEPT WHERE DEPTNO = 30;
		DBMS_OUTPUT.PUT_LINE('DNAME	:	'	||	V_DNAME);
	ELSIF	V_DEPTNO = 40 THEN
		SELECT DNAME INTO V_DNAME FROM DEPT WHERE DEPTNO = 40;
		DBMS_OUTPUT.PUT_LINE('DNAME	:	'	||	V_DNAME);
	ELSE
		DBMS_OUTPUT.PUT_LINE('N/A');
	END IF;
END;
/

-- CASE 문으로 풀었을 때
DECLARE 
	V_DEPTNO	DEPT.DEPTNO%TYPE :=	50;
	V_DNAME	DEPT.DNAME%TYPE; 
BEGIN
	CASE (V_DEPTNO/10) 
		WHEN 1 THEN
			SELECT DNAME INTO V_DNAME FROM DEPT WHERE DEPTNO = 10;
			DBMS_OUTPUT.PUT_LINE('DNAME	:	'	||	V_DNAME);
		WHEN 2 THEN
			SELECT DNAME INTO V_DNAME FROM DEPT WHERE DEPTNO = 20;
			DBMS_OUTPUT.PUT_LINE('DNAME	:	'	||	V_DNAME);
		WHEN 3 THEN
			SELECT DNAME INTO V_DNAME FROM DEPT WHERE DEPTNO = 30;
			DBMS_OUTPUT.PUT_LINE('DNAME	:	'	||	V_DNAME);
		WHEN 4 THEN
			SELECT DNAME INTO V_DNAME FROM DEPT WHERE DEPTNO = 40;
			DBMS_OUTPUT.PUT_LINE('DNAME	:	'	||	V_DNAME);
		ELSE
			DBMS_OUTPUT.PUT_LINE('N/A');
		END CASE;
END;
/


DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 30;
    V_DEPT_NAME DEPT.DNAME%TYPE;
BEGIN
    SELECT DNAME
      INTO V_DEPT_NAME
      FROM DEPT
     WHERE DEPTNO = V_DEPTNO;
     
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_NAME);
    
    EXCEPTION WHEN NO_DATA_FOUND THEN
        V_DEPT_NAME := 'N/A';
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_NAME);
END;
/















