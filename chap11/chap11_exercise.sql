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

-- 세션 (SESSION) : 어떤 활동을 위한 시간이나 기간을 뜻함
-- 접속시작 ~ 접속 종료

-- 읽기 일관성
-- 이 세션에서 테이블 데이터를 변경 중
-- 다른 세션에서는 확정전까지 본래의 데이터를 보여주는 특성
SELECT * FROM DEPT_TCL;
DELETE FROM DEPT_TCL WHERE DEPTNO = 50;
SELECT * FROM DEPT_TCL;

COMMIT;

-- LOCK : 특정 세션에서 조작중인 데이터는 완료(C/R) 되기 전까지 다른 세션에서 조작할 수 없는 상태
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