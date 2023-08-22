-- 2023.08.17(��)

-- �� ������ : and, or, not

--1. and ������ : �� ���ǽ��� ��� �����ϴ� �����͸� �˻�
--Q. ��� ���̺��� �μ���ȣ�� 10���̰�, job�� MANAGER�� ����� �˻��ϴ�
--   SQL�� �ۼ�?
select * from emp where deptno = 10 and job = 'manager';

--2. or ������ : �� ���ǽ� �߿��� �Ѱ����� �����ص� �˻�
--Q. ��� ���̺��� �μ���ȣ�� 10�̰ų�, job�� MANAGER�� ����� �˻��ϴ�
--   SQL�� �ۼ�?
select * from emp where deptno = 10 or job = 'manager';

--3. not ������ : ������ �ݴ�� �ٲ��ִ� ����
--Q. �μ���ȣ�� 10�� �ƴ� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where deptno = 10;

select * from emp where not deptno = 10; --�� ������
select * from emp where deptno != 10;  --�� ������
select * from emp where deptno ^= 10;  --�� ������
select * from emp where deptno <> 10;  --�� ������

--Q1. �޿��� 2000���� 3000������ �޿��� �޴� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where sal >= 2000 and sal <= 3000; 

--Q2. Ŀ�̼��� 300�̰ų� 500�̰ų� 1400 �� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where comm =300 or comm=500 or comm=1400;

--Q3. �����ȣ�� 7521�̰ų� 7654�̰ų� 7844�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where empno=7521 or empno=7654 or empno=7844;

--between and ������ : ������ ���� ������ �ִ� ��쿡 ����� �� �ִ�.
--���� : where �÷��� between ������ and ū��
--Q1. �޿��� 2000���� 3000������ �޿��� �޴� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where sal >= 2000 and sal <= 3000; 

select * from emp where sal between 2000 and 3000;
select * from emp where sal between 3000 and 2000; --�˻���� ����

--Q2. �޿��� 2000�̸��ΰų� 3000�ʰ��� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where sal < 2000 and sal > 3000; 
select * from emp where sal not between 2000 and 3000; --2000���� 3000���̰� �ƴ� ����

--Q3. 1987�⵵�� �Ի��� ����� �˻��ϴ� SQL�� �ۼ�?
select *from emp where hiredate >= '87/01/01' and hiredate <= '87/12/31';
select *from emp where hiredate between '87/01/01' and '87/12/31';

--in ������ : or �����ڸ� ����ؼ� ǥ���Ҷ� ���ȴ�.
-- ���� : where �÷��� in(������1,������2,...)
--Q2. Ŀ�̼��� 300�̰ų� 500�̰ų� 1400 �� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where comm =300 or comm=500 or comm=1400;

select * from emp where comm in(300,500,1400);

--Q3. Ŀ�̼��� 300,500,1400�� �ƴ� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where comm !=300 and comm!=500 and comm!=1400;

select * from emp where comm not in(300,500,1400);

--Q3. �����ȣ�� 7521�̰ų� 7844�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where empno=7521 or empno=7844;

select * from emp where empno in(7521,7844);

------------------------------------------------------------------------
--like �������� ���ϵ� ī�� : �˻������ �����Ҷ� �����.
--���� : where �÷��� like pattern(���ϵ� ī���̿�)

--���ϵ� ī��
--1. % : ���ڰ� ���ų�, �ϳ� �̻��� ���ڿ� � ���� �͵� �������.
--2. _ : �ϳ��� ���ڿ� � ���� �͵� �������.

--Q1. ������̺��� ������� F�� �����ϴ� ����� �˻��ϴ� SQL�� �ۼ�?
select *from emp where ename = 'FORD'; -- FORD ����� �˻���.

select *from emp where ename like 'F%';

--Q2. ������̺��� ������� N���� ������ ����� �˻��ϴ� SQL�� �ۼ�?
select *from emp where ename like '%N';

--Q3. ������̺��� ������� A�� �����ϴ� ����� �˻��ϴ� SQL�� �ۼ�?
select *from emp where ename like '%A%'; --A�� ���Ե� ��� �˻�

--����(_) ���ϵ� ī�� (�ڸ����� ��ü������ �����Ҷ�)
--: �ϳ��� ���ڿ� � ���� �͵� ��� ����.
--Q1. ��� �̸��� �ι�° ���ڰ� A�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename like '_A%';

--Q2. ��� �̸��� ����° ���ڰ� A�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename like '__A%';

--Q3. ����� A�� ���ԵǾ� ���� �ʴ� ����� �˻��ϴ� SQL�� �ۼ�?
select *from emp where ename like '%A%'; --A�� ���Ե� ��� �˻�
select *from emp where ename not like '%A%'; 

