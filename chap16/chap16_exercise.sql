--16-1 PL/SQL ����

SET SERVEROUTPUT ON;					 --ȭ�鿡 ��� Ȱ��ȭ

BEGIN
	DBMS_OUTPUT.PUT_LINE('Hello, PL/SQL!');
END;


-- �ּ� ����ϱ�
DECLARE
--	�����̸�		�ڷ���				���Կ�����	�� �Ǵ� ���� ����Ǵ� ���� ǥ����;
	V_EMPNO NUMBER(4) 	:=		7788;
	V_ENAME VARCHAR2(10);
BEGIN
	V_ENAME := 'SCOTT';

 	DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
	DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);	

END;
/

--	����� ������ �� �ڹٴ� FINAL // SQL�� CONSTANT
-- ����� ���� ������ �� ����ϱ�
DECLARE
	V_TAX		CONSTANT		NUMBER(1)	:=		3;
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_TAX		:	'	||	V_TAX);
END;
/


-- ������ �� �����ϱ�
DECLARE
	V_DEPTNO NUMBER(2)	DEFAULT 10;		-- �⺻�� 10 ����
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_DEPTNO		:	'	||	V_DEPTNO);
END;
/

-- ������ NOT NULL �����ϰ� ���� �����ϰ� ����ϱ�
DECLARE
	V_DEPTNO	NUMBER(2) NOT NULL := 10;	-- �⺻�� 10 ����
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_DEPTNO		:	'	||	V_DEPTNO);
END;
/

-- NOT NULL �� DEFAULT ���� ����
DECLARE
	V_DEPTNO	NUMBER(2) NOT NULL DEFAULT 10;	-- �⺻�� 10 ����
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_DEPTNO		:	'	||	V_DEPTNO);
END;
/

DECLARE
	V_DEPTNO	NUMBER(2) NOT NULL DEFAULT 10;	-- �⺻�� 10 ����
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_DEPTNO		:	'	||	v_deptno);		-- �ڹٿ� �ٸ��� sql�� ��ҹ��� ������ ���� ����
END;
/
	
-- �ĺ��� �̸� ���̴� ��Ģ
--		��ҹ��ڸ� �������� ����
--		���� �� �ȿ��� �ĺ��ڴ� �����ؾ� �ϸ� �ߺ� �Ұ�
--			���ڷ� ����, 30byte���� ��밡��

--	������ �ڷ���	(�߿�)
--	��Į��	:	����, ���ڿ�, ��¥ ��� ���� ����Ŭ���� �⺻���� ������ ���� �ڷ���
--	������	: 	Ư�� ���̺��� ���� �ڷ����̳� �ϳ��� �� ������ ����

DECLARE
	V_DEPTNO		DEPT.DEPTNO%TYPE	:=		50;
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_DEPTNO		:	'	||	v_deptno);		-- �ڹٿ� �ٸ��� sql�� ��ҹ��� ������ ���� ����
END;
/

--16-10	-- ���� �ʿ�
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

-- 16-3 ���� ���			IF�� CASE �� ��� ����
--	IF	-	THEN ��
-- END IF;				- -������ ���
-- IFELSIF
--	ELSIF	���ǽ�  THEN

-- ������ �Էµ� ���� Ȧ�� ���� �˾ƺ���
DECLARE
	V_NUMBER	NUMBER	:=		14;
BEGIN
	IF MOD(V_NUMBER, 2)	=	1 THEN
		DBMS_OUTPUT.PUT_LINE('V_NUMBER �� Ȧ�� �Դϴ�.');
	END IF;
END;
/

DECLARE
	V_NUMBER	NUMBER	:=		14;
BEGIN
	IF MOD(V_NUMBER, 2)	=	1 THEN
		DBMS_OUTPUT.PUT_LINE('V_NUMBER �� Ȧ�� �Դϴ�.');
	ELSE
		DBMS_OUTPUT.PUT_LINE('V_NUMBER �� ¦�� �Դϴ�.');
	END IF;
END;
/

-- �Է��� ������ ��� �������� ����ϱ�
DECLARE
	V_SCORE NUMBER := 87;
BEGIN
	IF V_SCORE >= 90 THEN
		DBMS_OUTPUT.PUT_LINE('A����');
	ELSIF V_SCORE >=80 THEN
		DBMS_OUTPUT.PUT_LINE('B����');
	ELSIF V_SCORE >=70 THEN
		DBMS_OUTPUT.PUT_LINE('C����');
	ELSIF V_SCORE >=60 THEN
		DBMS_OUTPUT.PUT_LINE('D����');
	END IF;
		
END;
/




-- ���� 1) ������ȣ�� 7900�� ���������� ����غ�����
DECLARE
	V_NO			EMP.EMPNO%TYPE;
	V_NAME	EMP.ENAME%TYPE;
	V_SAL			EMP.SAL%TYPE;
BEGIN
	SELECT EMPNO, ENAME, SAL
		INTO V_NO, V_NAME, V_SAL
	FROM EMP
	WHERE EMPNO = 7900;
	DBMS_OUTPUT.PUT_LINE('������ȣ�� 7900 �� ��������		:	' || V_NO	||'    ' || V_NAME|| '    ' || V_SAL);
END;
/



-- ����2 ���������� 7900�� ���������� ROWTYPE ������ Ȱ���Ͽ� ������ ����غ�����
DECLARE
	V_EMP_ROW EMP%ROWTYPE;
BEGIN
	SELECT *
		INTO V_EMP_ROW
	  FROM EMP
	WHERE EMPNO = 7900;
	DBMS_OUTPUT.PUT_LINE('���� ��ȣ		:	' || V_EMP_ROW.EMPNO);
	DBMS_OUTPUT.PUT_LINE('���� �̸�		:	' || V_EMP_ROW.ENAME);
	DBMS_OUTPUT.PUT_LINE('���� �޿�		:	' || V_EMP_ROW.SAL);
END;
/
SELECT * FROM EMP WHERE EMPNO = 7900;




-- �� 3 EMP, DEPT �����ؼ� EMPNO 7900�� ����� ������ ����غ�����

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
		V_LEVEL := '��';
	ELSIF V_SAL >= 5000 THEN
		V_LEVEL := '��';
	ELSE
		V_LEVEL := '��';
	END IF;
	DBMS_OUTPUT.PUT_LINE(V_LEVEL);
END;
/


-- CASE �� ���
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
		WHEN V_SCORE >= 90 THEN DBMS_OUTPUT.PUT_LINE('A ����');
		WHEN V_SCORE >= 80 THEN DBMS_OUTPUT.PUT_LINE('B ����');
		WHEN V_SCORE >= 70 THEN DBMS_OUTPUT.PUT_LINE('C ����');
		WHEN V_SCORE >= 60 THEN DBMS_OUTPUT.PUT_LINE('D ����');
		ELSE 											DBMS_OUTPUT.PUT_LINE('F ����');
	END CASE;
END;
/


