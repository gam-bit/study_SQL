/*
Julia conducted a 15 days of learning SQL contest.
The start date of the contest was March 01, 2016 and the end date was March 15, 2016.

문제)
Write a query to print total number of unique hackers who made at least
1 submission
***each day (starting on the first day of the contest),***
***첫 날부터 누적해서 매일매일 submission을 제출한 hacker 수***
and find the hacker_id and name of the hacker who made maximum number of
submissions each day.
If more than one such hacker has a maximum number of submissions,
print the lowest hacker_id.
The query should print this information for each day of the contest,
sorted by the date.

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
*/
--##############################################################################
--[MS SQL]
-- step 1. 각 날짜별로 매일매일 submission을 제출한 hacker의 데이터 : <base1>
--         with 문으로 갖고 있을 것
--         >> submission_date, hacker_id

-- 1-1) submission_date별로 하루하루 숫자를 매김 : t1
--      >> submission_date, date_count
/*
2016-03-01 1
2016-03-02 2
2016-03-03 3
2016-03-04 4
2016-03-05 5
*/
select submission_date
     , row_number() over (order by submission_date) as date_count
from submissions
group by submission_date

-- 1-2) submission_date, hacker_id별로 하루하루 숫자를 매김 : t2
--      >> submission_date, hacker_id, subs_date_count
/*
2016-03-05 79 1
2016-03-01 433 1
2016-03-09 433 2
2016-03-15 433 3
2016-03-09 463 1
2016-03-13 463 2
2016-03-14 463 3
2016-03-02 533 1
2016-03-04 533 2
2016-03-04 533 3
2016-03-07 533 4
2016-03-12 533 5
*/
select submission_date
     , hacker_id
     , row_number() over (partition by hacker_id order by submission_date) as subs_date_count
from (select submission_date, hacker_id
      from submissions
      group by submission_date, hacker_id) t0


-- 1-1 + 1-2) 매일매일 submission 제출(여부) 상황을 나타내는 table : base1
--            >> submission_date, hacker_id (제출한 데이터만 나옴)
select t2.submission_date, t2.hacker_id
from (select submission_date
           , hacker_id
           , row_number() over (partition by hacker_id order by submission_date) as subs_date_count
      from (select submission_date, hacker_id
            from submissions
            group by submission_date, hacker_id) t0) t2
join (select submission_date
           , row_number() over (order by submission_date) as date_count
      from submissions
      group by submission_date) t1 on t1.submission_date = t2.submission_date and t1.date_count = t2.subs_date_count

-- step 2. 각 날짜별로 submission을 제출한 unique hackers 숫자가 있는 테이블 : tt1
--         >> submission_date, num_hackers
select submission_date
     , count(distinct hacker_id) as num_hackers
from base1
group by submission_date


--==========================================
-- step 3. 날짜별, hacker별로 submission 제출 횟수가 있는 테이블 : tt2
--         >> submission_date, num_subs, hacker_id, name
select s.submission_date
     , count(*) as num_subs
     , s.hacker_id
     , h.name
from submissions s
join hackers h on s.hacker_id = h.hacker_id
group by s.submission_date, s.hacker_id, h.name



-- step 4. tt2에서 제출 횟수가 제일 많을 때의 데이터를 추출 : tt3
--         >> submission_date, max_subs
select submission_date
     , max(num_subs) max_subs
from tt2
group by submission_date



-- step 5. tt1, tt2, tt3를 join해서 원하는 데이터 추출 : ttt
--         >> submission_date, num_hackers, hacker_id, name
select tt1.submission_date
     , tt1.num_hackers
     , tt2.hacker_id
     , tt2.name
from tt2
join tt1 on tt1.submission_date = tt2.submission_date
join tt3 on tt2.submission_date = tt3.submission_date and tt2.num_subs = tt3.max_subs



-- step6. 날짜별로 num_subs가 같은 hackers가 존재하는 경우에는
--        hacker_id가 작은 경우를 선택 : tttt
--        >> submission_date, num_hackers, min_hacker_id
select submission_date
     , min(hacker_id) min_hacker_id
from ttt
group by submission_date, num_hackers



-- step7. tttt와 hackers를 join해서 name 붙이기
select tttt.submission_date
     , tttt.num_hackers
     , h.hacker_id
     , h.name
