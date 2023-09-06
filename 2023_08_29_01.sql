-- 2023.08.29(화)

--- 조건문(=선택문)

--1. if ~ then ~ end if
--Q1. 사원테이블(EMP)에서 SCOTT사원의 부서번호를 검색해서, 부서명을 출력하는
--  PL/SQL문을 작성하세요

SET SERVEROUTPUT ON
declare
  vempno number(4);   --사원번호
  vename varchar2(20); --사원명
  vdeptno dept.deptno%type; --부서번호
  vdname varchar2(20) := null; --부서명
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

    dbms_output.put_line('사번 / 이름  / 부서명');
    dbms_output.put_line(vempno || '/' || vename || '/' || vdname);

end;

--Q. 사원 테이블에서 SCOTT 사원의 연봉을 구하는 PL/SQL문 작성?
SET SERVEROUTPUT ON
declare            --%rowtype: emp테이블의 8개 컬럼의 자료형을 
                   --         모두 참조한다는 의미를 가지고 있다.
  vemp emp%rowtype; --레퍼런스변수
  annsal number(7,2);--스칼라 변수
begin 
  select * into vemp from emp where ename='SCOTT';
  
  if vemp.comm is null then 
    vemp.comm :=0;
  end if;
  
  annsal := vemp.sal * 12 + vemp.comm;  --연봉: 월급*12+comm
  dbms_output.put_line('사번 / 이름 / 연봉');
  dbms_output.put_line(vemp.empno||'/'||vemp.ename||'/'||annsal);
end;

--2. if ~then ~else ~ end if
--Q. 사원테이블에서 SCOTT 사원의 연봉을 구하는 PL/SQL문 작성
SET SERVEROUTPUT ON
declare
  vemp emp%rowtype;   --레퍼런스변수
  annsal number(7,2); --스칼라 변수
begin
 select * into vemp from emp where ename='SCOTT';
 
 if vemp.comm is null then
   annsal := vemp.sal * 12;
 else
   annsal := vemp.sal * 12 + vemp.comm;
 end if;
 
 dbms_output.put_line('사번 / 이름 / 연봉');
 dbms_output.put_line(vemp.empno||'/'||vemp.ename||'/'||annsal);
end;

--3. if~ then ~ elsif ~ else ~end if   (자바는 else if)
--Q. SCOTT 사원의 부서번호를 이용해서 부서명을 구하는 PL/SQL문 작성
SET SERVEROUTPUT ON
declare
  vemp emp%rowtype;   --레퍼런스변수
  vdname varchar2(14); --스칼라 변수  
begin
 select * into vemp from emp where ename='SCOTT'; -- * 검색, vemp 변수, scott사원에대한 8개의 컬럼값을 vemp에
 
    if vemp.deptno = 10 then
       vdname := 'ACCOUNTING';
    elsif vemp.deptno = 20 then
       vdname := 'RESEARCH';
    elsif vemp.deptno = 30 then
       vdname := 'SALES';
    elsif vemp.deptno = 40 then
       vdname := 'OPERATIONS';
    end if;
    dbms_output.put_line('사번 / 이름  / 부서명');
    dbms_output.put_line(vemp.empno || '/' || vemp.ename || '/' || vdname);
end;
---------------------------------------------------------------
--반복문
--1.Basic Loop문
-- loop
--   반복 실행될 문장;
--   조건식 exit;
-- end loop;

--Q1. Basic Loop문으로 1~5 까지 출력
SET SERVEROUTPUT ON
declare
  n number := 1;  --n변수의 초기값을 1로 설정
begin 
  loop
    dbms_output.put_line(n);
    n := n + 1;
    if n>5 then
      exit; --loop문을 빠져 나옴
    end if;
  end loop;
end;
--그냥 loop문 하면 밑 오류 나와서 if문 넣어줌
--ORA-20000: ORU-10027: buffer overflow, limit of 1000000 bytes

--Q2. 1부터 10까지 합을 구하는 프로그램을 작성
SET SERVEROUTPUT ON
declare 
  n number := 1;  --루프를 돌릴 변수
  s number := 0;  --합이 누적될 변수
begin 
  loop
    s:= s + n;
    n:= n + 1;
    if n>10 then
      exit; --loop문을 빠져 나옴
    end if;
  end loop;
  dbms_output.put_line('1~10까지의 합:' || s);
end;

--2. For Loop문
--  for 변수 in [reverse] 작은값..큰값 loop
--     반복 실행될 문장;
--  end loop;

--Q1. For Loop문으로 1부터 5까지 출력
SET SERVEROUTPUT ON
begin
   for n in 1..5 loop  --자동으로 1씩 증가
     dbms_output.put_line(n);
--     n := n+2;  --2씩증가는 오류발생
   end loop;
end;

--Q2. For Loop문으로 5부터 1까지 출력
SET SERVEROUTPUT ON
begin
   for n in reverse 1..5 loop  --자동으로 1씩 감소
     dbms_output.put_line(n);
--   n := n+2;  --2씩증가는 오류발생
   end loop;
end;

--Q3. For Loop문을 이용해서 부서테이블(DEPT)의 모든 정보를 출력하는 PL/SQL문 작성
SET SERVEROUTPUT ON
declare
  vdept dept%rowtype; --레퍼런스 변수
begin
  dbms_output.put_line('부서번호 / 부서명 / 지역명');
  for cnt in 1..4 loop
    select * into vdept from dept where deptno = 10 * cnt;
    
dbms_output.put_line(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);
  end loop;
end;

--3. While Loop문
--  While 조건식 loop
--   실행될 문장;
--  end loop;

--Q1. While Loop문으로 1부터 5까지 출력
SET SERVEROUTPUT ON
declare
  n number := 1;  --n변수의 초기값을 1로 설정
begin
  while n<=5 loop
    dbms_output.put_line(n);
    n:= n+1;
  end loop;
end;

--Q2. While Loop문으로 별(*)을 삼각형 모양으로 출력
SET SERVEROUTPUT ON
declare
  c number := 1;  --c변수의 초기값을 1로 설정
  star varchar2(100):='';
begin
  while c<=10 loop
    star:= star || '*';
    dbms_output.put_line(star);
    c := c+1;
  end loop;
end;