-- 2023.08.23 (��)

--���Ἲ ��������
--: ���̺� �������� �����Ͱ� �ԷµǴ� ���� ���� ���ؼ� ���̺��� �����Ҷ�
-- �� �÷��� ���ؼ� �����ϴ� �������� ��Ģ�� �ǹ��Ѵ�.
-- ex) not null, unique, primary key(�⺻Ű), foreign key(�ܷ�Ű)
--     check, default

--1. not null ��������
--  null ���� ������� �ʴ´�.
--  �ݵ�� ���� �Է� �ؾ� �Ѵ�.

--[�ǽ�] 
drop table emp02 purge;

create table emp02(
  empno number(4) not null,
  ename varchar2(12) not null,
  job varchar2(12),
  deptno number(2));
  
select * from tab;
select * from emp02;

-- �������ǿ� ������� �ʴ� ������ �Է�
insert into emp02 values(1111,'ȫ�浿','MANAGER',30);

-- ��������(NOT NULL)�� ����Ǳ� ������ ������ �Է��� ���� �ʴ´�.
insert into emp02 values(NULL,NULL,'SALEMAN',30);
insert into emp02(job,deptno) values('SALEMAN',30); --�����ϸ� �ڵ����� ���ڸ��� ��

--2. unique ��������
--  ������ ���� �Է��� �� �ִ�.
--  �ߺ��� ���� �Է��� �� ����.
--  null ���� �Էµ� �� �ִ�.

drop table emp03 purge;
create table emp03(
  empno number(4) unique,
  ename varchar2(12) not null,
  job varchar2(12),
  deptno number(2));
  
select * from emp03;

--�������� ������ �Է�
insert into emp03 values(1111,'ȫ�浿','������',10);

--unique �������ǿ� ����Ǵ� ������ �Է�
insert into emp03 values(1111,'ȫ�浿','������',20);

--unique �������ǿ� null���� �Է� �����ϴ�.
insert into emp03 values(NULL,'ȫ�浿','������',20);
insert into emp03 values(NULL,'��ȭ��','������',30);

--3. primary key(�⺻Ű) ��������
--   primary key = not null + unique
--   :�ݵ�� �ߺ����� ���� ���� ���� �ؾߵȴ�.
--   ex)  �μ����̺�(DEPT) - deptno(pk)
--        ������̺�(EMP)  - empno(pk)

--        �Խ���(board)    - ��ȣ(no) : pk
--        ȸ������(member) - ���̵�(id) : pk

-- �μ����̺�(DEPT) - deptno(pk)
select * from dept;
insert into dept values(10,'���ߺ�','����'); --unique �������ǿ� ����
insert into dept values(NULL,'���ߺ�','����'); --not null �������ǿ� ����

--������̺�(EMP)  - empno(pk)
select * from emp;
insert into emp (empno, ename) values(7788,'ȫ�浿'); --unique �������ǿ� ����
insert into emp (empno, ename) values(NULL,'ȫ�浿'); --not null �������ǿ� ����

drop table emp05 purge;
create table emp05(
  empno number(4) primary key, --�ݵ�� �ߺ����� ���� ���� �Է��ؾ� �ȴ�.
  ename varchar(12) not null,  --�ݵ�� ���� �Է��ؾ� �ȴ�.
  job varchar(12),
  deptno number(2));
  
select * from emp05;
insert into emp05 values(1111,'ȫ�浿','������',20); --�������� ������ �Է�
insert into emp05 values(1111,'ȫ�浿','������',20); --unique �������ǿ� ����
insert into emp05 values(NULL,'ȫ�浿','������',20); --not null �������ǿ� ����

-- �������� �̸�(constraint name)�� �����ؼ� ���̺� ����
--   EMP04_EMPNO_UK
--   ���̺��_Į����_���� ��������
drop table emp04 purge;
create table emp04(
   empno number(4) constraint emp04_empno_uk unique,
   ename varchar2(10) constraint emp04_empno_nn not null,
   job varchar(10),
   deptno number(2));


   
--4. foreign key (�ܷ�Ű) ��������
--  DEPT(�θ����̺�) -deptno(pk): �θ�Ű : 10,20,30,40
--  EMP(�ڽ����̺�) -deptno(fk) : �ܷ�Ű : 10,20,30

--1) ������̺�(EMP)�� deptno �÷��� foreign key ���������� �����Ǿ� �ִ�.
--2) foreign key ���������� ������ �ִ� �ǹ̴� �θ����̺�(DEPT)�� 
--   �θ�Ű(deptno)�� ���� ���� �� �� �ִ�. 
--3) �θ�Ű�� �Ǳ� ���� ������ primary key�� unique ������������ �����Ǿ� 
--  �־�� �Ѵ�.

--Q. ������̺�(EMP)�� ���ο� ���Ի���� ��� �غ���?
--�ܷ�Ű(deptno)�� �θ�Ű(DEPT-deptno)�ȿ� �ִ°�(10,20,30,40)�� �����Ҽ� �ִ�.
insert into emp(empno, deptno) values(1111,50);--foreign key�������� ����

