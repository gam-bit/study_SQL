/*
+---------+---------+----------+----------+
|    id   | student |  id + 1  |  id - 1  |
+---------+---------+----------+----------+
|    1    | Abbot   | >  2     |    0     |
|    2    | Doris   |    3     | >  1     |
|    3    | Emerson | >  4     |    2     |
|    4    | Green   |    5     | >  3     |
|    5    | Jeames  | >  6     |    4     |
+---------+---------+----------+----------+
*/
-- select 절에 있는 subquery에 from을 쓰지만
-- 쿼리의 from에 있는 테이블과 구분할 수 있다.


-- step 1)마지막 row의 id가 홀수이면 자기 자신
-- step 2)홀수 id -> id+1 짝수로 변경
-- step 3)짝수 id -> id-1 홀수로 변경


select case when id % 2 = 1 and id = (select count(*) from seat) then id
            when id % 2 = 0 then id - 1
            when id % 2 = 1 then id + 1 end as id
     , student
from seat
order by id
