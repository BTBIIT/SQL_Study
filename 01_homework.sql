---- ���� ���� ���� ----

--		1. �̸��� TURNER�� ����� ���� ������ �ϴ� ����� �����ȣ, �̸�, ����, �޿� ����
SELECT EMP.EMPNO, EMP.ENAME, EMP.JOB, EMP.SAL
	FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE ENAME = 'TURNER');
--		2. EMP ���̺��� �����ȣ�� 7521�� ����� ������ ����	�޿��� 7934�� ����� �޿����� ���� ����� �����ȣ, �̸�, ������, �Ի���, �޿� ����
SELECT EMP.EMPNO, EMP.ENAME, EMP.JOB, EMP.HIREDATE, EMP.SAL
	FROM EMP
WHERE JOB	=	(SELECT JOB FROM EMP WHERE EMPNO = 7521)
	AND SAL		>	(SELECT SAL FROM EMP WHERE EMPNO = 7934);
--		3. EMP ���̺��� �޿��� ��պ��� ���� ����� �����ȣ, �̸�, ����, �޿�, �μ���ȣ ����
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
	FROM EMP
WHERE SAL < (SELECT AVG(SAL) FROM EMP);
--		4. �μ��� �ּұ޿��� 20�� �μ��� �ּұ޿����� 
--		ū �μ��� �μ���ȣ
--		�ּ� �޿� ���� (Hint: HAVING������ ��)
SELECT DEPTNO, MIN(SAL)
	FROM EMP
GROUP BY DEPTNO
	HAVING MIN(SAL) > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 20);
--		5. ������ �޿� ��� �� ���� ���� 
--		�޿������ ������ 
--		�޿���� ����
SELECT JOB, AVG(SAL)
	FROM EMP
GROUP BY JOB
	HAVING AVG(SAL) = (SELECT MIN(AVG(SAL)) FROM EMP GROUP BY JOB);
--		6. ������ �ִ� �޿��� �޴� ����� �����ȣ, �̸�, ����, �Ի���, �޿�, �μ���ȣ ����
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO
	FROM EMP
WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY JOB);
--		7. 30�� �μ��� �ּұ޿��� �޴� ������� ���� �޿��� �޴� ����� �����ȣ, �̸�, ����, �Ի���, �޿�, �μ���ȣ, �� 30�� �μ��� �����ϰ� ����
SELECT ENAME, ENAME, JOB, HIREDATE, SAL, DEPTNO
	FROM EMP
WHERE DEPTNO IN (10, 20)
	AND SAL > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 30);
--		8. BLAKE�� ���� ��縦 ���� ����� �̸�,����, ����ȣ ����
SELECT ENAME, JOB, MGR
	FROM EMP
WHERE MGR IN (SELECT MGR FROM EMP WHERE ENAME = 'BLAKE')
	AND ENAME NOT IN 'BLAKE';