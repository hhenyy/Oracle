-- 2023.08.18(��)

--�׷��Լ�
--: �ϳ� �̻��� �����͸� �׷����� ��� ������ �����ϰ�, �ϳ��� ����� ó�� 
--���ִ� �Լ�

--sum() : ���� �����ִ� �Լ�
select sum(sal)from emp; --�޿��� ��
select sum(comm)from emp; --comm�� ��, NULL���� ����
select sum(ename)from emp; --�����߻�

--�׷� �Լ��鳢���� ���� ����� �� �ִ�.
select sum(sal),sum(comm) from emp;

--�׷� �Լ��� �Ϲ��÷��� ���� ����� �� ����.
select sal, sum(sal),sum(comm) from emp; --�����߻�

select sum(sal) from emp where deptno=10; --8750
select sum(sal) from emp where deptno=20; --10875
select sum(sal) from emp where deptno=30; --10875
select sum(sal) from emp where deptno=40; --null

--avg() : ��հ��� �����ִ� �Լ�
select avg(sal) from emp;
select avg(sal),avg(comm) from emp;
select avg(sal),avg(comm) from emp where deptno=10;
select avg(sal),avg(comm) from emp where deptno=20;
select avg(sal),avg(comm) from emp where deptno=30;

--max() :�ִ밪�� �����ִ� �Լ�
--Q1. ��� ���̺��� �ִ� �޿� �ݾ��� ���غ���?
select max(sal)from emp;--5000
select max(sal)from emp where deptno=10;--5000
select max(sal)from emp where deptno=20;--3000
select max(sal)from emp where deptno=30;--2850

--Q2.��� ���̺��� �ִ�޿��� �ִ�޿��� �޴� ������� ����ϴ� SQL�� �ۼ�?
select ename, max(sal) from emp; --�����߻�

--Q3. ��� ���̺��� ���� �ֱٿ� �Ի��� �Ի����� ����ϴ� SQL�� �ۼ�?
select max(hiredate) from emp; --87/07/13
select hiredate from emp order by hiredate desc; --�������� ����(�ֱٳ�¥�� ����)

--Q4. ��� ���̺��� ������� ���ĺ����� ���� ���߿� ������ ������� ���ϴ�
--   SQL�� �ۼ�?
select max(ename) from emp; --WARD
select ename from emp order by ename desc; --�������� ����(�������� ����)

--min() : �ּҰ��� �����ִ� �Լ�
--Q1. ��� ���̺��� �ּ� �޿� �ݾ��� ���غ���?
select min(sal) from emp; --800

select min(sal) from emp where deptno = 10; --1300
select min(sal) from emp where deptno = 20; --800
select min(sal) from emp where deptno = 30; --950

--Q2. ��� ���̺��� ���� ���� �Ի��� �Ի����� ���ϴ� SQL�� �ۼ�?
select min(hiredate) from emp; --80/12/17
select hiredate from emp order by hiredate asc; --������������(�̸���¥�� ����)

--Q2. ��� ���̺��� ������� ���ĺ����� ���� ���� ������ ������� ���ϴ�
-- SQL�� �ۼ�?
select min(ename) from emp; --ADAMS
select ename from emp order by ename asc; --������������(������ ����)

select sum(sal),avg(sal),max(sal),min(sal) from emp;
select sum(sal),avg(sal),max(sal),min(sal) from emp where deptno=10;
select sum(sal),avg(sal),max(sal),min(sal) from emp where deptno=20;
select sum(sal),avg(sal),max(sal),min(sal) from emp where deptno=30;

--count() : �� ������ ������ �����ִ� �Լ�
--���� : count (�÷���)
select count(sal) from emp; --14
select count(mgr) from emp;  --13 : null���� counting�� �����ʴ´�.
select count(comm) from emp; --4 : null���� counting�� �����ʴ´�.
select count(deptno) from dept; --4 : deptno �÷��� �⺻Ű ���������� �����Ǿ� �ִ�.
select count (empno) from emp; --14 : empno�÷��� �⺻Ű ���������� �����Ǿ� �ִ�.
select count (*) from emp; 

