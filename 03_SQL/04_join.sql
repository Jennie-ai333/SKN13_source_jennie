/* ********************************************************************************
조인(JOIN) 이란
- 2개 이상의 테이블에 있는 컬럼들을 합쳐서 가상의 테이블을 만들어 조회하는 방식을 말한다.
 	- 소스테이블 : 내가 먼저 읽어야 한다고 생각하는 테이블 (메인 정보) 
	- 타겟테이블 : 소스를 읽은 후 소스에 조인할 대상이 되는 테이블 (부가/ 추가 정보)
 
- 각 테이블을 어떻게 합칠지를 표현하는 것을 조인 연산이라고 한다.
    - 조인 연산에 따른 조인종류
        - Equi join , non-equi join
- 조인의 종류
    - Inner Join 
        - 양쪽 테이블에서 조인 조건을 만족하는 행들만 합친다. 조건 없는 행들은 합칠 때 뺀다. 
    - Outer Join
        - 한쪽 테이블의 행들을 모두 사용하고 다른 쪽 테이블은 조인 조건을 만족하는 행만 합친다. 다 합치고 조인조건을 만족하는 행이 없는 경우 NULL을 합친다.
        - 종류 : Left Outer Join,  Right Outer Join, Full Outer Join
    - Cross Join
        - 두 테이블의 곱집합을 반환한다. 중복된값 다 합침. 5*5 = 25개 행 
******************************************************************************** */        

use hr_join;

/* ****************************************
-- INNER JOIN
FROM  테이블a INNER JOIN 테이블b ON 조인조건 

- inner는 생략 할 수 있다.
**************************************** */
-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회
select  e.emp_id, 
		e.emp_name, 
        e.hire_date, 
        d.dept_name
from	emp e inner join dept d on e.dept_id = d.dept_id;

-- e 테이블의 별칭
-- e. emp_id
-- from emp e


-- 커미션을(emp.comm_pct) 받는 직원들의 직원_ID(emp.emp_id), 이름(emp.emp_name),
-- 급여(emp.salary), 커미션비율(emp.comm_pct), 소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 내림차순으로 정렬.

select  e.emp_id,
		e.emp_name,
        e.salary,
        e.comm_pct,
        d.dept_name,
        d.loc
from 	emp e join dept d on e.dept_id = d.dept_id
where 	comm_pct is not null
order by e.emp_id desc;
-- join만쓰면 inner join 임 
-- order by e.emp 에서 e 빼도 됨. 

-- 직원의 ID(emp.emp_id)가 100인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회.
select e.emp_id, e.emp_name, e.hire_date, d.dept_name
from emp e join dept d on e.dept_id = d.dept_id
where e.emp_id = 100;

-- select * from emp where emp_id = 100;
-- select * from dept ehre dept_id = 90;
-- 을 한번에 합친 것 

-- 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회
select  e.emp_id, e.emp_name, e.salary,
		j.job_title,
        d.dept_name
from	emp e join job j on e.job_id = j.job_id 
			  join dept d on e.dept_id = d.dept_id
order by 1;

-- 여기서 왜 프롬 _id가 되는지 귱굼, 표를 한번 확인해봐야겠다..


--  직원 ID 가 200 인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회              

select  e.emp_id, e.emp_name, e.salary,
		j.job_title,
        d.dept_name
from	emp e join job j on e.job_id = j.job_id 
			  join dept d on e.dept_id = d.dept_id
where   e.emp_id = 200;


-- 부서_ID(dept.dept_id)가 30인 부서의 이름(dept.dept_name), 위치(dept.loc), 그 부서에 소속된 직원의 이름(emp.emp_name)을 조회.
select d.dept_id, d. dept_name, d.loc, e.emp_name
from   dept d join emp e on d.dept_id = e.dept_id
where  d.dept_id = 30;

-- 위치가 다를 뿐. 
-- 30번 부서를 다니느 사람이 잇는데 
-- 부모 테이블 기준으로 자식 데이터 여러참조 -- 중복된 데이터가 나올 수 밖에 없음. 


-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 급여등급(salary_grade.grade) 를 조회. 
-- non equi join / 샐러리 그레이드는 참조되어질값이 잇는 게 아니고, 범위로 관계를 정하는 것이기 때문에 연산 방법이 다르다 
-- select * from salary_grade; --> low_sal 컬럼, high_sal 컬럼 존재
select e.emp_id, e.emp_name, e.salary, s.grade as "급여등급"
from   emp e join salary_grade s on e.salary between s.low_sal and s.high_sal;