--[�ǽ�]
drop table emp06 purge;
create table emp06(
   empno number(4) primary key,
   ename varchar2(10) not null,
   job varchar2(10),
   deptno number(2) references dept(deptno));
   
select * from emp06;
select * from dept;
insert into emp06 values(1111,'ȫ�浿','������',10);
insert into emp06 values(1112,'ȫ�浿','������',20);
insert into emp06 values(1113,'ȫ�浿','������',30);
insert into emp06 values(1114,'ȫ�浿','������',40);
--50�� �μ��� �θ�Ű���� ���� �� �� ���� ���̱� ������ �ܷ�Ű �������ǿ� ����
--�Ǿ �Է��� �� ����.
insert into emp06 values(1115,'ȫ�浿','������',50);--foreign key�������� ����

--5. check ���� ����
-- : �����Ͱ� �Էµɶ� Ư�� ������ �����ϴ� �����͸� �Էµǵ��� ����� �ִ�
--  �������� �̴�.

--�޿�(SAL) : 500~5000
--����(gender) : M or F
create table emp07(
  empno number(4) primary key,
  ename varchar2(10) not null,
  sal number(7,2) check(sal between 500 and 5000),
  gender varchar2(1) check(gender in('M','F')));

select * from emp07;
insert into emp07 values(1111,'ȫ�浿',3000,'M');--�������� ������ �Է�
insert into emp07 values(1112,'ȫ�浿',8000,'M');--SAL���� check�������� ����
insert into emp07 values(1113,'ȫ�浿',8000,'m');--table �� ���� ��ҹ��� ����, 
                                                --gender���� check�������� ����
                                                
--6. default ��������
-- : default(����) ���������� ������ �÷��� ���� �Էµ��� ������, default�� ������ 
-- ���� �ڵ����� �Էµȴ�.

drop table dept01 purge;
create table dept01(
   deptno number(2) primary key,
   dname varchar2(14),
   loc varchar2(13) default 'SEOUL');
   
select * from dept01;
insert into dept01 values(10,'ACCOUNTING','NEW YORL');
insert into dept01(deptno,dname) values(20,'RESERCH');
-------------------------------------------------------------------
--���� ���� ���� ���
--1. �÷����� ������� �������� ����
--2. ���̺��� ������� �������� ����

--1. �÷����� ������� �������� ����
drop table emp01 purge;

create table emp01(
   empno number(4) primary key,
   ename varchar2(15) not null,
   job varchar2(10) unique,
   deptno number(4) references dept(deptno));
   
--2. ���̺��� ������� �������� ����
drop table emp02 purge;

create table emp02(
   empno number(4),
   ename varchar2(15) not null,  --not null�� �÷�����������θ� �������� ����
   job varchar2(10),
   deptno number(4),
   primary key(empno),
   unique(job),
   foreign key (deptno) references dept(deptno));
   
--���� ������ �����Ҷ� ���̺� ���� ��ĸ� ������ ���
--1. �⺻Ű�� ����Ű�� ����ϴ� ���(�⺻Ű ���������� 2�� �̻� �����ϴ°�)
--2. alter table ������� ���������� �߰��� ���

--1. 2�� �̻��� �÷��� �⺻Ű�� ����
drop table member01 purge;

--1) �÷����� ������� 2���� �÷��� primary key�� ����
create table member01(
  id varchar2(20) primary key,
  passwd varchar2(20) primary key); --�����߻�
  
-- ORA-02260: table can have only one primary key

--2) ���̺��� ������� 2���� �÷��� primary key�� ����
create table member01(
   id varchar2(20),
   passwd varchar2(20),
   primary key (id,passwd));
   
--2. alter table ������� ���������� �߰��ϴ� ���
drop table emp01 purge;

--���������� ���� ���̺� ����
create table emp01(
  empno number(4),  --primary key
  ename varchar2(15), --not null
  job varchar2(10),  --unique
  deptno number(2)); --foreign key

--primary key �������� �߰� : empno
alter table emp01 add primary key (empno);

-- not null �������� �߰� : ename (�÷���������̶� �ٸ��������ǰ� �ٸ��� modify��)
alter table emp01 modify ename not null;

-- unique �������� �߰�: job
alter table emp01 add unique(job);

--foreign key �������� �߰�: deptno
alter table emp01 add foreign key(deptno) references dept(deptno);

-- �������� ����
-- ���� : alter table ���̺�� drop constraint constraint_name;

--primary key �������� ����
alter table emp01 drop constraint SYS_C007046;
alter table emp01 drop primary key;

--not null �������� ����
alter table emp01 drop constraint SYS_C007047;

--unique �������� ����
alter table emp01 drop constraint SYS_C007048;
alter table emp01 drop unique(job);

--foreign key �������� ����
alter table emp01 drop constraint SYS_C007049;
