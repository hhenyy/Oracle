-- 2023.08.22(ȭ)

--DML(Data Manipulation Language, ������ ���۾�)
-- insert, update, delete

--1. insert : ������ �Է�
-- 1) ����
--    insert into ���̺� (�÷�1, �÷�2,...) values(������1, ������2,...);
--    insert into ���̺� values(������1,������2,...);

--[�ǽ�]
drop table dept01 purge;

--����ִ� dept01 ���纻 ���̺� ���� - ���̺� ������ ����
create table dept01 as select * from dept where 1=0;

select * from dept01;

insert into dept01(deptno, dname, loc) values(10,'ACCOUNTING','NEW YORK');
insert into dept01 values(20,'RESEARCH','DALLAS');
insert into dept01 values(30,'������','����');

-- NULL �� �Է�
insert into dept01(deptno, dname) values(40,'���ߺ�'); --loc�÷� NULL
insert into dept01 values(50,'��ȹ��',NULL); --loc�÷� NULL
select * from dept01;

--2) ���������� ������ �Է� (����ǽ������� ��õ������ ������ ª���ð��� �Է°���)
drop table dept02 purge;

--dept02 ���̺� ���� : ���̺� ������ ����
create table dept02 as select * from dept where 1=0;
select * from dept02;

--���������� ������ �Է�
insert into dept02 select * from dept;
insert into dept02 select * from dept02; --��� �Է°���

select count(*) from dept02; --������ ���� ���ϱ�

--3) insert all ��ɹ����� ���� ���̺� ������ �Է�
-- 2���� ���̺� ����

create table emp_hir as select empno, ename, hiredate from emp where 1=0; 
create table emp_mgr as select empno, ename, mgr from emp where 1=0;

--insert all ��ɹ����� ���� ���̺� ������ �Է�
insert all
       into emp_hir values(empno, ename, hiredate)
       into emp_mgr values(empno, ename, mgr)
       select empno, ename, hiredate,mgr from emp where deptno=20;
       
select *from  emp_hir;
select *from  emp_mgr;

--2. update : ������ ����
--   ����: update ���̺�� set �÷�1=�����Ұ�1,
--		                     �÷�2=�����Ұ�2,...
--        where ������;

--[�ǽ�] 
drop table emp01 purge;

--���纻 ���̺� ����
create table emp01 as select * from emp;
select * from emp01;

--1) ��� ������ ���� : Where �������� ������� ����
--Q1. ��� ������� �μ���ȣ�� 30�� ����?
update emp01 set deptno = 30;

--Q2. ��� ������� �޿��� 10% �λ�
update emp01 set sal = sal * 1.1;

--Q3. ��� ������� �Ի����� ���� ��¥�� ����?
update emp01 set hiredate = sysdate;

--2) Ư�� ������ ���� : Where �������� ���
drop table emp02 purge;

--���纻 ���̺� ����
create table emp02 as select * from emp;
select * from emp02;

--Q1. �޿��� 3000�̻��� ����� �޿��� 10% �λ�?
update emp02 set sal= sal * 1.1 where sal>=3000;

--Q2. 1987�⵵ �Ի��� ����� �Ի����� ���� ��¥�� ����?
update emp02 set hiredate = sysdate where substr(hiredate,1,2)='87';
update emp02 set hiredate = sysdate where hiredate between '87/01/01' and'87/12/31';
update emp02 set hiredate = sysdate where hiredate >='87/01/01' and hiredate <='87/12/31';

--Q3. SCOTT ����� �Ի����� ���� ��¥�� �����ϰ�, �޿��� 50����,
--   Ŀ�̼��� 4000���� ����?
update emp02 set hiredate = sysdate,sal=50, comm=4000 where ename='SCOTT'; 

--3) ���������� �̿��� ������ ����
--Q. 20�� �μ��� ������(DALLAS)�� 40�� �μ��� ������(BOSTON)���� ����?
select * from dept;
--10	ACCOUNTING	NEW YORK
--20	RESEARCH	DALLAS
--30	SALES	CHICAGO
--40	OPERATIONS	BOSTON

drop table dept01 purge;
create table dept01 as select * from dept; --���纻 ���̺� ����
select * from dept01;

update dept01 set loc =  (select loc from dept01 where deptno=40)
     where deptno = 20;

--3. delete : ������ ����
 --����: delete from ���̺�� where ������;

--1) ��� ������ ����: where �������� ������� �ʴ´�.
select * from dept01;
delete from dept01;
rollback;   --Ʈ����� ��� (���� ������ ����)

--2) �������� �����ϴ� ������ ���� : where �������� ���
--Q. dept01 ���̺��� 30�� �μ��� ����?
delete from dept01 where deptno=30;
select * from dept01;

--3) ���������� �̿��� ������ ���� 
--Q. ������̺�(emp02)���� �μ����� SALES �μ��� ����� ���� ?
drop table emp02 purge;
create table emp02 as select *from emp;--���纻 ������ ����
select * from emp02;
delete  from emp02 where deptno=
      (select deptno from dept where dname= 'SALES');--30
      