-- 'New York'에 위치한(dept.loc) 부서의 부서_ID(dept.dept_id), 부서이름(dept.dept_name), 위치(dept.loc), 
-- 그 부서에 소속된 직원_ID(emp.emp_id), 직원 이름(emp.emp_name), 업무(emp.job_id)를 조회. 
select d.dept_id, d.dept_name, d.loc,
	   e.emp_id, e.emp_name, e.job_id
from   dept d join emp e on d.dept_id = e.dept_id
where  d.loc = 'New York';



SELECT d.dept_id, d.dept_name, d.loc, e.emp_id, e.emp_name, e.job_id
FROM dept d JOIN emp e ON d.dept_id = e.dept_id
WHERE d.loc = "New York";



-- 부서별 급여(salary)의 평균을 조회. 부서이름(dept.dept_name)과 급여평균을 출력. 급여 평균이 높은 순서로 정렬. 

select  d.dept_id, 
		d.dept_name, 
        round(avg(salary),2) as "평균급여"
from dept d join emp e on d.dept_id = e.dept_id
group by d.dept_id, d.dept_name
order by 3 desc; 
-- 세번째 컬럼을 내림차순으로 보여줘라 

-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 급여(emp.salary), 급여등급(salary_grade.grade), 소속부서명(dept.dept_name)을 조회.
-- 프롬절에서 네개 합침
select  e.emp_id, e.emp_name, j.job_title, e.salary,
		concat(s.grade, '등급') as "grade",
        d.dept_name
from    emp e join job j on e.job_id = j.job_id 
			  join salary_grade s on e.salary between s.low_sal and s.high_sal
			  join dept d on e.dept_id = d.dept_id
order by 1;             
              
              
        
        
        
        

/* ****************************************************
Self 조인
- 물리적으로 하나의 테이블을 두개의 테이블처럼 조인하는 것. 
- 같은 테이블 안에서의 관계성 - 상사아이디, 직원아이디 같은 테이블에 
**************************************************** */

-- 직원 ID가 101인 직원의 직원의 ID(emp.emp_id), 이름(emp.emp_name), 상사이름(emp.emp_name)을 조회
-- select * from emp e where emp_id = 101;
-- select emp_name as "상사이름" from emp m where m.emp_id = e.mrg_id = 100;

select e.emp_id, e.emp_name, m.emp_name as "manager name"
from   emp e join emp m on e.mgr_id = m.emp_id;




select e.emp_id, e.emp_name, m.emp_name as "manager name"
from   emp e join emp m on e.mgr_id = m.emp_id
where  e.emp_id = 100;

select * from emp where emp_id = 100;


-- 스티븐은 매니저 아이디가 없어서 나오지 않는다. 조인테이블 만들때 데이터가 없어서 나오지않는다. 
-- source 테이블, target 테이블 - 아우터 조인
-- 여기서는 소스테이블에서만 보고싶었던 것 . 
-- 추가정보 보고싶었는데 없으니 "아우터 조인" 하면 됨. 불충분 조건 


/* ****************************************************************************

외부 조인 (Outer Join)
- 불충분 조인
    - 조인 연산 조건을 만족하지 않는 행도 포함해서 합친다
종류
 left  outer join: 구문상 소스 테이블이 왼쪽.  왼쪽 테이블 다 볼거야 
 right outer join: 구문상 소스 테이블이 오른쪽. 오른쪽 테이블 다 볼거야 
 full outer join:  둘다 소스 테이블 (Mysql은 지원하지 않는다. - union 연산을 이용해서 구현).

- 구문
from 테이블a [LEFT | RIGHT] OUTER JOIN 테이블b ON 조인조건
- OUTER는 생략 가능.

**************************************************************************** */


