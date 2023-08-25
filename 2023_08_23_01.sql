-- 2023.08.23 (��)

--����.  
--       Q1. SMITH�� ������ ������ ���� ����� �̸��� ������ ����ϴ� 
--           SQL���� �ۼ� �ϼ���?
--
--       Q2. ������ 'SALESMAN'�� ����� �޴� �޿����� �ִ� �޿�����
-- 	   ���� �޴� ������� �̸��� �޿��� ����ϵ� �μ���ȣ�� 
--	   20���� ����� �����Ѵ�.(ALL������ �̿�)
--
--       Q3. ������ 'SALESMAN'�� ����� �޴� �޿����� �ּ� �޿����� 
-- 	   ���� �޴� ������� �̸��� �޿��� ����ϵ� �μ���ȣ�� 
--	   20���� ����� �����Ѵ�.(ANY������ �̿�)

Ans 1.
        SQL> select ename, job from emp where  
	    job = (select job from emp where ename='SMITH') --CLERK
                 and  ename != 'SMITH';     --SMITH����� �����Ѱ��
	     
Ans 2. // ������ ��������
        SQL> select ename, sal from emp where sal > 
	     (select max(sal)  from emp where job='SALESMAN') --1600
	     and deptno != 20;

         // ������ ��������
        SQL> select ename, sal from emp where sal > all
	     (select sal from emp where job='SALESMAN') 
	     and deptno != 20;

Ans 3. // ������ ��������
        SQL> select ename, sal from emp where sal > 
	     (select min(sal)  from emp where job='SALESMAN')
	     and deptno != 20;

         // ������ ��������
        SQL> select ename, sal from emp where sal > any
	     (select sal from emp where job='SALESMAN') 
	     and deptno != 20;
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

--�ڵ� Ŀ�� : �ڵ����� Ŀ���� ����Ǵ� ��.
--1) �������� ���� : quit, exit, con.close()
--2) DDL(create, alter, rename, drop, truncate), DCL(grant, revoke)
--  ����� ����ɶ� (delete�� DML�̶� �ڵ� Ŀ�Ե����ʾ� ������ ���� ����.)

--��1. DDL ����� ����(create)
select * from dept01; --10, 30, 40
delete from dept01 where deptno=40; --���ο� �ŷ� ���� : 40�� ������ ����

create table dept03 as select * from dept; --�ڵ� Ŀ�� ����(DDL)
rollback; --������ 40�� �����͸� �������� ���Ѵ�.

--��2. DDL ����� ���� (truncate)
--delete(DML) : ������ ���� ����
--truncate(DDL) : �ڵ� Ŀ���� ����Ǳ� ������ �����͸� ���� �� �� ����.
select * from dept01; --10,30

delete from dept01 where deptno = 30; --30�� �μ� ����
rollback;                             --������ 30�� �����Ͱ� ������

select * from dept01; --10,30
truncate table dept01;   --DDL(truncate) : �ڵ�Ŀ�� ����
rollback;                --������ dept01�� �����͸� ������ �� ����. 

--�ڵ� �ѹ� : �ڵ����� �ѹ��� ����Ǵ� ��.
-- : ���������� ���� -������ â�� �ݴ� ���, ��ǻ�Ͱ� �ٿ�Ǵ� ���

--savepint : �ӽ� �������� �����Ҷ� ���Ǵ� ���

--[�ǽ�]
drop table dept01 purge;

--1. dept01 ���̺� ����
create table dept01 as select * from dept;
select * from dept01;

--2. 40�� �μ� ����
delete from dept01 where deptno=40;

--3. commit ���� : Ʈ����� ����
commit;

--4. 30�� �μ� ����
delete from dept01 where deptno=30;

--5. c1 ������ ����
savepoint c1;

--6. 20�� �μ� ����
delete from dept01 where deptno=20;

--7. c2 ������ ����
savepoint c2;

--8. 10�� �μ� ����
delete from dept01 where deptno=10;

--9. c2 ���������� ����
rollback to c2; --10�� �μ� ����
select * from dept01;

--10. c1 ���������� ����
rollback to c1; --10,20�� �μ� ����
select * from dept01;

--11. ���� Ʈ����� ���� ���ĸ� ����
rollback;        --10,20,30�� �μ� ����
select * from dept01;