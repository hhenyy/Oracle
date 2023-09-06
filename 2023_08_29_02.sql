-- 2023.08.29(ȭ)

--���� ���ν���

--[�ǽ�]
drop table emp01 purge;
create table emp01 as select * from emp; --���纻 ���̺� ����
select * from emp01;

--1. ���� ���ν��� ����
create or replace procedure del_all
is
begin
  delete from emp01;
end;

--2. ���ν��� ��� Ȯ��
select * from user_source;

--3. ���ν��� ����
exec del_all;
execute del_all;

--4. ���ν��� ���� Ȯ��
select * from emp01; --���ν����� ���ؼ� �����Ͱ� ��� ������.

rollback;  --���������� ����->�ȵ�
insert into emp01 select * from emp;
-----------------------------------------------------------
--�Ű������� �ִ� ���ν���
--�Ű������� MODE�� in���� �Ǿ��ִ� ���ν���
--in: �Ű������� ���� �޴� ����
-- 1. �Ű������� �ִ� ���ν��� ����
create or replace procedure del_ename(vename in emp01.ename%type)
is
begin
  delete from emp01 where ename = vename;
end;

--2. ���ν��� ��� Ȯ��
select * from user_source;

--3. ���ν��� ����
execute del_ename('SCOTT');
execute del_ename('KING');
execute del_ename('SMITH');

--4. ���ν��� ����Ȯ��
select * from emp01;
---------------------------------------------------------------
--�Ű������� MODE�� in, out ���� �Ǿ� �ִ� ���ν���
-- in : �Ű������� ���� �޴� ����
-- out :�Ű������� ���� �����ִ� ����

--Q. ���ν����� �Ű������� �����ȣ�� �����ؼ�, �� ����� �����, �޿�, ��å��
--  ���ϴ� ���ν����� �����ϰ� �����ϼ��� 
--  1. ���ν��� ����
create or replace procedure sal_empno(
  vempno in emp.empno%type,  --�����ȣ
  vename out emp.ename%type, --�����
  vsal out emp.sal%type,     --�޿�
  vjob out emp.job%type)     --��å
is
begin
  select ename, sal, job into vename, vsal, vjob from emp
    where empno = vempno;
end;

--2. ���ν��� ��� Ȯ��
select * from user_source;

--3. ���ε� ���� : ���ν����� �����Ҷ� ����� �����޴� ����
variable var_ename varchar2(12);
variable var_sal number;
variable var_job varchar2(10);

--4. ���ν��� ����(out �Ű��������� ���� �޾ƿ������ؼ��� ���ν��� ȣ��� ���� �տ� ':'�� ������)
execute sal_empno(7788, : var_ename, : var_sal, : var_job);
execute sal_empno(7839, : var_ename, : var_sal, : var_job);

--5. ���ε� ������ �������� �� ���
print var_ename;
print var_sal;
print var_job;
-------------------------------------------------------------------
--�ڹ� ���α׷����� ���ν��� ����

--��1. �Ű������� ���� ���ν���/class CallableStatementTest ����
--1.���ν��� ����   
create or replace procedure del_all
is
begin
  delete from emp01;
end;

--2. emp01 ���̺� ����
drop table emp01 purge;
create table emp01 as select * from emp;
select * from emp01;

rollback;
--�ѹ�ȵ�:connection��ü�� clsose()�� ������ �ڹ� ���α׷�����
--�������� ������ �Ǽ� �ڵ�Ŀ�ԵǼ� ������ ������ ���� �Ҽ� ����.

--��2. �Ű������� �ִ� ���ν���/ class CallableStatementTest02 ����
insert into emp01 select * from emp;
select * from emp01;

--1.���ν��� ����   
create or replace procedure del_ename(vename in emp01.ename%type)
is
begin
  delete from emp01 where ename = vename;
end;

--�ڹ� ���α׷����� del_ename ���ν��� ���� �غ���
--2. ���ν��� ���� ��� Ȯ��
select * from emp01;

--��3. �Ű������� MODE�� in, out���� �Ǿ��ִ� ���� ���ν���/class CallableStatementTest03 ����
--1. ���� ���ν��� ���� 
create or replace procedure sel_customer(   --8/9 class JDBC_Insert02���� customer���ֱ�
  vname in customer.name%type,
  vemail out customer.email%type,
  vtel out customer.tel%type)
is
begin
  select email, tel into vemail, vtel from customer
    where name = vname;
end;

