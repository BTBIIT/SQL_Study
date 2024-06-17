-- 17�� ���ڵ�� �÷���

-- ���ڵ� : �ڷ����� �ٸ� ���� �����͸� ������ �� �ִ� Ÿ�� (Array List ����)

-- 17-1

SET SERVEROUTPUT ON;				





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

-- ���ڵ带 ����� INSERT
CREATE TABLE DEPT_RECORD
AS SELECT * FROM DEPT;

SELECT * FROM DEPT_RECORD;

-- 17-3
DECLARE
    TYPE REC_DEPT IS RECORD(
        dept_no NUMBER(2) NOT NULL := 99,
        dname DEPT.DNAME%TYPE,
        loc DEPT.LOC%TYPE
    );
    dept_rec REC_DEPT;
BEGIN
    dept_rec.dept_no := 99;
    dept_rec.dname := 'DATABASE';
    dept_rec.loc  := 'SEOUL';
    
    INSERT INTO DEPT_RECORD
    VALUES dept_rec;
    
--    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || dept_rec.dept_no);
--    DBMS_OUTPUT.PUT_LINE('DNAME : ' || dept_rec.dname);
--    DBMS_OUTPUT.PUT_LINE('LOC : ' || dept_rec.loc);
END;
/
SELECT * FROM DEPT_RECORD;

-- 17-4
DECLARE
    TYPE REC_DEPT IS RECORD(
        dept_no NUMBER(2) NOT NULL := 99,
        dname DEPT.DNAME%TYPE,
        loc DEPT.LOC%TYPE
    );
    dept_rec REC_DEPT;
BEGIN
    dept_rec.dept_no := 50;
    dept_rec.dname := 'DB';
    dept_rec.loc  := 'SEOUL';
    
    UPDATE DEPT_RECORD
       SET ROW = dept_rec
     WHERE DEPTNO = 99;
    
--    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || dept_rec.dept_no);
--    DBMS_OUTPUT.PUT_LINE('DNAME : ' || dept_rec.dname);
--    DBMS_OUTPUT.PUT_LINE('LOC : ' || dept_rec.loc);
END;
/
--17-5

DECLARE
	TYPE REC_DEPT IS RECORD(
		DEPT_NO NUMBER(2) NOT NULL := 99,
		DNAME	DEPT.DNAME%TYPE,
		LOC DEPT.LOC%TYPE
	);

	TYPE REC_EMP IS RECORD(
		EMPNO EMP.EMPNO%TYPE,
		ENAME EMP.ENAME%TYPE,
		DINFO   REC_DEPT
	);
	
	EMP_REC REC_EMP;
BEGIN
	SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
		INTO EMP_REC.EMPNO, EMP_REC.ENAME, 
			     EMP_REC.DINFO.DEPT_NO,
				 EMP_REC.DINFO.DNAME,
				 EMP_REC.DINFO.LOC
	  FROM EMP E, DEPT D
	WHERE E.DEPTNO = D.DEPTNO
		AND  E.EMPNO = 7788;
	DBMS_OUTPUT.PUT_LINE('DEPTNO	:	' || EMP_REC.DINFO.DEPT_NO);
	DBMS_OUTPUT.PUT_LINE('DNAME	:	' || EMP_REC.DINFO.DNAME);
	DBMS_OUTPUT.PUT_LINE('LOC			:	' || EMP_REC.DINFO.LOC);
END;
/

-- 17-2 
-- �ڷ����� ���� ���� �����͸� �����ϴ� �÷���

-- 17-6 �����迭 ����ϱ�
DECLARE
	TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
	INDEX BY PLS_INTEGER;
	
	text_arr ITAB_EX;
	
BEGIN
	text_arr(1) := '1st data';
	text_arr(2) := '2nd data';
	text_arr(3) := '3rd data';
	text_arr(4) := '4th data';	
	
	DBMS_OUTPUT.PUT_LINE('test_arr(1)	:	'  ||  text_arr(1));
	DBMS_OUTPUT.PUT_LINE('test_arr(2)	:	'  ||  text_arr(2));
	DBMS_OUTPUT.PUT_LINE('test_arr(3)	:	'  ||  text_arr(3));
	DBMS_OUTPUT.PUT_LINE('test_arr(4)	:	'  ||  text_arr(4));
END;
/

-- �ڹ��� ��ü �迭 ó��
-- ���ڵ� Ÿ���� ���� �迭 ����
--17 -7
DECLARE
	TYPE REC_DEPT IS RECORD(
		DEPTNO 	DEPT.DEPTNO%TYPE,
		DNAME	DEPT.DNAME%TYPE
	);
	
	TYPE ITAB_DEPT IS TABLE OF REC_DEPT
		INDEX BY PLS_INTEGER;
	
	DEPT_ARR	ITAB_DEPT;
	IDX PLS_INTEGER := 0;
BEGIN
	FOR i IN (SELECT DEPTNO, DNAME FROM DEPT) LOOP
		IDX	:=	IDX	+	1;
		DEPT_ARR(IDX).DEPTNO	:=	i.DEPTNO;
		DEPT_ARR(IDX).DNAME		:=	i.DNAME;
		DBMS_OUTPUT.PUT_LINE(
			DEPT_ARR(IDX).DEPTNO	|| '	:	'	|| DEPT_ARR(IDX).DNAME
		);
	END LOOP;
END;
/

