/*
<bst>
+----+-------+
|  N  |  P   |
+----+-------+
|  1  |  2   |
|  3  |  2   |
|  6  |  8   |
|  9  |  8   |
|  2  |  5   |
|  8  |  5   |
|  5  | null |
+-----+------+
*/

-- step1) p가 null이면 Root
-- step2) n에 존재하고 p에도 존재하는 node는 inner
-- step3) n에 존재하고 p에는 존재하지 않는 node는 leaf

select N
     , case when (p is null) then 'Root'
            when (select count(*) from bst where b.n=p) > 0 then 'Inner' else 'Leaf' end
from bst b
order by N




/*
select 절에서 사용되는 서브쿼리의 예) 연습 할 것 

select player_name
     , height
     , (select avg(height) from player p where p.team_id = x.team_id) as avg_height
from player x

==
(MS SQL의 window function 활용 가능)
select player_name
     , height
     , avg(height) over (partition by team_id)
from player
*/
