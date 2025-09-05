use hr1;

-- 1. 부서별 인원수를 출력하세요.

select department_id, count(employee_id) as '인원수'
from employees
group by department_id;

-- 2. IT 부서에서 일하는 직원의 first_name, last_name, salary 를 이름으로 출력하시요. 출력결과는 salary 가 낮은 사람부터 출력하시요. 

select e.first_name, e.last_name, e.salary 
from employees e
	join departments d on e.department_id = d.department_id
where d.department_name = 'IT'
order by salary ASC;

-- 3. 각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 업무명(job_title), 부서명(department_name)를 조회하시오. 
-- 단 도시명(city)이 ‘Seattle’인 지역(location)의 부서(department)에 근무하는 직원만 출력하시오.

select e.employee_id, e.first_name, j.job_title, d.department_name
from employees e
	join departments d on d.department_id = e.department_id
    join locations l on l.location_id = d.location_id
    join jobs j on j.job_id = e.job_id
where l.city = 'Seattle';

-- 4. 각 직책 별(job_title)로 급여의 총합을 구하되 직책이 Representative 인 사람은 제외하십시오. 
-- 단, 급여 총합이 30000 초과인 직책만 나타내며, 급여 총합에 대한 오름차순으로 정렬하십시오. 출력 결과의 컬럼명은 아래 결과와 동일하게 주십시오.

select j.job_title ,sum(e.salary) as '급여의 총합'
from employees e
	join jobs j on e.job_id = j.job_id
where e.manager_id is not null
group by j.job_title
having sum(e.salary)>30000;

-- 5. 각 부서 이름 별로 2005년 이전에 입사한 직원들의 인원수를 조회하시오.
select d.department_name as '부서이름', count(e.employee_id) as '인원 수'
from employees e
	join departments d on e.department_id = d.department_id
where e.hire_date < '2005-01-01'
group by d.department_name
order by d.department_name;

-- 5. 사원수가 3명 이상의 사원을 포함하고 있는 부서의 부서번호(department_id), 부서이름(department_name), 사원 수, 최고급여, 최저급여, 평균급여, 급여총액을 조회하여 출력하십시오. 
-- 출력 결과는 부서에 속한 사원의 수가 많은 순서로 출력하세요. (평균급여 계산시 소수점 이하는 버리시오)
select * from jobs;

select d.department_id as '부서 번호',
d.department_name as '부서이름',
count(e.employee_id) as '사원 수',
max(e.salary) as '최고 급여',
min(e.salary) as '최저 급여',
format(avg(e.salary),0) as '평균 급여',
sum(e.salary) as '급여 총액'
from employees e
	join departments d  on e.department_id = d.department_id
group by d.department_id
having count(e.employee_id)>=3
order by count(e.employee_id) DESC;

-- 6. Employees 테이블에서 입사일자(hire_date)에 따라 
-- 2005년 입사한 직원들 가운데 first_name이 'Lisa'인 직원보다 빨리 입사한 직원의 
-- 사번(employee_id), 이름(first_name), 성(last_name), 입사일자(hire_date)를 조회하는 SQL 문장을 서브쿼리로 작성하세요.

select employee_id as '사번', first_name as '이름', last_name as '성', hire_date as '입사일자'
from employees
where first_name = 'Lisa'
and hire_date < (select hire_date from employees where (hire_date between '2005-01-01' and '2005-12-31'));



