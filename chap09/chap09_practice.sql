-- 09 SQL문 속  또 다른 SQL 문 서브쿼리

-- 서브쿼리가 SQL문을 실행하는 데 필요한 데이터를 추가로 조회하기 위해 SQL문 내부에서
-- 사용하는 SELECT 문을 의미함. 서브쿼리의 결과 값을 사용하여 기능을 수행하는 영역은 메인쿼리라고 함
-- 예를 들어서 SELECT 문에서 WHERE 절의 조건식에 서브쿼리를 사용한다면 전체 SELECT문은 다음과 같이 구성됩니다.

-- 사원 이름이 JONES인 사원의 급여 출력하기
SELECT SAL
  FROM EMP
WHERE ENAME = 'JONES';
-- 급여가 29175보다 높은 사원 정보 출력하기
SELECT *
  FROM EMP
WHERE SAL > 2975;  

-- 서브쿼리로 JONES보다 많은 월급을 받는 사원 정보 출력하기
SELECT *
  FROM EMP
WHERE SAL > (SELECT SAL
                        FROM EMP
                      WHERE ENAME = 'JONES');
-- 이를 한줄로                      
SELECT * FROM EMP WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'JONES');

-- 서브쿼리 특징
-- 서브쿼리 연산자는 같은 비교 또는 조회 대상의 오른쪽에 놓이며 괄호()로 묶어서 사용
-- 서브쿼리의 SELECT 절에 명시한 열은 메인쿼리의 비교 대상과 같은 자료형과 같은 개수로 지정
-- 즉 메인쿼리의 비교 대상 데이터가 하나렴 서브쿼리의 SELECT절 역시 같은 자료형인 열을 하나 지정
-- 서브쿼리에 있는 SELECT문의 결과 행수는 함께 사용하는 메인쿼리의 연산자 종류와 호환 가능해야 함
-- 예를 들어서 메인쿼리에 사용한 연산자가 단 하나의 데이터로만 연산이 가능한 연산자라면 서브쿼리의결과 행 수는 반드시 하나여야 함
-- 이 내용은 '단일 행 서브쿼리 및 다중행 서브쿼리' 에서 자세히 살펴볼 예정


-- SCOTT보다 빨리 입사한 사원의 목록을 조회 -9-4
SELECT *
  FROM EMP
WHERE HIREDATE < (SELECT HIREDATE
                               FROM EMP
                               WHERE ENAME = 'SCOTT');
                               
-- 9-5 서브쿼리 안에서 함수를 사용한 경우 (EMP테이블과 DEPT 테이블을 묶음)
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL
            , D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
     AND E.DEPTNO = 20
     AND E.SAL > (SELECT AVG(SAL) 
                          FROM EMP);
                          
                          
                          
                          
-- 다중행 서브쿼리는 실행 결과 행이 여러개로 나오는 서브 쿼리를 가리킵니다. 앞에서 살펴본 단일행 서브쿼리와 달리 서브쿼리 결과가 여러개이므로 단일행 연산자는 사용할 수 없고
-- 다중행 연산자를 사용해야 메인쿼리와 비교할 수 있습니다. 다중행 연산 종류는 다음과 같음
-- IN                     :   메인쿼리의 데이터가 서브쿼리의 결과 중 하나라도 일치한 데이터가 있다면 true
-- ANY, SOME    :  메인쿼리의 조건식을 만족하는 서브쿼리의 결과가 하나 이상이면 true
--  ALL                 :   메인쿼리의 조건식을 서브쿼리의 결과 모두가 만족하면 true
-- EXISTS            :    서브쿼리의 결과가 존재하면 (즉, 행이 1개 이상일 경우) true


-- IN 연산자는 이미 05장에서 WHERE 절과 연산자를 다루면서 소개한 연산자이며 다음과 같은 형태로 사용이 가능함.
-- 9-6
SELECT *
  FROM EMP
WHERE DEPTNO IN (20, 30);   -- 부서 번호가 20이거나 30인 사원의 정보만 출력
-- 9-7 각 부서별 최고 급여와 동일한 급여를 받는 사원 정보 출력하기
SELECT *
  FROM EMP
WHERE SAL IN (SELECT MAX(SAL)   FROM EMP   GROUP BY DEPTNO); -- MAX(SAL) 2850, 3000, 5000 이 출력됨
-- ANY, SOME 연산자
-- 서브쿼리가 반환한 여러 결과 값 중 메인쿼리와 조건식을 사용한 결과가 하나라도 true라면 메인쿼리 조건식을 true로 반환해주는 연산자 입니다.
-- 서브쿼리 결과 값 중 하나만 조건식에 맞아떨어지면 메인쿼리의 조건식이 참이 되어 출력 대상이 된다는 점에서 앞에서 살펴 본 IN 연산자와 비슷함을 알 수 있음
-- 메인쿼리와 비교할때 ANY 및 SOME 연산자를 등가 비교 연산자 (=)와 함께 사용하면 IN 연산자와 정확히 같은 기능을 수행함.
SELECT *
  FROM EMP
