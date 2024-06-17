-- TCL
CREATE TABLE DEPT_TCL
        AS SELECT *
                FROM DEPT;
                
INSERT INTO DEPT_TCL VALUES (50, 'DATABASE', 'SEOUL');
UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO = 40;
DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';
COMMIT;
-- TRUNCATE TABLE DEPT_TCL;
SELECT * FROM DEPT_TCL;

-- ���� (SESSION) : � Ȱ���� ���� �ð��̳� �Ⱓ�� ����
-- ���ӽ��� ~ ���� ����

-- �б� �ϰ���
-- �� ���ǿ��� ���̺� �����͸� ���� ��
-- �ٸ� ���ǿ����� Ȯ�������� ������ �����͸� �����ִ� Ư��
SELECT * FROM DEPT_TCL;
DELETE FROM DEPT_TCL WHERE DEPTNO = 50;
SELECT * FROM DEPT_TCL;

COMMIT;

-- LOCK : Ư�� ���ǿ��� �������� �����ʹ� �Ϸ�(C/R) �Ǳ� ������ �ٸ� ���ǿ��� ������ �� ���� ����
SELECT * FROM DEPT_TCL;
UPDATE DEPT_TCL SET LOC = 'SEOUL' WHERE DEPTNO = 30;
COMMIT;
SELECT * FROM DEPT_TCL;

CREATE TABLE DEPT_HW
AS SELECT * FROM DEPT;

UPDATE DEPT_HW
        SET DNAME = 'DATABASE', LOC = 'SEOUL'
WHERE DEPTNO = 30;
SELECT * FROM DEPT_HW;
ROLLBACK;
SELECT * FROM DEPT_HW;