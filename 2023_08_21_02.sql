-- 2023.08.21(월)

--과제.
--      Q1. 사원 테이블(EMP)에서 가장 최근에 입사한 사원명을 출력 
--	  하는 SQL문을 작성 하세요?

--      Q2. 사원 테이블(EMP)에서 최대 급여를 받는 사원명과 최대급여
--           금액을 출력하는 SQL문을 작성 하세요?
    
     Ans1. SQL> select ename, hiredate from emp where hiredate=
		(select max(hiredate) from emp); --87/07/13

     Ans2. SQL> select ename, sal from emp where sal=
		(select max(sal) from emp); --5000
        
        select ename, max(sal) from emp;--오류발생

--서브쿼리

--Q. SCOTT 사원이 소속된 부서명을 출력하는 SQL문 작성?
--1) 사원테이블(EMP)에서 SCOTT 사원의 부서번호를 구한다.
select deptno from emp where ename = 'SCOTT'; --20
--2) 부서테이블(DEPT)에서 20번 부서의 부서명을 구한다.
select dname from dept where deptno =20; --RESEARCH

--서브쿼리로 구하기
select dname from dept where deptno=      --메인쿼리
(select deptno from emp where ename='SCOTT'); --서브쿼리

--오류발생, 서브쿼리는 ename까지 출력하지 못함. join으로 출력해야한다.
select ename,dname from dept where deptno=      --메인쿼리
(select deptno from emp where ename='SCOTT'); --서브쿼리

--join으로 구하기
select ename,dname from dept,emp where dept.deptno=emp.deptno and ename='SCOTT'; 
select dname from dept,emp where dept.deptno=emp.deptno and ename='SCOTT'; 
select dname from dept inner join emp on dept.deptno=emp.deptno where ename='SCOTT';
select dname from dept inner join emp using(deptno)where ename='SCOTT';
select dname from dept natural join emp where ename='SCOTT';

--1. 단일행 서브쿼리 
-- 1) 서브쿼리의 검색 결과가 1개만 반환되는 쿼리 
-- 2) 메인쿼리의 where 조건절에서 비교연산자만 사용할 수 있다.
--  (=, >, >=, <, <=, != )

--Q1. 사원 테이블에서 가장 최근에 입사한 사원명을 출력하는 SQL문 작성?
select ename, hiredate from emp where hiredate =
  (select max(hiredate) from emp); --87/07/13
--SCOTT	87/07/13
--ADAMS	87/07/13

--Q2. 사원 테이블에서 최대 급여를 받는 사원명과 최대급여 금액을 출력하는
--  SQL문 작성?
-- 오류 발생 : 그룹함수와 일반컬럼은 같이 사용할 수 없다.
select ename, max(sal) from emp; --오류발생
select ename, sal from emp where sal =
  (select max(sal) from emp); --5000
--KING	5000

--Q3. 직속상사(MGR)가 KING인 사원의 사원명과 급여를 출력하는 SQL문 작성?
select ename,sal, MGR from emp where mgr=
  (select empno from emp where ename='KING'); --7839
--JONES	2975	7839
--BLAKE	2850	7839
--CLARK	2450	7839

--2.다중행 서브쿼리
-- 1) 서브쿼리에서 반환되는 검색 결과가 2개 이상인 서브쿼리
-- 2) 메인쿼리의 where 조건절에서 다중행 연산자(in, all,any..)를 사용해야 한다.

--<in 연산자>
--: 서브쿼리의 검색 결과 중에서 하나라도 일치되면 참이된다.

--Q. 급여를 3000이상 받는 사원이 소속된 부서와 동일한 부서에서 근무하는
-- 사원들의 정보를 출력하는 SQL문 작성?

-- 각 부서별 최대급여 금액 구하기
select deptno, max(sal) from emp group by deptno;
--30	2850
--20	3000
--10	5000

--where deptno in (10,20)
select ename, sal, deptno from emp where deptno in
  (select distinct deptno from emp where sal >= 3000); --10,20
--distinct:중복항목 제거

--<all 연산자>
--: 메인쿼리의 비교조건이 서브쿼리의 검색 결과와 모든 값이 일치되면 참이된다.

--Q.30번 부서에 소속된 사원 중에서 급여를 가장 많이 받는 사원보다 더 많은
-- 급여를 받는 사원의 이름과 급여를 출력하는 SQL문 작성?

--30번 부서의 최대급여 금액 구하기
select max(sal) from emp where deptno=30;--2850

--1) 단일행 서브쿼리로 구하기
select ename, sal from emp where sal >
  (select max(sal) from emp where deptno =30);--2850

--2) 다중행 서브쿼리로 구하기
select ename, sal from emp where sal >all
  (select sal from emp where deptno =30); --다중행 서브쿼리
  
--<any 연산자>
--: 메인쿼리의 비교조건이 서브쿼리의 검색 결과와 하나 이상 일치되면 참이 된다.

--Q. 부서번호가 30번인 사원들의 급여중 가장 낮은 급여(950)보다 더 높은 급여를 
--  받는 사원명과 급여를 출력하는 SQL문 작성

--30번 부서의 최소급여 구하기
 select min(sal) from emp where deptno=30; --950
 
 --1) 단일행 서브쿼리로 구하기
 select ename, sal from emp where sal>
  (select min(sal) from emp where deptno=30); --950
  
--2) 다중행 서브쿼리로 구하기
select ename, sal from emp where sal > any
  (select sal from emp where deptno=30); --다중행 서브쿼리로 구하기