DECLARE
    TYPE ITAB_DEPT IS TABLE OF DEPT%ROWTYPE
	    INDEX BY PLS_INTEGER;
    
	DEPT_ARR ITAB_DEPT;
	IDX PLS_INTEGER := 0;
BEGIN
    FOR i IN (SELECT * FROM DEPT) LOOP
	    IDX := IDX + 1;
		DEPT_ARR(IDX).DEPTNO := i.DEPTNO;
		DEPT_ARR(IDX).DNAME := i.DNAME;
		DEPT_ARR(IDX).LOC := i.LOC;
		
		DBMS_OUTPUT.PUT_LINE(
		DEPT_ARR(IDX).DEPTNO || ' : ' ||
		DEPT_ARR(IDX).DNAME || ' : ' ||
		DEPT_ARR(IDX).LOC
		);
	END LOOP;
END;
/

-- 17-9 �÷��� �޼��� ����ϱ�
DECLARE
	TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
	INDEX BY PLS_INTEGER;
	TEXT_ARR ITAB_EX;
BEGIN
	TEXT_ARR(1) := '1st data';
	TEXT_ARR(2) := '2nd data';
	TEXT_ARR(3) := '3rd data';
	TEXT_ARR(50) := '50th data';
	DBMS_OUTPUT.PUT_LINE('TEXT_ARR.COUNT			:	'	||	TEXT_ARR.COUNT);
	DBMS_OUTPUT.PUT_LINE('TEXT_ARR.FIRST				:	'	||	TEXT_ARR.FIRST);
	DBMS_OUTPUT.PUT_LINE('TEXT_ARR.LAST				:	'	||	TEXT_ARR.LAST);
	DBMS_OUTPUT.PUT_LINE('TEXT_ARR.PRIOR(50)		:	'	||	TEXT_ARR.PRIOR(50));
	DBMS_OUTPUT.PUT_LINE('TEXT_ARR.NEXT(50)		:	'	||	TEXT_ARR.NEXT(50));
END;
/
-- �����ڷ���		:	���� �����͸� �ϳ��� �ڷ������� ���� ��� ���� ���� �����ϴ� �ڷ���
--	���ڵ�			:	���� ������ �ڷ����� �ϳ��� ������ ���� �� ���
-- �÷���			:	Ư�� �ڷ����� ������ �������� �ϳ��� ������ ���� �� ���


-- Q1 ������ ���� ����� �������� PL/SQL���� �ۼ��� ������.
CREATE TABLE EMP_RECORD
	AS SELECT * FROM EMP
		WHERE 1<>1;
-- 1) EMP ���̺�� ���� �� ������ ������ �� ���̺� EMP_RECORD�� �����ϴ� SQL���� �ۼ��� ������
-- 2) EMP_RECORD ���̺� ���ڵ带 ����Ͽ� ���ο� ��� ������ ������ ���� �����ϴ� PL/SQL ���� �ۼ��ϼ���.
DECLARE 
	TYPE REC_EMP IS RECORD(
		EMPNO		EMP.EMPNO%TYPE,
		ENAME		EMP.ENAME%TYPE,
		JOB				EMP.JOB%TYPE,
		MGR			EMP.MGR%TYPE,
		HIREDATE	EMP.HIREDATE%TYPE,
		SAL				EMP.SAL%TYPE,
		COMM		EMP.COMM%TYPE,
		DEPTNO		EMP.DEPTNO%TYPE
	);
	EMP_REC REC_EMP;
BEGIN
	EMP_REC.EMPNO		:= 1111;
	EMP_REC.ENAME		:= 'TEST_USER';
	EMP_REC.JOB				:= 'TEST_JOB';
	EMP_REC.MGR			:= NULL;
	EMP_REC.HIREDATE	:= TO_DATE('2018/03/01','YYYY/MM/DD');
	EMP_REC.SAL				:= 3000;
	EMP_REC.COMM		:=	NULL;
	EMP_REC.DEPTNO		:= 40;
	
	INSERT INTO EMP_RECORD
	VALUES EMP_REC;
END;
/

SELECT * FROM EMP_RECORD;
-- 17-2
DECLARE
   TYPE ITAB_EMP IS TABLE OF EMP%ROWTYPE
      INDEX BY PLS_INTEGER;
   emp_arr ITAB_EMP;
   idx PLS_INTEGER := 0;
BEGIN
   FOR i IN (SELECT * FROM EMP) LOOP
      idx := idx + 1;
      emp_arr(idx).empno    := i.EMPNO;
      emp_arr(idx).ename    := i.ENAME;
      emp_arr(idx).job      := i.JOB;
      emp_arr(idx).mgr      := i.MGR;
      emp_arr(idx).hiredate := i.HIREDATE;
      emp_arr(idx).sal      := i.SAL;
      emp_arr(idx).comm     := i.COMM;
      emp_arr(idx).deptno   := i.DEPTNO;

      DBMS_OUTPUT.PUT_LINE(
         emp_arr(idx).empno     || ' : ' ||
         emp_arr(idx).ename     || ' : ' ||
         emp_arr(idx).job       || ' : ' ||
         emp_arr(idx).mgr       || ' : ' ||
         emp_arr(idx).hiredate  || ' : ' ||
         emp_arr(idx).sal       || ' : ' ||
         emp_arr(idx).comm      || ' : ' ||
         emp_arr(idx).deptno);

   END LOOP;
END;
/







