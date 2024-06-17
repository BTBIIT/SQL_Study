-- 두테이블에서 이름과 자료형이 같은 열을 찾은 후 그 열을 기준으로 등가조인을 해주는 방식 NATURAL JOIN 사용
SELECT E.EMPNO, E.ENAME, E.MGR, E.HIREDATE, E.SAL, E.COMM
            , DEPTNO, D.DNAME, D.LOC
  FROM EMP E NATURAL JOIN DEPT D
ORDER BY DEPTNO, E.EMPNO;

-- JOIN ~ USING 등가조인을 대신해주는 조인방식 NATURAL JOIN이 자동으로 조인 기준 열을 지정하는 것과 달리 
-- USING 키워드에 조인 기준으로 사용할 열을 명시하여 사용합니다.
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM
            , DEPTNO, D.DNAME, D.LOC
  FROM EMP E JOIN DEPT D USING (DEPTNO) -- 여기서는 DEPTNO가 기준으로 사용된 것임
WHERE SAL >= 3000
ORDER BY DEPTNO, E.EMPNO;
-- WHERE 절에 있는 조인 조건식을 ON 키워드 옆에 작성함 조인 기준 조건식은 ON에 명시하고 그 밖의 출력행을 걸러내기 위해
-- WHERE 조건식을 따로 사용하는 방식
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM
            , E.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
WHERE SAL <= 3000
ORDER BY E.DEPTNO, EMPNO;

-- 왼쪽 외부 조인 
-- 기존       :    WHERE TABLE1.COL1 = TABLE2.COL1(+)
-- SQL-99   :    FROM TABLE 1 LEFT OUTER JOIN TABLE2 ON (조인 조건식)

-- 오른쪽 외부 조인 
-- 기존       :    WHERE TABLE1.COL1(+) = TABLE2.COL1
-- SQL-99   :    FROM TABLE 1 RIGHT OUTER JOIN TABLE2 ON (조인 조건식)

-- 전체 외부 조인
-- 기존       :   기본 문법은 없음 (UNION 집합 연산자를 활용)
-- SQL-99   :   FROM TABLE 1 FULL OUTER JOIN TABLE2 ON (조인 조건식)


-- 왼쪽 외부 조인을 SQL-99로 작성하기
SELECT E1.EMPNO, E1.ENAME, E1.MGR
            , E2.EMPNO AS MGR_EMPNO
            , E2.ENAME AS MGR_ENAME
  FROM EMP E1 LEFT OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO)
ORDER BY E1.EMPNO;
-- 왼쪽 외부 조인을 기존 문법으로 작성
SELECT E1.EMPNO, E1.ENAME, E1.MGR
            , E2.EMPNO AS MGR_EMPNO
            , E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+)
ORDER BY E1.EMPNO;

-- 오른쪽 외부 조인을 SQL-99로 작성하기
SELECT E1.EMPNO, E1.ENAME, E1.MGR
            , E2.EMPNO AS MGR_EMPNO
            , E2.ENAME AS MGR_ENAME
  FROM EMP E1 RIGHT OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO)
ORDER BY E1.EMPNO, MGR_EMPNO;
-- 오른쪽 외부 조인을 기존 문법으로 작성
SELECT E1.EMPNO, E1.ENAME, E1.MGR
            , E2.EMPNO AS MGR_EMPNO
            , E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR(+) = E2.EMPNO
ORDER BY E1.EMPNO;

-- 전체 외부 조인 은 왼쪽, 오른쪽 외부 조인을 모두 적용한 즉 왼쪽열이 null인 경우와 오른쪽열이 null인 경우 모두를 출력하는 방식
-- 기존 외부 조인으로는  UNION 집합 연산자를 사용하여 왼쪽 오른쪽 조인의 결과를 합치는 방법만 가능했습니다. 하지만 
-- SQL-99 방식의 외부조인은 FULL OUTER JOIN ~ ON 키워드로 모두 외부 조인된 결과의 값을 출력할 수 있습니다
SELECT E1.EMPNO, E1.ENAME, E1.MGR
            , E2.EMPNO AS MGR_EMPNO
            , E2.ENAME AS MGR_ENAME
  FROM EMP E1 FULL OUTER JOIN EMP E2 ON (E1.MGR  = E2.EMPNO)
ORDER BY E1.EMPNO;

