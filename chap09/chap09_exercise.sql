-- 9장 서브쿼리
-- 9-1 JONES인 사원의 급여 출력
SELECT SAL
  FROM EMP
WHERE ENAME = 'JONES';

-- 9-2 급여가 2975보다 높은 사원 정보 출력
SELECT *
  FROM EMP
WHERE SAL > 2975;

 -- 이는 동일한 말로
 SELECT *
   FROM EMP
WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'JONES');

-- 서브쿼리 특징
-- 1. 괄호로 묶어줘야함
-- 2. 특수한 경우 제외 서브쿼리에는 ORDER BY를 사용할 수 없음 -- > 성능이 낮아짐
-- 3. 메인쿼리 비교대상과 데이터 개수와 자료형 고려
-- 4. 서브쿼리에 단일행, 다중행이냐에 따라 연산자 고려
SELECT *
  FROM EMPLOYEES
 WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEES
               WHERE FIRST_NAME = 'Adam') ;  -- David 다중행 오류
-- 1분 복습 -- 사원정보 중에서 사원 이름이 ALLEN인 사원의 추가수당보다 많은 추가수당을 받는 사원 정보
SELECT *
  FROM EMP 
WHERE COMM > (SELECT COMM FROM EMP WHERE ENAME = 'ALLEN');

-- 9-4
SELECT *
  FROM EMP
WHERE HIREDATE < (SELECT HIREDATE FROM EMP WHERE ENAME = 'SCOTT');
-- 서브쿼리 특징
-- 서브쿼리 연산자는 같은 비교 또는 조회 대상의 오른쪽에 놓이며 괄호()로 묶어서 사용
-- 서브쿼리의 SELECT 절에 명시한 열은 메인쿼리의 비교 대상과 같은 자료형과 같은 개수로 지정
-- 즉 메인쿼리의 비교 대상 데이터가 하나렴 서브쿼리의 SELECT절 역시 같은 자료형인 열을 하나 지정
-- 서브쿼리에 있는 SELECT문의 결과 행수는 함께 사용하는 메인쿼리의 연산자 종류와 호환 가능해야 함
-- 예를 들어서 메인쿼리에 사용한 연산자가 단 하나의 데이터로만 연산이 가능한 연산자라면 서브쿼리의결과 행 수는 반드시 하나여야 함
-- 이 내용은 '단일 행 서브쿼리 및 다중행 서브쿼리' 에서 자세히 살펴볼 예정

SELECT SALARY
  FROM EMPLOYEES
WHERE HIRE_DATE = '2006/01/03';

SELECT *
  FROM EMPLOYEES
WHERE SALARY = (SELECT SALARY FROM EMPLOYEES WHERE HIRE_DATE = '20060103');

SELECT *
  FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE HIRE_DATE = '20060103');

-- 단일행 서브쿼리와 함수
-- 9-5 사원정보에서 평균급여보다 많ㅇ ㅣ받는 사람을 출력
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL
            , D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
     AND E.DEPTNO = 20
     AND E.SAL > (SELECT AVG(SAL)  FROM EMP);

SELECT *
  FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

-- 1분복습
-- 전체 사원의 평균 급여보다 작거나 같은 급여를 받고 있는 
-- 20번 부서의 사원 및 부서 정보를 구하도록
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL
            , D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
     AND E.DEPTNO = 20
     AND E.SAL <= (SELECT AVG(SAL)  FROM EMP);

-- 다중행 서브쿼리 연산자 : IN, ANY/SOME, ALL, EXISTS
--9-6
SELECT *
  FROM EMP
WHERE DEPTNO IN (20, 30);

SELECT DEPTNO, MAX(SAL)
  FROM EMP
GROUP BY DEPTNO;

-- 9-7 각 부서별 최고 급여와 동일한 급여를 받는 사원 정보 출력
SELECT *
  FROM EMP
WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

-- ANY SOME 연산자
-- 9-9
SELECT *
  FROM EMP
