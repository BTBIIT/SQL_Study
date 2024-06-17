---- 서브 쿼리 문제 ----

--		1. 이름이 TURNER인 사원과 같은 업무를 하는 사람의 사원번호, 이름, 업무, 급여 추출
SELECT EMP.EMPNO, EMP.ENAME, EMP.JOB, EMP.SAL
	FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE ENAME = 'TURNER');
--		2. EMP 테이블의 사원번호가 7521인 사원과 업무가 같고	급여가 7934인 사원의 급여보다 많은 사원의 사원번호, 이름, 담당업무, 입사일, 급여 추출
SELECT EMP.EMPNO, EMP.ENAME, EMP.JOB, EMP.HIREDATE, EMP.SAL
	FROM EMP
WHERE JOB	=	(SELECT JOB FROM EMP WHERE EMPNO = 7521)
	AND SAL		>	(SELECT SAL FROM EMP WHERE EMPNO = 7934);
--		3. EMP 테이블에서 급여의 평균보다 적은 사원의 사원번호, 이름, 업무, 급여, 부서번호 추출
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
	FROM EMP
WHERE SAL < (SELECT AVG(SAL) FROM EMP);
--		4. 부서별 최소급여가 20번 부서의 최소급여보다 
--		큰 부서의 부서번호
--		최소 급여 추출 (Hint: HAVING문에서 비교)
SELECT DEPTNO, MIN(SAL)
	FROM EMP
GROUP BY DEPTNO
	HAVING MIN(SAL) > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 20);
--		5. 업무별 급여 평균 중 가장 작은 
--		급여평균의 업무와 
--		급여평균 추출
SELECT JOB, AVG(SAL)
	FROM EMP
GROUP BY JOB
	HAVING AVG(SAL) = (SELECT MIN(AVG(SAL)) FROM EMP GROUP BY JOB);
--		6. 업무별 최대 급여를 받는 사원의 사원번호, 이름, 업무, 입사일, 급여, 부서번호 추출
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO
	FROM EMP
WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY JOB);
--		7. 30번 부서의 최소급여를 받는 사원보다 많은 급여를 받는 사원의 사원번호, 이름, 업무, 입사일, 급여, 부서번호, 단 30번 부서는 제외하고 추출
SELECT ENAME, ENAME, JOB, HIREDATE, SAL, DEPTNO
	FROM EMP
WHERE DEPTNO IN (10, 20)
	AND SAL > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 30);
--		8. BLAKE와 같은 상사를 가진 사원의 이름,업무, 상사번호 추출
SELECT ENAME, JOB, MGR
	FROM EMP
WHERE MGR IN (SELECT MGR FROM EMP WHERE ENAME = 'BLAKE')
	AND ENAME NOT IN 'BLAKE';