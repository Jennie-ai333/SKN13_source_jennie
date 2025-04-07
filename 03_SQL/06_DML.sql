/* *********************************************************************
INSERT 문 - 행 추가
구문
 - 한행추가 :
   - INSERT INTO 테이블명 (컬럼 [, 컬럼]) VALUES (값 [, 값[])
   - 모든 컬럼에 값을 넣을 경우 컬럼 지정구문은 생략 할 수 있다.

************************************************************************ */



/* *********************************************************************
UPDATE : 테이블의 컬럼의 값을 수정
UPDATE 테이블명
SET    변경할 컬럼 = 변경할 값  [, 변경할 컬럼 = 변경할 값] 
[WHERE 제약조건]

 - UPDATE: 변경할 테이블 지정
 - SET: 변경할 컬럼과 값을 지정
 - WHERE: 변경할 행을 선택. 
************************************************************************ */
use hr_join;

-- 직원 ID가 200인 직원의 급여를 5000으로 변경
-- select * from emp where emp_id = 200

update emp 
set salary = 5000 
where emp_id =200;

-- select처럼 조회 값이 아니라서 나오진 않지만 log에는 나온다. 메세지 : 몇개의 행이 쿼리 적용이 받앗는지 나온다. 
select * from emp where emp_id = 200;
update emp 
set salary = 5000 
where emp_id =200;

-- 직원 ID가 200인 직원의 급여를 10% 인상한 값으로 변경.
-- salary = 5000
-- salary = salary * 1.1
update  emp
set 	salary = salary * 1.1
where   emp_id = 200;


-- 부서 ID가 100인 직원의 커미션 비율을 null 로 변경.

select * from emp where dept_id =100;
update emp
set comm_pct = 0.1
where dept_id = 100;

update emp
set comm_pct = null -- 변경할땐 그냥 이퀄 = null하면 된다. is null 아님 // where 절에서만 is null 로 비교 
where dept_id = 100;

--  부서 ID가 100인 직원들의 급여를 100% 인상
select * from emp where dept_id = 100;

update  emp
set 	salary = salary * 2
where 	dept_id = 100;



-- 부서 ID가 100인 직원의 커미션 비율을 0.2로 salary는 3000을 더한 값으로, 상사_id는 100 변경.
update emp
set comm_pct = 0.2,
	salary = salary + 3000,
    mgr_id = 100
where dept_id = 100;
    

select * from emp where dept_id = 100;


select dept_id from dept where dept_name = 'IT'; -- 60이나옴

--  IT 부서의 직원들의 급여를 3배 인상
select * from emp where dept_id = 60;
update emp
set salary = salary * 3
where dept_id = (select dept_id from dept where dept_name = 'IT');


-- EMP 테이블의 모든 데이터를 MGR_ID는 NULL로 HIRE_DATE 는 현재일시로 COMM_PCT는 0.5로 수정.

select * from emp;
update emp
set mgr_id = null,
	hire_date = curdate(),
    comm_pct = 0.5;




/* *********************************************************************
DELETE : 테이블의 행을 삭제 - 유일하게 컬럼과 관련없이 일함 
구문 
 - DELETE FROM 테이블명 [WHERE 제약조건]
   - WHERE: 삭제할 행을 선택
************************************************************************ */

-- 전체 행 삭제





-- 부서테이블에서 부서_ID가 200인 부서 삭제

select * from dept where dept_id = 200;

delete from dept where dept_id = 200;


-- 부서테이블에서 부서_ID가 10인 부서 삭제

select * from dept where dept_id = 10;
delete from dept where dept_id = 10;

select count(*) from emp where dept_id is null; -- null 값의 개수를 알려줘라 , 지금 6개
select count(*) from emp where dept_id = 20; 

-- 만약 20인 것을 위 두줄에서 지우면 is null 값은 8개로 늘어남 , 그리고 마지막 줄은 값이 나오지않음. 

select count(*) from emp;  -- 107개
select * from emp where job_id = 'IT_PROG';

delete from job where job_id = 'IT_PROG';
select * from job where job_id = 'IT_PROG';



-- 부서 ID가 없는 직원들을 삭제
select * from emp where dept_id is null; 

select count(*) from emp;

delete from emp where dept_id is null;



-- 담당 업무(emp.job_id)가 'SA_MAN'이고 급여(emp.salary) 가 12000 미만인 직원들을 삭제.

delete from emp where job_id = 'SA_MAN' and salary < 12000;

-- comm_pct 가 null이고 job_id 가 IT_PROG인 직원들을 삭제

delete from emp where comm_pct is null and job_id = 'IT_PROG';


delete from emp; 
select * from emp;
