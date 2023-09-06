-- 2023.08.28 (��)

--��(ROLE): �������� ������ ���� ������.

--����Ŭ���� �⺻������ �����Ǵ� ��
--EX) connect(8���� ����), resource�� (20������ ����),dba��(130������ ����)

--1. ���ο� ���� ���� : user04/tiger
create user user04 identified by tiger;

--2. ������ ���� ��� Ȯ��
select * from dba_users;

--3. user04 �������� role �ο�: connect, resource 2���� ���� �ο�
grant connect, resource to user04;

--4. user04 �������� ���� �� ���̺��� ���� �غ���?
conn user04/tiger
create table member(id varchar2(20),passwd varchar2(20));
------------------------------------------------------------
--����� ���� �� ���� : �ѿ� �ý��� ������ �ο�
--1. �� ����
create role mrole;

--2. ������ �ѿ� �ý��� ������ �߰��Ѵ�.
grant create session, create table, create view to mrole;

--3. mrole�� �����ϱ� ���� ���� ����:user05/tiger
create user user05 identified by tiger;

--4. user05�������� mrole�� �ο��Ѵ�.
grant mrole to user05;

--5. user05 �������� ���� �غ���
sqlplus user05/tiger
conn user05/tiger

--------------------------------------------------------
--����� ���� �� ����: �ѿ� ��ü������ �ο�
--1. �� ����  --�ý��۰������� ����
conn system/oracle   
create role mrole02;

--2. ������ �ѿ� ��ü ������ �ο��Ѵ�.(scott���������ο�) emp���̺��� �ý��۰����� ����.
conn scott/tiger
grant select on emp to mrole02;

--3. user05 �������� mrole02�� �ο��Ѵ�.
conn system/oracle
grant mrole02 to user05;

--4. user05 �������� ���� �� �� �˻��� �غ���
conn user05/tiger
select * from scott.emp;
--------------------------------------------------------
--�� ȸ�� : Ư�� �������� �ο��� ���� ��� �ϴ°�.
--���� : revoke ���̸� from ����ڸ�;

--Q. user05�������� �ο��� mrole�� mrole02�� ȸ�� �غ���
conn system/oracle
revoke mrole from user05;
revoke mrole02 from user05;

--�� ���� 
--���� : drop role ���̸�;
conn system/oracle
drop role mrole;
drop role mrole02;

--------------------------------------------------------
--����Ʈ ���� �����ؼ� ���� ����ڿ��� �� �ο��ϱ�
--����Ʈ �� = �ý��� ���� + ��ü ���� 

--1. ����Ʈ �� ����
conn system/oracle
create role def_role;

--2. ������ ��(def_role)�� �ý��� ������ �߰�
conn system/oracle
grant create session, create table to def_role;

--3. ������ ��(delf_role)�� ��ü ������ �߰�
conn scott/tiger
grant select on emp to def_role;
grant update on emp to def_role;
grant delete on emp to def_role;

--4. ���� �����ϱ� ���� �Ϲ� ���� ����
conn system/oracle
create user usera1 identified by tiger;
create user usera2 identified by tiger;
create user usera3 identified by tiger;


--5. def_role�� ������ �������� �ο��ϱ�
conn system/oracle
grant def_role to usera1;
grant def_role to usera2;
grant def_role to usera3;

--6.usera1 �������� �����Ŀ� �˻��� �غ���?
conn usera1/tiger
conn usera2/tiger
conn usera3/tiger

select * from scott.emp; --�˻� ������
select * from emp; --�����߻� (��ü�� ������ �����ڸ��� ��Ʈ����/scott���������� ��ü�����ڶ� �������� )
----------------------------------------------------------
--���Ǿ�(synonym):���� �ǹ̸� ���� �ܾ�.
--1. ����� ���Ǿ�
-- : ��ü�� ���� ���� ������ �ο����� ����ڰ� ������ ���Ǿ�ν� 
--   ���Ǿ ���� ����ڸ� ����� �� �ִ�.

--2. ���� ���Ǿ�
-- : DBA ������ ���� ����ڸ� ���� �� �� ������, ������ ����� �� �ִ�.

--���� ���Ǿ��� ��
-- sys.tab --->tab  select*from tab; 
-- sys.seq --->seq  select*from seq;
-- sys.dual --->dual  select 10+20 from dual; 
----------------------------------------------------------
-- ����� ���Ǿ� ��
--1. system �������� ������ ���̺� ����
conn system/oracle
create table systb1(ename varchar2(20));

--2. ������ ���̺� ������ �߰�
conn system/oracle
insert into systb1 values('ȫ�浿');
insert into systb1 values('��ȭ��');

select * from systb1;

--3. scott �������� systb1 ���̺� ���� select ��ü ���� �ο��Ѵ�.
conn system/oracle
grant select on systb1 to scott;

--4. scott �������� �����Ŀ� �˻��� �غ���
conn scott/tiger
select *from systb1;         --�����߻�(���������ڸ��� ����)
select *from system.systb1;  --�������� �˻� ������.

--5. scott�������� ���Ǿ ������ �� �ִ� ���� �ο�
create synonym systb1 for system.systb1; --scott�������������߻�(������ѱ���)
conn system/oracle
grant create synonym to scott;

--6. scott �������� �����Ŀ� ����� ���Ǿ� ����
--  system.systb1 ---> systb1 : ����� ���Ǿ�
conn scott/tiger
create synonym systb1 for system.systb1;

--7. ���Ǿ� ���
conn scott/tiger
select * from user_synonyms;

--8. ���Ǿ �̿��ؼ� �˻��� �غ���?
conn scott/tiger
select * from system.systb1;
select * from systb1;  ---- ����� ���Ǿ�� �˻���

--.9.����� ���Ǿ� ����
--����: drop synonym synonym_name;
conn scott/tiger
drop synonym systb1;

--���� ���Ǿ�
--1. DBA �������� �����ؼ� ���� ���Ǿ �����Ҽ� �ִ�.
--2. ���� ���Ǿ ���鋚�� public�� �ٿ��� ���� �� �� �ִ�.

--���� ���Ǿ� ����
conn system/oracle
create public synonym pubdept for scott.dept;

--���� ���Ǿ� ���
select * from dba_synonyms;

--���� ���Ǿ� ����
conn system/oracle
drop public synonym pubdept;


