/*
# 문제)
Write a SQL query to delete all duplicate email entries in a table named <Person>,
keeping only unique emails based on its smallest Id.

<Person>
+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
- Id : Primary key column

# 답)
위의 query를 실행하면 <Person>은 다음과 같아진다.:
+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+

*/
-- ####################################################################

-- # HINT. 남겨야 되는 것을 어떻게 뽑아낼지 먼저 select문으로 써보기

-- 방법1) 서브쿼리
-- 1-1)
delete from Person
      where id not in (select min(P.id) from (select * from Person) as P group by email)
      -- # 주의! 서브쿼리에는 쿼리에 사용된 테이블을 그대로 가져다 사용할 수 없다.


-- 1-2)
delete from Person
where id not in (
select sub.min_id
from (
    select email, min(id) as min_id
    from Person group by email) as sub)


-- ####################################################################

-- 방법2) join (★헷갈림)

delete p1
from person p1 join person p2 on p1.email = p2.email
where p1.id > p2.id  -- 해당 조건을 만족하는 id가 있는 record를 지움(id=3)