WHERE SAL = ANY (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

-- 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원정보 출력하기
SELECT *
  FROM EMP
WHERE SAL < ANY (SELECT SAL FROM EMP WHERE DEPTNO = 30)
ORDER BY SAL, EMPNO; -- 2850보다 작게 받는 사원

-- < ANY 서브쿼리에 MAX 함수를 사용한 경우

-- 30번 부서 사원들의 최소급여 보다 많은 급여를 받는 사원
SELECT *
  FROM EMP
WHERE SAL > ANY (SELECT SAL FROM EMP WHERE DEPTNO = 30)
ORDER BY SAL, EMPNO; 
-- ALL 연산자 : 모두 만족
-- 9-14 부서 번호가 30번인 사원들의 최소 급여 보다 더 적은 급여를 받는 사원
SELECT *
  FROM EMP
WHERE SAL < ALL (SELECT SAL FROM EMP WHERE DEPTNO = 30);
-- 9-15 부서 번호가 30번인 사원 들의 최대 급여 보다 더 많은 급여를 받는 사원
SELECT *
  FROM EMP
WHERE SAL > ALL (SELECT SAL FROM EMP WHERE DEPTNO = 30);

-- EXISTS 연산자 : 서브쿼리 결과 값이 존재하는 경우
-- 실습 9-16
SELECT * 
  FROM EMP
WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO = 10);

-- 다중 행연산자 사용
-- EMP 테이블의 사원 중에 10분 부서에 속한 모든 사원들 보다 
-- 일찍 입사한 사원 정보를 출력

SELECT *
  FROM EMP
WHERE HIREDATE < ALL(SELECT HIREDATE FROM EMP WHERE DEPTNO = 10);

-- 상관 쿼리
-- : 메인쿼리와 서브쿼리 간에 서로 상관 참조 하는 쿼리
-- 사원이 한명이라도 있는 부서명 출력
SELECT DNAME
  FROM DEPT D
WHERE  EXISTS ( SELECT 1 FROM EMP WHERE DEPTNO = D.DEPTNO);
-- 플랜떠봣어 ? = 제대로 짯냐?
SELECT EMPNO FROM EMP WHERE DEPTNO = 10;
SELECT EMPNO FROM EMP WHERE DEPTNO = 20;
SELECT EMPNO FROM EMP WHERE DEPTNO = 30;
SELECT EMPNO FROM EMP WHERE DEPTNO = 40;

SELECT * FROM EMP ;

-- 비교할 열이 여러개인 다중열 서브쿼리
-- 9-18
SELECT *
  FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)  FROM EMP GROUP BY DEPTNO);

SELECT DEPTNO, MAX(SAL)  FROM EMP GROUP BY DEPTNO;
/*
-- 출력하는데 부서코드 순으로 오름차순 정렬하여 출력하는 쿼리를 작성하세요
SELECT DEPTNO, ENAME, SAL
  FROM EMP e
 WHERE SAL = (SELECT MAX(SAL) 
                FROM EMP 
               WHERE DEPTNO = e.DEPTNO)
 ORDER BY DEPTNO;               


                          
                          
-- SELECT절의 서브쿼리 :  스칼라쿼리 , 상관쿼리
SELECT E.EMPNO, E.ENAME, E.DEPTNO
     , (SELECT DNAME FROM DEPT WHERE DEPTNO = E.DEPTNO) DNAME
  FROM EMP E;

SELECT E.EMPNO, E.ENAME, E.DEPTNO
     , D.DNAME  
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO;
*/
-- SELECT 절의 서브쿼리 = 스칼라쿼리
SELECT E.EMPNO, E.ENAME, E.DEPTNO
            ,D.DNAME, (SELECT DNAME FROM DEPT WHERE DEPTNO = E.DEPTNO) AS DNAME
  FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
  
-- 각 부서의 최대 급여를 받는 사원의 부서코드, 이름, 급여를
-- 출력하는데 부서코드 순으로 오름차순 정렬하여 출력하는 쿼리를 작성하세요
SELECT DEPTNO, ENAME, SAL
  FROM EMP E
