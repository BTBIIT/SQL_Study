-- countires ���̺� ��ȸ
SELECT * 
  FROM COUNTRIES;

-- countires ���̺��� country_id�� country_name �÷��� ��ȸ
SELECT COUNTRY_ID, COUNTRY_NAME
  FROM COUNTRIES;

-- countires ���̺��� �÷��� country_id�� ����ID, country_name�� ���������� ��ȸ
SELECT COUNTRY_ID AS "����ID", COUNTRY_NAME AS "������"
  FROM COUNTRIES;

-- countries ���̺��� region_id�� �ߺ������ϰ� ��ȸ
SELECT DISTINCT REGION_ID
  FROM COUNTRIES;

-- countires ���̺��� country_name�� country_id�� �����Ͽ� ��ȸ
SELECT COUNTRY_NAME | | '     ' || COUNTRY_ID AS ������_����ID
  FROM COUNTRIES;
-- locations ���̺��� street_address�� city �÷��� ��ȸ
SELECT STREET_ADDRESS, CITY
  FROM LOCATIONS;

-- jobs ���̺��� jobs_id�� job_title �÷��� ��ȸ
SELECT JOB_ID, JOB_TITLE
  FROM JOBS;

-- jobs ���̺��� job_title, min_salary, max_salary �÷��� �ּҿ����� �ִ뿬���� 10% �λ�� ���·� ��ȸ
SELECT JOB_TITLE, MIN_SALARY * 1.1, MAX_SALARY * 1.1
  FROM JOBS;

-- employees ���̺��� first_name�� last_name�� �����ϰ� �÷����� �̸����� ��ȸ
SELECT FIRST_NAME ||'  '|| LAST_NAME AS �̸�
  FROM EMPLOYEES;

-- employees ���̺��� job_id�� �ߺ������ϰ� ��ȸ
SELECT DISTINCT JOB_ID
  FROM EMPLOYEES;
-- employees ���̺��� first_name�� 'David'�� ���� ��ȸ
SELECT * 
  FROM EMPLOYEES
 WHERE FIRST_NAME = 'David';
-- jobs ���̺��� �ּ� ������ 4000�޷��� ���� ��ȸ
SELECT JOB_ID
  FROM JOBS
WHERE MIN_SALARY = 4000;

-- jobs ���̺��� �ּ� ������ 8000�޷� �ʰ��� ���� ��ȸ
SELECT JOB_ID
  FROM JOBS
WHERE MIN_SALARY > 8000;
-- jobs ���̺��� �ִ� ������ 10000�޷� ������ ���� ��ȸ
SELECT JOB_ID
  FROM JOBS
WHERE MAX_SALARY <= 10000;
-- jobs ���̺��� �ּ� ������ 4000�̻��̰� �ִ� ������ 10000 ������ ���� ��ȸ
SELECT JOB_ID
  FROM JOBS
WHERE min_salary >= 4000 AND max_salary < 10000;
-- employee ���̺��� job_id�� 'IT-PROG'�̸鼭 salary�� 5000�ʰ��� ���� ��ȸ
SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID = 'IT_PROG' AND SALARY > 5000;
 
 
 
 -- IS NULL ������
 SELECT ENAME, SAL, SAL*12 + COMM AS "ANNSAL", COMM
 FROM EMP;