-- 2023.08.22(ȭ)

------------------------------------------------------------------------
--DDL(Data Defintion Language) :������ ���Ǿ�
--create : ���̺� ����
--alter : ���̺� ���� ����
--rename : ���̺� �̸� ����
--drop : ���̺� ���� 
--truncate : ���̺� ����

--���̺� ���
select *from tab;
select *from user_tables;

--1. create
-- : �����ͺ��̽� ����, ���̺� ����

--���� : create table ���̺�� (�÷���1 ������Ÿ��1,
--                            �÷���2 ������Ÿ��2,
--                            �÷���n ������Ÿ��n);

--* ���̺��,�÷��� ��� ��Ģ
-- 
--1. �ݵ�� ���ڷ� ���� �ؾ���.
--2. 1~30�� ���� ������.
--3. A~Z������ ��ҹ��ڿ� 0~9������ ����, 
--   Ư����ȣ�� (_, $, #)�� ������ �� ����.
--4. ����Ŭ���� ���Ǵ� ���� �ٸ� ��ü��� �ߺ��Ұ�
--5. ������� �ȵ�.

--����Ŭ�� ������ Ÿ��
--1) ���� ������
--  number(n) : ���� n�ڸ� ���� ����
--  number(n1,n2) : n1:��ü �ڸ���, n2:�Ҽ��� ���Ͽ� �Ҵ�� �ڸ���

--2) ���� ������
-- char() : �������� ������
--         �ִ� 2000byte���� ���� ����
-- vachar2() :�������� ������
--           �ִ� 4000byte���� ���� ���� 
-- long : 2GB���� ���� ����
--        long������ ������ �÷��� �˻� ����� �������� �ʴ´�.

--3) ��¥ ������
--  date: ��/��/�� ���� ����
--  timestamp : ��/��/�� ��:��:�� ���� ����

--���̺� ����
--1) ���� ���̺� ����
create table emp01 (empno number(4),
                    ename varchar2(20),
                    sal number(7,2));
                    
select * from tab; --���̺� ��� Ȯ��

--2) ���������� ���̺� ���� 
--  ���纻 ���̺��� �����ȴ�.  
--  ��,���������� ���簡 ���� �ʴ´�.

-- ���纻 ���̺� ����
create table emp02 as select * from emp;
select * from tab; --���̺� ��� Ȯ��
select * from emp02;

-- ���ϴ� �÷����� ������ ���纻 ���̺� ����
create table emp03 as select empno, ename from emp;
select * from emp03;

--���ϴ� ��(row, ������)���� ������ ���纻 ���̺� ����
create table emp04 as select * from emp where deptno=10;
select * from emp04;

--���̺� ������ ����
--(1=0�� �����ʾ� �׻� �����̶� ���ǽ��� �����ϴ� �����Ͱ� ���⋚���� �����ʹ� ��������ʰ� ���̺� ������ ����)
create table emp05 as select * from emp where 1=0;
select * from emp05;

--2. alter
--  :���̺� ���� ���� (�÷��߰�, �÷�����, �÷�����)

--1) �÷� �߰� : emp01 ���̺� job�÷� �߰�
alter table emp01 add(job varchar2(10));
desc emp01;  --���̺� ���� Ȯ��

--2) �÷� ����
--  i) ������ �÷��� �����Ͱ� ���� ���
--     �÷��� ������ Ÿ���� ������ �� �ִ�.
--     �÷��� ũ�⸦ ������ �� �ִ�.
--  ii) ������ �÷��� �����Ͱ� �ִ� ���
--      �÷��� ������ Ÿ���� ������ �� ����.
--      �÷��� ũ��� �ø����� ������, ���� ����� ������ ũ�⺸�� ���� ũ���
--      ������ ���� ����.

--emp01 ���̺��� job�÷��� ũ�⸦ 10���� 30���� ����
alter table emp01 modify(job varchar2(30));
desc emp01;

--3) �÷�����
alter table emp01 drop column job;
alter table emp01 drop(job);
desc emp01;

--3. rename
--   : ���̺� �̸� ����
--���� : rename old_name to new_name;

--Q. emp01 ���̺��� test ���̺������ �̸��� ���� �غ���?
rename emp01 to test;
select * from tab;

--4. truncate
--  :���̺��� ��� �����͸� ����
-- ���� : truncate table table_name;
truncate table emp02;
select * from emp02;

--5. drop
-- : ���̺� ����
-- ���� : drop table table_name; (Oracle 10g ���ʹ� �ӽ� ���̺�� ��ü)
--       drop table table_name purge; (�����ϰ� ����)

--Q. test ���̺� ���� �غ���?
drop table test;
select * from tab;

--�ӽ� ���̺� ����
purge recyclebin;
------------------------------------------------------------------
* ����Ŭ�� ��ü
  ���̺�, ��, ������, �ε���, ���Ǿ�, ���ν���, Ʈ����


* ������ ��ųʸ�(������ ����)�� ������ ��ųʸ� ��
  ������ ��ųʸ��� ���ؼ� ���ٰ�����

  - ������ ��ųʸ� �� : user_xxxx
     (���� ���̺�)      all_xxxx
		              dba_xxxx

  - ������ ��ųʸ�(�ý��� ���̺�) :   

--scott ���� ������ ���̺� ��ü�� ���� ������ �˻�
  select * from tab;
  select table_name from user_tables; (���̺�)
  
  select * from user_views; (��)

  select * from seq;
  select * from user_sequences; (������)

  select * from user_indexes; (�ε���)

  select * from user_synonyms; (���Ǿ�)

  select * from user_source; (���ν���)

  select * from user_triggers; (Ʈ����)

-- �ڱ� ���� ���� �Ǵ� ������ �ο� ���� ��ü�� ���� ���� �˻�
  select table_name from all_tables;

--�����ͺ��̽� ������(DBA)�� ������ �� �ִ� ��ü�� ���� ���� �˻�
  select table_name from dba_tables; (DBA ������ ��밡��)
 
-- ����Ŭ �ý����� ��� ���� ���� �˻� 
  select username from dba_users; (DBA ������ ��밡��)