-- 직원의 id(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 부서명(dept.dept_name), 부서위치(dept.loc)를 조회. 
-- 부서가 없는 직원의 정보도 나오도록 조회.(**모든 직원** 정보를 조회) dept_name의 내림차순으로 정렬한다.

select * from emp where dept_id is null;
-- select e.emp_id, e.emp_name, e.salary, d.dept_name, d.loc


select count(*)
from emp e join dept d on e.dept_id = d.dept_id;  
-- 102 null 인 애들은 다 빠져서 102명이 됨. 5명 빠짐. 모든 직원을 조회한다는 점에서 틀린 것. 
-- 5명까지 다 붙여주는 테이블을 만든다. 해당 안되는 곳은 비워두기. 

-- select count(*) -- 107명 다 나옴. 
select  e.emp_id, e.emp_name, e.salary, 
		d.dept_name, d.loc
from    emp e left join dept d on e.dept_id = d.dept_id
order by 4;


-- **모든 직원**의 id(emp.emp_id), 이름(emp.emp_name), 부서_id(emp.dept_id)를 조회하는데
-- 부서_id가 80 인 직원들은 부서명(dept.dept_name)과 부서위치(dept.loc) 도 같이 출력한다. (부서 ID가 80이 아니면 null이 나오도록)

select  e.emp_id, e.emp_name, e.dept_id,
		d.dept_name, d.loc
from	emp e left join dept d on e.dept_id = d.dept_id and d.dept_id = 80;
-- where   e.dept_id = 80 하게 되면 모든 직원이 안나오고 80인 애들만 나오기 때문에, 위의 문제에 맞는 문장이 아니다. 
-- and 는 두 조건이 다 True여야 성립되기 때문에, ... 
-- 그래서 left join을 해서 합친다. 

        
--  직원_id(emp.emp_id)가 100, 110, 120, 130, 140인 직원의 ID(emp.emp_id),이름(emp.emp_name), 업무명(job.job_title) 을 조회. 업무명이 없을 경우 '미배정' 으로 조회
select  e.emp_id, 
		e.emp_name, 
        ifnull(j.job_title, '미배정') as "job_title"
from  emp e left join job j on e.job_id = j.job_id
where e.emp_id in (100, 110, 120, 130, 140);
-- left 빼면 미배정인 애들은 안나옴. emp 는 다 나와야돼 


-- 부서 ID(dept.dept_id), 부서이름(dept.dept_name)과 그 부서에 속한 직원들의 수를 조회. 직원이 없는 부서는 0이 나오도록 조회하고 직원수가 많은 부서 순서로 조회.

/* *****************
-- emp 테이블에는 11개의 부서가 . 부서 테이블에는 27개의 부서가 있다. 
-- select count(distinct dept_id) from emp;
-- select count(*) from dept;

select  d.dept_id, d.dept_name,
		count(*) as "직원수" -- * 행 수를 셈. 그래서 120 부서에 아무도 없는데 1로 나온다. -- 오류임 
        -- 직원수를 세는 것이므로 emp_id를 기준으로 count 한다. 
from    dept d left join emp e on d.dept_id = e.dept_id
group by d.dept_id, d.dept_name
order by 3 desc;
****************** */


select  d.dept_id, d.dept_name,
		count(e.emp_id) as "직원수" -- emp id 를 넣어서 오류가 나지 않게 
from dept d left join emp e on d.dept_id = e.dept_id
group by d.dept_id, d.dept_name
order by 3 desc;


-- EMP 테이블에서 부서_ID(emp.dept_id)가 90 인 모든 직원들의 id(emp.emp_id), 이름(emp.emp_name), 상사이름(emp.emp_name), 입사일(emp.hire_date)을 조회. 
-- 입사일은 yyyy/mm/dd 형식으로 출력

select  e.emp_id,
		e.emp_name,
        m.emp_name as "상사이름",
        date_format(e.hire_date, '%Y/%m/%d') as "hire_date"
from  emp e left join emp m on e.mgr_id = m.emp_id -- foriegn key와 primary key가 같은 것.
where e.dept_id = 90;
-- 상사도 없는 100도 조회가 되는 것. 


-- 2003년~2005년 사이에 입사한 모든 직원의 id(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 급여(emp.salary), 입사일(emp.hire_date),
-- 상사이름(emp.emp_name), 상사의입사일(emp.hire_date), 소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회.
 
select  e.emp_id, 
		e.emp_name,
        j.job_title,
        e.salary,
        e.hire_date,
        m.emp_name as "상사이름",
        m.hire_date as "상사입사일",
        d.dept_name,
        d.loc
from emp e left join job j on e.job_id = j.job_id
		   left join emp m on e.mgr_id = m.emp_id
           left join dept d on e.dept_id = d.dept_id
where year(e.hire_date) between 2003 and 2005;

-- 상사 없는 사람도 다 나옴. 
-- 잡 타이틀, 부서가 없는 사람도 나옴





select d.*
from dept d right join emp e on d.dept_id = e.dept_id;

select e.*
from dept d right join emp e on d.dept_id = e.dept_id;

select d.*, e.emp_name, e.salary
from dept d right join emp e on d.dept_id = e.dept_id


-- left right 방향도 잘 맞춰야한다. 