WHERE SAL = ANY (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO); -- IN을 사용한것과 거의 동일
-- ANY를 등가비교연산자와 사용하지 않은 경우 = > 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 정보 출력하기
SELECT *
  FROM EMP
WHERE SAL < ANY (SELECT SAL FROM EMP WHERE DEPTNO = 30) -- 30번 사원들의 최대급여보다 적은 급여인 이유 : DEPTNO가 30인 사원들의 급여가 출력되지만
                                                                                                                      --  ANY는 하나라도 만족하는 경우에 대해서 TRUE 2850 달러보다 적은 경우 출력
ORDER BY SAL, EMPNO;                 

SELECT SAL FROM EMP WHERE DEPTNO = 30;                                  --출력하면 1600 1250 1250 2850 1500 950이 출력됨 -- MAX를 안써도 되는 것을 알 수 있음

-- 반대로 30번 부서 사원들의 최소 급여보다 많은 급여를 받는 사원 정보를 출력
SELECT *
  FROM EMP
WHERE SAL > ANY (SELECT SAL FROM EMP WHERE DEPTNO = 30);    -- 마찬가지로 ANY를 써줌으로 MIN 함수를 써지 않아도 되는 것을 확인할 수 있음

/*
SOME 연산자 사용하기
*/
SELECT *
  FROM EMP
WHERE SAL = SOME (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO); -- ANY, IN 과 동일

-- ALL 연산자
-- ANY 및 SOME과 달리 서브쿼리의 모든 결과가 조건식에 맞아 떨어져야만 메인쿼리의 조건식이 TRUE가 되는 연산자
-- 부서번호가 30번인 사원들의 최소 급여보다 더 적은 급여를 받는 사원을 출력
SELECT *
  FROM EMP
WHERE SAL < ALL (SELECT SAL FROM EMP WHERE DEPTNO = 30);  -- 1600 1250 1250 2850 1500 950 보다 적게 받는 사원 출력 = 모두 만족해야하므로 950보다 적은 사원

SELECT *
  FROM EMP
WHERE SAL > ALL(SELECT SAL FROM EMP WHERE DEPTNO = 30); -- 마찬가지로 2850보다 많이 받는 사원을 출력

-- EXISTS 연산자
-- EXISTS 연산자는 조금 특이한 연산자인데 서브쿼리에 결과 값이 하나 이상 존재하며 조건식이 모두 TRUE
-- 존재하지 않으면 모두 FALSE 가 되는 연산자 먼저 TRUE가 되는 결과를 확인
-- 9-16 서브쿼리 결과 값이 존재하는 경우
SELECT *
  FROM EMP
WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO = 10); -- DEPT 테이블의 10번 부서의 DNAME이 전부 존재하면 SELECT * FROM EMP; 를 출력하라 라는 것과 동일
SELECT *  FROM EMP;

SELECT *
  FROM EMP
WHERE EXISTS(SELECT DNAME FROM DEPT WHERE DEPTNO = 50);  -- DEPT 테이블의 50번 부서의 DNAME이 전부 존재하면 SELECT * FROM EMP를 출력하라 = 하나라도 없으면 출력하지 마라
-- 1분 복습
SELECT *
FROM EMP 
WHERE HIREDATE < ALL (SELECT HIREDATE FROM EMP WHERE DEPTNO = 10);

-- 9-4 비교할 열이 여러 개인 다중열 서브쿼리
-- 9-18 비교할 열이 여러 개인 다중열 서브쿼리
SELECT *
  FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO); -- 의미 있는 출력은 아니지만 다중열 서브 쿼리의 사용 방법으로 기억해두는 것이 좋음
SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO; 


