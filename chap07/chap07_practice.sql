-- 212 PAGE Q1
SELECT DEPTNO, FLOOR(AVG(SAL)) AS AVG_SAL
            , MAX(SAL) AS MAX_SAL
            , MIN(SAL) AS MIN_SAL
            , COUNT(SAL) AS CNT
  FROM EMP
GROUP BY DEPTNO;

-- 212PAGE Q2
SELECT JOB, COUNT(*)
  FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 3;

-- 212PAGE Q3
SELECT SUBSTR(HIREDATE,1,4) AS HIRE_YEAR
            , DEPTNO
            , COUNT(DEPTNO) AS CNT
  FROM EMP
GROUP BY  SUBSTR(HIREDATE,1,4), DEPTNO;

-- 강사님 답
SELECT TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR
            , DEPTNO
            , COUNT(*) AS CNT
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')
            , DEPTNO;


-- 212PAGE Q4
SELECT NVL2(COMM, 'O', 'X') AS EXIST_COM
            , COUNT(NVL2(COMM, 'O', 'X')) AS CNT
FROM EMP
GROUP BY NVL2(COMM, 'O', 'X');



-- 212PAGE Q5
SELECT NVL(TO_CHAR(DEPTNO), ' ') AS DEPTNO
            , NVL(SUBSTR(HIREDATE,1,4),' ') AS HIRE_YEAR
            , COUNT(SUBSTR(HIREDATE,1,4)) AS CNT
            , MAX(SAL) AS MAX_SAL
            , SUM(SAL) AS SUM_SAL
            , AVG(SAL) AS AVG_SAL
FROM EMP
GROUP BY ROLLUP(DEPTNO, SUBSTR(HIREDATE,1,4));
-- 강사님 답
SELECT  DECODE(GROUPING(DEPTNO), 1,'총계', DEPTNO)  AS DEPTNO
            , DECODE(GROUPING(TO_CHAR(HIREDATE, 'YYYY')), 1, 
                            DECODE(GROUPING(DEPTNO), 1,' ', '소계'),
                        TO_CHAR(HIREDATE,'YYYY') )AS HIREDATE
            , COUNT(*) AS CNE
            , MAX(SAL) AS MAX_SAL
            , SUM(SAL) AS SUM_SAL
            , TRUNC(AVG(SAL)) AS AVG_SAL
            
            
  FROM EMP
GROUP BY ROLLUP(DEPTNO, TO_CHAR(HIREDATE, 'YYYY'));
-- 한울이형 정답
SELECT DECODE(GROUPING(DEPTNO), 1, ' ', DEPTNO) AS DEPTNO
            , DECODE(GROUPING(TO_CHAR(HIREDATE, 'YYYY')), 1,
                DECODE(GROUPING(DEPTNO), 1, ' ', ' '), TO_CHAR(HIREDATE, 'YYYY')) AS HIRE_YEAR
            , COUNT(*) AS CNT
            , MAX(SAL) AS MAX_SAL
            , SUM(SAL) AS SUM_SAL
            , ROUND(AVG(SAL), 5) AS AVG_SAL
  FROM EMP
GROUP BY ROLLUP(DEPTNO, TO_CHAR(HIREDATE, 'YYYY'));

-- 1. 부서번호 10번인 사원들의 사원번호, 사원이름, 월급을 출력하시오
SELECT EMPNO AS "사원번호", ENAME AS "사원이름", DEPTNO AS "부서번호" 
FROM EMP;

--2 사원번호 7369인 사원의 사원번호 사원이름 월급을 출력
SELECT EMPNO AS "사원번호", ENAME AS "사원이름", DEPTNO AS "부서번호" 
  FROM EMP
WHERE EMPNO = 7369;

--2 사원번호 7300보다 크고 7400보다 작은 사원 이름, 입사일, 부서번호 출력
SELECT ENAME 사원이름, HIREDATE 입사일, DEPTNO 부서번호
  FROM EMP
WHERE EMPNO > 7300 AND EMPNO <7400;

-- 4 EMPLOYEE 모든 정보를 사원번호 기준 내림차순으로 검색하시오
SELECT *
  FROM EMP 
ORDER BY EMPNO DESC;

-- 5 이름이 S로 시작하는 모든 사람의 사원번호와 이름을 출력하시오
SELECT *
  FROM EMP
WHERE ENAME LIKE 'S%';







