--Q1. ������̺��� �ߺ����� ������ JOB�� ������ ���ϴ� SQL�� �ۼ�?
--1) job�� ���� ���ϱ�?
select count(job) from emp; --14 : �ߺ� �����͵� counting�� �Ѵ�.
select job from emp;
select distinct job from emp; --�ߺ����� ������ job��� : 5���� job���
--2) �ߺ����� ������ job�� ���� ���ϱ�?
select count(distinct job) from emp; --5

--Q2. 30�� �μ� �Ҽ� ��� �߿��� Ŀ�̼��� �޴� ������� ���ϴ� SQL�� �ۼ�?
select count(comm) from emp where deptno=30;--4
------------------------------------------------------------------------
--group by : Ư�� �÷��� �������� ���̺� �����ϴ� �����͸� �׷����� �����Ͽ�
--           ó�����ִ� ������ �Ѵ�.

--Q. �� �μ�(10,20,30)�� �޿���, ��ձ޿�, �ִ�޿�, �ּұ޿��� ���ϴ� SQL�� �ۼ�?
select sum(sal),avg(sal),max(sal),min(sal) from emp where deptno=10;
select sum(sal),avg(sal),max(sal),min(sal) from emp where deptno=20;
select sum(sal),avg(sal),max(sal),min(sal) from emp where deptno=30;

-- �׷��Լ��� �Ϲ�Į���� ���� ����� �� ������, ���������� group by���� ���Ǵ�
-- �÷��� �׷��Լ��� ���� ����� �� �ִ�.
select deptno, sum(sal),avg(sal),max(sal),min(sal) from emp 
      group by deptno order by deptno asc;
      
--Q1. job�÷��� �������� �޿��� ��, ��ձ޿�, �ִ�޿�, �ּұ޿��� ���ϴ� 
--SQL�� �ۼ�?
select job, sum(sal),avg(sal),max(sal),min(sal) from emp
  group by job;

--Q2. �� �μ���(10,20,30) ������� Ŀ�̼��� �޴� ������� ���ϴ� SQL�� �ۼ�?
select deptno, count(*) �����, count(comm) Ŀ�̼� from emp
   group by deptno order by deptno asc;
   
--having ���ǰ�
--:group by ���� ���Ǵ� ��쿡 ������ ������ ���ϱ� ���ؼ� where ������ 
-- ��ſ� having �������� ����ؾ� �Ѵ�.

--Q1. �� �μ���(10,20,30) ��ձ޿� �ݾ��� 2000�̻��� �μ��� ����ϴ� SQL�� �ۼ�?

-- 1) �� �μ��� ��ձ޿� �ݾ� ���
select deptno, avg(sal) from emp group by deptno;
--30 1566.666666666666666666666666666666666667
--20 2175
--10 2916.666666666666666666666666666666666667

--2) ��ձ޿� �ݾ��� 2000�̻��� �μ��� ���
select deptno, avg(sal) from emp group by deptno 
   where avg(sal) >= 2000;  --�����߻�

--group by ���� ���Ǵ� ��쿡�� having �������� ����ؾ� �Ѵ�.
select deptno, avg(sal) from emp group by deptno
   having avg(sal) >=2000;
   
--Q2. �� �μ���(10,20,30) �ִ�޿� �ݾ��� 2900 �̻��� �μ��� ����ϴ� SQL�� �ۼ�?
--1) �� �μ��� �ִ�޿� �ݾ� ���
select deptno, max(sal) from emp group by deptno;
--30 2850
--20 3000
--10 5000

--2) ��ձ޿� �ݾ��� 2900�̻��� �μ��� ���
select deptno, max(sal) from emp group by deptno
   where max(sal) >= 2900; --�����߻�

--group by ���� ���Ǵ� ��쿡�� having �������� ����ؾ� �Ѵ�.   
   select deptno, max(sal) from emp group by deptno
   having max(sal) >= 2900; 

