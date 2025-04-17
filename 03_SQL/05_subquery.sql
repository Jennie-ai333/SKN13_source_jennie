
/* **************************************************************************
서브쿼리(Sub Query)
- 쿼리안에서 select 쿼리를 사용하는 것.
- 메인 쿼리 - 서브쿼리

서브쿼리가 사용되는 구
 - select절, from절, where절(비교할 값을 조회), having절
 
서브쿼리의 종류
- 어느 구절에 사용되었는지에 따른 구분
    - 스칼라 서브쿼리 - select 절에 사용. 반드시 서브쿼리 결과가 1행 1열(값 하나-스칼라) 0행이 조회되면 null을 반환
    - 인라인 뷰 - from 절에 사용되어 테이블의 역할을 한다. --> from 절은 테이블 쓰는 곳, from 절에 sub qeury를 쓴다는 것은. 안쪽의 셀렉트 문을 실행하면, 그것을 하나의 테이블로 쓰겠다. 
- 서브쿼리 조회결과 행수에 따른 구분
    - 단일행 서브쿼리 - 서브쿼리의 조회결과 행이 한행인 것.
    - 다중행 서브쿼리 - 서브쿼리의 조회결과 행이 여러행인 것. - 둘 차이는 where 절에서 연산자가 달라지는데 있다. 
- 동작 방식에 따른 구분
    - 비상관 서브쿼리 - 서브쿼리에 메인쿼리의 컬럼이 사용되지 않는다.
                메인쿼리에 사용할 값을 서브쿼리가 제공하는 역할을 한다.
    - 상관 서브쿼리 - 서브쿼리에서 메인쿼리의 컬럼을 사용한다. 
                            메인쿼리가 먼저 수행되어 읽혀진 데이터를 서브쿼리에서 조건이 맞는지 확인하고자 할때 주로 사용한다.

- 서브쿼리는 반드시 ( ) 로 묶어줘야 한다.
************************************************************************** */

-- <직원_ID(emp.emp_id)가 120번인 직원과 같은 업무(emp.job_id)를 하는> 직원의 id(emp_id),이름(emp.emp_name), 업무(emp.job_id), 급여(emp.salary) 조회


select job_id from emp where emp_id = 120; -- 120 직원을 먼저 파악해야함. 

select emp_id, emp_name, job_id, salary
from emp 
where job_id = 'ST_MAN';


/* *** 한번에 넣어버리자 *** */

select emp_id, emp_name, job_id, salary
from emp 
where job_id = (select job_id from emp where emp_id = 120); -- sub query는 반드시 소괄호로 묶어줘야함. 



-- 직원_id(emp.emp_id)가 115번인 직원과 같은 업무(emp.job_id)를 하고 같은 부서(emp.dept_id)에 속한 직원들을 조회하시오.
select job_id, dept_id from emp where emp_id=115;

select * from emp
where (job_id, dept_id) = (select job_id, dept_id from emp where emp_id=115);


-- select * from emp where (job_id, dept_id) = ("PU_MAN", 30);
-- mysql은 지원하지만 안되는 dbms도 있다. 




-- 직원의 ID(emp.emp_id)가 150인 직원과 업무(emp.job_id)와 상사(emp.mgr_id)가 같은 직원들의 
-- id(emp.emp_id), 이름(emp.emp_name), 업무(emp.job_id), 상사(emp.mgr_id) 를 조회
select emp_id, emp_name, job_id
from emp
where (job_id, mgr_id) = (select job_id, mgr_id from emp where emp_id=150);


-- 직원들 중 급여(emp.salary)가 전체 직원의 평균 급여보다 적은 직원들의 id(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary)를 조회. 

select avg(salary) from emp; -- 6517.906542

select emp_id, emp_name, salary
from emp 
where salary < (select avg(salary) from emp)
order by 3 desc;
-- avg는 select나 having 절에서 사용 가능하다 . 그래서 where salary > avg(salary) 는 안됨. 
-- 서브쿼리를 사용해야한다, 



-- 부서직원들의 평균이 전체 직원의 평균(emp.salary) 이상인 부서의 이름(dept.dept_name), 평균 급여(emp.salary) 조회.
-- 평균급여는 소숫점 2자리까지 나오고 통화표시($)와 단위 구분자 출력

select  d.dept_id, d.dept_name, avg(e.salary) as "평균급여"
from 	dept d join emp e on d.dept_id = e.dept_id
group by d.dept_id, d.dept_name -- 평균보다 높은애를 골라내야한다. 
having avg(salary) >= (select avg(salary) from emp)
order by 3;
-- 그룹단위로 하려면 having 으로 가야한다. 