from tttt
join hakcers h on tttt.min_hacker_id = h.hacker_id
order by submisson_date




--======================================
-- 나의 답 total solution)
with base1 as (
    select t2.submission_date, t2.hacker_id
    from (select submission_date
               , hacker_id
               , row_number() over (partition by hacker_id order by submission_date) as subs_date_count
         from (select submission_date, hacker_id
               from submissions
               group by submission_date, hacker_id) t0) t2
    join (select submission_date
               , row_number() over (order by submission_date) as date_count
          from submissions
          group by submission_date) t1 on t1.submission_date = t2.submission_date and t1.date_count = t2.subs_date_count)

select tttt.submission_date
     , tttt.num_hackers
     , h.hacker_id
     , h.name
from (select submission_date
           , num_hackers
           , min(hacker_id) min_hacker_id
      from (select tt1.submission_date
                 , tt1.num_hackers
                 , tt2.hacker_id
                 , tt2.name
            from (select s.submission_date
                       , count(*) as num_subs
                       , s.hacker_id
                       , h.name
                  from submissions s
                  join hackers h on s.hacker_id = h.hacker_id
                  group by s.submission_date, s.hacker_id, h.name) tt2
            join (select submission_date
                       , count(distinct hacker_id) as num_hackers
                  from base1
                  group by submission_date) tt1 on tt1.submission_date = tt2.submission_date
            join (select submission_date
                       , max(num_subs) max_subs
                  from (select s.submission_date
                             , count(*) as num_subs
                             , s.hacker_id
                             , h.name
                        from submissions s
                        join hackers h on s.hacker_id = h.hacker_id
                        group by s.submission_date, s.hacker_id, h.name) tt2
                  group by submission_date) tt3 on tt2.submission_date = tt3.submission_date and tt2.num_subs = tt3.max_subs) ttt
        group by submission_date, num_hackers) tttt
join hackers h on tttt.min_hacker_id = h.hacker_id
order by tttt.submission_date







--#############################################################################
--#############################################################################
-- From Discussion) 더 나은 정답
-- minimum을 뽑아내는 방법이 더 유용함
SELECT Q2.submission_date, Q3.unique_count, Q2.hacker_id, H.name FROM
/**이 부분이 완전 유용!!!! Q2
>> rank로 ranking을 지정한 다음 where로 선택!!
>> group by 해서 minimum고르고 다시 subquery로 묶는 것보다 훨씬 효율적!!!
**/

    (
        SELECT submission_date, submission_count, hacker_id,
        RANK() OVER (PARTITION BY submission_date ORDER BY submission_count DESC, hacker_id ASC) Rank
        FROM
        (
            SELECT submission_date, COUNT(submission_date) as submission_count, hacker_id
            FROM Submissions
            GROUP BY submission_date, hacker_id
        ) Q1
    ) Q2
    JOIN
    (
        /** #using sliding window and day(date) to check
         whether or not the submissions of the hacker is the same number of the day till that day **/
        SELECT submission_date, COUNT(DISTINCT hacker_id) unique_count FROM
            (
            SELECT DISTINCT(T0.hacker_id), T0.submission_date,
            COUNT(T0.submission_date) OVER(PARTITION BY T0.hacker_id ORDER BY T0.submission_date ASC) subdate_count
            FROM
                        /**이 부분 놓치기 쉬움**/
                (
                    SELECT submission_date, hacker_id
                    FROM Submissions
                    GROUP BY submission_date, hacker_id
                )T0
            ) T1
        WHERE T1.subdate_count = DAY(T1.submission_date)
        GROUP BY submission_date
    ) Q3
    ON Q3.submission_date= Q2.submission_date
    JOIN Hackers H ON H.hacker_id=Q2.hacker_id
    WHERE Q2.Rank = 1

-- Q1>> submission_date, num_subs, hacker_id
-- Q2>> submission_date, num_subs, hacker_id, rank(num_sub를 기준으로)
-- T1>> hacker_id, submission_date, subdate_count(hacker별 날짜 순 누적 제출 횟수)
-- Q3>> sumbmission_date, unique_count(날짜별로 submission을 매일 제출한 hacker 수)
