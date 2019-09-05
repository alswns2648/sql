-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select count(emp_no)
from salaries 
where salary > (select avg(salary)
				from salaries
                where to_date = '9999-01-01')
and to_date = '9999-01-01';

-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 
-- 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
select d.dept_name as 부서, a.emp_no as 사번, concat(a.first_name, ' ', a.last_name) as 이름, b.salary as '부서 연봉'
    from employees a,
         salaries b,
         dept_emp c,
         departments d,
         (select c.dept_no, max(b.salary) as 최고급여 
	      from employees a, salaries b, dept_emp c, departments d
             where a.emp_no = b.emp_no
               and a.emp_no = c.emp_no
               and c.dept_no = d.dept_no
               and b.to_date = '9999-01-01'
               and c.to_date = '9999-01-01'
          group by c.dept_no) e
   where a.emp_no = b.emp_no
     and a.emp_no = c.emp_no
     and c.dept_no = d.dept_no
     and d.dept_no = e.dept_no
     and b.salary = e.최고급여
     and b.to_date = '9999-01-01'
     and c.to_date = '9999-01-01'
group by d.dept_name
order by b.salary desc;

-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
select c.dept_no as 부서, a.emp_no as 사번, concat(a.first_name, ' ', a.last_name)as 이름, salary as 연봉
from employees a, salaries b, dept_emp c, (select avg(b.salary) as 부서평균급여, c.dept_no as 부서번호
										from employees a, salaries b, dept_emp c
										where a.emp_no = b.emp_no
                                        and a.emp_no = c.emp_no
										and b.to_date = '9999-01-01'
										and c.to_date = '9999-01-01'
										group by c.dept_no) d
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and d.부서번호 = c.dept_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and b.salary > d.부서평균급여;

-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
select  a.emp_no as 사번, concat(a.first_name, ' ', a.last_name) as 이름, e.name as '매니저 이름', dept_name as '부서 이름'
from employees a, dept_emp c, departments d, 
		( select concat(a.first_name, ' ', a.last_name) as name, d.dept_no as 현매니저
		  from employees a, dept_manager dm, departments d
          where a.emp_no = dm.emp_no
          and dm.dept_no = d.dept_no
          and dm.to_date = '9999-01-01') e
where a.emp_no = c.emp_no
  and c.dept_no = d.dept_no
  and e.현매니저 = c.dept_no
  and c.to_date = '9999-01-01';

-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select a.emp_no as 사번, concat(a.first_name, ' ', a. last_name) as 이름, title as 직책, c.salary as 연봉
from employees a, titles b, salaries c, dept_emp d, departments e,
( select e.dept_no
	from employees a, salaries c, dept_emp d, departments e
    where a.emp_no = c.emp_no
    and a.emp_no = d.emp_no
    and d.dept_no = e.dept_no
    and c. to_date = '9999-01-01'
    and d. to_date = '9999-01-01'
    group by dept_no
    order by avg(c.salary) desc
    limit 0,1)f
where a.emp_no = c.emp_no
	and a.emp_no = b.emp_no
    and a.emp_no = d.emp_no
    and d.dept_no = e.dept_no
    and f.dept_no = d.dept_no
    and b. to_date = '9999-01-01'
    and c. to_date = '9999-01-01'
    and d. to_date = '9999-01-01'
order by c.salary desc;
    
-- 문제6.
-- 평균 연봉이 가장 높은 부서는?
	 select d.dept_name
      from departments d, (select d.dept_no
	  from employees a, salaries b, dept_emp c, departments d
      where a.emp_no = c.emp_no
      and c.dept_no = d.dept_no
      and a.emp_no = b.emp_no
      group by d.dept_no
      order by avg(b.salary) desc
      limit 0,1) a
	 where a.dept_no = d.dept_no;

-- 문제7.
-- 평균 연봉이 가장 높은 직책?
select b.title as 직책
			    from employees a, titles b, salaries c
                where a.emp_no = b.emp_no
                and a.emp_no = c.emp_no
                group by b.title
                order by avg(c.salary) desc
                limit 0,1;
-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
select d.dept_name as 부서이름, a.last_name as 이름, b.salary 연봉, col.이름 as '매니저 이름', col.연봉 as '매니저 연봉'
from employees a, salaries b, dept_emp c, departments d, 
     (select concat(a.first_name, ' ', a. last_name) as 이름, e.dept_no as 매니저, b.salary as 연봉
      from employees a, departments d, dept_manager e, salaries b
      where a.emp_no = e.emp_no
      and a.emp_no = b.emp_no
      and b.to_date = '9999-01-01'
      and e.dept_no = d.dept_no
      and e.to_date = '9999-01-01'
      )col
where a.emp_no = b.emp_no
	and a.emp_no = c.emp_no
    and c.dept_no = d.dept_no
      and b.to_date = '9999-01-01'
      and c.to_date = '9999-01-01'
      and col.매니저 = c.dept_no
      and b.salary > col.연봉;