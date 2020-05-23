/*
<Logs>
+----+-----+
| Id | Num | prevId | nextId
+----+-----+
| 1  |  1  | Null | 2
| 2  |  1  | 1    | 3
| 3  |  1  | 2    | 4
| 4  |  2  | 3
| 5  |  1  | 4
| 6  |  2  | 5
| 7  |  2  | 6
+----+-----+


문제)
Write a SQL query to find all numbers that appear at least three times consecutively.
연속적으로 3번 이상 나타나는 숫자를 모두 찾는 쿼리를 작성해라.

정답)
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
*/

--######################################################################
-- join
-- >> prve, next사용
select distinct stand.num as ConsecutiveNums
       -- distinct 주의! 만약 이것 같으면 같은 숫자 여러번 나올 수 있음
from logs stand
join logs prev on stand.id = prev.id + 1
join logs next on next.id = stand.id + 1
where stand.num = prev.num and stand.num = next.num


-- >> next1, next2사용
select distinct stand.num as ConsecutiveNums
from logs stand
join logs next on next.id = stand.id + 1
join logs next2 on next2.id = next.id + 1
where stand.num = next.num and stand.num = next2.num


--#######################################################################
-- [My SQL|MS SQL]window function
-- >> lag/lead 둘 다 사용 가능
-- >> lag(이전 데이터 가져오기)/lead(이후 데이터 가져오기)

select distinct num as ConsecutiveNums
from (
    select num
         , lag(num, 1) over (order by id) as lag1
         , lag(num, 2) over (order by id) as lag2
    from logs
) as logs_dash
where num = lag1
and num = lag2


-- >> rank 사용
select department
     , employee
     , salary
from (
    select e.name as employee
         , d.name as department
         , e.salary as salary
         , rank() over (partition by d.name order by e.salary desc) as salary_rank
    from employee as e
        inner join department as d on e.departmentid = d.id
) ms
where ms.salary_rank = 1
