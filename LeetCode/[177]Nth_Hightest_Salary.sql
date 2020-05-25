/*
<Employee>
+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+

문제)
Write a SQL query to get the nth highest salary from the <Employee> table.

답)
For example, given the above Employee table, the nth highest salary where n = 2 is 200.
If there is no nth highest salary, then the query should return null.
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
*/

-- #########################################################################
-- 방법1)[MS SQL] dense_rank 사용
CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    RETURN (
        select distinct salary
        from (
            select dense_rank() over (order by salary desc) as rank
                 , salary
            from employee) t
        where @N = rank
    );
END


-- #########################################################################
-- 방법2)[MySQL] case when
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
    select case when count(salary) <> N then NULL else min(salary) end
    from (
        select distinct salary
        from employee
        order by salary desc
        limit N
        ) t
  );
END


-- #########################################################################
-- 방법3)[My SQL] if function
-- >> 조건이 1개일 때 활용
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
    select if(count(salary) <> N, NULL, min(salary))
    from (
        select distinct salary
        from employee
        order by salary desc
        limit N
        ) t
  );
END


-- #########################################################################
-- 방법4)[My SQL] limit, offset
-- >> ★제일 속도가 빠른 방법★
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  declare new_n int;
  set new_n = n-1;
  RETURN (
    select distinct salary
    from employee
    order by salary desc
    limit 1 offset new_n -- limit new_n, 1도 가능
            -- offset 뒤에 n-1과 같은 연산은 사용할 수 X. 따라서 declare로 변수를 지정해서 가져옴.
  );
END



-- #########################################################################


-- Extra) 위의 함수 사용 방법
select getNthHighestSalary(2)
