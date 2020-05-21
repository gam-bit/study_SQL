/*
<Employee>
+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+

<Department>
+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+

문제)
Write a SQL query to find employees who have the highest salary in each of the departments.
(순서는 중요X)

답)
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+
*/

select d2.name as Department
     , e.name as employee
     , e.salary as salary
from employee as e
     inner join (
         -- 부서id와 그에 따른 최고 임금
         select departmentid, max(salary) as max_salary
         from employee
         group by departmentid
         ) as d on e.departmentid = d.departmentid
                and e.salary = d.max_salary
     inner join department as d2
          on e.departmentid = d2.id


/*
# How to Return all rows with max values
1) 위의 경우 처럼 max가 나오는 새로운 table을 만들어서 join
2) where in (select max(column) ...)로 where절을 이용
*/

-- 방법2) where절 사용
select d.name as Department
     , e.name as employee
     , e.salary as salary
from employee e inner join department d on e.departmentid = d.id
where (e.departmentid, salary) in (select departmentid, max(salary) from employee group by departmentid)
