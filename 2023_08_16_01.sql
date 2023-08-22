-- 2023.08.16(수)

-- 테이블 목록
select * from tab;
-- DEPT : 부서 테이블
-- EMP : 사원 테이블
-- BONUS : 상여금
-- SALGRADE : 급여등급

-- dept 테이블 구조 (부서테이블)
describe dept;
desc dept;

-- dept 데이터 검색 : SQL문은 대,소문자를 구분하지 않는다.
select * from dept;
SELECT * from DEPT;

-- EMP 테이블 구조
desc emp;

-- EMP 테이블 검색
select * from emp;

-- 오라클의 데이터 타입
--1.숫자 데이터
--number(n)
--number(n): number(2) 정수 2자리까지 저장
--number(n1,n2) : n1-전체 자리수
--                n2-소수점에 할당된 자리수
--ex) number(7,2):전체 자리수 7자리
--                소숫점에 2자리
--2.문자 데이터
--char() : 고정 길이 문자형
--         최대 2000 byte 까지 저장 가능함.
--varchar2() : 가변 길이 문자형
--             최대 4000 byte 까지 저장 가능함.
--long :2GB까지 저장 가능함.
--      long형으로 설정된 컬럼은 검색 기능을 지원하지 않는다.
--3. 날짜 데이터
--date : 연/월/일 정보 저장
--timestamp : 연/월/일 시:분:초 정보 저장

--SELECT SQL 문
select* from dept;

select loc, dname, deptno from dept;

select * from emp;

select empno, ename, sal from emp;

--산술 연산자 : +,-,*,/
select sal+ comm from emp;
select sal+ 100 from emp;
select sal- 100 from emp;
select sal* 100 from emp;
select sal/ 100 from emp;

--Q. 사원테이블(EMP)에 소속된 사원들의 연봉을 구해보자?
-- 연봉=급여(SAL)*12 + 커미션(COMM)

--NULL
--1.정해지지 않은 값을 의미
--2. NULL 값은 산술 연산을 할 수 없다.
--3. NULL 값의 예
--   ex) EMP 테이블 : MGR 컬럼-KING 사원은 MGR컬럼이 NULL
--                  COMM 컬럼-job이 SALESMAN인 사원만 값을 가지고 있다.

--sal * 12 + comm : null 값은 산술 연산이 되지 않기 때문에
--                  job이 SALESMAN인 사원만 연봉 계산이 된다.
select ename, job, sal, comm, sal*12, sal*12+comm from emp;

--NVL(컬럼, 변환될 값) : NULL값을 다른값(0)으로 변환 해주는 역할
--ex) NVL(COMM, 0) : COMM 컬럼의 NULL 값을 0으로 치환 하라는 의미

--올바른 연봉계산 SQL작성?
select ename, job, sal, comm, sal*12+comm, sal*12+nvl(comm,0) from emp;

-- 별칭부여: as "별칭명" (외따옴표x)/문자데이터 검색시 문자열은 ' '외따옴표
select ename, sal*12+nvl(comm,0) as "Annsal" from emp;
select ename, sal*12+nvl(comm,0) "Annsal" from emp; -- as 생략가능
select ename, sal*12+nvl(comm,0) Annsal from emp; -- 쌍따옴표 생략가능

-- 한글 별칭명 부여
select ename, sal*12+nvl(comm,0) as "연봉" from emp;
select ename, sal*12+nvl(comm,0) "연봉" from emp; -- as 생략가능
select ename, sal*12+nvl(comm,0) 연봉 from emp; -- 쌍따옴표 생략가능
select ename, sal*12+nvl(comm,0) "연 봉" from emp; -- 사용 가능(""안은 띄어쓰기 가능)
--별칭명에 띄어쓰기를 한 경우에는 별칭명 좌우에 쌍따옴표를 붙여야 된다.
select ename, sal*12+nvl(comm,0) 연 봉 from emp; --오류발생

-- Concatenation 연산자 : || 
-- : 컬럼과 문자열을 연결할 때 사용한다.
select ename, 'is a', job from emp;
select ename || ' is a ' || job from emp;

-- distinct : 중복행을 제거하고 1번만 출력하는 역할
select deptno from emp; -- 14개의 데이터 출력

select distint deptno from emp; --3개의 부서번호 출력: 10,20,30

--Q1. EMP 테이블에서 각 사원들의 job을 1번만 출력하는 SQL문을 작성 하세요.
select job from emp;          -- 14개의 데이터 출력

select distinct job from emp; -- 5개의 JOB출력

--Q2. EMP 테이블에서 중복을 제거한 job의 갯수를 구하는 SQL문 작성 하세요.

--count (컬럼명) : 데이터 갯수를 구해주는 함수
select count(*) from dept;  --4
select count(*) from emp;   --14
select count(job) from emp; --14

select count(distinct job) from emp; --5

-- Where 조건절 : 비교 연산자(=,>,>=,<,<=,!=,^=,<>)

--1. 숫자 데이터 검색
--Q1. 사원 테이블에서 급여를 3000 이상 받는 사원을 검색하는 SQL문 작성?
select*from emp where sal >= 3000;

--Q2. 급여가 3000인 사원을 검색하는 SQL문 작성?
select*from emp where sal = 3000;

--Q3. 급여가 3000이 아닌 사원을 검색하는 SQL문 작성?
select*from emp where sal != 3000;
select*from emp where sal ^= 3000;
select*from emp where sal <> 3000;

--Q4. 급여가 1500이하인 사원의 사원번호, 사원명, 급여를 출력하는 SQL문 작성?
select empno, ename, sal from emp where sal <=1500;

--2. 문자 데이터 검색
--1) 문자 데이터는 대,소문자를 구분한다. (테이블 안에있는 영문데이터만 구분)
--2) 문자 데이터를 검색 할때는 문자열 좌,우에 외따옴표(')를 붙여야 한다.
--별칭부여시 별칭명은 "쌍따옴표 /문자열은 '외따옴표

--Q1. 사원테이블에서 사원명이 FORD 인 사원의 정보를 검색하는 SQL문 작성?
select*from emp where ename = 'ford'; --검색결과 없음
select*from emp where ename = FORD;   --오류발생
select*from emp where ename = "FORD"; --오류발생
select*from emp where ename = 'FORD'; --정상적인 검색

--Q2. SCOTT 사원의 사원번호, 사원명, 급여를 출력하는 SQL문 작성?
select empno, ename, sal from emp where ename = 'SCOTT';

--3. 날짜 데이터 검색
--1) 날짜 데이터를 검색할때는 날짜 데이터 좌,우에 외따옴표(')를 붙여야 한다.
--2) 날짜 데이터를 비교할때 비교 연산자를 사용한다.

--Q1. 1982년 1월 1일 이후에 입사한 사원을 검색하는 SQL문 작성?
select * from emp where hiredate >= 82/01/01; --오류발생
select * from emp where hiredate >= '82/01/01'; --정상적인 검색
select * from emp where hiredate >= '1982/01/01'; --정상적인 검색

--Q2. 1982년 1월 1일 이후에 입사한 사원을 검색하고, 입사일을 기준으로 
--    오름차순으로 정렬하는 SQL문 작성?
select * from emp where hiredate >= '1982/01/01'
  order by hiredate asc;