-- 2023.08.30(수)

-- 패키지 (package) = 저장 프로시저와 저장 함수를 묶어 놓은것.(저장 프로시저 +저장 함수)

--패키지 = 패키지 헤드 + 패키지 바디

--패키지 생성
--1. 패키지 헤드 생성
create or replace package exam_pack
is 
  function cal_bonus(vempno in emp.empno%type) --저장함수
    return number;
  procedure cursor_sample02;           --만들어놓은 저장프로시저
end;

--2.패키지 바디 생성
create or replace package body exam_pack
is
  --저장함수 : cal_bonus
  function cal_bonus(vempno in emp.empno%type)
    return number                    --돌려줄 값의 자료형
  is 
    vsal number(7,2);                --로컬변수 (자릿수7,소숫점2)
  begin
    select sal into vsal from emp where empno = vempno;
    return vsal*2;                   --급여를 200%인상한 결과를 돌려준다.
  end;
  
  --저장프로시저 : cursor_sample02; 
  procedure cursor_sample02
  is
    vdept dept%rowtype;  --로컬변수
  
    cursor c1            --커서 선언
    is
    select * from dept;
  begin
  dbms_output.put_line('사원번호 / 부서명 / 지역명');
  dbms_output.put_line('-------------------------');
  
     for vdept in c1 loop  --커서가가진내용을 변수 vdept가 가지게됨.
      exit when c1%notfound; --커서가 가져올 데이터가 없을때 true리턴
 dbms_output.put_line(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);
    end loop;
  end;
  
end;

--3.저장 프로시저 실행 :cursor_sample02 (패키지명.프로시저명)
execute exam_pack.cursor_sample02;

--4. 저장 함수 실행 : cal_bonus()
-- 바인드 변수 생성
variable var_res number;

--저장 함수 실행
execute :var_res := exam_pack.cal_bonus(7788); --바인드변수를 통해 값을 받음.
execute :var_res := exam_pack.cal_bonus(7900);

--바인드 변수로 받은 결과 출력
print var_res;

--SQL문으로 저장함수 실행 (바인드변수없이실행 가능)
select ename, exam_pack.cal_bonus(7788) from emp where empno =7788; 
select ename, exam_pack.cal_bonus(7900) from emp where empno =7900; 
--------------------------------------------------------------------
--트리거(trigger)
--1. 트리거의 사전적인 의미는 방아쇠 라는 의미를 가지고있다.
--2. 트리거는 이벤트를 발생 시켜서, 연쇄적으로 다른 작업을 자동으로 수행할때
--   사용한다.
--3. 이벤트는 DML SQl문을 이용해서 이벤트를 발생시키고, 이때 연쇄적으로 
--   실행부(begin~ end)안의 내용을 자동으로 실행한다.

--Q1. 사원테이블에 사원이 등록되면,"신입 사원이 입사 했습니다." 라는 메시지를 
--   출력하는 트리거를 생성 하세요

--1. 사원 테이블 생성
purge recyclebin;             --임시 테이블 삭제
drop table emp01 purge;
create table emp01(
  empno number(4) primary key, --기본키 제약조건
  ename varchar2(20),
  job varchar2(20));
  
select * from tab;

--2. 트리거 생성
create or replace trigger trg_01
  after insert on emp01        --이벤트 발생
begin
  dbms_output.put_line('신입 사원이 입사 했습니다.');
end;

--3. 트리거 목록 확인
select * from user_triggers;

--4. 이벤트 발생: EMP01 테이블에 회원가입(데이터입력)
set SERVEROUTPUT on
insert into emp01 values(1111,'홍길동','개발자');
insert into emp01 values(1112,'홍길동','개발자');
insert into emp01 values(1113,'홍길동','개발자');
insert into emp01 values(1114,'홍길동','개발자');