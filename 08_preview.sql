-- FROM절에 여러 테이블 선언하기
SELECT *
  FROM EMP, DEPT
ORDER BY EMPNO;

-- 열 이름을 비교하는 조건식으로 조인하기
SELECT *
  FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO --DEPTNO 열 값이 14개 항만 출력
ORDER BY EMPNO;

-- 테이블의 별칭 설정
SELECT *
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;


SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
            , D.DNAME, D.LOC
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;


-- 08-2
-- 여러 테이블의 열 이름이 같을 때 유의점
-- 두 테이블에 부서 번호가 똑같은 열 이름으로 포함되어 있을 때 에러가 납니다.
SELECT EMPNO, ENAME, DEPTNO, DNAME, LOC
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
-- colum ambiguously defined

-- 8-5 열 이름에 각각의 테이블 이름도 함께 명시할 때
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO, E.EMPNO;

-- WHERE 절에 조건식 추가하여 출력 범위 설정하기
SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
     AND SAL >= 3000;

SELECT *
  FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

SELECT E.EMPNO, E.ENAME, C.MGR, E.JOB
  FROM EMP E, copy_emp C
WHERE E.MGR = C.EMPNO;

-- 같은 테이블을 두 번 사용하여 자체 조인하기
SELECT E1.EMPNO, E1.ENAME, E1.MGR
            , E2.EMPNO AS MGR_EMPNO
            , E2.ENAME AS MGR_ENAME
  FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO;


-- 내부 조인 외부 조인 이름에 대해서 
-- 왼쪽 외부 조인 (LEFT OUTER JOIN) WHERE TABLE1.COL1 = TABLE2.COL1(+)
-- 오른쪽 외부 조인 (RIGHT OUTER JOIN) WHERE TABLE1.COL1(+) = TABLE2.COL1

-- 왼쪽 외부 조인 사용하기
SELECT E1.EMPNO, E1.ENAME, E1.MGR
            , E2.EMPNO AS MGR_EMPNO
            , E2.ENAME AS MGR_ENAME
  FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+)
ORDER BY E1.EMPNO;


-- 오른쪽 외부 조인 사용하기
SELECT E1.EMPNO, E1.ENAME, E1.MGR
            , E2.EMPNO AS MGR_EMPNO
            , E2.ENAME AS MGR_ENAME
  FROM EMP E1, EMP E2
WHERE E1.MGR(+) = E2.EMPNO
ORDER BY E1.EMPNO;





