WHERE SAL = (SELECT MAX(SAL) FROM EMP WHERE DEPTNO = E.DEPTNO)
ORDER BY DEPTNO;
  
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO
            , D.DNAME, D.LOC
  FROM (SELECT * FROM EMP WHERE DEPTNO = 10 ) E10
            , (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;

-- WITH절 사용
WITH
        E10 AS  ( SELECT * FROM EMP WHERE DEPTNO = 10),
        D AS (SELECT * FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM E10, D
WHERE E10.DEPTNO = D.DEPTNO;

-- 한발 더 나가기 : 상호 연관 서브쿼리
SELECT *
  FROM EMP E1
WHERE SAL > (SELECT MIN(SAL) FROM EMP E2 WHERE E2.DEPTNO = E1.DEPTNO)
ORDER BY DEPTNO, SAL;


--9-21 SELECT 절에 서브쿼리 사용하기
SELECT EMPNO, ENAME, JOB, SAL
            , (SELECT GRADE FROM SALGRADE 
            WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE -- E.SAL이 LOSAL ~ HISAL에 속한 GRADE값을 SALGRADE라고 함
            , DEPTNO
            , (SELECT DNAME FROM DEPT 
            WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME                             -- E.DEPTNO = DEPT.DEPTNO 값이 같은 상태에서의 DNAME을 DNAME이라고 함
            , (SELECT ENAME FROM EMP
            WHERE EMP.EMPNO = E.MGR) MGR
  FROM EMP E;

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

SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC            -- 사원번호(EMPNO)    사원이름(ENAME)    사원직업(JOB)    부서번호(DEPTNO)    부서명(DNAME)     부서위치(LOC)
  FROM EMP E, DEPT D                                                                                         -- 필요한 TABLE
WHERE E.DEPTNO = D.DEPTNO                                                                         -- EMP TABLE과 DEPT TABLED에서 DEPTNO가 일치하는 사람 들 중
     AND E.DEPTNO = 10                                                                                        -- 10번 부서에 근무하는 사람들 중
     AND JOB NOT IN (SELECT DISTINCT JOB FROM EMP WHERE DEPTNO = 30);  -- 30번 부서에는 존재하지 않는 직책을 가진 사람 -- DISTINCT는 빠져도 상관 없음 다만 중복값 존재





-- 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원정보 급여등급 정보를 다음과 같이 출력하는 SQL 문을 작성하세요
-- 단 서브쿼리를 활용할 때 다중행 함수를 사용하는 방법과 사용하지 않는 방법을 통해 사원 번호를 기준으로 오름차순으로 정렬하세요.
-- EMPNO, ENAME, SAL, GRADE
-- 다중행 사용 O
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE                                                                                    -- 사원번호      사원이름        급여      급여등급
  FROM EMP E, SALGRADE S                                                                                                                    -- EMP TABLE, GRADE TABLE
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL                                                                                    -- 급여등급의 범위는 S.LOSAL ~ H.SAL이므로 급여의 범위를 설정함
     AND E.SAL > ALL (SELECT DISTINCT SAL FROM EMP WHERE EMP.JOB = 'SALESMAN')          -- DISTINCT는 빠져도 상관 없음 다만 중복값이 있어서 제거하기위해 넣음 1250,1600,1500 반환이므로 ALL 사용
ORDER BY E.EMPNO;                                                                                                                               -- EMPNO 오름차순 (DEFAULT)

SELECT DISTINCT SAL FROM EMP WHERE EMP.JOB = 'SALESMAN';                                                -- 1250 1250 1500 1600 이 반환되므로 DISTINCT로 1250 1500 1600으로 줄임(굳이? 한줄정도차이)


-- 다중행 사용 X
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
     AND E.SAL > (SELECT MAX(SAL) FROM EMP WHERE EMP.JOB = 'SALESMAN')                      -- 한가지 값인 1600이 반환됨
ORDER BY E.EMPNO;