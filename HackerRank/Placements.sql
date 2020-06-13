/*
<Students>
+------------+----------+
|   Column   |   Type   |
+------------+----------+
| ID         |  Integer |
| Name       |  String  |
+------------+----------+

<Friends> - Friend_id is the only best friend.
+------------+----------+
|   Column   |   Type   |
+------------+----------+
| ID         |  Integer |
| Friend_ID  |  Integer |
+------------+----------+

<Packages> - Salary is offered salary in $ thousands per month.
+------------+----------+
|   Column   |   Type   |
+------------+----------+
| ID         |  Integer |
| Salary     |  Float   |
+------------+----------+

문제)
Write a query to output the names of those students
whose best friends got offered a higher salary than them.
Names must be ordered by the salary amount offered to the best friends.
It is guaranteed that no two students got same salary offer.
*/
--#############################################################################
select name
from (select s.id
           , s.name
           , p1.salary student_salary
           , p2.salary friend_salary
      from students s
      join friends f on s.id = f.id
      join packages p1 on s.id = p1.id
      join packages p2 on f.friend_id = p2.id) t
where student_salary < friend_salary
order by friend_salary


--#############################################################################
-- 더 짧은 코드(From Discussions)
select s.name
from students s
join friends f on s.id = f.id
join packages p1 on s.id = p1.id
join packages p2 on f.friend_id = p2.id
where p1.salary < p2.salary
order by p2.salary