-------------------------------------------------------------------------
* ���̺� ������ ������ �� ���̺��� MERGE ����

  MERGE : ������ ���� 2���� ���̺��� �ϳ��� ���̺�� ��ġ�� ���.
  MERGE����� �����Ҷ� ������ �����ϴ� ��(ROW)�� ������ ���ο�     
  ������ UPDATE�ǰ�, �������� ������ ���ο� ��(ROW)���� �߰��ȴ�.

drop table emp01 purge;
drop table emp02 purge;
select * from emp01; --14�� ������
select * from emp02; -- 3�� ������

1. create table emp01 as select * from emp;

2. create table emp02 as select * from emp where job='MANAGER';

3. update emp02 set job='Test';

4. insert into emp02 values(8000, 'ahn', 'top', 7566, '2023/02/09',1200, 10, 20);

5. select * from emp02; (Ȯ��)

6. merge into emp01
	using emp02                   --emp02�� �̿��Ͽ� emp01�� merge����
	on(emp01.empno = emp02.empno) --�����ȣ����
	when matched then             --��ġ�� �Ǹ� update�� ����
	     update set emp01.ename = emp02.ename,
			emp01.job = emp02.job,
			emp01.mgr = emp02.mgr,
			emp01.hiredate = emp02.hiredate,
			emp01.sal = emp02.sal,
			emp01.comm = emp02.comm,
			emp01.deptno = emp02.deptno
	when not matched then          --��ġ�� �ȵǸ� isert�� ����
	     insert values(emp02.empno, emp02.ename, emp02.job, 	 	         	         
		          emp02.mgr,emp02.hiredate, 
		         emp02.sal, emp02.comm,emp02.deptno);

7. select * from emp01; (�պ��� ��� Ȯ��)
-------------------------------------------------------------------------
--Ʈ�����(Transaction)(�ŷ�)

--1. ������ �۾� ���� 
--2. ������ �۾������� Ʈ������� DML(insert,update,delete)SQL������ ���۵ȴ�.
--3. �������� �ϰ����� �����ϸ鼭, �����͸� ���������� �����ϱ� ���ؼ� ����� �ȴ�.
--4. Ʈ������� All-or-Nothing ������� ó���ȴ�.

--TCL(Transaction COntrol Language)
--commit : Ʈ����� ����
--rollback : Ʈ������� ���
--savepoint : ������ ����(������)�� �����ϴ� ����

--[�ǽ�]
drop table dept01 purge;
create table dept01 as select * from dept; --���纻 ���̺� ����
select * from dept01;

--1. rollback : Ʈ������� ���
--���ο� Ʈ������� ���۵ǰ�, �޸𸮻󿡼��� delete�� ����ȴ�.
delete from dept01; 

-- Ʈ������� ����ϱ� ������, �޸𸮻󿡼� delete�� �����Ͱ� �����ȴ�.
rollback;

select * from dept01; --������ �����Ͱ� �����Ǿ� �ִ�.

--2. commit : Ʈ������� ����
-- : �޸� �󿡼� ó���� DML SQL���� �����ͺ��̽��� ���������� �ݿ��ϰ� �ȴ�.
delete from dept01 where deptno=20; --�޸𸮻󿡼� 20�� ������ ����
commit;--Ʈ����� ����(�޸� �󿡼� ������ �����͸� DB�� �ݿ��ؼ� �����Ѵ�.)
rollback; --Ʈ������� ���� �Ǿ��� ������ ������ 20�� �����ʹ� ������ �� ����.

--����.
--       Q1. SMITH�� ������ ������ ���� ����� �̸��� ������ ����ϴ� 
--            SQL���� �ۼ� �ϼ���?  ��������
select ename, job from emp where job= (select job from emp where ename='SMITH');

--     Q2. ������ 'SALESMAN'�� ����� �޴� �޿����� �ִ� �޿�����
-- 	���� �޴� ������� �̸��� �޿��� ����ϵ� �μ���ȣ�� 
--	20���� ����� �����Ѵ�.(ALL������ �̿�) ������ ���������Ұ��� ������ ��������
select ename, sal,deptno  from emp where sal >(select max(sal) from emp where job='SALESMAN')and deptno!=20; 
select ename, sal,deptno  from emp where sal >all(select sal from emp where job='SALESMAN')and deptno!=20; 

--       Q3. ������ 'SALESMAN'�� ����� �޴� �޿����� �ּ� �޿����� 
-- 	���� �޴� ������� �̸��� �޿��� ����ϵ� �μ���ȣ�� 
--	20���� ����� �����Ѵ�.(ANY������ �̿�) ������ ���������Ұ��� ������ ��������
--any : �ϳ��̻� ������ ��

select ename, sal,deptno  from emp where sal >(select min(sal) from emp where job='SALESMAN')and deptno!=20;
select ename, sal,deptno  from emp where sal >any(select sal from emp where job='SALESMAN')and deptno!=20; 
