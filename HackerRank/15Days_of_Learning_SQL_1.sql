/*
Julia conducted a 15 days of learning SQL contest.
The start date of the contest was March 01, 2016 and the end date was March 15, 2016.

문제)
Write a query to print total number of unique hackers who made at least
1 submission, ***이 부분이 수정 됨***
and find the hacker_id and name of the hacker who made maximum number of
submissions each day.
If more than one such hacker has a maximum number of submissions,
print the lowest hacker_id.
The query should print this information for each day of the contest,
sorted by the date.
>> 각 날짜별로 submission을 제출한 distinct hackers 수를 구하고,
>> 해당 날짜에 submission 수가 제일 많은 hacker_id, name을 추출하라.

<hackers>
+------------+---------+
|   Column   |   Type   |
+------------+---------+
| hacker_id  |  Integer |
|    Name    |  String  |
+------------+---------+

<submissions>
+----------------+----------+
|     Column     |   Type   |
+----------------+----------+
| submission_date|  Date    |
|  hacker_id     |  Integer |
| challenge_id   |  Integer |
|     score      |  Integer |
+----------------+----------+

정답) 맨 밑에 있음. HackerRank에 돌리면 WrongAnswer로 나오지만 확인은 가능함.

*/
--##############################################################################
--[MySQL]
-- step 1. 각 날짜별로 submission을 제출한 unique hackers 숫자가 있는 테이블 : t1
--         >> submission_date, num_hackers
select submission_date
     , count(distinct hacker_id) as num_hackers
from submissions
group by submission_date


-- step 2. 각 날짜별, hacker별로 submission 제출 횟수가 있는 테이블 : t2
--         >> submission_date, num_submissions, hacker_id, name
select s.submission_date
     , count(*) as num_submissions
     , s.hacker_id
     , h.name
from submissions s
join hackers h on s.hacker_id = h.hacker_id
group by s.submission_date, s.hacker_id, h.name


-- step3. t2에서 제출 횟수가 제일 많을 때의 데이터를 추출 : t3
--        >> submission_date, max_subs
select submission_date
     , max(num_submissions) max_subs
from t2
group by submission_date


-- step4. t1, t2, t3를 join해서 원하는 데이터 추출 : ttt
--        >> submission_date, num_hackers, hacker_id, name
select t1.submission_date
     , t1.num_hackers
     , t2.hacker_id
     , t2.name
from t2
join t1 on t1.submission_date = t2.submission_date
join t3 on t2.submission_date = t3.submission_date
where t2.num_submissions = t3.max_subs
order by submissions_date, hacker_id


-- step5. 날짜별로 submissions이 같은 hackers가 존재하는 경우에는
--        hacker_id가 작은 경우를 선택한 테이블 : tttt
--        >> submission_date, num_hackers, min_hacker_id
select submission_date
     , num_hackers
     , min(hacker_id) min_hacker_id
from (select t1.submission_date
           , t1.num_hackers
           , t2.hacker_id
           , t2.name
      from t2
      join t1 on t1.submission_date = t2.submission_date
      join t3 on t2.submission_date = t3.submission_date
      where t2.num_submissions = t3.max_subs
      order by submissions_date, hacker_id) ttt
group by submission_date, num_hackers

-- step6. tttt와 hackers를 join해서 tttt에 name을 붙임
select tttt.submission_date
     , tttt.num_hackers
     , h.hacker_id
     , h.name
from (select submission_date
           , num_hackers
           , min(hacker_id) min_hacker_id
      from (select t1.submission_date
                 , t1.num_hackers
                 , t2.hacker_id
                 , t2.name
            from t2
            join t1 on t1.submission_date = t2.submission_date
            join t3 on t2.submission_date = t3.submission_date
            where t2.num_submissions = t3.max_subs
            order by submissions_date, hacker_id) ttt
      group by submission_date, num_hackers) tttt
join hackers h on tttt.min_hacker_id = h.hacker_id


-- total solutions)
select tttt.submission_date
     , tttt.num_hackers
     , h.hacker_id
     , h.name
from (select submission_date
           , num_hackers
           , min(hacker_id) min_hacker_id
      from (select t2.submission_date
                 , t1.num_hackers
                 , t2.hacker_id
                 , t2.name
            from (select s.submission_date
                       , count(*) as num_submissions
                       , s.hacker_id
                       , h.name
                  from submissions s
                  join hackers h on s.hacker_id = h.hacker_id
                  group by s.submission_date, s.hacker_id, h.name) t2
      join (select submission_date
                 , count(distinct hacker_id) as num_hackers
            from submissions
            group by submission_date) t1 on t1.submission_date = t2.submission_date
      join (select submission_date
                 , max(num_submissions) max_subs
            from (select s.submission_date
                , count(*) as num_submissions
                , s.hacker_id
                , h.name
            from submissions s
            join hackers h on s.hacker_id = h.hacker_id
            group by s.submission_date, s.hacker_id, h.name) t2_sub
            group by submission_date) t3 on t2.submission_date = t3.submission_date and t2.num_submissions = t3.max_subs
        order by submission_date, hacker_id ) ttt
        group by submission_date, num_hackers) tttt
join hackers h on tttt.min_hacker_id = h.hacker_id
order by submission_date



--#############################################################################
--[MS SQL]
-- solutions)
with t2 as (
    select s.submission_date
         , count(*) as num_submissions
         , s.hacker_id
         , h.name
    from submissions s
    join hackers h on s.hacker_id = h.hacker_id
    group by s.submission_date, s.hacker_id, h.name)


select submission_date
     , num_hackers
     , hacker_id
     , name
from (
    select t1.submission_date
         , t1.num_hackers
         , t2.hacker_id
         , row_number() over (partition by t1.submission_date order by t2.num_submissions desc, t2.hacker_id) order_id
         , t2.name
     from t2
     join (select submission_date
                , count(distinct hacker_id) as num_hackers
           from submissions
           group by submission_date) t1 on t1.submission_date = t2.submission_date) t
where order_id = 1


--#############################################################################
/*
<output>
2016-03-01 112 81314 Denise
2016-03-02 144 39091 Ruby
2016-03-03 122 18105 Roy
2016-03-04 136 533 Patrick
2016-03-05 144 7891 Stephanie
2016-03-06 140 84307 Evelyn
2016-03-07 101 80682 Deborah
2016-03-08 147 10985 Timothy
2016-03-09 154 31221 Susan
2016-03-10 108 43192 Bobby
2016-03-11 117 3178 Melissa
2016-03-12 107 54967 Kenneth
2016-03-13 90 30061 Julia
2016-03-14 146 32353 Rose
2016-03-15 117 27789 Helen
*/
