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
--#############################################################################
/*
group by > select 순서로 sql 쿼리가 진행되지만
select에서 생성한 칼럼을 group by에서 사용할 수 있는 DB가 있다.

그러나 만약 group by에 total_earnings를 걸었을 때 쿼리에서 에러가 발생한다면
방법3과 같이 from절의 subquery를 이용해서 해결하면 된다.
*/
--#############################################################################

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
group by total_earnings  -- group by 1도 가능(첫번째 칼럼을 기준으로 group by)
order by total_earnings desc limit 1


-- 방법2) WHERE절 서브 쿼리
      -- > where 절의 비교 대상이 꼭 불러온 테이블의 칼럼일 필요는 없다.
select salary * months as total_earning, -- alias 쓰지 않아도 됨
       count(employee_id)
from employee
where salary * months = (select max(salary * months) from employee)
group by total_earning -- 대신 salary * months를 써도 됨




-- 방법2) HAVING절 서브 쿼리
select salary * months as total_earning
     , count(employee_id)
from employee
group by total_earning
having total_earning = (select max(salary * months) from employee)


-- 방법3) from절 서브 쿼리
select earning
     , count(*)
from (select months*salary as earning
      from employee) as new_table
group by earning
order by earning desc limit 1