--2. ���ν��� ��� Ȯ��
select * from user_source;
select * from customer;

--3. ���ε� ���� ���� : ���ν����� �����Ҷ� ����� �����޴� ����
variable var_email varchar2(20);
variable var_tel varchar2(20);

--4.���ν��� ����
execute sel_customer('ȫ�浿',:var_email,:var_tel);
execute sel_customer('��ȭ��',:var_email,:var_tel);

--5. ���ε� ������ �������� �� ���
print var_email;
print var_tel;

--�ڹ� ���α׷����� sel_customer ���ν����� �����غ���
---------------------------------------------------------------
--���� �Լ�
--: ���� �Լ��� ���� ���ν����� ������ ����� ����������, ���� ����� �����ִ�
--  ������ �Ѵ�.

--Q1. ��� ���̺��� Ư�� ����� �޿��� 200% �λ��� ����� �����ִ� �����Լ���
--   �����ϼ���
--1. ���� �Լ�
create or replace function cal_bonus(vempno in emp.empno%type)
  return number                    --������ ���� �ڷ���
is 
  vsal number(7,2);                --���ú���
begin
  select sal into vsal from emp where empno = vempno;
  return vsal*2;                   --�޿��� 200%�λ��� ����� �����ش�.
end;

--2. �����Լ� ��� Ȯ��
select * from user_source;

--3. ���ε� ���� ���� : ���ν����� �����Ҷ� ����� �����޴� ����
variable var_res number;

--4.���� �Լ� ����
execute :var_res := cal_bonus(7788);
execute :var_res := cal_bonus(7900);

--5.���ε� ������ �������� �� ���
print var_res; 

--�����Լ��� SQL���� ���� ���Ѽ� ����
select ename, sal, cal_bonus(7788) from emp where empno=7788;
select ename, sal, cal_bonus(7900) from emp where empno=7900;

------------------------------------------------------------
Q1.
�䱸1] create user woman identified by tiger;
�䱸2] 
grant create session to woman with admin option;
�䱸3]
create role mrole;
grant connect, resource,dba to woman;
Q2.
create user user01 identified by tiger;
Q3.
create role mrole;
grant create session, create table to mrole;
grant mrole to user05;

Q4.
create or replace procedure job_ename(
  vename in emp.ename%type, --�����
  vjob out emp.job%type)     --��å
is
begin
  select job into vjob from emp
    where ename = vename;
end;

variable var_job varchar2(10);

execute sal_ename('SCOTT',:var_job);

print var_job;

����.
      Q1. ����ǿ� ���� �Ի��� ������� ���ο� ������ ������ �ַ��� 
          �մϴ�.�Ʒ��� �䱸 ������ �����ϴ� SQL���� ���� �ۼ� �ϼ��� ? 
   
   [�䱸1] USER�� : woman, �н����� : tiger 
   [�䱸2] CREATE SESSION �̶�� �ý��� ������ �ο��� �ݴϴ�. 
	  (��, �� �ٸ� �������Ե� ������ �� �� �ֵ��� 
	      WITH ADMIN OPTION�� �ο��մϴ�). 
   [�䱸3] woman�������� connect, resource, dba ������ �ο��մϴ�.

   Q2. user01 ������ ���� �ϼ���? (��й�ȣ: tiger)

   Q3. user01 �������� ����Ŭ ������ ���̽��� �����ؼ�, ���̺��� ����
	�� �� �ִ� ������ �ο��Ͻÿ�.

���������� ���Ѻο��� �ý��۰����̳� db�������� 
Ans 1. SQL> create user woman identified by tiger;

       SQL> grant create session to woman with admin option;

       SQL> grant connect, resource, dba to woman;


Ans 2. SQL> create user user01 identified by tiger;


Ans 3. SQL> grant create session, create table to user01;

����.
��� ���̺��� ������� �˻��Ͽ� ����� ������ ���ؿ��� ���� ���ν����� ���� �����ϼ���?

--1. ���� ���ν��� ����
create or replace procedure ename_job(
        vename in emp.ename%type,
        vjob out emp.job%type)
is
begin
    select job into vjob from emp where ename = vename;
end;

--2. ���ν��� ��� Ȯ��
select * from  user_source;

--3. ���ε� ���� ����
variable var_job varchar2(10);

--4. ���ν��� ����
execute ename_job('SCOTT', :var_job); 
execute ename_job('KING', :var_job); 
execute ename_job('SMITH', :var_job); 

--5. ���ε� ������ ���� �� ���
print var_job;