select  d.dept_id, 
		d.dept_name, 
        concat('$', round(avg(e.salary),2)) as "평균급여"
from 	dept d join emp e on d.dept_id = e.dept_id
group by d.dept_id, d.dept_name -- 평균보다 높은애를 골라내야한다. 
having avg(salary) >= (select avg(salary) from emp)
order by 3;

-- concat을 넣으니 10,000이나오고 숫자가 커지고 작아지고 어쩌구됨. 
-- concat 이후로 전부 문자로 바뀜
-- 유니코드 순서대로 바뀜 
-- 이 상태에서는 해결이 안됨. 
-- 달러를 안붙이거나, 인라인뷰라는 걸 써야됨. 




/* ***********
select  d.dept_id, d.dept_name, avg(e.salary) as "평균급여"
from 	dept d join emp e on d.dept_id = e.dept_id
group by d.dept_id, d.dept_name -- 평균보다 높은애를 골라내야한다. 
having avg(salary) >= (select avg(salary) from emp)
order by 3;

얘 자체 테이블을 서브쿼리 절에 넣어준다. 
********** */


-- 최종최종 진짜 최종 -- 

select  dept_id, 
		dept_name,
        concat('$', round(평균급여, 2)) as "평균급여" -- 조회할 땐 따옴표 넣지 않는다(앞의 평균급여), 별칭에만 따옴표를 붙인다.
from (select  d.dept_id, d.dept_name, avg(e.salary) as "평균급여"
		from 	dept d join emp e on d.dept_id = e.dept_id
		group by d.dept_id, d.dept_name -- 평균보다 높은애를 골라내야한다. 
		having avg(salary) >= (select avg(salary) from emp)
		order by 3)
        as t;
        
        


--  급여(emp.salary)가장 많이 받는 직원이 속한 부서의 이름(dept.dept_name), 위치(dept.loc)를 조회.
select dept_id from emp where salary = (select max(salary) from emp);
-- 90번 부서의 이름과 위치를 조회하면 된다

select dept_name, loc
from dept
where dept_id = (select dept_id from emp where salary = (select max(salary) from emp));





-- Sales 부서(dept.dept_name) 의 평균 급여(emp.salary)보다 급여가 많은 직원들의 모든 정보를 조회.
-- dept엔 sales 부서의 이름만 아는 상황임. 급여를 모름 . 
-- emp 테이블에서는 급여만 알고 부서의 번호를 몰라서 join 해줘야됨 

/* ******
select avg(salary)
from dept d join emp e on d.dept_id = e.dept_id
where d.dept_name = 'Sales'; -- 8960.606061
****** */


select * from emp
where salary > (select avg(salary)
			from dept d join emp e on d.dept_id = e.dept_id
            where d.dept_name = 'Sales')
order by salary asc; -- 평균 8960 보다 높은 애들로다가 보여줌. 

-- 원하는걸 뽑아내고 그 다음 값으로 쓰겠다. 






-- 전체 직원들 중 담당 업무 ID(emp.job_id) 가 'ST_CLERK'인 직원들의 평균 급여보다 적은 급여를 받는 직원들의 모든 정보를 조회. 
-- 단 업무 ID가 'ST_CLERK'이 아닌 직원들만 조회. 

select * from emp
where  salary < (select avg(salary) from emp where job_id = 'ST_CLERK')
and    (job_id <> 'ST_CLERK' or job_id is null); 

-- 같은 st clerk에서도 평균보다 적게 받는 사람들이 나옴
-- null 인 사람들이 사라짐 그래서 null 도 포함해야함. 
-- or 조건 먼저! 그래서 꼭 괄호를 쳐줘야함. 


-- 업무(emp.job_id)가 'IT_PROG' 인 직원들 중 가장 많은 급여를 받는 직원보다 더 많은 급여를 받는 직원들의 id(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary)를 급여 내림차순으로 조회.

select emp_id, emp_name, salary
from emp
where salary > (select max(salary) from emp where job_id = 'IT_PROG')
order by 3 desc;


select max(salary) from emp where job_id = 'IT_PROG';


/* ----------------------------------------------
 다중행 서브쿼리
 - 서브쿼리의 조회 결과가 여러행인 경우
 - where절 에서의 연산자
	- in
	- 비교연산자 any : 조회된 값들 중 하나만 참이면 참 (where 컬럼 > any(서브쿼리) ) 
	- 비교연산자 all : 조회된 값들 모두와 참이면 참 (where 컬럼 > all(서브쿼리) ) - max값과 비교하는것과 같다. 1,2,3 중 3보다만 크면 되니까 .. 
    -----------------------------------------------*/
