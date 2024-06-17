--12�� DDL Data Definition Language

CREATE TABLE EMP_DDL
(EMPNO       NUMBER(4)
, ENAME      VARCHAR2(10)
, JOB             VARCHAR2(9)
, MGR           NUMBER(4)
, HIREDATE  DATE
, SAL              NUMBER(7,2)
, COMM        NUMBER(7,2)
, DEPTNO       NUMBER(2)
);


-- DDL ���� �ڵ����� COMMIT�� ��

-- ���̺� �� / �� �� ������Ģ
-- 1. ���ڷ� ���ۺҰ�, 2. ����� 30��, �ѱ��� 15�� -- �ѱ��� ���ڵ��� ���� �� �����Ƿ� �� ���ϴ°� ����
-- 3. ���� ������ ������ ���̺� �̸� �ߺ� �Ұ�
-- 4. Ư������ $, #, _ �� ����� �� �ִ�. ex) EMP#90_OB
-- 6. SELECT, FROM ���� ���̺� �̸����� ��� �Ұ� (�ٵ� DUAL�� �Ǵ���)

-- ���� ���̺� �� ����ȭ �����͸� �����Ͽ� �� ���̺� �����ϱ�
CREATE TABLE DEPT_DDL
         AS SELECT * FROM DEPT;
         
DESC DEPT_DDL;

-- �ٸ� ���̺��� �Ϻθ� �����Ͽ� ���̺� �����ϱ�
CREATE TABLE EMP_DDL_30
        AS  SELECT * FROM EMP WHERE DEPTNO = 30;
        
-- ���� ���̺��� �� ������ �����Ͽ� �� ���̺� ����
CREATE TABLE EMPDEPT_DDL
        AS  SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE
                        ,   E.SAL, E.COMM, D.DEPTNO, D.DNAME, D.LOC
                FROM EMP E, DEPT D
            WHERE 1<>1;
SELECT * FROM EMPDEPT_DDL;

-- 12-6 EMP ���̺� �����Ͽ� ���̺� ���� ����
CREATE TABLE EMP_ALTER
         AS SELECT * FROM EMP;
         
SELECT * FROM EMP_ALTER;

-- 12-7 �÷� �߰�(ADD)
ALTER TABLE EMP_ALTER
        ADD HP VARCHAR(20);
        
SELECT * FROM EMP_ALTER;



-- 12-8 �÷��� ����(RENAME)
ALTER TABLE EMP_ALTER
       RENAME COLUMN HP TO TEL;
SELECT * FROM EMP_ALTER;


-- ������ Ȯ��
ALTER TABLE EMP_ALTER
MODIFY EMPNO NUMBER(5); -- ������ Ȯ���� ������ ������ ��Ҵ� �Ұ�
SELECT * FROM EMP_ALTER;

-- �� ����
ALTER TABLE EMP_ALTER
DROP COLUMN TEL;
SELECT * FROM EMP_ALTER;

-- ���̺� �̸� ����
RENAME EMP_ALTER TO EMP_RENAME;

DESC EMP_ALTER;
DESC EMP_RENAME;

SELET * FROM EMP_RENAME;

TRUNCATE TABLE EMP_RENAME;
DROP TABLE EMP_RENAME;

-- Q1
CREATE TABLE EMP_HW
(EMPNO       NUMBER(4)
, ENAME      VARCHAR2(10)
, JOB             VARCHAR2(9)
, MGR           NUMBER(4)
, HIREDATE  DATE
, SAL              NUMBER(7,2)
, COMM        NUMBER(7,2)
, DEPTNO       NUMBER(2)
);

-- Q2
SELECT * FROM EMP_HW;
ALTER TABLE EMP_HW
ADD BIGO VARCHAR(20);
DESC EMP_HW;

-- Q3
ALTER TABLE EMP_HW
MODIFY BIGO VARCHAR(30);
DESC EMP_HW;
--Q4
ALTER TABLE EMP_HW
RENAME COLUMN BIGO TO REMARK;
DESC EMP_HW;
--Q5
INSERT INTO EMP_HW 
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, NULL 
  FROM EMP; 
SELECT * FROM EMP_HW;
--Q6
TRUNCATE TABLE EMP_HW;
DROP TABLE EMP_HW;


