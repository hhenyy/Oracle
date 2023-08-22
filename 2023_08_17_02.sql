-- 2023.08.17(��)

select 10+20 from dept; --4�� ���
select 10+20 from emp; --14�� ���

-- dual ���̺�
--1.dual ���̺��� sys���� ������ ���̺��̰�, ���� ���Ǿ�� ���� �Ǿ� �ִ�.
--2.dual ���̺��� ������ �Ǿ� �ֱ� ������ ������ ����� �� �ִ�.
--3.dual ���̺��� �����Ͱ� 1�� �ۿ� ���� ������, ���� ����� 1���� ����Ѵ�.

select 10+20 from dual; --1�� ���
select 10+20 from sys.dual;

desc dual;              --dummy Į�� 1�� ����.
--DUMMY  VARCHAR2(1)

select * from dual;    -- x ������ 1�� ����.

select * from sys.tab;
select * from tab;     --tab : ���� ���Ǿ�

--1. ���� ó�� �Լ�
--abs() : ���밪�� �����ִ� �Լ�
--        �Լ����� ��,�ҹ��ڸ� �������� �ʴ´�.
select -10, abs(-10), ABS(-10) from dual;

--floor() : �Ҽ��� ���ϸ� ������ ����
select 34.5678, floor(34.5678) from dual;

--round() : Ư�� �ڸ����� �ݿø��� ���ִ� �Լ�
--round( ���, �ڸ��� )
select 34.5678, round(34.5678) from dual; --35 : �Ҽ� ù°�ڸ����� �ݿø�
select 34.5678, round(34.5678,2) from dual; --34.57 : �Ҽ� ��°�ڸ����� �ݿø�
select 34.5678, round(34.5678,-1) from dual; --30
select 34.5678, round(35.5678,-1) from dual; --40

--trunc() : Ư�� �ڸ����� �߶󳻴�(������) ����
--trunc(���,�ڸ���)
select trunc(34.5678),trunc(34.5678,2),trunc(34.5678,-1)from dual;
--            34            34.56             30

--mod() : �������� �����ִ� �Լ�
select mod(27,2), mod(27,5),mod(27,7) from dual;
--          1           2         6

--Q. ��� ���̺��� �����ȣ�� Ȧ���� ������� ����ϴ� SQL�� �ۼ�?
select ename,empno from emp where mod(empno,2) =1;

-----------------------------------------------------------
--2. ���� ó�� �Լ�

--upper() : �빮�ڷ� ��ȯ���ִ� �Լ�
select 'Welcome to Oracle', upper('Welcome to Oracle') from dual;

--lower() : �ҹ��ڷ� ��ȯ���ִ� �Լ�
select 'Welcome to Oracle', lower('Welcome to Oracle') from dual;

--initcap(): �� �ܾ��� ù���ڸ� �빮�ڷ� ��ȯ���ִ� �Լ�
select 'Welcome to Oracle', initcap('Welcome to Oracle') from dual;

--Q.��� ���̺��� job�� manager �� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where job = 'manager'; --�˻��ȵ�
select * from emp where lower(job) = 'manager'; 
select * from emp where job = upper('manager');

--length() : ���ڿ��� ���̸� �����ִ� �Լ�(���ڼ�)
select length('Oracle'), length('����Ŭ') from dual;

--lengthb() : ���ڿ��� ���̸� ����Ʈ�� �����ִ� �Լ�
--���� 1���� : 1Byte, �ѱ� 1���� : 3Byte
select lengthb('Oracle'), lengthb('����Ŭ') from dual;
--                 6               9

-- substr() : ���ڿ��� �Ϻθ� �����Ҷ� ���Ǵ� �Լ�
-- ���� : substr(��� ���ڿ�, ������ġ, ������ ���ڰ���)
--        ������ ���۹�ȣ�� ���ʺ��� 1������ �����Ѵ�.

select substr('Welcome to Oracle', 4, 3) from dual; --com���
select substr('Welcome to Oracle', -4, 3) from dual; --acl���
select substr('Welcome to Oracle', -6, 3) from dual; --Ora���

--Q1. ������̺��� �Ի���(hiredate)�� ��,��,���� �����ϴ� SQL�� �ۼ�?
select substr(hiredate, 1,2) as "��",
       substr(hiredate, 4,2) as "��",
       substr(hiredate, 7,2) as "��" from emp;
       
--Q2. ��� ���̺��� 87�⵵�� �Ի��� ����� �˻��ϴ� SQL�� �ۼ�?
select *from emp where hiredate >= '87/01/01' and hiredate <= '87/12/31';
select *from emp where hiredate between '87/01/01' and '87/12/31';
select*from emp where substr(hiredate, 1,2) = '87';

--Q3. ��� ���̺��� ������� E�� ������ ����� �˻��ϴ� SQL�� �ۼ�?
select*from emp where ename like '%E';
select*from emp where substr(ename, -1,1)='E';

