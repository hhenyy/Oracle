-- 2023.08.24 (목)

--제약 조건의 활성화 / 비활성화

--Q. 부모테이블(DEPT)의 데이터를 삭제 해보자?
delete from dept where deptno = 10; --오류발생

--자식테이블(EMP)에서 부모키(deptno)를 참조하는 외래키가 있기 
--때문에 부모테이블의 데이터를 삭제할 수 없다.
--2.부모 테이블의 데이터를 삭제하기 위해서, 참조하는 자식테이블의 외래키를 
--  비활성화 시켜서, 부모 테이블의 데이터를 삭제 할 수 있다.

--1. 부모 테이블 생성
drop table dept01 purge;
create table dept01(
  deptno number(2) primary key, --부모키
  dname varchar2(14),
  loc varchar2(13));
  
insert into dept01 values(10, 'ACCOUNTING','NEW YORK');
select * from dept01;

--2. 자식 테이블 생성
drop table emp01 purge;
create table emp01(
  empno number(4) primary key,
  ename varchar2(10) not null,
  job varchar2(10) unique,
  deptno number(2) references dept01(deptno)); --외래키
  
insert into emp01 values(1111,'홍길동','개발자',10); --부모키 값 10만 참조해서 값입력
select * from emp01;

--3. 부모테이블 (DEPT01)의 데이터 삭제
delete from dept01; --자식테이블(emp01)에서 참조하고 있기 때문에 삭제안됨
select * from dept01;
select * from emp01;

--4. 자식 테이블의 외래키 제약조건을 비활성화 시켜보자.
--  부모 테이블(DEPT01)의 데이터를 삭제하기 위해서는 자식 테이블(EMP01)의
-- 외래키 제약조건을 비활성화(disable) 시키면, 부모테이블의 데이터를 삭제 할 수 있다.

--형식 : alter table 테이블명 disable constraint constraint_name;
--ENABLED(활성화)->DISABLED(비활성화)
alter table emp01 disable constraint SYS_C007062; 

--cf. 자식 테이블(EMP01)의 외래키 제약조건을 활성화?
--형식 : alter table 테이블명 enable constraint constraint_name;
delete from emp01; --5.에서 참조하는 부모테이블의 값이 삭제되어서 참조할수 있는 값이 없어서 자식테이블값도 삭제후 활성화함
alter table emp01 enable constraint SYS_C007062;

--5. 부모 테이블의 데이터를 삭제 해보자?
delete from dept01;  --참조하는 외래키가 없기 때문에 삭제됨
select * from dept01;

--cascade 옵션
--1. cascade 옵션을 붙여서 부모테이블(DEPT01)의 제약조건을 비활성화 시키면,
-- 참조하고 있는 자식테이블(EMP01)의 외래키 제약조건도 같이 비활성화 된다.
-- 부모테이블(DEPT01)의 constraint_name
alter table dept01 disable constraint SYS_C007054 cascade; 

--2. cascade 옵션을 붙여서 부모테이블(DEPT01)의 primary key제거하면,
-- 참조하는 자식테이블(EMP01)의  foreign key 제약조건도 같이 제거해준다.
--형식 : alter table 테이블명 drop constraint constraint_name;
alter table dept01 drop constraint SYS_C007054 cascade; 
alter table dept01 drop primary key cascade; 

--1. 부모 테이블 생성
drop table dept01 purge;
create table dept01(
  deptno number(2) primary key, --부모키
  dname varchar2(14),
  loc varchar2(13));
  
insert into dept01 values(10, 'ACCOUNTING','NEW YORK');
select * from dept01;

--2. 자식 테이블 생성
drop table emp01 purge;
create table emp01(
  empno number(4) primary key,
  ename varchar2(10) not null,
  job varchar2(10) unique,
  deptno number(2) references dept01(deptno)on delete cascade); --외래키
  
-- on delete cascade 
--: 부모 테이블의 데이터를 삭제하면, 참조하는 자식 테이블의 데이터도 같이 삭제
--  해주는 옵션
insert into emp01 values(1111,'홍길동','개발자',10); --부모키 값 10만 참조해서 값입력
select * from emp01;

--3. 부모 테이블(dept01)의 데이터를 삭제 해보자?
delete from dept01 where deptno =10;
select * from dept01; --데이터 삭제됨
select * from emp01; --cascade 옵션 때문에 데이터가 삭제됨
-------------------------------------------------------------
--뷰(view) : 기본 테이블을 이용해서 만들어진 가상 테이블

--실습을 위한 기본 테이블 생성 : dept_copy, emp_copy

--2개의 기본 테이블 생성
create table dept_copy as select * from dept;
create table emp_copy as select * from emp;

select * from dept_copy;
select * from emp_copy;

