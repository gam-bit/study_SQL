/*
<contests>
+------------+----------+
|   Column   |   Type   |
+------------+----------+
| contest_id |  Integer |
|  hacker_id |  Integer |
|    name    |  String  |
+------------+----------+

<colleges>
>> The college_id is the id of the college,
>> and contest_id is the id of the contest that Samantha used to screen the candidates.
+------------+----------+
|   Column   |   Type   |
+------------+----------+
| college_id |  Integer |
| contest_id |  Integer |
+------------+----------+

<challenges>
>> The challenge_id is the id of the challenge that belongs to one of the contests whose contest_id Samantha forgot,
>> and college_id is the id of the college where the challenge was given to candidates.
+------------+----------+
|   Column   |   Type   |
+------------+----------+
|challenge_id|  Integer |
| college_id |  Integer |
+------------+----------+

<view_stats>
>> The challenge_id is the id of the challenge, total_views is the number of times the challenge was viewed by candidates,
>> and total_unique_views is the number of times the challenge was viewed by unique candidates.
+--------------------+----------+
|       Column       |   Type   |
+--------------------+----------+
|    challenge_id    |  Integer |
|     total_views    |  Integer |
| total_unique_views |  Integer |
+--------------------+----------+

<submission_stats>
>> The challenge_id is the id of the challenge, total_submissions is the number of submissions for the challenge,
>> and total_accepted_submission is the number of submissions that achieved full scores.
+----------------------------+----------+
|           Column           |   Type   |
+----------------------------+----------+
|        challenge_id        |  Integer |
|      total_submissions     |  Integer |
| total_accepted_submissions |  Integer |
+----------------------------+----------+

문제)
Write a query to print
the contest_id, hacker_id, name, and the sums of total_submissions,
total_accepted_submissions, total_views, and total_unique_views for each contest
sorted by contest_id.
Exclude the contest from the result if all four sums are 0.
*/


--#############################################################################
-- [MS SQL] with statement
with base as (
    select con.contest_id
         , con.hacker_id
         , con.name
         , col.college_id
         , chal.challenge_id
    from contests con
    left join colleges col on con.contest_id = col.contest_id
    left join challenges chal on col.college_id = chal.college_id)

select b.contest_id
     , b.hacker_id
     , b.name
     , sum(t2.total_submissions) as sum_total_submissions
     , sum(t2.total_accepted_submissions) as sum_total_accepted_submissions
     , sum(t1.total_views) as sum_total_views
     , sum(t1.total_unique_views) as sum_total_unique_views
from base b
left join (
        select challenge_id
             , sum(total_views) as total_views
             , sum(total_unique_views) as total_unique_views
        from view_stats
        group by challenge_id
    ) t1 on b.challenge_id = t1.challenge_id
left join (
        select challenge_id
             , sum(total_submissions) as total_submissions
             , sum(total_accepted_submissions) as total_accepted_submissions
        from submission_stats
        group by challenge_id
    ) t2 on b.challenge_id = t2.challenge_id
group by b.contest_id, b.hacker_id, b.name
having sum(total_submissions) <> 0 or sum(total_accepted_submissions) <> 0
       or sum(total_views) <> 0 or sum(total_unique_views) <> 0
order by b.contest_id

-- ###################################################################################
-- step1) challenge_id별로 view/submission을 sum한 table 생성
-- step2) contests + colleges + chalenges를 join한 테이블 생성
-- step3) step1 + step2 on challenge_id & group by contest_id로 sum view/submission
-- step4) having 조건으로 모두 0인 records 제외
-- step5) 정렬
select con.contest_id
     , con.hacker_id
     , con.name
     , sum(sub.total_submissions) as sum_total_submissions
     , sum(sub.total_accepted_submissions) as sum_total_accepted_submissions
     , sum(views.total_views) as sum_total_views
     , sum(views.total_unique_views) as sum_total_unique_views
from contests con
left join colleges col on con.contest_id = col.contest_id
left join challenges chal on col.college_id = chal.college_id
left join (
      select challenge_id
           , sum(total_views) as total_views
           , sum(total_unique_views) as total_unique_views
      from view_stats
      group by challenge_id ) views on chal.challenge_id = views.challenge_id
left join (
    select challenge_id
         , sum(total_submissions) as total_submissions
         , sum(total_accepted_submissions) as total_accepted_submissions
    from submission_stats
    group by challenge_id) sub on chal.challenge_id = sub.challenge_id
group by con.contest_id, con.hacker_id, con.name
having sum(total_submissions) != 0 or sum(total_accepted_submissions) != 0
       or sum(total_views) != 0 or sum(total_unique_views) != 0
order by con.contest_id, con.hacker_id, con.name
-- ## 함부로 join을 사용하지 말 것. left join이 현실적으로 막 붙일 수 있어서 더 적합.

-- #############################################################################
-- 위의 코드랑 having절만 조금 다름. 둘 다 사용 가능함.
select con.contest_id
     , con.hacker_id
     , con.name
     , sum(sub.total_submissions) as sum_total_submissions
     , sum(sub.total_accepted_submissions) as sum_total_accepted_submissions
     , sum(views.total_views) as sum_total_views
     , sum(views.total_unique_views) as sum_total_unique_views
from contests con
left join colleges col on con.contest_id = col.contest_id
left join challenges chal on col.college_id = chal.college_id
left join (
      select challenge_id
           , sum(total_views) as total_views
           , sum(total_unique_views) as total_unique_views
      from view_stats
      group by challenge_id ) views on chal.challenge_id = views.challenge_id
left join (
    select challenge_id
         , sum(total_submissions) as total_submissions
         , sum(total_accepted_submissions) as total_accepted_submissions
    from submission_stats
    group by challenge_id) sub on chal.challenge_id = sub.challenge_id
group by con.contest_id, con.hacker_id, con.name
having sum_total_submissions <> 0 or sum_total_accepted_submissions <> 0
       or sum_total_views <> 0 or sum_total_unique_views <> 0
order by con.contest_id
