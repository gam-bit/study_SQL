/*
<Employee>
+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+

문제)
Write a SQL query to get the second highest salary from the <Employee> table.

답)
For example, given the above Employee table,
the query should return 200 as the second highest salary.
If there is no second highest salary, then the query should return null.
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
*/

--##########################################################################
-- 정답)
select case when count(*) = 2 then min(salary) else null end as SecondHighestSalary
from (
    select distinct salary
    from employee
    order by salary desc limit 2
) t


--##########################################################################
-- 틀린 답) 만약 아래와 같이 쓰면
select case when denserank = 2 then salary else null end as SecondHighestSalary
from (
    select salary
         , dense_rank() over (order by salary desc) as denserank
    from employee) t

-- 결과는 다음과 같다
/*
["SecondHighestSalary"]
[[null], [200], [null]]}
*/
--##########################################################################
