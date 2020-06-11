/*
-- Challenges에서 연결되는 문제
-- but, 개별적인 문제로 봐도 상관없음
The total score of a hacker is
the sum of their maximum scores for all of the challenges.
(∵같은 challenge에서 여러번 submission)
Write a query to print the hacker_id, name,
and total score of the hackers ordered by the descending score.
If more than one hacker achieved the same total score,
then sort the result by ascending hacker_id.
Exclude all hackers with a total score of 0 from your result.
(score=0 있음)

<hackers>
+------------+---------+
|   Column   |   Type   |
+------------+---------+
| hacker_id  |  Integer |
|    Name    |  String  |
+------------+---------+

<submissions>
+--------------+----------+
|     Column   |   Type   |
+--------------+----------+
| submission_id|  Integer |
|  hacker_id   |  Integer |
| challenge_id |  Integer |
|     score    |  Integer |
+--------------+----------+
*/
--############################################################################
-- hacker_id, challenge_id 별로 max score 구한 table
-- hackers 테이블을 join해서 name 칼럼 가져오기

select h.hacker_id
     , h.name
     , sum(t.max_score) as total_score
from (select hacker_id
           , challenge_id
           , max(score) as max_score
      from submissions s
      group by hacker_id, challenge_id) t
join hackers h on t.hacker_id = h.hacker_id
group by h.hacker_id, h.name
having sum(t.max_score) > 0
order by total_score desc, hacker_id
