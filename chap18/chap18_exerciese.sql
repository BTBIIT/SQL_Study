-- 18 장 커서와 예외처리
-- 18-1
SET SERVEROUTPUT ON;
DECLARE
	V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
	SELECT DEPTNO, DNAME, LOC
		INTO V_DEPT_ROW
		FROM DEPT
	WHERE DEPTNO = 40;
	DBMS_OUTPUT.PUT_LINE ('DEPTNO	:	' 	|| V_DEPT_ROW.DEPTNO);
	DBMS_OUTPUT.PUT_LINE ('DNAME	:	' 	|| V_DEPT_ROW.DNAME);
	DBMS_OUTPUT.PUT_LINE ('LOC	:	'		|| V_DEPT_ROW.LOC);
END;
/
-- 18-2 명시적 커서 선언
DECLARE
    -- ROW변수 <- 커서 데이터 로우 입력받을 변수
    V_DEPT_ROW DEPT%ROWTYPE;
    -- 1. 명시적 커서 선언
    CURSOR C1 IS
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT
         WHERE DEPTNO = 40;
BEGIN
    -- 2. 커서 열기
    OPEN C1;
    LOOP
        -- 3. FETCH
        FETCH C1 INTO V_DEPT_ROW;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE ('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
        DBMS_OUTPUT.PUT_LINE ('DNAME : ' || V_DEPT_ROW.DNAME);
        DBMS_OUTPUT.PUT_LINE ('LOC : ' || V_DEPT_ROW.LOC);
        
    END LOOP;
    -- 4. 커서 닫기
    CLOSE C1;
END;
/


-- 명시적 커서 선언
DECLARE
	-- ROW 변수 <- 커서 데이터 로우 입력 받을 변수 
	V_DEPT_ROW DEPT%ROWTYPE;
	--1. 명시적 커서 선언
	CURSOR  C1 IS
		SELECT DEPTNO, DNAME, LOC
		  FROM DEPT
		WHERE DEPTNO = 40;
BEGIN
	--2. 커서 열기
	OPEN C1;
	LOOP
		-- 3. FETCH
		FETCH C1 INTO V_DEPT_ROW;
		EXIT WHEN C1%NOTFOUND;
		
		DBMS_OUTPUT.PUT_LINE (
		'DEPTNO	:	' 		|| V_DEPT_ROW.DEPTNO ||
		',  DNAME	:	' 	|| V_DEPT_ROW.DNAME ||
		',  LOC	:	'			|| V_DEPT_ROW.LOC
		);
	
	END LOOP;
	-- 4. 커서 닫기
	CLOSE C1;
END;
/


-- 18-4
DECLARE
	-- 명시적 커서 선언
	CURSOR C1 IS
		SELECT DEPTNO, DNAME, LOC
		  FROM DEPT;
BEGIN
	FOR c1_rec IN C1 LOOP
		DBMS_OUTPUT.PUT_LINE(
		'DEPTNO	:	' 		|| c1_rec.DEPTNO ||
		',  DNAME	:	' 	|| c1_rec.DNAME ||
		',  LOC	:	'			|| c1_rec.LOC
		);
	END LOOP;
END;
/
	
-- 18-5
DECLARE 
		-- 커서 데이터를 입력할 변수 선언
		V_DEPT_ROW DEPT%ROWTYPE;
		-- 명시적 커서 선언
		CURSOR C1(p_deptno DEPT.DEPTNO%TYPE)	IS
				SELECT DEPTNO, DNAME, LOC
				  FROM DEPT
				WHERE DEPTNO = p_deptno;
BEGIN
-- 10번 부서 처리를 위해 CURSOR 사용
		OPEN C1(10);
		LOOP
				FETCH C1 INTO V_DEPT_ROW;
				EXIT WHEN C1%NOTFOUND;
		END LOOP;
			DBMS_OUTPUT.PUT_LINE (
			'DEPTNO	:	' 		|| V_DEPT_ROW.DEPTNO ||
			',  DNAME	:	' 	|| V_DEPT_ROW.DNAME ||
			',  LOC	:	'			|| V_DEPT_ROW.LOC
			);
		CLOSE C1;
-- 20번 부서 처리를 위해 CURSOR를 사용
		OPEN C1(20);
		LOOP
				FETCH C1 INTO V_DEPT_ROW;
				EXIT WHEN C1%NOTFOUND;
		END LOOP;
			DBMS_OUTPUT.PUT_LINE (
			'DEPTNO	:	' 		|| V_DEPT_ROW.DEPTNO ||
			',  DNAME	:	' 	|| V_DEPT_ROW.DNAME ||
			',  LOC	:	'			|| V_DEPT_ROW.LOC
			);
		CLOSE C1;
END;
/


DECLARE 
		-- 커서 데이터를 입력할 변수 선언
		V_DEPTNO DEPT.DEPTNO%TYPE;
		-- 명시적 커서 선언
		CURSOR C1(p_deptno DEPT.DEPTNO%TYPE)	IS
				SELECT DEPTNO, DNAME, LOC
				  FROM DEPT
				WHERE DEPTNO = p_deptno;
BEGIN
		-- INPUT_DEPTNO 에 부서번호 입력받고 V_DEPTNO에 대입
		V_DEPTNO := &INPUT_DEPTNO;
		FOR C1_REC IN C1(V_DEPTNO) LOOP
			DBMS_OUTPUT.PUT_LINE(
			'DEPTNO	:	' 		|| c1_rec.DEPTNO ||
			',  DNAME	:	' 	|| c1_rec.DNAME ||
			',  LOC	:	'			|| c1_rec.LOC
			);
		END LOOP;
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

-- 18-7
BEGIN
	UPDATE	DEPT	SET DNAME = 'DATABASE'
		WHERE DEPTNO = 50;
	DBMS_OUTPUT.PUT_LINE('갱신된 행의 수	:	' ||		SQL%ROWCOUNT);
	
	IF(SQL%FOUND) THEN
		DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재여부	:	true');
	ELSE
		DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재여부	:	false');
	END IF;
	
	IF(SQL%ISOPEN) THEN
		DBMS_OUTPUT.PUT_LINE('커서의 오픈 여부	:	true');
	ELSE
		DBMS_OUTPUT.PUT_LINE('커서의 오픈 여부	:	false');
	END IF;
END;
/

-- 예외처리	:
-- 오류가 발생 해도 프로그램이 비정상 종료 되지 않도록 하는 처리
DECLARE
	V_WRONG NUMBER;
BEGIN
	SELECT DNAME INTO V_WRONG
		FROM DEPT
	WHERE DEPTNO = 10;
END;
/

DECLARE
		V_WRONG NUMBER;
BEGIN
		SELECT DNAME INTO V_WRONG
			FROM DEPT
		WHERE DEPTNO = 10;
		EXCEPTION
			WHEN VALUE_ERROR THEN
				DBMS_OUTPUT.PUT_LINE('예외처리	:	수치 또는 값 오류 발생');
END;
/

DECLARE
		V_WRONG NUMBER;
BEGIN
		SELECT DNAME INTO V_WRONG
			FROM DEPT
		WHERE DEPTNO = 10;
			DBMS_OUTPUT.PUT_LINE('예외가 발생하면 해당 문장은 실행되지 않습니다');
		EXCEPTION
			WHEN VALUE_ERROR THEN
				DBMS_OUTPUT.PUT_LINE('예외처리	:	수치 또는 값 오류 발생');
END;

-- 예외 이름
/*
DUP_VAL_ON_INDEX	:	UNIQUE 인덱스가 있는 열에 중복 값을 저장 시 
NO_DATA_FOUND		:	SELECT INTO 문에서 결과 행이 하나도 없을 경우
VALUE_ERROR			:	산술, 변환, 잘림, 제약 조건 오류가 발생 시
TOO_MANY_ROWS	:	SELECT INTO 문의 결과 행이 다중행 출력 시
*/



DECLARE
		V_WRONG NUMBER;
BEGIN
		SELECT DNAME INTO V_WRONG
			FROM DEPT
		WHERE DEPTNO = 10;
			DBMS_OUTPUT.PUT_LINE('예외가 발생하면 해당 문장은 실행되지 않습니다');
		EXCEPTION
			WHEN 	OTHERS THEN
				DBMS_OUTPUT.PUT_LINE('사전 정의 외 오류 발생');
				DBMS_OUTPUT.PUT_LINE('SQLCODE	:	'	||	 TO_CHAR(SQLCODE));
				DBMS_OUTPUT.PUT_LINE('SQLERRM	:	'	||	 SQLERRM);
END;
/