--9-19 인라인 뷰 사용하기
-- FROM 절에 사용하는 서브쿼리는 인라인 뷰라고 부름
-- SELECT 문을 통해 특정 열을 추출해 온 후 별칭을 주어 사용할 수 있음
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10, (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;


-- 하지만 FROM 절에 너무 많은 서브쿼리를 지정하면 가독성이나 성능이 떨어질 수 있기 때문에
-- WITH 절을 사용하기도 함

-- WITH 절 사용하기 (최상단에 나올 수 있음)
WITH
E10 AS (SELECT * FROM EMP WHERE DEPTNO  = 10),
D     AS (SELECT * FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM E10, D
WHERE E10.DEPTNO = D.DEPTNO;

-- 상호연관 서브쿼리
-- 서브쿼리 결과 값을 다시 메인쿼리로 돌려주는 방식인 상호연관 서브쿼리도 존재함 ( 단 성능을 떨어트리는 원인이 될 수 있어 사용 빈도가 높지 않음)
-- 예시
SELECT *
  FROM EMP E1
WHERE SAL > (SELECT MIN(SAL) FROM EMP E2 WHERE E2.DEPTNO = E1.DEPTNO) -- E2.DEPTNO 와 E1.DEPTNO가 동일한 테이블에서 MIN(SAL) 값 을 EMP1 테이블의 SAL 값과 비교 
ORDER BY DEPTNO, SAL;                                                                                                      -- 이후 DEPTNO SAL로 정렬

-- 09-6 SELECT 절에 사용하는 서브쿼리
--9-21 SELECT 절에 서브쿼리 사용하기
SELECT GRADE  FROM SALGRADE, EMP E WHERE E.SAL BETWEEN LOSAL AND HISAL; --??
SELECT DNAME FROM EMP E, DEPT WHERE E.DEPTNO =DEPT.DEPTNO;
SELECT EMPNO, ENAME, JOB, SAL
            , (SELECT GRADE FROM SALGRADE WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE -- E.SAL이 LOSAL ~ HISAL에 속한 GRADE값을 SALGRADE라고 함
            , DEPTNO
            , (SELECT DNAME FROM DEPT WHERE E.DEPTNO =DEPT.DEPTNO) AS DNAME                             -- E.DEPTNO = DEPT.DEPTNO 값이 같은 상태에서의 DNAME을 DNAME이라고 함
  FROM EMP E;

SELECT DNAME FROM DEPT, EMP WHERE EMP.DEPTNO =DEPT.DEPTNO;

-- 262 페이지 Q1
-- 전체 사원 중 ALLEN과 같은 직책(JOB)인 사원들의 사원 정보, 부서 정보를 다음과 같이 출력하는 SQL을 작성하시오
SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
     AND JOB = (SELECT JOB FROM EMP WHERE ENAME = 'ALLEN'); 
-- 전체 사원의 평균 급여(SAL)보다 높은 급여를 받는 사원들의 사원 정보, 부서 정보, 급여 등급 정보를 출력하는 SQL문을 작성
-- (단 출력할 때 급여가 많은 순으로 정렬하되 급여가 같을 경우 사원 번호를 기준으로 오름 차순으로 정렬)
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE,D.LOC, E.SAL, S.GRADE
FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL BETWEEN S.LOSAL AND S.HISAL
AND SAL > (SELECT AVG(SAL) FROM EMP)
ORDER BY E.SAL DESC, E.EMPNO;


-- 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않은 직책을 가진 사원들의 사원 정보 부서 정보를 다음과 같이 출력하는 SQL문을 작성
-- 예시 7839  KING    PRESIDENT 10  ACCOUNTING  NEWYORK     -->  7839번인       왕       대표      10번부서       ACCOUNTING부서        뉴욕거주

SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC            -- 사원번호    사원이름    사원직업    부서번호    부서명     부서위치
  FROM EMP E, DEPT D                                                                                         -- 필요한 TABLE
WHERE E.DEPTNO = D.DEPTNO                                                                         -- EMP TABLE과 DEPT TABLED에서 DEPTNO가 일치하는 사람 들 중
     AND E.DEPTNO = 10                                                                                        -- 10번 부서에 근무하는 사람들 중
     AND JOB NOT IN (SELECT DISTINCT JOB FROM EMP WHERE DEPTNO = 30);  -- 30번 부서에는 존재하지 않는 직책을 가진 사람 -- DISTINCT는 빠져도 상관 없음





-- 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원정보 급여등급 정보를 다음과 같이 출력하는 SQL 문을 작성하세요
-- 단 서브쿼리를 활용할 때 다중행 함수를 사용하는 방법과 사용하지 않는 방법을 통해 사원 번호를 기준으로 오름차순으로 정렬하세요.
-- EMPNO, ENAME, SAL, GRADE
-- 다중행 사용 O
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
     AND E.SAL > ALL (SELECT DISTINCT SAL FROM EMP WHERE EMP.JOB = 'SALESMAN')          -- DISTINCT는 빠져도 상관 없음 다만 중복값이 있어서 제거하기위해 넣음
ORDER BY E.EMPNO;

-- 다중행 사용 X
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
     AND E.SAL > (SELECT MAX(SAL) FROM EMP WHERE EMP.JOB = 'SALESMAN')                      -- 한가지 값인 1600이 반환됨
ORDER BY E.EMPNO;




SELECT MAX(SAL) FROM EMP WHERE EMP.JOB = 'SALESMAN';
SELECT DISTINCT SAL FROM EMP WHERE EMP.JOB = 'SALESMAN';













































