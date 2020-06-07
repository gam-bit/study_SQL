/*
X city built a new stadium, each day many people visit it
and the stats are saved as these columns: id, visit_date, people

Please write a query to display the records which have 3 or more consecutive rows
and the amount of people more than 100(inclusive).

<stadium>
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 1    | 2017-01-01 | 10        |
| 2    | 2017-01-02 | 109       |
| 3    | 2017-01-03 | 150       |
| 4    | 2017-01-04 | 99        |
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-08 | 188       |
+------+------------+-----------+

output)
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-08 | 188       |
+------+------------+-----------+
*/
--############################################################################
-- <나의 풀이> lead, lag 사용
select id
     , visit_date
     , people
from (select id
           , visit_date
           , people
           , lag(people, 1) over (order by visit_date) as lag1
           , lag(people, 2) over (order by visit_date) as lag2
           , lead(people, 1) over (order by visit_date) as lead1
           , lead(people, 2) over (order by visit_date) as lead2
      from stadium ) t
where (people>=100 and lag1>=100 and lag2>=100)
   or (people>=100 and lag1>=100 and lead1>=100)
   or (people>=100 and lead2>=100 and lead1>=100)

--#############################################################################
-- solution using self join
select distinct s1.*
from stadium s1
join stadium s2
join stadium s3
on ((s1.id = s2.id - 1 and s1.id = s3.id - 2)  -- s1.id가 맨 앞인 경우
   or (s1.id = s2.id + 1 and s1.id = s3.id - 1) -- s1.id가 중간인 경우
   or (s1.id = s2.id + 1 and s1.id = s3.id + 2)) -- s1.id가 마지막인 경우
where s1.people >= 100 and s2.people >= 100 and s3.people >= 100
order by s1.id
