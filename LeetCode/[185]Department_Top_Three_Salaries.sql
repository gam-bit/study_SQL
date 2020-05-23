/*
[MS SQL]

<employee>
+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 85000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
| 7  | Will  | 70000  | 1            |
+----+-------+--------+--------------+

<department>
+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+

문제)
Write a SQL query to find employees who earn the top three salaries in each of the department.
For the above tables, your SQL query should return the following rows
(order of rows does not matter).

답)
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Randy    | 85000  |
| IT         | Joe      | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+
*/

select sr.department
     , sr.employee
     , sr.salary
from (
    select d.name as department
         , e.name as employee
         , e.salary as salary
         , dense_rank() over (partition by d.id order by e.salary desc) as salary_rank
           -- 여기에서 rank쓰면 공동 1, 2등이 있는 경우 2 or 3등이 없을 수도 있음
    from employee as e
    inner join department as d on e.departmentid = d.id
) sr
where sr.salary_rank <= 3
