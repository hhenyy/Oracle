-- 2023.08.18(��)

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

--instr() : Ư�� ������ ��ġ�� �����ִ� �Լ�
--instr(���, ã������) : ���� ���� ������ ������ ��ġ�� ã���ش�.
--instr(���, ã������, ������ġ, ���° �߰�)
--Q1. ���� ���� ������ 'O'�� ��ġ�� ã���ش�.
select instr('Welcome to oracle','o')from dual; --5

--Q2. 6�� ���Ŀ� 2��° �߰ߵ� 'o'�� ��ġ�� ã���ش�.
select instr('Welcome to oracle','o',6,2) from dual; --12

--Q3. ��� ���̺��� ������� 3��° �ڸ��� R�� �Ǿ��ִ� ����� �˻��ϴ� SQL�� �ۼ�?
--3���� ��� : like������, substr(), instr()
select *from emp where ename like '__R%';
select *from emp where substr(ename,3,1)='R';
select *from emp where instr(ename,'R') = 3;
select *from emp where instr(ename,'R',3,1) = 3;

--lpad() / rpad() : Ư�� ��ȣ�� ä���ִ� ����
select lpad('Oracle',20,'#') from dual; --##############Oracle
select rpad('Oracle',20,'#') from dual; --Oracle##############

--ltrim() : ���� ������ ���� ���ִ� �Լ�
--rtrim() : ������ ������ ���� ���ִ� �Լ�
select ' Oracle ',ltrim(' Oracle ') from dual;
select ' Oracle ',rtrim(' Oracle ') from dual;

--trim() : ���ڿ� ��,������ ������ ���� ���ִ� �Լ�
--         Ư�� ���ڸ� �߶󳻴� �Լ�
select ' Oracle ', trim(' Oracle ')from dual;
select trim('a' from 'aaaaaOracleaaa')from dual;
-------------------------------------------------------
--3. ��¥ ó�� �Լ�

--sysdate : �ý����� ��¥�� ���ؿ��� �Լ�
select sysdate from dual; --23/08/18

select sysdate-1 ����, sysdate ����, sysdate+1 ���� from dual;

--Q. ��� ���̺��� �� ������� ������� �ٹ��� �ٹ��ϼ��� ���ϴ� SQL�� �ۼ�?
select ename, sysdate - hiredate from emp;
select ename, round(sysdate - hiredate) from emp; --�Ҽ� ù°�ڸ����� �ݿø�
select ename, trunc(sysdate - hiredate) from emp; --�Ҽ��� �ڸ��� ����

--months_between() : �� ��¥ ������ ����� ���� ���� �����ִ� �Լ�
--���� : months_between( date1, date2 )
--Q. ��� ���̺��� �� ������� �ٹ��� �������� ���ϴ� SQL�� �ۼ�?
select months_between(sysdate,hiredate) from emp; --��� ������ ���
select months_between(hiredate,sysdate) from emp; --���� ������ ���

select round(months_between(sysdate,hiredate)) from emp; --��� ������ ���
select trunc(months_between(hiredate,sysdate)) from emp; --���� ������ ���

--add_months() : Ư�� ��¥�� ����� ��¥�� �����ִ� �Լ�
--���� : add_months( date, ������)
--Q1. ��� ���̺��� �� ������� �Ի��� ��¥�� 6������ ����� ���ڸ� ���ϴ�
--    SQL�� �ۼ�?
select ename, hiredate, add_months(hiredate, 6) from emp;

--Q2. �츮���� �԰��Ŀ� 6������ ����� ���ڸ� ���ϴ� SQL�� �ۼ�?
-- 2023.07.11 �԰�
select add_months('23/07/11',6) from dual;

--next_day() : �ش� ������ ���� ����� ��¥�� �����ִ� �Լ�
--���� : next_day( date, ���� )
--Q. ������ �������� ���� ����� ������� ���������� ���ϴ� SQL�� �ۼ�?
select sysdate, next_day(sysdate, '�����') from dual;
select sysdate, next_day(sysdate, '������') from dual;

-- last_day() : �ش� ���� ������ ��¥�� �����ִ� �Լ�
--Q1. �� ������� �Ի��� ���� ������ ��¥�� ���ϴ� SQL�� �ۼ�?
select hiredate, last_day(hiredate) from emp;

--Q2. �̹����� ���� ������ ��¥�� ���ϴ� SQL�� �ۼ�?
select sysdate, last_day(sysdate) from dual;

--Q3. 2023�� 2������ ������ ��¥�� ���ϴ� SQL�� �ۼ�?
select last_day('23/02/01') from dual; --23/02/28
select last_day('20/02/01') from dual; --20/02/29
---------------------------------------------------------------------
--4. ����ȯ �Լ� 
--  to_char() , to_date(), to_number()

--1. to_char() : ��¥��, ������ �����͸� ���������� ��ȯ ���ִ� �Լ�

-- 1) ��¥�� �����͸� ������ ��ȯ
--    ���� : to_char( ��¥ ������, '�������' )
--Q1. ���� �ý����� ��¥�� ��,��,��,��,��,��,���Ϸ� ���
select sysdate from dual; --23/08/18

select sysdate, to_char(sysdate, 'yyyy/mm/dd am hh:mi:ss dy') from dual; --2023/08/18 ���� 11:39:41 ��
select sysdate, to_char(sysdate, 'yyyy/mm/dd am hh:mi:ss day') from dual;--2023/08/18 ���� 11:40:10 �ݿ���
select sysdate, to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss day') from dual;
select sysdate, to_char(sysdate, 'YYYY/MM/DD') from dual; --��ҹ��� �������� ����.