-- 'Alexander' 란 이름(emp.emp_name)을 가진 관리자(emp.mgr_id)의 부하 직원들의 ID(emp_id), 이름(emp_name), 업무(job_id), 입사년도(hire_date-년도만출력), 급여(salary)를 조회
select emp_id, emp_name, job_id, year(hire_date) as "입사년도", salary
from emp 
where mrg_id in (select emp_id from emp where emp_name = 'Alexander');

-- 둘 중 하나니까 in을 써서 or 연산자 처럼 쓴다. 
select emp_id, emp_name
from emp 
where emp_name = 'Alexander'; -- 103번하고 115번, 값이 두개 -- 위에 where절에 넣으면 에러가 난다. 둘 중 어느걸 원하는지 모르니까. 






--  부서 위치(dept.loc) 가 'New York'인 부서에 소속된 직원의 ID(emp.emp_id), 이름(emp.emp_name), 부서_id(emp.dept_id) 를 sub query를 이용해 조회.
select emp_id, emp_name, dept_id
from emp
where dept_id in (select dept_id from dept where loc='New York'); -- in 연산자 쓰기

-- subquery where 절의 비교 컬럼 loc 이 unique가 아닌 경우 -> 결과행이 여러개일 수 있다 
-- 다중행 sub query 연산.



-- 직원 ID(emp.emp_id)가 101, 102, 103 인 직원들 보다 급여(emp.salary)를 많이 받는 직원의 모든 정보를 조회.
select * from emp
where salary > all (select salary from emp where emp_id in (101, 102, 103));

-- all 을 이용해서 17000, 17000, 9000 보다 큰 행들만 가져오겠다. 그 중 제일 큰 것만 가져오는 셈이 되기도 함. 
-- all 을 안쓰게 되면, max 함수를 써도 된다. 

select * from emp
where salary > (select max(salary) from emp where emp_id in (101, 102, 103));


-- 직원 ID(emp.emp_id)가 101, 102, 103 인 직원들 중 급여가 가장 적은 직원보다 급여를 많이 받는 직원의 모든 정보를 조회.

select * from emp
where salary > (select min(salary) from emp where emp_id in (101, 102, 103));

select * from emp
where salary > any (select salary from emp where emp_id in (101, 102, 103));
-- 9000 이상만 조회될 것
-- 어디가 크고 어디가 작은지 보자 !!!!!! < > 똑바로 보자!!!!!!!!!! 



-- 최대 급여(job.max_salary)가 6000이하인 업무를 담당하는  직원(emp)의 모든 정보를 sub query를 이용해 조회.
select * from job -- min_salary, max_salary
where max_salary <= 6000;

select * from emp
where job_id in (select job_id from job where max_salary <= 6000);

-- 여기서 in 연산자 왜쓴다구??? 모든 직원의 정보를 알기위해 



-- 전체 직원들중 부서_ID(emp.dept_id)가 20인 부서의 모든 직원들 보다 급여(emp.salary)를 많이 받는 직원들의 정보를 sub query를 이용해 조회.

select * from emp
where salary > all (select salary from emp where dept_id = 20);
-- 13000 보다 큰 사람만 조회하면 된다. max 로 써도 됨. 


/* *************************************************************************************************
인라인 뷰(Inline View)
- from절에 서브쿼리를 사용하는 것. select 결과를 from 절에 넣는다.
- 서브쿼리 결과를 테이블처럼 사용할 수 있다. 
* *************************************************************************************************/

-- 중복된 데이터 조회 - 두 번 이상 나온 값을 조회하고싶다. 2보다 크거나 같은걸 조회하면 된다. 서브쿼리로 프롬절에 넣는다. 

-- emp에서 여러번 나오는 이름을 조회


select emp_name, count(*) as "cnt"
from emp
group by emp_name;

-- 얘를 테이블로 써서 --

select emp_name, cnt
from (
	select emp_name, count(*) as "cnt"
	from emp
	group by emp_name
    order by cnt
    ) t -- table 의 뜻. 그냥 t를 쓰는것. 가상의 테이블 as t도 가능
    where cnt >= 2;

-- 몇번 나왓는지를 count 라는 걸로 조회하겠다. 




/* *****

1. 서브쿼리가 먼저 실행
2. 바깥쿼리가 그 다음 실행 
3. 서브쿼리가 실행될때는 바깥 쿼리와 관계없이 실행된다. - 독립적으로 실행 
-- 실행시점에 독립적으로 실행되기때문에 '비상관서브쿼리'라고 함

***** */