--NULL ���� �˻�
--EMP ���̺� : MGR, COMM

--Q1. MGR �÷��� NULL ���� �����͸� �˻�?
select * from emp where mgr = null;--�˻��ȵ�
select * from emp where mgr = '';--�˻��ȵ�

select * from emp where mgr is null; -- �������� �˻�

--Q2. MGR Į���� NULL ���� �ƴ� �����͸� �˻�?
select * from emp where mgr is not null; 

--Q3. COMM �÷��� NULL���� �����͸� �˻�?
select * from emp where comm = null; --�˻��ȵ�
select * from emp where comm = ''; --�˻��ȵ�
select * from emp where comm is null; --�������� �˻�

--Q4. COMM �÷��� NULL���� �ƴ� �����͸� �˻�?
select * from emp where comm is not null;

-----------------------------------------------------------------------
--����
--����: order by �÷��� ���Ĺ��(asc or desc)
--���Ĺ�� : ��������(ascending), ��������(descending)

--          ��������                           ��������
-----------------------------------------------------------------------
--����:���� ���ں��� ū���� ������ ����(1,2,3..)  ū���ں��� ���� ���� ������ ����
--����:������ ����(a,b,c..)                    �������� ����(z,y,x..)
--��¥:���� ��¥������ ����                      ���� ��¥������ ����
--NULL: NULL���� ���� �������� ���              NULLL ���� ���� ���� ���

--1. ���� ������ ����
--Q1. ��� ���̺��� �޿��� �������� �������� ����
select * from emp order by sal asc;

--���Ĺ��(asc,desc)�� ������ �Ǹ�, �⺻ ���� ����� ������������ ������.
select * from emp order by sal;

--Q2. ��� ���̺��� �޿��� �������� �������� ����
select * from emp order by sal desc;

--2. ���� ������ ����
--Q1. ��� ���̺��� ������� �������� �������� ���� : ������ ����
select * from emp order by ename asc;
select * from emp order by ename; --���Ĺ��(asc)�� ��������

--Q2. ��� ���̺��� ������� �������� �������� ���� : �������� ����
select * from emp order by ename desc;

--3. ��¥ ������ ����
--Q1. ��� ���̺��� �Ի����� �������� �������� ���� : ������¥ ������ ����
select *from emp order by hiredate asc;

--Q1. ��� ���̺��� �Ի����� �������� �������� ���� : ������¥ ������ ����
select *from emp order by hiredate desc;

--4. NULL�� ����
-- 1) �������� ���� : NULL ���� ���� �������� ���
-- 2) �������� ���� : NULL ���� ���� ���� ���
--Q1. MGR �÷��� �������� �������� ����: NULL ���� ���� �������� ���
select * from emp order by mgr asc;

--Q2. MGR �÷��� �������� �������� ����: NULL ���� ���� ���� ���
select * from emp order by mgr desc;

--Q3. COMM �÷��� �������� �������� ����: NULL ���� ���� �������� ���
select * from emp order by comm asc;

--Q4. COMM �÷��� �������� �������� ����: NULL ���� ���� ���� ���
select * from emp order by comm desc;

--������ �����ϱ�
--1. �ѹ� ���������� ������ ����� �����Ͱ� ���� ��쿡�� �ѹ��� ������ �ؾ��Ѵ�.
--2. �ι�° ���� ������ �ѹ� ���� ������ ������ ����� ���� �����͸� �ι�°
--   ���� ������ ������ �޴´�.
--3. ��� �Խ����� ����� ��쿡 �ַ� ����Ѵ�.

--2�� ���Ĺ���
--Q1. ��� ���̺��� �Ի����� �������� �������� �����ϵ�, ���� ������ �Ի��Ͽ� 
--   �Ի��� ��쿡�� ������� �������� ������������ �����ؼ� ����ϴ� SQL�� �ۼ�?
select * from emp order by hiredate asc;
select * from emp order by hiredate asc, ename desc;

--Q1. ��� ���̺��� �޿��� �������� ������������ ������ �Ѵ�. �̶� ������ �޿���
--    �޴� ������� ������� �������� ������������ �����ؼ� ����ϴ� SQL�� �ۼ�?
select * from emp order by sal desc; --3000(2��), 1250(2��)
select * from emp order by sal desc, ename asc;

--Q2. ��� ���̺��� �μ���ȣ(deptno)�� �������� �������� �����ϰ�, �̶� ������
--    �μ��� �Ҽӵ� ��쿡�� �Ի���(hiredate)�� �������� ������������ �����ؼ�
--    ����ϴ� SQL�� �ۼ�?
select * from emp order by deptno asc;
select * from emp order by deptno asc, hiredate desc;
