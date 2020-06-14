/*
<functions>
+--------+----------+
| Column |   Type   |
+--------+----------+
|   x    |  Integer |
|   y    |  Integer |
+--------+----------+

Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs
if X1 = Y2 and X2 = Y1.

문제)
Write a query to output all such symmetric pairs
in ascending order by the value of X.
*/
-- ############################################################################

select *
from (select case when x <= y then x else y end a
           , case when x <= y then y else x end b
      from functions) t
group by a, b
having count(*) > 1
order by a, b