--Q2. ��� ���̺��� �� ������� �Ի����� ��,��,��,��,��,��,���Ϸ� ����ϴ� 
--    SQL�� �ۼ�?
select hiredate, to_char(hiredate, 'yyyy/mm/dd hh24:mi:ss day')from emp;

-- 2) ������ �����͸� ������ ��ȯ
--   ���� : to_char(���� ������, '���б�ȣ')
--Q1. ���� 1230000�� 3�ڸ��� �ĸ��� �����ؼ� ���
select 1230000 from dual;

--0���� �ڸ����� �����ϸ�, �������� ���̰� 9�ڸ��� ���� ������ 0���� ä���.
select 1230000, to_char(1230000, '000,000,000') from dual;--001,230,000

--9�� �ڸ����� �����ϸ�, �������� ���̰� 9�ڸ��� ���� �ʾƵ� ä���� �ʴ´�.
select 1230000, to_char(1230000, '999,999,999') from dual;--1,230,000

--Q2. ��� ���̺��� �� ������� �޿��� 3�ڸ��� �ĸ�(,)�� �����ؼ� ����ϴ�
--    SQL�� �ۼ�?
select ename, sal, to_char(sal,'9,999') from emp;
select ename, sal, to_char(sal,'L9,999') from emp;
select ename, sal, to_char(sal,'9,999L') from emp;

--2. to_date() : ������ �����͸� ��¥������ ��ȯ ���ִ� �Լ�
--  ���� : to_date('���ڵ�����','��¥ format')
-- Q1. 2023 1�� 1�Ϻ��� ������� ����� �ϼ��� ���ϴ� SQL�� �ۼ�?
select sysdate - '2023/01/01' from dual; --�����߻�

select sysdate - to_date('2023/01/01','yyyy/mm/dd') from dual; 
select round(sysdate - to_date('2023/01/01','yyyy/mm/dd')) from dual; 
select trunc(sysdate - to_date('2023/01/01','yyyy/mm/dd')) from dual;

--Q2. 2023�� 12�� 25�� ũ������������ ���� �ϼ��� ���ϴ� SQL�� �ۼ�?
select to_date('2023/12/25','yyyy/mm/dd')-sysdate from dual;
select round(to_date('2023/12/25','yyyy/mm/dd')-sysdate) from dual;
select round(to_date('2023/12/25','yyyy/mm/dd')-sysdate) from dual;

--Q3. �츮���� �����Ⱓ(2023.07.11~2024.01.19)�� �ϼ��� ���غ���?
select to_date('2024.01.19','yyyy/mm/dd')
     - to_date('2023.07.11','yyyy/mm/dd')from dual; 
     
--3. to_number() : ������ �����͸� ���������� ��ȯ ���ִ� �Լ�
--  ���� : to_number( '���� ������', '���б�ȣ')
select '20,000' - '10,000' from dual; --�����߻�
select to_number('20,000','99,999') - to_number('10,000','99,999') from dual; 

--����
-- Q1. ������̺�(EMP)���� �Ի���(HIREDATE)�� 4�ڸ� ������ ��� 
--    �ǵ��� SQL���� �ۼ��ϼ���? (ex. 1980/01/01)
select HIREDATE, to_char(hiredate,'YYYY/MM/DD') from emp;

-- Q2. ������̺�(EMP)���� MGR�÷���  ����  null �� �������� MGR�� 
--    ����  CEO��  ����ϴ� SQL���� �ۼ� �ϼ���?

select *from emp where mgr is null;
select nvl(mgr,0) from emp where mgr is null;
select nvl(mgr,'CEO') from emp where mgr is null; --�����߻�
select NVL(to_char(MGR),'CEO')from emp where mgr is null;
select ename, nvl(to_char(mgr,'9999'),'CEO')
              as MANAGER from emp where mgr is null;


select  NVL(to_char(MGR,'MGR'),'CEO')from emp where mgr is null;

--NVL(�÷�, ��ȯ�� ��) : NULL���� �ٸ���(0)���� ��ȯ ���ִ� ����
--ex) NVL(COMM, 0) : COMM �÷��� NULL ���� 0���� ġȯ �϶�� �ǹ�

--NVL() : NULL���� �ٸ������� ��ȯ���ִ� �Լ�
--1.NULL���� �������� ���� ���� �ǹ�
--2.NULL���� �������(+,-,*,/)�� ���� �ʴ´�.

--Q. ������̺��� �� ������� ������ ����ϴ� SQL�� �ۼ�
--����=�޿�(SAL) *12 +Ŀ�̼�(COMM)
--NVL(COMM,0) :COMM�÷����� NULL�� �����͸� 0���� ġȯ

select ename, sal*12 +nvl(comm,0) as "����" from emp;
--------------------------------------------------------------
--decode(): switch ~case ������ ����
--���� : decode ( �÷���, ��1, ���1,
--                      ��2, ���2,
--                      ��3, ���3,
--                      ��N, ���N)
--Q.��� ���̺��� �μ���ȣ(deptno)�� �μ������� �ٲ㼭 ����ϴ� SQL�� �ۼ�?
select ename, deptno, decode(deptno,10,'ACCOUNTING',
                                    20,'RESEARGH',
                                    30,'SALE',
                                    40,'OPEARTIONS')as dname from emp;
--------------------------------------------------------------------------
-- case �Լ� : if~else if ������ ����
-- ���� : case when ����1 then ��� 1
--            when ����2 then ��� 2
--            else ���3
--       end

--Q. ��� ���̺��� �μ���ȣ(deptno)�� �μ������� �ٲ㼭 ����ϴ� SQL�� �ۼ�?/
select ename, deptno, case when deptno=10 then 'ACCOUNTING'
                           when deptno=20 then 'RESEARGH'
                           when deptno=30 then 'SALE'
                           when deptno=40 then 'OPEARTIONS'
                      end as dname from emp;