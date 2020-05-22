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

-- prve, next사용
select distinct stand.num as ConsecutiveNums
       -- distinct 주의! 만약 이것 같으면 같은 숫자 여러번 나올 수 있음
from logs stand
join logs prev on stand.id = prev.id + 1
join logs next on next.id = stand.id + 1
where stand.num = prev.num and stand.num = next.num


-- next1, next2사용
select distinct stand.num as ConsecutiveNums
from logs stand
join logs next on next.id = stand.id + 1
join logs next2 on next2.id = next.id + 1
where stand.num = next.num and stand.num = next2.num
