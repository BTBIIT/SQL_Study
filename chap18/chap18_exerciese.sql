-- 18 �� Ŀ���� ����ó��
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
-- 18-2 ����� Ŀ�� ����
DECLARE
    -- ROW���� <- Ŀ�� ������ �ο� �Է¹��� ����
    V_DEPT_ROW DEPT%ROWTYPE;
    -- 1. ����� Ŀ�� ����
    CURSOR C1 IS
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT
         WHERE DEPTNO = 40;
BEGIN
    -- 2. Ŀ�� ����
    OPEN C1;
    LOOP
        -- 3. FETCH
        FETCH C1 INTO V_DEPT_ROW;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE ('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
        DBMS_OUTPUT.PUT_LINE ('DNAME : ' || V_DEPT_ROW.DNAME);
        DBMS_OUTPUT.PUT_LINE ('LOC : ' || V_DEPT_ROW.LOC);
        
    END LOOP;
    -- 4. Ŀ�� �ݱ�
    CLOSE C1;
END;
/


-- ����� Ŀ�� ����
DECLARE
	-- ROW ���� <- Ŀ�� ������ �ο� �Է� ���� ���� 
	V_DEPT_ROW DEPT%ROWTYPE;
	--1. ����� Ŀ�� ����
	CURSOR  C1 IS
		SELECT DEPTNO, DNAME, LOC
		  FROM DEPT
		WHERE DEPTNO = 40;
BEGIN
	--2. Ŀ�� ����
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
	-- 4. Ŀ�� �ݱ�
	CLOSE C1;
END;
/


-- 18-4
DECLARE
	-- ����� Ŀ�� ����
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
		-- Ŀ�� �����͸� �Է��� ���� ����
		V_DEPT_ROW DEPT%ROWTYPE;
		-- ����� Ŀ�� ����
		CURSOR C1(p_deptno DEPT.DEPTNO%TYPE)	IS
				SELECT DEPTNO, DNAME, LOC
				  FROM DEPT
				WHERE DEPTNO = p_deptno;
BEGIN
-- 10�� �μ� ó���� ���� CURSOR ���
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
-- 20�� �μ� ó���� ���� CURSOR�� ���
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
		-- Ŀ�� �����͸� �Է��� ���� ����
		V_DEPTNO DEPT.DEPTNO%TYPE;
		-- ����� Ŀ�� ����
		CURSOR C1(p_deptno DEPT.DEPTNO%TYPE)	IS
				SELECT DEPTNO, DNAME, LOC
				  FROM DEPT
				WHERE DEPTNO = p_deptno;
BEGIN
		-- INPUT_DEPTNO �� �μ���ȣ �Է¹ް� V_DEPTNO�� ����
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
	DBMS_OUTPUT.PUT_LINE('���ŵ� ���� ��	:	' ||		SQL%ROWCOUNT);
	
	IF(SQL%FOUND) THEN
		DBMS_OUTPUT.PUT_LINE('���� ��� �� ���翩��	:	true');
	ELSE
		DBMS_OUTPUT.PUT_LINE('���� ��� �� ���翩��	:	false');
	END IF;
	
	IF(SQL%ISOPEN) THEN
		DBMS_OUTPUT.PUT_LINE('Ŀ���� ���� ����	:	true');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Ŀ���� ���� ����	:	false');
	END IF;
END;
/

-- ����ó��	:
-- ������ �߻� �ص� ���α׷��� ������ ���� ���� �ʵ��� �ϴ� ó��
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
				DBMS_OUTPUT.PUT_LINE('����ó��	:	��ġ �Ǵ� �� ���� �߻�');
END;
/

DECLARE
		V_WRONG NUMBER;
BEGIN
		SELECT DNAME INTO V_WRONG
			FROM DEPT
		WHERE DEPTNO = 10;
			DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� �ش� ������ ������� �ʽ��ϴ�');
		EXCEPTION
			WHEN VALUE_ERROR THEN
				DBMS_OUTPUT.PUT_LINE('����ó��	:	��ġ �Ǵ� �� ���� �߻�');
END;

-- ���� �̸�
/*
DUP_VAL_ON_INDEX	:	UNIQUE �ε����� �ִ� ���� �ߺ� ���� ���� �� 
NO_DATA_FOUND		:	SELECT INTO ������ ��� ���� �ϳ��� ���� ���
VALUE_ERROR			:	���, ��ȯ, �߸�, ���� ���� ������ �߻� ��
TOO_MANY_ROWS	:	SELECT INTO ���� ��� ���� ������ ��� ��
*/



DECLARE
		V_WRONG NUMBER;
BEGIN
		SELECT DNAME INTO V_WRONG
			FROM DEPT
		WHERE DEPTNO = 10;
			DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� �ش� ������ ������� �ʽ��ϴ�');
		EXCEPTION
			WHEN 	OTHERS THEN
				DBMS_OUTPUT.PUT_LINE('���� ���� �� ���� �߻�');
				DBMS_OUTPUT.PUT_LINE('SQLCODE	:	'	||	 TO_CHAR(SQLCODE));
				DBMS_OUTPUT.PUT_LINE('SQLERRM	:	'	||	 SQLERRM);
END;
/