--뷰 생성
create view emp_view30
as
select empno,ename,deptno from emp_copy where deptno=30;
--"insufficient privileges" 권한 불충분 오류
--scott계정은 뷰생성 권한이 없어서 system 계정에서 뷰생성 권한 부여

--뷰 목록 확인
select *from tab; --EMP_VIEW30은 tabletype이	VIEW
select * from user_views; --view객체의 자세한 정보 확인

--뷰 검색
select*from emp_view30;
desc emp_view30; 

--Q.뷰(emp_view30)에 insert로 데이터를 입력 했을 경우에,
-- 기본테이블(emp_copy)에 데이터가 입력 될까요?
insert into emp_view30 values(1111,'홍길동',30);

--view에 데이터가 입력되면, 기본 테이블에도 입력된다.
select*from emp_view30;
select*from emp_copy;

--뷰의 종류
--단순뷰: 하나의 기본 테이블로 생성된 뷰
--복합뷰: 여러개의 기본 테이블로 생성된 뷰

--1. 단순뷰
--Q. 기본 테이블인 emp_copy를 이용해서 20번 부서에 소속된 사원들의 사번과 이름,
-- 부서번호, 직속상사의 사번을 출력하기 위한 뷰(emp_view20)를 생성?
create view emp_view20
as
select empno,ename,deptno,mgr from emp_copy where deptno=20;

-- 뷰 확인
select * from tab;
select * from user_views;

select * from emp_view20;

--2. 복합뷰
--Q.각 부서별(부서명) 최대급여와 최소급여를 출력하는 뷰를 sal_view라는
-- 이름으로 작성 하세요?
create view sal_view
as
select dname, max(sal) MAX, min(sal) MIN from dept, emp
   where dept.deptno=emp.deptno group by dname;
   
--뷰 확인
select * from tab;
select * from user_views;

--뷰 데이터 확인
select * from sal_view;

--뷰 삭제
-- 형식 : drop view 뷰이름;
drop view sal_view;

--뷰를 생성할때 사용되는 옵션
--1. or replace 옵션 (기억하기)
-- 기존에 뷰가 존재하지 않으면 뷰를 생성하고, 만일에 동일한 이름을 가진 뷰가
-- 존재하면 뷰의 내용을 수정 하도록 만들어 주는 옵션

--1) or replace 옵션없이 동일한 뷰(emp_view30)를 생성 : 오류발생
create view emp_view30
as
select empno, ename, deptno,sal, comm from emp_copy where deptno=30;

--2) or replace 옵션을 붙여서 동일한 뷰(emp_view30)를 생성 : 뷰의 내용이 수정됨
create or replace view emp_view30
as
select empno, ename, deptno,sal, comm from emp_copy where deptno=30;

-- 3) 뷰 확인
select * from emp_view30;

--2. with check option
-- : where 조건절에 사용된 값을 수정하지 못하도록 만들어 주는 옵션

-- 1) with check option 사용하지 않은 경우
-- : where 조건절에 사용된 값이 수정가능하다.
create or replace view emp_view30
as
select empno, ename, deptno,sal, comm from emp_copy where deptno=30;

--Q. emp_view30 뷰에서 급여가 1200 이상인 사원들의 부서번호를 30번에서 
--  20번으로 수정?
select * from emp_view30;
update emp_view30 set deptno=20 where sal>=1200;
select * from emp_view30;

-- 1) with check option 사용한 경우
--뷰에 insert, update, delete가 실행되면, 기본 테이블에도 동일한 내용이
--적용된다.
-- : where 조건절에 사용된 값을 수정하지 못한다.
select * from emp_copy; --기본 테이블 내용이 바껴있다.
drop table emp_copy purge;
create table emp_copy as select * from emp; --기본 테이블 생성

--with check option 사용해서 뷰 생성
create or replace view emp_view30
as
select empno, ename, deptno,sal, comm from emp_copy where deptno=30
  with check option;

--Q. emp_view30 뷰에서 급여가 1200 이상인 사원들의 부서번호를 30번에서 
--  20번으로 수정?
update emp_view30 set deptno=20 where sal>=1200;  --오류발생

--3. with read only 옵션
-- : 읽기 전용의 뷰를 만들어 주는 옵션
-- : 뷰를 통해서 기본 테이블의 내용을 수정하지 못하도록 만들어 주는 역할

create or replace view view_read30
as
select empno, ename, sal, comm, deptno from emp_copy 
  where deptno=30 with read only; --읽기전용의 view생성
  
select * from user_views;
select * from view_read30;
  
--Q. 생성된 뷰(view_read30)를 수정 해보자?
update view_read30 set sal = 3000;
--오류발생 : with read only 옵션때문에 수정이 안됨.
----------------------------------------------------------------------
--rownum 컬럼
--1.데이터의 검색 순서를 가지고 있는 논리적인 컬럼이다.
--2. rownum 값은 1번부터 시작된다.
--3. rownum 값은 order by절로 정렬 하더라도 값이 바뀌지 않는다.
--4. rownum 값을 변경하기 위해서는 테이블을 변경 해야한다.

