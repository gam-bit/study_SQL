-- MySQL
/*
<salary> 테이블이 다음과 같이 주어집니다.
+----+------+-----+--------+
| id | name | sex | salary |
|----|------|-----|--------|
| 1  | A    | m   | 2500   |
| 2  | B    | f   | 1500   |
| 3  | C    | m   | 5500   |
| 4  | D    | f   | 500    |
+----+------+-----+--------+
문제)
Swap all f and m values (i.e., change all f values to m and vice versa) with a single update statement.
DO NOT write any select statement for this problem.
*/


update salary
set sex = case when sex = 'm' then 'f'
               else 'm' end
