-- 2023.08.16(��)

-- ���̺� ���
select * from tab;
-- DEPT : �μ� ���̺�
-- EMP : ��� ���̺�
-- BONUS : �󿩱�
-- SALGRADE : �޿����

-- dept ���̺� ���� (�μ����̺�)
describe dept;
desc dept;

-- dept ������ �˻� : SQL���� ��,�ҹ��ڸ� �������� �ʴ´�.
select * from dept;
SELECT * from DEPT;

-- EMP ���̺� ����
desc emp;

-- EMP ���̺� �˻�
select * from emp;

-- ����Ŭ�� ������ Ÿ��
--1.���� ������
--number(n)
--number(n): number(2) ���� 2�ڸ����� ����
--number(n1,n2) : n1-��ü �ڸ���
--                n2-�Ҽ����� �Ҵ�� �ڸ���
--ex) number(7,2):��ü �ڸ��� 7�ڸ�
--                �Ҽ����� 2�ڸ�
--2.���� ������
--char() : ���� ���� ������
--         �ִ� 2000 byte ���� ���� ������.
--varchar2() : ���� ���� ������
--             �ִ� 4000 byte ���� ���� ������.
--long :2GB���� ���� ������.
--      long������ ������ �÷��� �˻� ����� �������� �ʴ´�.
--3. ��¥ ������
--date : ��/��/�� ���� ����
--timestamp : ��/��/�� ��:��:�� ���� ����

--SELECT SQL ��
select* from dept;

select loc, dname, deptno from dept;

select * from emp;

select empno, ename, sal from emp;

--��� ������ : +,-,*,/
select sal+ comm from emp;
select sal+ 100 from emp;
select sal- 100 from emp;
select sal* 100 from emp;
select sal/ 100 from emp;

--Q. ������̺�(EMP)�� �Ҽӵ� ������� ������ ���غ���?
-- ����=�޿�(SAL)*12 + Ŀ�̼�(COMM)

--NULL
--1.�������� ���� ���� �ǹ�
--2. NULL ���� ��� ������ �� �� ����.
--3. NULL ���� ��
--   ex) EMP ���̺� : MGR �÷�-KING ����� MGR�÷��� NULL
--                  COMM �÷�-job�� SALESMAN�� ����� ���� ������ �ִ�.

--sal * 12 + comm : null ���� ��� ������ ���� �ʱ� ������
--                  job�� SALESMAN�� ����� ���� ����� �ȴ�.
select ename, job, sal, comm, sal*12, sal*12+comm from emp;

--NVL(�÷�, ��ȯ�� ��) : NULL���� �ٸ���(0)���� ��ȯ ���ִ� ����
--ex) NVL(COMM, 0) : COMM �÷��� NULL ���� 0���� ġȯ �϶�� �ǹ�

--�ùٸ� ������� SQL�ۼ�?
select ename, job, sal, comm, sal*12+comm, sal*12+nvl(comm,0) from emp;

-- ��Ī�ο�: as "��Ī��" (�ܵ���ǥx)/���ڵ����� �˻��� ���ڿ��� ' '�ܵ���ǥ
select ename, sal*12+nvl(comm,0) as "Annsal" from emp;
select ename, sal*12+nvl(comm,0) "Annsal" from emp; -- as ��������
select ename, sal*12+nvl(comm,0) Annsal from emp; -- �ֵ���ǥ ��������

-- �ѱ� ��Ī�� �ο�
select ename, sal*12+nvl(comm,0) as "����" from emp;
select ename, sal*12+nvl(comm,0) "����" from emp; -- as ��������
select ename, sal*12+nvl(comm,0) ���� from emp; -- �ֵ���ǥ ��������
select ename, sal*12+nvl(comm,0) "�� ��" from emp; -- ��� ����(""���� ���� ����)
--��Ī�� ���⸦ �� ��쿡�� ��Ī�� �¿쿡 �ֵ���ǥ�� �ٿ��� �ȴ�.
select ename, sal*12+nvl(comm,0) �� �� from emp; --�����߻�

