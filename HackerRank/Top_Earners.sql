/*
<Employee>
+----+------------------+
|    Column   |  Type   |
+----+------------------+
| employee_id | Integer |
|    name     | String  |
|   months    | Integer |
|   salary    | Integer |
+-------------+---------+

toal earnings = salary x months

문제)
Write a query to find the maximum total earnings for all employees
as well as the total number of employees who have maximum total earnings.

sample output)
69952 1
*/

-- 방법1)

select salary * months as total_earnings, count(*)
from employee
where total_earnings = (
select max(salary * months) as total_earnings
from employee
)

select salary * months as total_earnings,
       count(employee_id)
from employee
group by total_earnings
order by total_earnings desc limit 1


-- 방법2) WHERE절 서브 쿼리
      -- > where 절의 비교 대상이 꼭 불러온 테이블의 칼럼일 필요는 없다.
select salary * months as total_earning, -- alias 쓰지 않아도 됨
       count(employee_id)
from employee
where salary * months = (select max(salary * months) from employee)
group by total_earning -- 대신 salary * months를 써도 됨




-- 방법2) HAVING절 서브 쿼리
select salary * months as total_earning, count(employee_id)
from employee
group by total_earning
having total_earning = (select max(salary * months) from employee)
