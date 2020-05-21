/*
테이블이 2개 주어져있다.
<Students>
+----+------------------+
|   Column   |   Type   |
+----+------------------+
|     ID     |  Integer |
|    Name    |  String  |
|    Marks   |  Integer |
+----+------------------+

<Grades>
+------------+----------+-----+
| Grade | Min_Mark | Max_Mark |
+------------+----------+-----+
| 1     | 0        | 9        |
| 2     | 10       | 19       |
| 3     | 20       | 29       |
| ...  | ...       | ...      |
| 10   | 90        | 100      |
+------------+----------+-----+

문제)
Generate a report cotaining 3 columns: Name, Grade and Mark.
Mask the names of those students who received a grade lower than 8.(NULL)
grade를 기준으로 내림차순 정리하고, -- i.e. higher grades are entered first.
grade(8-10) 같으면 이름의 알파벳 순으로 정렬해라.
grade(1-7) 같으면 marks의 오름차순으로 정렬해라.
*/

select case when g.grade < 8 then NULL
            else s.name end as name
     , g.grade as grade
     , s.marks as mark
from students s
left join grades g
on s.marks between g.min_mark and g.max_mark
order by grade desc, name, mark
                     -- grade가 8보다 작은 경우에는 이름이 모두 NULL이라 mark로 다시 정렬하는 것임
