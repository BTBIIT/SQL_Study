-- HOMEWORK
SET SERVEROUTPUT ON;				
-- SET SERVEROUTPUT ON �׽�Ʈ
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

-- 	���� 5 ) 1���� ������ Ȧ�� 10���� ����ϱ�
--	(IF  ���ǹ� ���� �ݺ���  BASIC LOOP �� WHILE LOOP ������ ������� ����غ�����)

-- Q1-1. BASIC ���� ����
DECLARE
		V_NUM NUMBER := 1;						-- �ʱ��
		V_COUNT NUMBER := 1;
BEGIN
		LOOP
				EXIT WHEN V_COUNT > 10;		-- ���ǽ�
				DBMS_OUTPUT.PUT_LINE(V_NUM);
				V_NUM := V_NUM + 2;
				V_COUNT := V_COUNT +1;
		END LOOP;
END;
/
-- Q-1-2. WHILE �� Ǯ��
DECLARE
		V_NUM		NUMBER := 1;	-- �ʱ��
		V_COUNT 	NUMBER := 0;		
BEGIN
		WHILE V_COUNT < 10 LOOP -- ���ǽ�
		DBMS_OUTPUT.PUT_LINE(V_NUM);
		V_NUM := V_NUM +2;
		V_COUNT := V_COUNT + 1;
		END LOOP;
END;
/

--	����6) ������̺��� 30 �� �μ��� ����� �����ȣ, �̸�, ��å ����ϱ�  (cursor ���)
-- (v_emp.EMPNO || '  ' || v_emp.ENAME || '  ' || v_emp.job)
--	1. ���� OPEN   FETCH CLOSE      2. FOR   IN 
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

-- Q2-2 FOR IN �� �Ἥ ���� ��
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