select rownum, rowid, deptno, dname, loc from dept;
select rownum, ename, sal from emp;
select rownum, ename, sal from emp where ename='WARD';

--order by절로 정렬해도 rownum 값은 바뀌지 않는다.
select rownum, ename, sal from emp order by sal desc;

--Q1. 사원 테이블에서 입사일이 빠른 사원 5명을 구해보자?
select * from emp;
--1) 입사일이 빠른 사원 순으로 정렬 (입사일을 기준으로 오름차순 정렬)
select rownum, empno,ename, hiredate from emp order by hiredate asc;

--2) 뷰생성
create or replace view hire_view
as
select empno,ename, hiredate from emp order by hiredate asc;

--3) 입사일이 빠른 사원 5명 출력
select rownum, empno,ename, hiredate from hire_view;

select rownum, empno,ename, hiredate from hire_view where rownum <= 5;

--4) 인라인 뷰(=서브쿼리로 만들어진 뷰)
-- 입사일이 빠른 사원 5명 검색?
--입사일이 빠른 사원 순으로 정렬을 하고 rownum값을 구함.
select rownum, ename, hiredate from (
  select empno,ename, hiredate from emp order by hiredate asc) --hire_view들어갈자리에 selec문 들어감
where rownum <=5;

-- 입사일이  3~5번째 빠른 사원 검색?
select rownum, rnum, ename, hiredate from (
  select rownum rnum, ename, hiredate from (
  select * from emp order by hiredate asc))
 where rnum >=3 and rnum <= 5;
 
-----------------------------------------------------------------------
--Q2. 사원 테이블에서 사원번호(empno)가 빠른 사원 5명을 구해보자?
--1) 사원번호가 빠른 사원순으로 정렬(사원번호를 기준으로 오름차순 정렬)
select empno, ename from emp order by empno asc;

--2) 뷰생성
create or replace view emp_view
as
select empno, ename from emp order by empno asc;

--3) 사원번호가 빠른 사원 5명 출력
select rownum, empno, ename from emp_view where rownum <= 5;

--4) 인라인 뷰
-- 사원번호가 빠른 사원 5명 검색?
select rownum,empno,ename from (
 select * from emp order by empno asc) --인라인 뷰
 where  rownum <= 5;
 
 -- 사원번호가  3~5번째 빠른 사원 검색?
 select rownum, rnum, empno, ename from (
   select rownum rnum, empno, ename from(
   select * from emp order by empno asc ))
where rnum >=3 and rnum <= 5;  
   
select rownum, rnum, empno, ename from (
   select rownum rnum, empno, ename from(
   select * from emp order by empno asc ))
where rnum between 3 and 5; 
 --------------------------------------------------------------------------
 --Q3. 사원 테이블에서 급여를 많이 받는 사원 5명을 검색?
 --1) 급여를 많이 받는 사원순으로 정렬
 select ename, sal from emp order by sal desc;
 
 --2) 뷰생성
create or replace view sal_view
as
select ename, sal from emp order by sal desc;

--3) 급여를 많이 받는 사원 5명 출력 
select rownum, ename, sal from sal_view;

select rownum, ename, sal from sal_view where rownum <= 5;

--4) 인라인 뷰
-- 급여를 많이 받는 사원 5명 출력 ?
select rownum,ename, sal from (
 select * from emp order by sal desc) --인라인 뷰
where rownum <= 5;
 
-- 과제.
--      사원테이블(EMP)에서 급여를 3~5번째로 많이 받는 사원을
--      출력하는 SQL문을 작성 하세요?
 -- 급여를 3~5번째로 많이 받는 사원 검색 ? 
 select rownum,ename, sal from (
  select * from emp order by sal desc) --인라인 뷰
 where rownum >= 3 and rownum <= 5;   --검색안됨.( rownum 값이 계속 바뀌는 값이 되어서)
 
--서브쿼리 두번사용
select rownum, rnum, ename, sal from (   --rownum출력값순서라 계속 바뀌는값 :1~3
    select rownum rnum, ename, sal from (   --rownum 컬럼에 별칭 부여 (컬럼이됨): 잘라내기 역할
    select * from emp order by sal desc) )  --rownum은 실제컬럼이 아니라서 검색 순서를 1부터 보여줌
where rnum >=3 and rnum <=5;               --rnum값 : 3~5

-- 컬럼명을 간결하게 처리
select rnum, ename, sal, hiredate from (
    select rownum rnum, board.* from(  --별칭명.*을 쓰면 모든 컬럼검색
    select * from emp order by sal desc)  board) --서브쿼리에 별칭 부여
where rnum>=3 and rnum <= 5;