/* *************************************************************************************************
상관 쿼리
- 메인쿼리문 테이블의 값을 where절의 subquery에서 참조한다.
	- 메인 쿼리의 각 행마다 where의 subquery가 조회 대상인지 검사하면서 실행된다. 이때 현재 검사중인 그 행의 컬럼값을 subquery에서 사용한다.

메인쿼리 5개면 서브쿼리 5번 실행된다. 
체크할때마다 메인쿼리 불러낸다. 값을 가져다가 비교할 때 쓴다. 

select 
그 중 이력테이블에 있냐 
-> 하나씩 연결되어서 보니까 상관테이블을 쓴다. 



EXISTS, NOT EXISTS 연산자 (상관쿼리와 같이 사용된다)
-- 서브쿼리의 결과를 만족하는 값이 존재하는지 여부를 확인하는 조건. 
-- 조건을 만족하는 행이 여러개라도 한행만 있으면 더이상 검색하지 않는다.

- 보통 데이터테이블의 값이 이력테이블(Transaction TB)에 있는지 여부를 조회할 때 사용된다.
	- 메인쿼리: 데이터테이블
	- 서브쿼리: 이력테이블
	- 메인쿼리에서 조회할 행이 서브쿼리의 테이블에 있는지(또는 없는지) 확인
    - 몇번있는지가 중요한게 아니고, 있냐없냐의 문제 
	
고객(데이터) 주문(이력) -> 특정 고객이 주문을 한 적이 있는지 여부
장비(데이터) 대여(이력) -> 특정 장비가 대여 된 적이 있는지 여부
************************************************************************************* */
 

-- 직원이 한명이상 있는 부서의 부서ID(dept.dept_id)와 이름(dept.dept_name), 위치(dept.loc)를 조회

-- select d.dept_id, d.dept_name, d.loc
-- from dept d -- 이건 다 조회하는 것 / dept 110번 까지만 직원이 있음. / 여기서 where절에서 어떻게 뽑아낼 것인지? 직원이 있는 부서인지 어떻게 알아?
-- where 직원이 있는 부서..

select* from emp; --  몇번 부서에 직원 있어?  emp안의 dept_id 를 찾고 조회 
-- 번호를 하나하나씩 10, 20, 있어?물어보면서 조회 
-- 120 까지 조회, 없다고 나옴. select * from emp e where e.dept_id = 120 
-- 상관커리 


select d.dept_id, d.dept_name, d.loc
from dept d;

/* *****

10넣고 체크, 20넣고 체크. 한행씩 특정값을 서브쿼리에 넣어서 체크
메인쿼리에서 직원 있는 행인지 확인하기 위해서
그러기위해선 매행마다 실행이 되어야한다. 

****** */

select d.dept_id, d.dept_name, d.loc
from dept d -- d는 where절 안에 있는 서브쿼리에서 한행씩 실행한다 
where exists(select * from emp e where e.dept_id = d.dept_id); -- 마지막 d.dept_id에 뭐 들어가는지 알고있어야한다 .

-- subquery 에서 main query의 table을 사용하도록 정의하면 상관커리. 

/* ******
select *
from dept d
where exists (select * from emp where dept_id = d.dept 
뒤의 d.dept 안에 id 를 넣어서 True False 체크. 
... 한행씩 체크할때 where 뒤의 구문 안에다가. d.dept_id 를 체크하겠다. 


직원이 한명이라도 있는 거 있냐 없냐를 보는 거니까 -- > exists를 쓴다. 

추가적인 성격)

부서가 예를 들어 90번 부서라면, 
서브쿼리에 90번을 넣고 e.dept_id가 90인 걸 체크
표에 첫번째 이미 있다. -->. 있으면 됐다. 몇개있는지는 체크안해 
exists는 바로 True로 return함

만약 dept_id 가 100인것을 조회... 나올때까지 
100이 나오면 where 절을 끝내고 앞에 쿼리를 실행함. 

있냐없냐를 볼때 사용한다. 고객이 주문 한 적이 있는지 여부, 대여를 한 적이 있는지 여부 확인
이력 : 데이터가 부서가 되는것이고, 참조하는게 직원. 직원이 있어없어가 됨 
고객데이터가 pk 부모테이블이고
주문이력이 fk 자식테이블이 된다. 

추가적으로 exists는 서브쿼리 실행결과 하나라도 나오면 실행을 멈춘다. 
반대는 not exists

****** */ 


-- 직원이 한명도 없는 부서의 부서ID(dept.dept_id)와 이름(dept.dept_name), 위치(dept.loc)를 조회

select d.dept_id, d.dept_name, d.loc
from dept d -- d는 where절 안에 있는 서브쿼리에서 한행씩 실행한다 
where not exists(select * from emp e where e.dept_id = d.dept_id);