-- 08-practice 01 번 SQL-99 방식 적용
SELECT E.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO) -- FROM 절에서 EMP와 DEPT를 선언 및 JOIN ON으로 동일 조건을 명시 및 묶음
WHERE SAL > 2000                                                      -- WHERE 절에서 한 가지에 대해서만 필터링하면 적용이 가능
ORDER BY E.DEPTNO;
-- 08-practice 01번 SQL-99방식 미적용
SELECT E.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO                                    -- WHERE 절에서 DEPTNO가 같은 경우에 대해서 조건을 걸어줌
AND SAL > 2000                                                         -- 이후 AND 조건을 통해 추가적인 조건을 걸어서 2000 달러 이상인 경우에만 출력
ORDER BY E.DEPTNO;

--08 practice 02번 SQL-99 방식 적용
SELECT E.DEPTNO, D.DNAME, ROUND(AVG(E.SAL),0) AS AVG_SAL
            , MAX(E.SAL) AS MAX_SAL
            , MIN(E.SAL) AS MIN_SAL
            , COUNT(*) AS CNT
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
GROUP BY E.DEPTNO, D.DNAME;
--SQL-99 방식(2)
SELECT DEPTNO,
       D.DNAME,
       TRUNC(AVG(SAL)) AS AVG_SAL,
       MAX(SAL) AS MAX_SAL,
       MIN(SAL) AS MIN_SAL,
       COUNT(*) AS CNT
  FROM EMP E JOIN DEPT D USING (DEPTNO)
GROUP BY DEPTNO, D.DNAME;
--08 practice 02번 SQL-99 방식 미적용 -- 복습 필요★★★
SELECT E.DEPTNO, D.DNAME, ROUND(AVG(E.SAL),0) AS AVG_SAL
            , MAX(E.SAL) AS MAX_SAL
            , MIN(E.SAL) AS MIN_SAL
            , COUNT(*) AS CNT
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
GROUP BY E.DEPTNO, D.DNAME;

--08 practice 03번 SQL-99 방식 적용 -- 오른쪽 외부조인을 이용하는 방법으로 DEPT D에 맟춰야 하는 방법 따라서 RIGHT JOIN (기준 우측열)이 옴
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM EMP E RIGHT JOIN  DEPT D ON (E.DEPTNO = D.DEPTNO)
ORDER BY E.DEPTNO;

--08 practice 03번 SQL-99 방식 미적용 -- 기존 SQL - 99가 아닌 방식으로 코딩할땐 맟춰야 되는 쪽에 +를 붙여줬음
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO
ORDER BY E.DEPTNO;

--08-practice 04번 -- 복습 필요★★★
--SQL-99방식
SELECT D.DEPTNO, D.DNAME
          , E.EMPNO, E.ENAME, E.MGR, E.SAL, E.DEPTNO
          , S.LOSAL, S.HISAL, S.GRADE
          , E2.EMPNO AS MGR_EMPNO
          , E2.ENAME AS MGR_ENAME
  FROM EMP E RIGHT OUTER JOIN DEPT D 
                ON (E.DEPTNO = D.DEPTNO) -- 기준열은 DEPT 열로 우측정열하면서
              LEFT OUTER JOIN SALGRADE S -- 동시에 SALGRADE는 EMP에 왼쪽정렬로 맟춘다
                ON (E.SAL BETWEEN S.LOSAL AND S.HISAL)
              LEFT OUTER JOIN EMP E2      -- 이후 똑같은 열을 호출하여  상관번호가 EMPNO 와 같은열만 호출
                ON (E.MGR = E2.EMPNO)
ORDER BY D.DEPTNO, E.EMPNO;  -- 이후 DEPTNO와 EMPNO에 대하여 정렬

--SQL-99 이전 방식 -- 이 방식이 좀 더 가독성은 있는듯...
SELECT D.DEPTNO, D.DNAME,
       E.EMPNO, E.ENAME, E.MGR, E.SAL, E.DEPTNO,
       S.LOSAL, S.HISAL, S.GRADE,
       E2.EMPNO AS MGR_EMPNO, E2.ENAME AS MGR_ENAME
  FROM EMP E, DEPT D, SALGRADE S, EMP E2
 WHERE E.DEPTNO(+) = D.DEPTNO
   AND E.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
   AND E.MGR = E2.EMPNO(+)
ORDER BY D.DEPTNO, E.EMPNO; 


