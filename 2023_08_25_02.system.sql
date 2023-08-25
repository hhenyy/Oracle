-- 2023.08.25 (��)

--������ ���̽� ������ ���� ����
--1. �ý��� ����
--2. ��ü ����

--�ý��� ���� : �����ͺ��̽� ������(DBA)�� ������ �ִ� ����
--ex) create user, drop user...

--�ý��� �����ڰ� �Ϲ� ����ڿ��� �ο��ؾ� �ϴ� ����
--ex) create session : �����ͺ��̽� ���� ����
--    create table : ���̺��� ������ �� �ִ� ����
--    create view : �並 ������ �� �ִ� ����
--    create sequence : �������� ������ �� �ִ� ����
--    create procedure : ���ν����� ������ �� �ִ� ����

--���ο� ���� ���� (���ı���ϱ�) : user01(������) / tiger(P.W)
create user user01 identified by tiger;

--������ ���� ��� Ȯ��
select * from dba_users;

--user01�������� �����ͺ��̽� ���� ������ �ο� : create session 
grant create session to user01;
grant create session, create table to user01;

-- with admin option
-- : grant ������� ������ �ο� ������ with admin option �� �ٿ��� ������
--  �ο��Ǹ�, ������ �ο����� ������ �ڱⰡ �ο� ���� ������ �� 3���� ��������
--  �� �ο��� �� �ִ�.

--1. ���ο� ���� ���� : user02 / tiger
create user user02 identified by tiger;

--2. ������ ���̽� ���� ���� �ο� : create session
grant create session to user02 with admin option;

--3. �� 3�� ���� ���� : user03 / tiger
create user user03 identified by tiger;

--4. user01 �������� ������ user03 �������� create session ���� �ο� 
SQL> conn user01/tiger
SQL> grant create session to user03; --�����߻�

--5. user02 �������� ������ user03 �������� create session ������ �ο��غ���
SQL> conn user02/tiger
SQL> grant create session to user03; --create session ������ �ο���

--6. user03 ������ user02�������� ���� create sesson ������ �ο� �޾ұ�
--  ������ ������ ���̽� ������ �����ϴ�.
SQL> conn user03/tiger
SQL> show user
SQL> user is USER03