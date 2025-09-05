use hr1;

-- HR 데이터베이스 

select * from countries;

-- 1. 모든 사원의 이름을 조회하세요
select concat(first_name, ' ', last_name) as name from employees;
-- 2. 모든 사원의 모든 정보를 조회하세요
select * from employees;
-- 3. 모든 도시명을 조회하세요 
select country_name from countries;
-- 4. 이름(first_name)이 'M'으로 시작하는 사원의 모든 정보를 조회하세요
select * from employees where first_name like 'M%';
-- 5. 이름(first_name)의 두번째 글자가 'a'인 사원의 이름(first_name)과 연봉을 조회하세요
select first_name, salary from employees where first_name like '_a%';
-- 6. 도시명을 오름차순 하세요 
select city from locations order by city ASC;

-- 7. 부서명을 내림차순 정려하여 조회하세요 
select department_name from departments order by department_name DESC;
-- 8. 연봉이 7000이상인 사원들의 모든 정보를 연봉순(오름차순)으로 정렬하세요
select *
from employees
where salary >= 7000
order by salary ASC;
-- 9. 인센티브(COMMISSION_PCT)를 받지 않는 사원들의 모든 정보를 조회하세요
select *
from employees
where commission_pct is null;
-- 10. 2007년 06월 21일에 입사한 사원의 사원번호, 이름 , 부서번호를 조회하세요 
select employee_id, concat(first_name,' ', last_name), department_id
from employees
where hire_date = str_to_date('2007-06-21', '%Y-%m-%d');
-- 11. 2006년 입사한 사원의 사원번호와 입사일을 조회하세요 
select employee_id, str_to_date(hire_date, '%Y-%m-%d')
from employees
where hire_date like '2006%';

-- 12. 이름의 길이가 5글자 이상인 사원을 조회하세요
select *
from employees
where length(last_name) >=5;

-- 13. 부서별 사원 수를 조회하고 부서번호로 오름차순 정렬하세요
select department_id, count(employee_id) as '사원 수'
from employees
group by department_id
order by department_id ASC;
-- 14. 직무별 평균 연봉을 조회하고 직무아이디로 내림차순 정렬하세요 
select job_id, avg(salary*12) as '평균 연봉'
from employees
group by job_id
order by job_id DESC;

-- 15. 상사가 있는 사원들의 모든 정보를 조회하세요 
select * 
from employees
where manager_id is not null;

select * from departments;

-- 16. 모든 사원들의 사원번호, 이름, 부서번호, 부서명을 조회하세요 
select employee_id as '사원번호', concat(first_name, ' ', last_name) as '이름', departments.department_id as '부서번호', departments.department_name as '부서명'
from employees, departments
where employees.department_id = departments.department_id;

-- 17. 모든 부서의 부서명과 도시명을 조회하세요 

select department_name, locations.city
from departments, locations
where locations.location_id = departments.location_id;

-- 18. 모든 사원들의 사원번호, 부서명, 직무명(Job_title)을 조회하세요 

select employee_id, departments.department_name, jobs.job_title
from employees, departments, jobs
where employees.department_id = departments.department_id and 
employees.job_id = jobs.job_id;

-- 19. 모든 사원들의 사원번호, 부서명,  근무직무명,하는 도시명을 조회하세요 

select employee_id, d.department_name, j.job_id, l.city
from employees e
	join departments d on d.department_id = e.department_id
    join jobs j on j.job_id= e.job_id
    join locations l on d.location_id = l.location_id;

-- 20. 부서번호가 10,20,30 번 부서에서 근무하는 사원들의 모든 정보를 조회하세요 

select *
from employees
where department_id in (10,20,30);

-- 21. 4인 미만의 사원이 근무하는 부서의 평균연봉과 부서명을 조회하세요 

select avg(e.salary*12) as '평균연봉', d.department_name
from employees e, departments d
where d.department_id = e.department_id
group by d.department_id
having count(e.employee_id) < 4;

-- 22.  6인 미만의 사원이 근무하는 부서의 이름을 조회하세요 
select d.department_name as '부서이름'
from employees e, departments d
where e.department_id = d.department_id
group by d.department_id
having count(e.employee_id)<6;

-- 23. IT 부서의 연봉 총합을 조회하세요 

select sum(e.salary*12) as '연봉총합'
from employees e, departments d
where d.department_id = e.department_id and d.department_name = 'IT'
group by e.department_id;

-- 24. REGIONS 별 도시의 개수를 조회하세요 

select region_id, count(country_id) as '도시 개수'
from countries
group by region_id;

-- 25. 도시별 부서의 개수를 조회하세요  

select location_id ,count(department_id) as '부서 개수'
from departments
group by location_id;

-- 26. 연봉이 12000이상이 되는 직원들의 LAST_NAME 및 급여를 조회하세요 

select last_name, salary
from employees
where salary*12 >= 12000;

-- 27. 사원 번호가 176번인 사람의 LAST_NAME 및 부서명을 조회하세요 

select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id and employee_id = 176;

-- 28. 연봉이 5000 에서 12000 의 범위 이외인 사원들의 last_name 과 급여를 조회하세요 

select last_name, salary
from employees
where salary*12 between 5000 and 12000;

-- 29. 직속상사(manager_id)가 없는 사람들의 last_name과 부서명을 조회하세요 

select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id and e.manager_id is null;

-- 30. 커미션을 받는 사원들의 이름(full name), 급여, 커미션 내역을 조회하세요 

select concat(first_name,' ',last_name) as '이름', salary, commission_pct as '커미션 내역'
from employees
where commission_pct is not null;