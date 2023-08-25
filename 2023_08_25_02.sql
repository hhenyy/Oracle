-- 2023.08.25 (��)

--��ü ����
--����Ŭ�� ��ü : ���̺�, ��, ������, �ε���, ���Ǿ�, ���ν���, Ʈ����

--1. ���� ������ user01 �������� scott ���� ������ EMP ���̺� ��ü�� ����
--  SELECT ��ü ������ �ο��غ���?
conn scott/tiger
grant select on emp to user01;

--2. user01 �������� ������ EMP ���̺� ��ü�� ���ؼ� select�� ���� �غ���?
conn user01/tiger
select * from emp;   --�����߻�
select * from scott.emp; --�˻� ������

--3. ��ü ���� ���
revoke select on emp from user01;

--��ü ������ ��� �Ǿ��� ������ ���� �߻�
conn user01/tiger
select * from scott.emp;  --���� �߻�

--with grant option
--:user02 �������� scott ���� ������ EMP ���̺� ��ü�� ���ؼ� SELECT ��ü 
-- ������ �ο��Ҷ� with grant option�� �ٿ��� ������ �ο��Ǹ�, user02������
-- �ڱⰡ �ο����� ������ �� 3�� ����(user01)���� ��ο� �� �� �ִ�.
--1. user02 �������� scott ���� ������ EMP ���̺� ��ü�� ���� select��ü������
-- �ο��غ���?
conn scott/tiger
grant select on emp to user02 with grant option;

--2. user02 �������� ������, user01 �������� �ڱⰡ �ο����� ��ü������
-- ��ο� �غ���?
conn user02/tiger
select * from scott.emp;  --�˻�������

grant select on scott.emp to user01;

--3. user01 �������� ������ �˻��� �غ���?
conn user01/tiger
select * from scott.emp;  --�˻�������