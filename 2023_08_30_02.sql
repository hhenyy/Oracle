-- 2023.08.30(��)

-- ��Ű�� (package) = ���� ���ν����� ���� �Լ��� ���� ������.(���� ���ν��� +���� �Լ�)

--��Ű�� = ��Ű�� ��� + ��Ű�� �ٵ�

--��Ű�� ����
--1. ��Ű�� ��� ����
create or replace package exam_pack
is 
  function cal_bonus(vempno in emp.empno%type) --�����Լ�
    return number;
  procedure cursor_sample02;           --�������� �������ν���
end;

--2.��Ű�� �ٵ� ����
create or replace package body exam_pack
is
  --�����Լ� : cal_bonus
  function cal_bonus(vempno in emp.empno%type)
    return number                    --������ ���� �ڷ���
  is 
    vsal number(7,2);                --���ú��� (�ڸ���7,�Ҽ���2)
  begin
    select sal into vsal from emp where empno = vempno;
    return vsal*2;                   --�޿��� 200%�λ��� ����� �����ش�.
  end;
  
  --�������ν��� : cursor_sample02; 
  procedure cursor_sample02
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
  
end;

--3.���� ���ν��� ���� :cursor_sample02 (��Ű����.���ν�����)
execute exam_pack.cursor_sample02;

--4. ���� �Լ� ���� : cal_bonus()
-- ���ε� ���� ����
variable var_res number;

--���� �Լ� ����
execute :var_res := exam_pack.cal_bonus(7788); --���ε庯���� ���� ���� ����.
execute :var_res := exam_pack.cal_bonus(7900);

--���ε� ������ ���� ��� ���
print var_res;

--SQL������ �����Լ� ���� (���ε庯�����̽��� ����)
select ename, exam_pack.cal_bonus(7788) from emp where empno =7788; 
select ename, exam_pack.cal_bonus(7900) from emp where empno =7900; 
--------------------------------------------------------------------
--Ʈ����(trigger)
--1. Ʈ������ �������� �ǹ̴� ��Ƽ� ��� �ǹ̸� �������ִ�.
--2. Ʈ���Ŵ� �̺�Ʈ�� �߻� ���Ѽ�, ���������� �ٸ� �۾��� �ڵ����� �����Ҷ�
--   ����Ѵ�.
--3. �̺�Ʈ�� DML SQl���� �̿��ؼ� �̺�Ʈ�� �߻���Ű��, �̶� ���������� 
--   �����(begin~ end)���� ������ �ڵ����� �����Ѵ�.

--Q1. ������̺� ����� ��ϵǸ�,"���� ����� �Ի� �߽��ϴ�." ��� �޽����� 
--   ����ϴ� Ʈ���Ÿ� ���� �ϼ���

--1. ��� ���̺� ����
purge recyclebin;             --�ӽ� ���̺� ����
drop table emp01 purge;
create table emp01(
  empno number(4) primary key, --�⺻Ű ��������
  ename varchar2(20),
  job varchar2(20));
  
select * from tab;

--2. Ʈ���� ����
create or replace trigger trg_01
  after insert on emp01        --�̺�Ʈ �߻�
begin
  dbms_output.put_line('���� ����� �Ի� �߽��ϴ�.');
end;

--3. Ʈ���� ��� Ȯ��
select * from user_triggers;

--4. �̺�Ʈ �߻�: EMP01 ���̺� ȸ������(�������Է�)
set SERVEROUTPUT on
insert into emp01 values(1111,'ȫ�浿','������');
insert into emp01 values(1112,'ȫ�浿','������');
insert into emp01 values(1113,'ȫ�浿','������');
insert into emp01 values(1114,'ȫ�浿','������');