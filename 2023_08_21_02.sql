-- 2023.08.21(��)

--����.
--      Q1. ��� ���̺�(EMP)���� ���� �ֱٿ� �Ի��� ������� ��� 
--	  �ϴ� SQL���� �ۼ� �ϼ���?

--      Q2. ��� ���̺�(EMP)���� �ִ� �޿��� �޴� ������ �ִ�޿�
--           �ݾ��� ����ϴ� SQL���� �ۼ� �ϼ���?
    
     Ans1. SQL> select ename, hiredate from emp where hiredate=
		(select max(hiredate) from emp); --87/07/13

     Ans2. SQL> select ename, sal from emp where sal=
		(select max(sal) from emp); --5000
        
        select ename, max(sal) from emp;--�����߻�

--��������

--Q. SCOTT ����� �Ҽӵ� �μ����� ����ϴ� SQL�� �ۼ�?
--1) ������̺�(EMP)���� SCOTT ����� �μ���ȣ�� ���Ѵ�.
select deptno from emp where ename = 'SCOTT'; --20
--2) �μ����̺�(DEPT)���� 20�� �μ��� �μ����� ���Ѵ�.
select dname from dept where deptno =20; --RESEARCH

--���������� ���ϱ�
select dname from dept where deptno=      --��������
(select deptno from emp where ename='SCOTT'); --��������

--�����߻�, ���������� ename���� ������� ����. join���� ����ؾ��Ѵ�.
select ename,dname from dept where deptno=      --��������
(select deptno from emp where ename='SCOTT'); --��������

--join���� ���ϱ�
select ename,dname from dept,emp where dept.deptno=emp.deptno and ename='SCOTT'; 
select dname from dept,emp where dept.deptno=emp.deptno and ename='SCOTT'; 
select dname from dept inner join emp on dept.deptno=emp.deptno where ename='SCOTT';
select dname from dept inner join emp using(deptno)where ename='SCOTT';
select dname from dept natural join emp where ename='SCOTT';

--1. ������ �������� 
-- 1) ���������� �˻� ����� 1���� ��ȯ�Ǵ� ���� 
-- 2) ���������� where ���������� �񱳿����ڸ� ����� �� �ִ�.
--  (=, >, >=, <, <=, != )

--Q1. ��� ���̺��� ���� �ֱٿ� �Ի��� ������� ����ϴ� SQL�� �ۼ�?
select ename, hiredate from emp where hiredate =
  (select max(hiredate) from emp); --87/07/13
--SCOTT	87/07/13
--ADAMS	87/07/13

--Q2. ��� ���̺��� �ִ� �޿��� �޴� ������ �ִ�޿� �ݾ��� ����ϴ�
--  SQL�� �ۼ�?
-- ���� �߻� : �׷��Լ��� �Ϲ��÷��� ���� ����� �� ����.
select ename, max(sal) from emp; --�����߻�
select ename, sal from emp where sal =
  (select max(sal) from emp); --5000
--KING	5000

--Q3. ���ӻ��(MGR)�� KING�� ����� ������ �޿��� ����ϴ� SQL�� �ۼ�?
select ename,sal, MGR from emp where mgr=
  (select empno from emp where ename='KING'); --7839
--JONES	2975	7839
--BLAKE	2850	7839
--CLARK	2450	7839

--2.������ ��������
-- 1) ������������ ��ȯ�Ǵ� �˻� ����� 2�� �̻��� ��������
-- 2) ���������� where ���������� ������ ������(in, all,any..)�� ����ؾ� �Ѵ�.

--<in ������>
--: ���������� �˻� ��� �߿��� �ϳ��� ��ġ�Ǹ� ���̵ȴ�.

--Q. �޿��� 3000�̻� �޴� ����� �Ҽӵ� �μ��� ������ �μ����� �ٹ��ϴ�
-- ������� ������ ����ϴ� SQL�� �ۼ�?

-- �� �μ��� �ִ�޿� �ݾ� ���ϱ�
select deptno, max(sal) from emp group by deptno;
--30	2850
--20	3000
--10	5000

--where deptno in (10,20)
select ename, sal, deptno from emp where deptno in
  (select distinct deptno from emp where sal >= 3000); --10,20
--distinct:�ߺ��׸� ����

--<all ������>
--: ���������� �������� ���������� �˻� ����� ��� ���� ��ġ�Ǹ� ���̵ȴ�.

--Q.30�� �μ��� �Ҽӵ� ��� �߿��� �޿��� ���� ���� �޴� ������� �� ����
-- �޿��� �޴� ����� �̸��� �޿��� ����ϴ� SQL�� �ۼ�?

--30�� �μ��� �ִ�޿� �ݾ� ���ϱ�
select max(sal) from emp where deptno=30;--2850

--1) ������ ���������� ���ϱ�
select ename, sal from emp where sal >
  (select max(sal) from emp where deptno =30);--2850

--2) ������ ���������� ���ϱ�
select ename, sal from emp where sal >all
  (select sal from emp where deptno =30); --������ ��������
  
--<any ������>
--: ���������� �������� ���������� �˻� ����� �ϳ� �̻� ��ġ�Ǹ� ���� �ȴ�.

--Q. �μ���ȣ�� 30���� ������� �޿��� ���� ���� �޿�(950)���� �� ���� �޿��� 
--  �޴� ������ �޿��� ����ϴ� SQL�� �ۼ�

--30�� �μ��� �ּұ޿� ���ϱ�
 select min(sal) from emp where deptno=30; --950
 
 --1) ������ ���������� ���ϱ�
 select ename, sal from emp where sal>
  (select min(sal) from emp where deptno=30); --950
  
--2) ������ ���������� ���ϱ�
select ename, sal from emp where sal > any
  (select sal from emp where deptno=30); --������ ���������� ���ϱ�

