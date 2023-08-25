-- 2023.08.24 (��)

--���� ������ Ȱ��ȭ / ��Ȱ��ȭ

--Q. �θ����̺�(DEPT)�� �����͸� ���� �غ���?
delete from dept where deptno = 10; --�����߻�

--�ڽ����̺�(EMP)���� �θ�Ű(deptno)�� �����ϴ� �ܷ�Ű�� �ֱ� 
--������ �θ����̺��� �����͸� ������ �� ����.
--2.�θ� ���̺��� �����͸� �����ϱ� ���ؼ�, �����ϴ� �ڽ����̺��� �ܷ�Ű�� 
--  ��Ȱ��ȭ ���Ѽ�, �θ� ���̺��� �����͸� ���� �� �� �ִ�.

--1. �θ� ���̺� ����
drop table dept01 purge;
create table dept01(
  deptno number(2) primary key, --�θ�Ű
  dname varchar2(14),
  loc varchar2(13));
  
insert into dept01 values(10, 'ACCOUNTING','NEW YORK');
select * from dept01;

--2. �ڽ� ���̺� ����
drop table emp01 purge;
create table emp01(
  empno number(4) primary key,
  ename varchar2(10) not null,
  job varchar2(10) unique,
  deptno number(2) references dept01(deptno)); --�ܷ�Ű
  
insert into emp01 values(1111,'ȫ�浿','������',10); --�θ�Ű �� 10�� �����ؼ� ���Է�
select * from emp01;

--3. �θ����̺� (DEPT01)�� ������ ����
delete from dept01; --�ڽ����̺�(emp01)���� �����ϰ� �ֱ� ������ �����ȵ�
select * from dept01;
select * from emp01;

--4. �ڽ� ���̺��� �ܷ�Ű ���������� ��Ȱ��ȭ ���Ѻ���.
--  �θ� ���̺�(DEPT01)�� �����͸� �����ϱ� ���ؼ��� �ڽ� ���̺�(EMP01)��
-- �ܷ�Ű ���������� ��Ȱ��ȭ(disable) ��Ű��, �θ����̺��� �����͸� ���� �� �� �ִ�.

--���� : alter table ���̺�� disable constraint constraint_name;
--ENABLED(Ȱ��ȭ)->DISABLED(��Ȱ��ȭ)
alter table emp01 disable constraint SYS_C007062; 

--cf. �ڽ� ���̺�(EMP01)�� �ܷ�Ű ���������� Ȱ��ȭ?
--���� : alter table ���̺�� enable constraint constraint_name;
delete from emp01; --5.���� �����ϴ� �θ����̺��� ���� �����Ǿ �����Ҽ� �ִ� ���� ��� �ڽ����̺��� ������ Ȱ��ȭ��
alter table emp01 enable constraint SYS_C007062;

--5. �θ� ���̺��� �����͸� ���� �غ���?
delete from dept01;  --�����ϴ� �ܷ�Ű�� ���� ������ ������
select * from dept01;

--cascade �ɼ�
--1. cascade �ɼ��� �ٿ��� �θ����̺�(DEPT01)�� ���������� ��Ȱ��ȭ ��Ű��,
-- �����ϰ� �ִ� �ڽ����̺�(EMP01)�� �ܷ�Ű �������ǵ� ���� ��Ȱ��ȭ �ȴ�.
-- �θ����̺�(DEPT01)�� constraint_name
alter table dept01 disable constraint SYS_C007054 cascade; 

--2. cascade �ɼ��� �ٿ��� �θ����̺�(DEPT01)�� primary key�����ϸ�,
-- �����ϴ� �ڽ����̺�(EMP01)��  foreign key �������ǵ� ���� �������ش�.
--���� : alter table ���̺�� drop constraint constraint_name;
alter table dept01 drop constraint SYS_C007054 cascade; 
alter table dept01 drop primary key cascade; 

--1. �θ� ���̺� ����
drop table dept01 purge;
create table dept01(
  deptno number(2) primary key, --�θ�Ű
  dname varchar2(14),
  loc varchar2(13));
  
insert into dept01 values(10, 'ACCOUNTING','NEW YORK');
select * from dept01;

--2. �ڽ� ���̺� ����
drop table emp01 purge;
create table emp01(
  empno number(4) primary key,
  ename varchar2(10) not null,
  job varchar2(10) unique,
  deptno number(2) references dept01(deptno)on delete cascade); --�ܷ�Ű
  
-- on delete cascade 
--: �θ� ���̺��� �����͸� �����ϸ�, �����ϴ� �ڽ� ���̺��� �����͵� ���� ����
--  ���ִ� �ɼ�
insert into emp01 values(1111,'ȫ�浿','������',10); --�θ�Ű �� 10�� �����ؼ� ���Է�
select * from emp01;

--3. �θ� ���̺�(dept01)�� �����͸� ���� �غ���?
delete from dept01 where deptno =10;
select * from dept01; --������ ������
select * from emp01; --cascade �ɼ� ������ �����Ͱ� ������
-------------------------------------------------------------
--��(view) : �⺻ ���̺��� �̿��ؼ� ������� ���� ���̺�

--�ǽ��� ���� �⺻ ���̺� ���� : dept_copy, emp_copy

--2���� �⺻ ���̺� ����
create table dept_copy as select * from dept;
create table emp_copy as select * from emp;

select * from dept_copy;
select * from emp_copy;

--�� ����
create view emp_view30
as
select empno,ename,deptno from emp_copy where deptno=30;
--"insufficient privileges" ���� ����� ����
--scott������ ����� ������ ��� system �������� ����� ���� �ο�

--�� ��� Ȯ��
select *from tab; --EMP_VIEW30�� tabletype��	VIEW
select * from user_views; --view��ü�� �ڼ��� ���� Ȯ��

--�� �˻�
select*from emp_view30;
desc emp_view30; 

--Q.��(emp_view30)�� insert�� �����͸� �Է� ���� ��쿡,
-- �⺻���̺�(emp_copy)�� �����Ͱ� �Է� �ɱ��?
insert into emp_view30 values(1111,'ȫ�浿',30);

--view�� �����Ͱ� �ԷµǸ�, �⺻ ���̺��� �Էµȴ�.
select*from emp_view30;
select*from emp_copy;

--���� ����
--�ܼ���: �ϳ��� �⺻ ���̺�� ������ ��
--���պ�: �������� �⺻ ���̺�� ������ ��

--1. �ܼ���
--Q. �⺻ ���̺��� emp_copy�� �̿��ؼ� 20�� �μ��� �Ҽӵ� ������� ����� �̸�,
-- �μ���ȣ, ���ӻ���� ����� ����ϱ� ���� ��(emp_view20)�� ����?
create view emp_view20
as
select empno,ename,deptno,mgr from emp_copy where deptno=20;

-- �� Ȯ��
select * from tab;
select * from user_views;

select * from emp_view20;

--2. ���պ�
--Q.�� �μ���(�μ���) �ִ�޿��� �ּұ޿��� ����ϴ� �並 sal_view���
-- �̸����� �ۼ� �ϼ���?
create view sal_view
as
select dname, max(sal) MAX, min(sal) MIN from dept, emp
   where dept.deptno=emp.deptno group by dname;
   
--�� Ȯ��
select * from tab;
select * from user_views;

--�� ������ Ȯ��
select * from sal_view;

--�� ����
-- ���� : drop view ���̸�;
drop view sal_view;

--�並 �����Ҷ� ���Ǵ� �ɼ�
--1. or replace �ɼ� (����ϱ�)
-- ������ �䰡 �������� ������ �並 �����ϰ�, ���Ͽ� ������ �̸��� ���� �䰡
-- �����ϸ� ���� ������ ���� �ϵ��� ����� �ִ� �ɼ�

--1) or replace �ɼǾ��� ������ ��(emp_view30)�� ���� : �����߻�
create view emp_view30
as
select empno, ename, deptno,sal, comm from emp_copy where deptno=30;

--2) or replace �ɼ��� �ٿ��� ������ ��(emp_view30)�� ���� : ���� ������ ������
create or replace view emp_view30
as
select empno, ename, deptno,sal, comm from emp_copy where deptno=30;

-- 3) �� Ȯ��
select * from emp_view30;

--2. with check option
-- : where �������� ���� ���� �������� ���ϵ��� ����� �ִ� �ɼ�

-- 1) with check option ������� ���� ���
-- : where �������� ���� ���� ���������ϴ�.
create or replace view emp_view30
as
select empno, ename, deptno,sal, comm from emp_copy where deptno=30;

--Q. emp_view30 �信�� �޿��� 1200 �̻��� ������� �μ���ȣ�� 30������ 
--  20������ ����?
select * from emp_view30;
update emp_view30 set deptno=20 where sal>=1200;
select * from emp_view30;

-- 1) with check option ����� ���
--�信 insert, update, delete�� ����Ǹ�, �⺻ ���̺��� ������ ������
--����ȴ�.
-- : where �������� ���� ���� �������� ���Ѵ�.
select * from emp_copy; --�⺻ ���̺� ������ �ٲ��ִ�.
drop table emp_copy purge;
create table emp_copy as select * from emp; --�⺻ ���̺� ����

--with check option ����ؼ� �� ����
create or replace view emp_view30
as
select empno, ename, deptno,sal, comm from emp_copy where deptno=30
  with check option;

--Q. emp_view30 �信�� �޿��� 1200 �̻��� ������� �μ���ȣ�� 30������ 
--  20������ ����?
update emp_view30 set deptno=20 where sal>=1200;  --�����߻�

--3. with read only �ɼ�
-- : �б� ������ �並 ����� �ִ� �ɼ�
-- : �並 ���ؼ� �⺻ ���̺��� ������ �������� ���ϵ��� ����� �ִ� ����

create or replace view view_read30
as
select empno, ename, sal, comm, deptno from emp_copy 
  where deptno=30 with read only; --�б������� view����
  
select * from user_views;
select * from view_read30;
  
