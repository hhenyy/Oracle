-- 2023.08.28(��)

--PL/SQL (Oracle's Procedural Language extention to SQL) 
--Q. PL/SQL�� Hello world~!! ����غ���
SET SERVEROUTPUT on                      --serveroutput ȯ�溯�� Ȱ��ȭ
begin                                    --����� ����
  dbms_output.put_line('Hello world~!!');
end;                                   --����� ��

--Q. ���� ����ϱ� : ��Į�� ���� ����ϱ�
SET SERVEROUTPUT ON
declare                 --����� ����
  vempno number(4);    --��������: ��Į�� ����
  vename varchar2(10);
begin                    --����� ����
  vempno :=7788;        --�������� ��.�ҹ��ڸ� �������� �ʴ´�.
  vename :='SCOTT';
  dbms_output.put_line('���  /  �̸�');
  dbms_output.put_line('-----------');
  dbms_output.put_line(vempno || '/' || vename);  
end;                       --����� ��

--Q. ����� �̸� �˻��ϱ� : ���۷��� ����
SET SERVEROUTPUT ON
declare 
  vempno emp.empno%type;   --���� ���� : ���۷���(����) ����
  vename emp.ename%type;
begin
  select empno, ename into vempno, vename from emp
    where ename='SCOTT';
    
 dbms_output.put_line('���  /  �̸�');
 dbms_output.put_line(vempno || '/' || vename);
end;
-----------------------------------------------------------
--- ���ǹ�(=���ù�)

--1. if ~ then ~ end if
--Q1. ������̺�(EMP)���� SCOTT����� �μ���ȣ�� �˻��ؼ�, �μ����� ����ϴ�
--  PL/SQL���� �ۼ��ϼ���

SET SERVEROUTPUT ON
declare
  vempno number(4);
  vename varchar2(20);
  vdeptno dept.deptno%type;
  vdname varchar2(20) := null;
begin
  select empno, ename, deptno into vempno, vename, vdeptno from emp
    where ename='SCOTT';
    
    if vdeptno = 10 then
       vdname := 'ACCOUNTING';
    end if;
    if vdeptno = 20 then
       vdname := 'RESEARCH';
    end if;
    if vdeptno = 30 then
       vdname := 'SALES';
    end if;
    if vdeptno = 40 then
       vdname := 'OPERATIONS';
    end if;

    dbms_output.put_line('��� / �̸�  / �μ���');
    dbms_output.put_line(vempno || '/' || vename || '/' || vdname);

end;
