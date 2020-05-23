/*
<hackers>
+----+------------------+
|   Column   |   Type   |
+----+------------------+
| hacker_id  |  Integer |
|    Name    |  String  |
+----+------------------+

<challenges>
+----+------------------+
|   Column   |   Type   |
+----+------------------+
|challenge_id|  Integer |
| hacker_id  |  Integer |
+----+------------------+


문제)
쿼리를 다음과 같이 작성하라.
- hacker_id, name, and the total number of challenges created by each student
- sort your results by the total number of challenges in descending order
- If more than one student created the same number of challenges,
  then sort the result by hacker_id.
- If more than one student created the same number of challenges and
  the count is less than the maximum number of challenges created,
  then exclude those students from the result.



*/
-- # step
-- 1. hacker_id에 따라 # challenges를 구하기
-- 2-1. # challenges = max(# challenges) -> include
-- 2-2. 2가 아닌 것 중, # challenges가 중복되면 -> exclude


select h.hacker_id
     , h.name
     , count(*) challenges_created
from challenges c
    inner join hackers h on c.hacker_id = h.hacker_id
group by h.hacker_id, h.name
having challenges_created = (select max(challenges_created)
                            from (
                                select hacker_id
                                     , count(*) as challenges_created
                                from challenges
                                group by hacker_id
                            ) sub1)
or challenges_created not in (select challenges_created
                            from (
                                select hacker_id
                                     , count(*) as challenges_created
                                from challenges
                                group by hacker_id
                            ) sub2
                            group by challenges_created
                            having count(*) > 1)
order by challenges_created desc, hacker_id


-- having을 사용하지 않고 엄청 깊고 많은 서브쿼리를 사용했었음.
-- *group by를 이용해서 만들어진 칼럼에 대한 조건은 having을 사용한다는 점 기억하기*
-- 구조를 먼저 잡고 시작할 것!



--#############################################################################
-- [MS SQL] with문
-- >>위의 쿼리를 보면 같은 쿼리가 계속 반복되고 있음(challenges_created 정의하는 쿼리)
-- >>이런 경우에는 with문을 사용! 여러번 재사용이 가능함
with counter as (
    select hackers.hacker_id
         , hackers.name
         , count(*) as challenges_created
    from challenges
        inner join hackers on challenges.hacker_id = hackers.hacker_id
    group by hackers.hacker_id, hackers.name
)

select hacker_id
     , name
     , challenges_created
from counter
where challenges_created = (select max(challenges_created)
                            from counter)
or challenges_created in (select challenges_created
                          from counter
                          group by challenges_created
                          having count(*) = 1)
order by challenges_created desc, hacker_id
