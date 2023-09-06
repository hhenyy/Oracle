-- 2023.08.30(��)

--���� �Լ�
--: ���� �Լ��� ���� ���ν����� ������ ����� ����������, ���� ����� �����ִ�
--  ������ �Ѵ�.

--Q1. ��� ���̺��� Ư�� ����� �޿��� 200% �λ��� ����� �����ִ� �����Լ���
--   �����ϼ���
--1. ���� �Լ�
create or replace function cal_bonus(vempno in emp.empno%type)
  return number                    --������ ���� �ڷ���
is 
  vsal number(7,2);                --���ú��� (�ڸ���7,�Ҽ���2)
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

--Q2.��� ���̺��� ������� �����Լ��� �Ű������� �����Ͽ� �ش����� 
--����(job)�� ���ؿ��� �����Լ��� �����ϰ�, �����ϼ���?
--1. ���� �Լ� ����   
create or replace function job_emp(vename in emp.ename%type)
  return varchar2         --������ ���� �ڷ���
is
  vjob emp.job%type;     --���ú���(��������� �˻��� ����� job����)
begin
    select job into vjob from emp where ename = vename;
    return vjob;
end;

--2. ���� �Լ� ��� Ȯ��
select * from user_source;

--3. ���ε� ���� ����   
variable var_job varchar2(10);

--4. �����Լ� ����         /���ν����� ���ĺ��ϱ�
execute :var_job := job_emp('SCOTT');
execute :var_job := job_emp('KING');

--5. ���ε� ������ ����� ��� ���
print var_job;

--�����Լ��� SQL���� �����ؼ� ����
select ename, job_emp('SCOTT') from emp where ename='SCOTT';
select ename, job_emp('KING') from emp where ename='KING';

----------------------------------------------------------------------
--Ŀ��(cursor)
-- : 2�� �̻��� �����͸� ó���Ҷ� Ŀ���� ����Ѵ�.

--Q1. �μ� ���̺��� ��� �����͸� ����ϱ� ���� PL/SQL�� �ۼ�
--1. ���� ���ν��� ����
SET serveroutput on
create or replace procedure cursor_sample01
is
  vdept dept%rowtype;  --���ú���
   
  cursor c1             --Ŀ������
  is
  select * from dept;
begin
  dbms_output.put_line('�����ȣ / �μ��� / ������');
  dbms_output.put_line('-------------------------');
  
  open c1;               --Ŀ�� ����(ù��° �����͸� �����´�.)
    loop
        fetch c1 into vdept.deptno, vdept.dname, vdept.loc; --����
          exit when c1%notfound; --Ŀ���� ������ �����Ͱ� ������
          dbms_output.put_line(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);
    end loop;
    close c1;       --Ŀ�� �ݱ�
end;

--2. ���ν��� ��� Ȯ��
select * from user_source;

--3. ���ν��� ����
execute cursor_sample01;

--Q2. �μ� ���̺��� ��� �����͸� ����ϴ� PL/SQL�� �ۼ�?
--  For Loop������ ó��
--  1. open ~ fetch ~ close ���� ó���Ҽ� ����.
--  2. for loop���� ����ϰ� �Ǹ� �� �ݺ�������, cursor�� ����, 
--   �� ���� ����(fetch)�ϰ�, cursor�� �ݴ� �۾��� �ڵ����� ó���� �ش�.

--1. ���� ���ν��� ����
create or replace procedure cursor_sample02
is
  vdept dept%rowtype;  --���ú���
  
  cursor c1            --Ŀ�� ����
  is
  select * from dept;
begin
  dbms_output.put_line('�����ȣ / �μ��� / ������');
  dbms_output.put_line('-------------------------');
  
  for vdept in c1 loop  --Ŀ�������������� ���� vdept�� �����Ե�.
     exit when c1%notfound; --Ŀ���� ������ �����Ͱ� ������ true����
 dbms_output.put_line(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);
  end loop;
end;

--2. ���ν��� ��� Ȯ��
select * from user_source;

--3. ���ν��� ����
execute cursor_sample02;

--Q3. ������̺��� �μ���ȣ�� �����Ͽ� �ش� �μ��� �Ҽӵ� ����� ������
--  ����ϴ� ���ν����� Ŀ���� �̿��ؼ� ó���ϼ���
--1. ���� ���ν��� ����
create or replace procedure info_emp(vdeptno in emp.deptno%type) --�μ���ȣ�� �����ؼ� ������� �˻� 
is
  vemp emp%rowtype;  --���ú���
  
  cursor c1            --Ŀ�� ����
  is
  select * from emp where deptno= vdeptno;  --emp���̺��� ��簪 �˻�
begin        
  dbms_output.put_line('�μ���ȣ / �����ȣ / ����� / ���� / �޿�');
  dbms_output.put_line('-------------------------------------');
  
  for vemp in c1 loop  --c1Ŀ�������������� ���� vdept�� �����Ե�.
     exit when c1%notfound; --Ŀ���� ������ �����Ͱ� ������ true����
 dbms_output.put_line(vemp.deptno||'/'||vemp.empno||'/'||vemp.ename||'/'||vemp.job||'/'||vemp.sal);
  end loop;
end;

--2. ���ν��� ��� Ȯ��
select * from user_source;

--3. ���ν��� ����
execute info_emp(10);
execute info_emp(20);
execute info_emp(30);
execute info_emp(40);
