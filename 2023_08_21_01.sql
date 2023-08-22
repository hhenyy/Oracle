-- 2023.08.21(��)

--����(join)
--:2�� �̻��� ���̺��� �����ؼ� ������ ���ؿ��� ��.

--������ �ʿ伺
--Q. SCOTT ����� �Ҽӵ� �μ����� ����ϴ� SQL�� �ۼ�?
--1) ������̺�(EMP)���� SCOTT ����� �μ���ȣ�� ���Ѵ�.
select deptno from emp where ename = 'SCOTT'; --20
--2) �μ����̺�(DEPT)���� 20�� �μ��� �μ����� ���Ѵ�.
select dname from dept where deptno =20; --RESEARCH

--CROSS JOIN
select * from dept,emp; --4*14 =56���� ������ �˻�
select * from emp,dept; --14*4 =56���� ������ �˻�

--CROSS JOIN�� ����
--1. �����(Equi Join)
--2. �� ����(Non-Equi Join)
--3. ��ü����(Self Join)
--4. �ܺ�����(Outer Join)

--1. � ����(Equi Join)
--  �ΰ��� ���̺� ������ �÷��� �������� ���� �ϴ� ��.
select * from dept, emp where dept.deptno = emp.deptno; --14�� ������ �˻�

--Q. SCOTT ����� �Ҽӵ� �μ����� ����ϴ� SQL�� �ۼ�? (join���)
select ename,dname from dept, emp 
   where dept.deptno = emp.deptno and ename='SCOTT';
   
--Q.SCOTT ����� �Ҽӵ� �μ���ȣ, �μ����� ����ϴ� SQL�� �ۼ�?
select deptno,ename,dname from dept, emp 
   where dept.deptno = emp.deptno and ename='SCOTT'; --�����߻�
   
--�����÷�(deptno)�� ���̺�.�����÷��� �������� ����ؾ� �ȴ�.
--�����÷��� �ƴ� �÷����� �տ� ���̺���� ���� �� �� �ִ�.
select dept.deptno,ename,dname from dept, emp 
   where dept.deptno = emp.deptno and ename='SCOTT'; --�������� ó��
   
select emp.deptno,ename,dname from dept, emp 
   where dept.deptno = emp.deptno and ename='SCOTT'; --�������� ó��
   
select dept.deptno, emp.ename, dept.dname from dept, emp 
   where dept.deptno = emp.deptno and emp.ename='SCOTT'; --�������� ó��
   
--���̺� ��Ī �ο��ϱ�
--1) ���̺� ���� ��Ī�� �ο��� ���� ���ʹ� ���̺���� ����� �� ����,
--  ��Ī�� ����ؾ� �Ѵ�.
--2) ��Ī���� ��.�ҹ��ڸ� �������� �ʴ´�.
--3) �����÷�(deptno)�� ��Ī��.�����÷��� �������� ����ؾ� �Ѵ�.
--  ex) d.deptno, e.deptno
--4) �����÷��� �ƴ� �÷����� �տ� ��Ī���� ���� �� �� �ִ�.

--���̺�� ��Ī �ο�
select d.deptno, e.ename, d.dname from dept d, emp e
  where d.deptno=e.deptno and e.ename = 'SCOTT'; --�������� ó��
  
--�����߻�: ��Ī���� �ο��� ���� ���ʹ� ���̻� ���̺���� ����� �� ����.
select dept.deptno, e.ename, d.dname from dept d, emp e
  where d.deptno=e.deptno and e.ename = 'SCOTT';
  
--��Ī���� ��.�ҹ��ڸ� �������� �ʴ´�.
select d.deptno, e.ename, d.dname from dept D, emp E
  where d.deptno=e.deptno and e.ename = 'SCOTT';

--�Ϲ� �÷��� �÷��� �տ� ��Ī���� ������ �� �ִ�.  
select d.deptno, ename, dname from dept d, emp e
  where d.deptno=e.deptno and e.ename = 'SCOTT';
  
--2. �� ����(Non-Equi Join)
--  �ΰ��� ���̺� ������ �÷����� �ٸ� ������ �̿��ؼ� ���� �ϴ°�.

--Q.��� ���̺� �ִ� �� ������� �޿��� �� ��������� ����ϴ� SQL�� �ۼ�?
--  EMP(SAL) - SALGRADE(grade)

select sal from emp;
select *from salgrade;
--1	700	    1200
--2	1201	1400
--3	1401	2000
--4	2001	3000
--5	3001	9999

select ename, sal, grade from emp, salgrade
  where sal>=losal and sal<=hisal;
  
select ename, sal, grade from emp, salgrade
  where sal between losal and hisal;
  
select e.ename, e.sal, s.grade from emp e, salgrade s --��Ī�ο�
  where e.sal between s.losal and s.hisal;
  
--3. ��ü����(Self Join)
--  �Ѱ��� ���̺� ������ �÷��� �÷� ������ ���踦 �̿��ؼ� �����ϴ°�.

