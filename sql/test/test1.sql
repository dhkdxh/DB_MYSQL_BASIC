use hr1;

-- 문제1
select 
employee_id AS '사원번호', 
concat(first_name, ' ', last_name) as 이름, 
salary as 급여, 
job_id as 업무, 
hire_date as 입사일, 
manager_id as '상사의 사원번호'
from employees;


desc employees;

-- 문제2
select
concat(first_name, ' ', last_name) as Name,
job_id as Job,
salary as Salary,
12*salary+100 as 'Increased Ann_Salary',
(salary+100)*12 as 'Increased Salary'
from Employees;

-- 문제3
select 
concat(last_name, ': 1 Year Salary = $', salary*12) as '1 Year Salary'
from employees;

-- 문제4
select distinct department_id, job_id
from employees;

-- 문제5
select concat(first_name,' ',last_name) as Name, salary
from employees
where salary not between 7000 and 10000
order by salary ASC, first_name desc;

-- 문제6
select last_name as 'e and o Name'
from employees
where last_name like '%e%' and last_name like '%o%';

-- 문제7

select concat(first_name,' ',last_name) as Name, employee_id, hire_date
from employees
where hire_date between STR_TO_DATE('1995-05-20', '%Y-%m-%d') and STR_TO_DATE('1996-05-20', '%Y-%m-%d')
order by hire_date ASC ;

-- 문제8
select employee_id, department_id, job_id, commission_pct from employees;

select concat(first_name, ' ', last_name) as Name, salary, job_id, commission_pct
from employees
where commission_pct is not null
order by salary DESC, commission_pct DESC;