-- Concatenation ������ : || 
-- : �÷��� ���ڿ��� ������ �� ����Ѵ�.
select ename, 'is a', job from emp;
select ename || ' is a ' || job from emp;

-- distinct : �ߺ����� �����ϰ� 1���� ����ϴ� ����
select deptno from emp; -- 14���� ������ ���

select distint deptno from emp; --3���� �μ���ȣ ���: 10,20,30

--Q1. EMP ���̺��� �� ������� job�� 1���� ����ϴ� SQL���� �ۼ� �ϼ���.
select job from emp;          -- 14���� ������ ���

select distinct job from emp; -- 5���� JOB���

--Q2. EMP ���̺��� �ߺ��� ������ job�� ������ ���ϴ� SQL�� �ۼ� �ϼ���.

--count (�÷���) : ������ ������ �����ִ� �Լ�
select count(*) from dept;  --4
select count(*) from emp;   --14
select count(job) from emp; --14

select count(distinct job) from emp; --5

-- Where ������ : �� ������(=,>,>=,<,<=,!=,^=,<>)

--1. ���� ������ �˻�
--Q1. ��� ���̺��� �޿��� 3000 �̻� �޴� ����� �˻��ϴ� SQL�� �ۼ�?
select*from emp where sal >= 3000;

--Q2. �޿��� 3000�� ����� �˻��ϴ� SQL�� �ۼ�?
select*from emp where sal = 3000;

--Q3. �޿��� 3000�� �ƴ� ����� �˻��ϴ� SQL�� �ۼ�?
select*from emp where sal != 3000;
select*from emp where sal ^= 3000;
select*from emp where sal <> 3000;

--Q4. �޿��� 1500������ ����� �����ȣ, �����, �޿��� ����ϴ� SQL�� �ۼ�?
select empno, ename, sal from emp where sal <=1500;

--2. ���� ������ �˻�
--1) ���� �����ʹ� ��,�ҹ��ڸ� �����Ѵ�. (���̺� �ȿ��ִ� ���������͸� ����)
--2) ���� �����͸� �˻� �Ҷ��� ���ڿ� ��,�쿡 �ܵ���ǥ(')�� �ٿ��� �Ѵ�.
--��Ī�ο��� ��Ī���� "�ֵ���ǥ /���ڿ��� '�ܵ���ǥ

--Q1. ������̺��� ������� FORD �� ����� ������ �˻��ϴ� SQL�� �ۼ�?
select*from emp where ename = 'ford'; --�˻���� ����
select*from emp where ename = FORD;   --�����߻�
select*from emp where ename = "FORD"; --�����߻�
select*from emp where ename = 'FORD'; --�������� �˻�

--Q2. SCOTT ����� �����ȣ, �����, �޿��� ����ϴ� SQL�� �ۼ�?
select empno, ename, sal from emp where ename = 'SCOTT';

--3. ��¥ ������ �˻�
--1) ��¥ �����͸� �˻��Ҷ��� ��¥ ������ ��,�쿡 �ܵ���ǥ(')�� �ٿ��� �Ѵ�.
--2) ��¥ �����͸� ���Ҷ� �� �����ڸ� ����Ѵ�.

--Q1. 1982�� 1�� 1�� ���Ŀ� �Ի��� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where hiredate >= 82/01/01; --�����߻�
select * from emp where hiredate >= '82/01/01'; --�������� �˻�
select * from emp where hiredate >= '1982/01/01'; --�������� �˻�

--Q2. 1982�� 1�� 1�� ���Ŀ� �Ի��� ����� �˻��ϰ�, �Ի����� �������� 
--    ������������ �����ϴ� SQL�� �ۼ�?
select * from emp where hiredate >= '1982/01/01'
  order by hiredate asc;