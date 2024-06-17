--chap 13 
-- ������ ���� ��� �뵵�� ���� �̸� �տ� ������ ���� ���ξ �����Ͽ� �з���
--  USER_XXXX   :   ���� �����ͺ��̽��� ������ ����ڰ� ������ ��ü ����
--  ALL_XXXX      :   ���� �����ͺ��̽��� ������ ����ڰ� ������ ��ü �Ǵ� �ٸ� ����ڰ� ������ ��ü �� ��� �㰡�� ���� ��ü, �� ��� ������ ��� ��ü ����
-- DBA_XXXX     :    �����ͺ��̽� ������ ���� ���� (�����ͺ��̽� ���� ������ ���� SYSTEM, SYS ����ڸ� ���� ����)
-- V$_XXXX        :    ������ ���̽� ���� ���� ���� (x$_XXXX ���̺��� ��)

-- ������  �������� �����ͺ��̽� �޸� ���� ����� ���� ��ü �� ����Ŭ �����ͺ��̽� ��� �߿��� �����Ͱ� �����Ǿ� ���� ���� �� �����Ϳ� ������ �߻��Ѵٸ�
-- ����Ŭ �����ͺ��̽� ����� �Ұ������� ���� ����
-- ���� ����Ŭ �����ͺ��̽��� ����ڰ� ������ ���� ������ ���� �����ϰų� �۾��ϴ� ���� ������� �ʰ�, �� ��� ������ ���� �並 �����Ͽ� SELECT ������ ���� ������ �� �� �ְ� �ص�

-- 13-1
SELECT * FROM DICT;
-- ������ ��ɾ� �ε�
SELECT * FROM DICTIONARY;

-- USER_���ξ ���� ������ ����
-- ������ ������ �ִ� ��ü ���� ���캸��(USER_ ���ξ� ���)
SELECT TABLE_NAME
  FROM USER_TABLES;
  
-- ALL_ ���ξ ���� ������ ����
SELECT OWNER, TABLE_NAME
  FROM ALL_TABLES;
-- ALL_TABLES���� USER_TABLES�� �޸� OWNER���� �ϳ� ������ �� ���� ���̺��� ������ ����ڸ� �����, 
-- ���忡�� �ƿ��� DUAL ���̺��� ����Ŭ ���� ���� SYS �����̰� HR������ �� ���̺��� �㰡 ���� ��


-- DBA_ ���ξ ���� ������ ����
SELECT * FROM DBA_TABLES;       -- ��� ������ ���� ����ڴ� �������� �ʽ��ϴ� ������ ��Ÿ�� table or view does not exist
SELECT * FROM DBA_TABLES;       -- ���� ��ܿ��� SYS�� ���� ���� �� ���� ���� ���� ��Ÿ��

-- �ε��� ����ϱ�
-- HR ������ ������ �ε��� ���� �˾ƺ���
SELECT *
    FROM USER_INDEXES;
-- HR ������ ������ �ε��� �÷� ���� �˾ƺ���
SELECT *
    FROM USER_IND_COLUMNS;

-- �ε��� ���� EMP ���̺��� SAL ���� �ε����� �����ϱ�
CREATE INDEX IDX_EMP_SAL -- table or view does not exist" ��� ������ ���δٸ� SYS�� HR�� �����غ��� 
    ON  EMP(SAL);                       -- ������ ��޵� ���̺��̳� �䰡 ������ ��Ÿ���� �޼�����.

-- �ε��� ����
DROP INDEX IDX_EMP_SAL;

SELECT * FROM USER_IND_COLUMNS; -- �ε����� ������ Ȯ���ϴ� �� INDEX_NAME   TABLE_NAME  COLUMN_NAME COLUMN_POSITION COLUMN_LENGTH   CHAR_LENGTH DESCEND�� ��Ÿ��

-- ���? �������̺��� �θ��� ��Ī���� �ϳ� �̻��� ���̺��� ��ȸ�ϴ� SELECT���� ������ ��ü�� �ǹ���. SELECT���� �����ϱ� ������ ������ �����͸� ���� ���������� ����
SELECT EMPNO, ENAME, JOB, DEPTNO
    FROM EMP
WHERE DEPTNO = 20;
-- ==>
SELECT *
    FROM(SELECT EMPNO, ENAME, JOB, DEPTNO
                    FROM EMP
                WHERE DEPTNO = 20);
                
-- �����
CREATE VIEW VW_EMP20
    AS (SELECT EMPNO, ENAME, JOB, DEPTNO
                FROM EMP
            WHERE DEPTNO = 20);
SELECT *
    FROM USER_VIEWS;
    
SELECT VIEW_NAME, TEXT_LENGTH, TEXT
    FROM USER_VIEWS;
    
-- ������ �� ��ȸ�ϱ�
SELECT *
    FROM VW_EMP20;
-- ���� ��� ����(����)
-- 1. ���� : SELECT ���� ���⵵�� ��ȭ�ϱ� ����
-- 2. ���ȼ� : ���̺��� Ư������ �����ϰ� ���� ���� ���

-- ������ �� �����ϱ�
DROP VIEW VW_EMP20;

-- �ζ��� �並 ����� TOP-N SQL ��
SELECT ROWNUM, E.*  -- ROWNUM�̶� ���ڴ� �������� ������ �ش� ���ڰ� ��Ÿ���� ���� Ȯ���� �� ����
    FROM EMP E;             -- �� ��� �ǻ� ���̶�� �ϴ� Ư�� ����

-- EMP ���̺��� SAL �� �������� �����ϱ�
SELECT ROWNUM, E.*
    FROM EMP E
ORDER BY SAL DESC;

-- 13-22 -- �� ���̺��� ���������� ��Ÿ�� ��
SELECT ROWNYM, E.*
    FROM (SELECT *  FROM EMP E  ORDER BY SAL DESC) E;
    
--13-23 -- WITH ���� ����� ��
WITH E AS (SELECT * FROM EMP ORDER BY SAL DESC)
SELECT ROWNUM, E.*
    FROM E;

--13-24 �ζ��� ��� TOP-N �����ϱ� (�������� ���)
SELECT ROWNUM, E.*
    FROM(SELECT *   FROM EMP E  ORDER BY SAL DESC) E
WHERE ROWNUM <= 3;

-- 13-25 �ζ��� ��� TOP-N �����ϱ� (WITH �� ���)
WITH E AS (SELECT * FROM EMP ORDER BY SAL DESC) 
SELECT ROWNUM, E.*
    FROM E
WHERE ROWNUM <= 3;

-- 13-4
-- ��������?
-- �������� ����Ŭ ������ ���̽����� Ư�� ��



























