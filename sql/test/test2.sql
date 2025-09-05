use hr1;

-- 문제 1: 모든 사원은 직속 상사 및 직속 직원을 갖는다. 단, 최상위 또는 최하위 직원은 직속 
-- 상사 및 직원이 없다. 소속된 사원들 중 어떤 사원의 상사로 근무 중인 사원의 총 수를 출력하시오
select * from employees;
select count(distinct manager_id) as 'count managers'
from employees;

-- 문제 2: 각 사원이 소속된 부서별로 급여 합계, 급여 평균, 급여 최대값, 급여 최소값을 집계하고자 한다.
-- 계산된 출력값은 6자리와 세 자리 구분기호, $ 표시와 함께 출력하고 부서번호의 오름
-- 차순 정렬하시오. 단, 부서에 소속되지 않은 사원에 대한 정보는 제외하고 출력시 머리글은 아래 
-- 예시처럼 별칭(alias) 처리하시오

select department_id, concat('$', format(sum(salary), 0)) as 급여합계,
concat('$', format(avg(salary), 1)) as 급여평균,
concat('$', format(max(salary), 0)) as 최대급여,
cconcat('$', format(min(salary), 0)) as 최소급여
from employees
where department_id is not null
group by department_id
order by department_id ASC;

-- 문제3: 사원들의 업무별 전체 급여 평균이 $10,000보다 큰 경우를 조회하여 업무, 급여 평균을 
-- 출력하시오. 단 업무에 사원(CLERK)이 포함된 경우는 제외하고 전체 급여 평균이 높은 순서대로 
-- 출력하시오
select job_id, format(avg(salary),1) as 'avg salary'
from employees
where job_id not like '%CLERK%'
group by job_id
having avg(salary)>10000
order by avg(salary) desc; 

