-- upper
-- 1. 자바 upperCase보다 DB의 upper() 함수 가 훨씬 빠르다.
-- 2. 웬만한 DB에서 문자열 처리뿐만 아니라 포맷팅 처리등을 다 해주고
--     자바에서 출력만 해결한다.
-- 3. 자바 코드가 간결해서 좋다.
select upper('SeouL'), ucase('seoul');
select upper(first_name) from employees;

-- lower
select lower('SEoul'), lcase('SEOUL');

-- substring()
select substring('Happy Day', 3, 2);

select first_name as '이름',
       substring(hire_date, 1, 4) as '입사년도'
  from employees;

-- lpad, rpad : 정렬
select lpad('1234', 10, '-');
select rpad('1234', 10, '-');

-- ex1) salaries 테이블에서 2001년 급여가 70000불 이하의 직원만 
--      사번, 급여로 출력하되 급여는 10자리로 부족한 자리수는 *로 표시
select emp_no, lpad(cast(salary as char), 10, '*')
  from salaries
 where from_date like '2001%'
   and salary < 70000;
   
-- ltrim, rtirm, trim
select concat('---', ltrim('    hello    '), '---') as 'LTRIM',
       concat('---', rtrim('    hello    '), '---') as 'RTRIM',
       concat('---', trim('    hello    '), '---') as 'TRIM',
       concat('---', trim(both 'x' from 'xxxxxhelloxxxxx'), '---') as 'TRIM2',
       concat('---', trim(leading 'x' from 'xxxxxhelloxxxxx'), '---') as 'TRIM3',
       concat('---', trim(trailing 'x' from 'xxxxxhelloxxxxx'), '---') as 'TRIM4'
       






