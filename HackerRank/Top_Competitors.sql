/*
<hackers> - hacker 정보
+-------------+---------+
|    Column   |  Type   |
+-------------+---------+
|  hacker_id  | Integer | **
|    name     | String  | **
+-------------+---------+

<difficulty> - challenge 난이도에 따른 점수
+-------------------+---------+
|       Column      |  Type   |
+-------------------+---------+
| difficulty_level  | Integer |
|       score       | Integer | **
+-------------------+----------+

<challenges> - challenge 정보
             - The hacker_id is the id of the hacker who created the challenge.
+-------------------+---------+
|       Column      |  Type   |
+-------------------+---------+
|   challenge_id    | Integer |
|     hacker_id     | Integer |
| difficulty_level  | Integer |
+-------------------+---------+

<submissions> - submission 정보
              - The hacker_id is the id of the hackr who made the submission.
+-------------------+---------+
|       Column      |  Type   |
+-------------------+---------+
|   submission_id   | Integer |
|     hacker_id     | Integer |
|   challenge_id    | Integer |
|       score       | Integer | **
+-------------------+---------+

Write a query to print the respective hacker_id and name of hackers
who achieved full scores for more than one challenge.
Order your output in descending order by the total number of challenges
in which the hacker earned a full score.
If more than one hacker received full scores in same number of challenges,
then sort them by ascending hacker_id.

*/
-- ############################################################################
-- 필요한 테이블 : hacker_id, name, full_score, sub_score
-- *주의
-- >> left join을 했더니 full_score에 null이 생김
-- >> diff.score=sub.score를 만족하지 않는 경우 null로 join된 것

select sub.hacker_id
     , h.name
from submissions sub
join hackers h on sub.hacker_id = h.hacker_id
join challenges ch on sub.challenge_id = ch.challenge_id
join difficulty diff on (ch.difficulty_level = diff.difficulty_level and diff.score=sub.score)
group by sub.hacker_id, h.name
having count(*) > 1
order by count(*) desc, hacker_id asc
  -- >> order by에 group by로 생성할 수 있는 집계 함수 사용가능
