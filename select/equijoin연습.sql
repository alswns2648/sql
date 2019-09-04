-- 1)현재 회사 상황을 반영한 직원별 근무부서를  사번, 직원 전체이름, 근무부서 형태로 출력해 보세요
select a.emp_no as 사번, 
		concat(a.first_name, ' ', a.last_name)as '직원 전체이름', 
		c.dept_name as 근무부서
  from employees a, dept_emp b, departments c
 where a.emp_no = b.emp_no
   and b.dept_no = c.dept_no
   and b.to_date = '9999-01-01';

-- 2)현재 회사에서 지급되고 있는 급여체계를 반영한 결과를 출력하세요. 사번,  전체이름, 연봉  이런 형태로 출력하세요.    
select a.emp_no as 사번, 
		concat(a.first_name, ' ', a.last_name)as 전체이름, 
		b.salary as 연봉
  from employee a, salaries b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
order by b.salary desc;