--Q. ������ ��(view_read30)�� ���� �غ���?
update view_read30 set sal = 3000;
--�����߻� : with read only �ɼǶ����� ������ �ȵ�.
----------------------------------------------------------------------
--rownum �÷�
--1.�������� �˻� ������ ������ �ִ� ������ �÷��̴�.
--2. rownum ���� 1������ ���۵ȴ�.
--3. rownum ���� order by���� ���� �ϴ��� ���� �ٲ��� �ʴ´�.
--4. rownum ���� �����ϱ� ���ؼ��� ���̺��� ���� �ؾ��Ѵ�.

select rownum, rowid, deptno, dname, loc from dept;
select rownum, ename, sal from emp;
select rownum, ename, sal from emp where ename='WARD';

--order by���� �����ص� rownum ���� �ٲ��� �ʴ´�.
select rownum, ename, sal from emp order by sal desc;

--Q1. ��� ���̺��� �Ի����� ���� ��� 5���� ���غ���?
select * from emp;
--1) �Ի����� ���� ��� ������ ���� (�Ի����� �������� �������� ����)
select rownum, empno,ename, hiredate from emp order by hiredate asc;

--2) �����
create or replace view hire_view
as
select empno,ename, hiredate from emp order by hiredate asc;

--3) �Ի����� ���� ��� 5�� ���
select rownum, empno,ename, hiredate from hire_view;

select rownum, empno,ename, hiredate from hire_view where rownum <= 5;

--4) �ζ��� ��(=���������� ������� ��)
-- �Ի����� ���� ��� 5�� �˻�?
--�Ի����� ���� ��� ������ ������ �ϰ� rownum���� ����.
select rownum, ename, hiredate from (
  select empno,ename, hiredate from emp order by hiredate asc) --hire_view���ڸ��� selec�� ��
where rownum <=5;

-- �Ի�����  3~5��° ���� ��� �˻�?
select rownum, rnum, ename, hiredate from (
  select rownum rnum, ename, hiredate from (
  select * from emp order by hiredate asc))
 where rnum >=3 and rnum <= 5;
 
-----------------------------------------------------------------------
--Q2. ��� ���̺��� �����ȣ(empno)�� ���� ��� 5���� ���غ���?
--1) �����ȣ�� ���� ��������� ����(�����ȣ�� �������� �������� ����)
select empno, ename from emp order by empno asc;

--2) �����
create or replace view emp_view
as
select empno, ename from emp order by empno asc;

--3) �����ȣ�� ���� ��� 5�� ���
select rownum, empno, ename from emp_view where rownum <= 5;

--4) �ζ��� ��
-- �����ȣ�� ���� ��� 5�� �˻�?
select rownum,empno,ename from (
 select * from emp order by empno asc) --�ζ��� ��
 where  rownum <= 5;
 
 -- �����ȣ��  3~5��° ���� ��� �˻�?
 select rownum, rnum, empno, ename from (
   select rownum rnum, empno, ename from(
   select * from emp order by empno asc ))
where rnum >=3 and rnum <= 5;  
   
select rownum, rnum, empno, ename from (
   select rownum rnum, empno, ename from(
   select * from emp order by empno asc ))
where rnum between 3 and 5; 
 --------------------------------------------------------------------------
 --Q3. ��� ���̺��� �޿��� ���� �޴� ��� 5���� �˻�?
 --1) �޿��� ���� �޴� ��������� ����
 select ename, sal from emp order by sal desc;
 
 --2) �����
create or replace view sal_view
as
select ename, sal from emp order by sal desc;

--3) �޿��� ���� �޴� ��� 5�� ��� 
select rownum, ename, sal from sal_view;

select rownum, ename, sal from sal_view where rownum <= 5;

--4) �ζ��� ��
-- �޿��� ���� �޴� ��� 5�� ��� ?
select rownum,ename, sal from (
 select * from emp order by sal desc) --�ζ��� ��
where rownum <= 5;
 
-- ����.
--      ������̺�(EMP)���� �޿��� 3~5��°�� ���� �޴� �����
--      ����ϴ� SQL���� �ۼ� �ϼ���?
 -- �޿��� 3~5��°�� ���� �޴� ��� �˻� ? 
 select rownum,ename, sal from (
  select * from emp order by sal desc) --�ζ��� ��
 where rownum >= 3 and rownum <= 5;   --�˻��ȵ�.( rownum ���� ��� �ٲ�� ���� �Ǿ)
 
--�������� �ι����
select rownum, rnum, ename, sal from (   --rownum��°������� ��� �ٲ�°� :1~3
    select rownum rnum, ename, sal from (   --rownum �÷��� ��Ī �ο� (�÷��̵�): �߶󳻱� ����
    select * from emp order by sal desc) )  --rownum�� �����÷��� �ƴ϶� �˻� ������ 1���� ������
where rnum >=3 and rnum <=5;               --rnum�� : 3~5

-- �÷����� �����ϰ� ó��
select rnum, ename, sal, hiredate from (
    select rownum rnum, board.* from(  --��Ī��.*�� ���� ��� �÷��˻�
    select * from emp order by sal desc)  board) --���������� ��Ī �ο�
where rnum>=3 and rnum <= 5;