--Q. ��ü����(Self Join)�� �̿��ؼ� ��� ���̺��� �� ������� ������ 
--  �Ŵ���(���ӻ��)�� ����ϴ� SQL�� �ۼ�?
--  EMP(empno) - EMP(mgr)
select * from emp;
select employee.ename || '�� ���� ' || manager.ename
 from emp employee, emp manager where employee.mgr= manager.empno;
 
 --4.�ܺ�����(Outer Join)
 --  ���� ������ �������� �ʴ� �����͸� ������ִ� ����.
 --1) ���̺��� �����Ҷ� ��� ������ ���̺��� �����Ͱ� ����������, �ٸ� ���̺�
 --   �����Ͱ� �������� �ʴ� ��쿡, �� �����Ͱ� ��µ��� �ʴ� ������ �ذ��ϱ�
 --   ���ؼ� ���Ǵ� ���� ����̴�.
 --2) ������ ������ ���� (+)�� �߰��Ѵ�.
 
 --Q1. ���� ��ü����(Self Join)�� ���, KING ����� ���ӻ�簡 ���� ������
 --   ��µ��� �ʾҴµ�, KING ����� �ܺ������� �̿��ؼ� ��� �غ�����?
 select employee.ename || '�� ���� ' || manager.ename
  from emp employee, emp manager where employee.mgr=manager.empno(+);
  
--Q2. �μ����̺�(DEPT)�� ������̺�(EMP)�� ������� �ϸ� 40�� �μ��� ��Ÿ���� 
-- �ʱ� ������, �ܺ������� �̿��ؼ� 40�� �μ��� ��Ÿ������ ó���ϼ���?

--1) DEPT - EMP ���̺��� ����� : 40�� �μ��� ��¾ȵ�
select d.deptno, ename, dname from dept d, emp e
  where d.deptno=e.deptno order by deptno asc;

--2) �ܺ�����: ��µ��� �ʴ� 40�� �μ��� ������ִ� ����
select d.deptno, ename, dname from dept d, emp e
  where d.deptno=e.deptno(+) order by deptno asc;
  
------------------------------------------------------
--ANSI JOIN
--ANSI (�̱� ǥ����ȸ) ǥ�ؾȿ� ���� ������� join���

--ANSI CROSS JOIN
select * from dept cross join emp; --4 * 14 = 56�� ������ �˻�
select * from emp cross join dept; --4 * 14 = 56�� ������ �˻�

-- ANSI INNER JOIN : ����ΰ� ���� �ǹ̸� ������ �ִ� ���ι��
--Q. SCOTT ����� �Ҽӵ� �μ����� ����ϴ� SQL���� ANSI INNER JOIN����
--  �ۼ��ϼ���?
select ename, dname from dept inner join emp
  on dept.deptno = emp.deptno where ename ='SCOTT';

--(�join�� �̿��ؼ� ����)
select ename,dname from dept, emp 
   where dept.deptno = emp.deptno and ename='SCOTT';
   
-- using�� �̿��ؼ� ����
select ename, dname from dept inner join emp
  using(deptno) where ename='SCOTT';
  
-- ANSI NATURAL JOIN
--DEPT�� EMP���̺� ������ ���� �÷��� ���ٴ� �ǹ̸� ������ �ִ�.
select ename, dname from dept natural join emp where ename='SCOTT';
-----------------------------------------------------------------------
--ANSI OUTER JOIN
--���� : select * from table [ left | right | full ] outer join table2;

-- 1. dept01 ���̺� ����
create table dept01(deptno number(2),dname varchar2(14));
insert into dept01 values(10,'ACCOUNTING');
insert into dept01 values(20,'RESEARCH');
select * from dept01;

--2. dept02 ���̺� ����
create table dept02(deptno number(2), dname varchar2(14));
insert into dept02 values(10,'ACCOUNTING');
insert into dept02 values(30,'SALES');
select * from dept02;

--3. left outer join : dept01 ���̺� ������ ���
select * from dept01 left outer join dept02 using(deptno);

--4. right outer join : dept02 ���̺� ������ ���
select * from dept01 right outer join dept02 using(deptno);

--5. full outer join : dept01,dept02 ���̺� ���� ���
select * from dept01 full outer join dept02 using(deptno);
-----------------------------------------------------------------------------
--����.
--Q1. ������ MANAGER�� ����� �̸�, �μ����� ����ϴ� SQL����
--   �ۼ� �ϼ���? (JOIN�� ����Ͽ� ó��)
Ans 1. 
    --�����
        SQL> select ename, dname from emp, dept 
                  where emp.deptno=dept.deptno  and  job='MANAGER'; 
     --ANSI INNER JOIN
       SQL> select ename, dname from emp inner join dept 
                     on emp.deptno=dept.deptno  where  job='MANAGER'; 
     -- using�� �̿��ؼ� ����
       SQL> select ename, dname from emp inner join dept 
                     using(deptno)  where  job='MANAGER'; 
    -- ANSI NATURAL JOIN
       SQL> select ename, dname from emp natural join dept 
                     where job='MANAGER'; 

--Q2. �Ŵ����� KING �� ������� �̸��� ������ ����ϴ� SQL�� �ۼ�? (join or ��������)
     --��üjoin
     SQL>  select employee.ename, employee.job 
                   from emp employee, emp manager
                   where employee.mgr=manager.empno and manager.ename='KING';

  --��������
        SQL> select ename, job from emp where mgr = 
                 (select empno from emp where ename='KING'); --7839

--Q3. SCOTT�� ������ �ٹ������� �ٹ��ϴ� ����� �̸��� ����ϴ� SQL�� �ۼ�?(join or ��������)
      --��������
        SQL> select deptno, ename from emp 
                   where deptno = (select deptno from emp where ename = 'SCOTT');