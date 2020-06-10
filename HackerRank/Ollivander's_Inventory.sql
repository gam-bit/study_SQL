/*
Hermione decides the best way to choose is by determining
the minimum number of gold galleons
needed to buy each non-evil wand of high power and age.

Write a query to print the id, age, coins_needed,
and power of the wands that Ron's interested in,
sorted in order of descending power.
If more than one wand has same power, sort the result in order of descending age.

<Wands> - id는 wand의 id/ code는 wand의 code
+----+-------+--------------+-------+
| id | code  | coins_needed | power |
+----+-------+--------------+-------+
| 1  |   4   |     3688     |   8   |
| 2  |   3   |     9365     |   3   |
| 3  |   3   |     7187     |   10  |
| 4  |   1   |     734      |   8   |
| 5  |   2   |     6020     |   2   |
|... |  ...  |     ...      |  ...  |
+----+-------+--------------+-------+

<wands_property> - is_evil denotes whether the wand is good for the dark arts.
                 - The mapping between code and age is one-one.
+------+-------+---------+
| code |  age  | is_evil |
+------+-------+---------+
|  1   |   45  |    0    |
|  2   |   40  |    0    |
|  3   |   4   |    1    |
|  4   |   20  |    0    |
|  5   |   17  |    0    |
| ...  |  ...  |   ...   |
+------+-------+---------+
*/
--#############################################################################
-- 방법1)[MS SQL] window function
-- >> step1. minimum coins_needed 가 있는 table을 subquery로 생성
-- >> -->> age(or code), power 두 columns를 기준으로 하는 minimum 값을 찾아야 함
-- >> step2. 원하는 칼럼 선택 and 정렬

select id, age, coins_needed, power
from (select w.id
           , p.age
           , w.coins_needed
           , min(coins_needed) over (partition by p.age, w.power) as min_coin
           , w.power
      from wands w
      join wands_property p on w.code = p.code
      where p.is_evil = 0) t
where coins_needed = min_coin
order by power desc, age desc


--#############################################################################
-- 방법2)[MS SQL] window function(row_number) FROM DISCUSSION
select A.myid, A.age, A.coins_needed, A.power
from (select w1.id as myid
            , age
            , coins_needed
            , power
            , row_number() over (partition by age,power order by coins_needed asc) as rn
      from wands w1
      inner join wands_property w2 on w1.code = w2.code
      where is_evil = 0) A
where A.rn = 1
order by power desc, age desc


--#############################################################################
-- 방법3)[MySQL]

select t2.id
     , t2.age
     , t2.coins_needed
     , t2.power
from (select code
           , power
           , min(coins_needed) as min_coin
      from wands
      group by code, power) t1
join (select w.id
           , w.code  -- p.code도 있기 때문에 duplicate error가 떠서 직접 지정함
           , w.coins_needed
           , w.power
           , p.age
           , p.is_evil
      from wands w
      join wands_property p on w.code = p.code
      where p.is_evil = 0) t2
on (t1.code = t2.code and t1.power = t2.power and t1.min_coin = t2.coins_needed)
     -- coins_needed도 같다는 조건을 주지 않으면 min_coin이 아닌 경우까지
     -- cross join이 된다.
order by power desc, age desc
