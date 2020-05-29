-- MS SQL에서는 pivot 키워드를 이용해서 쉽게 피봇 테이블을 만들 수 있지만,
-- mysql에서는 해당 키워드가 없다.

-- [MySQL]
/*
1. subquery로 테이블 T 생성
-- 각 occupation별로 rownum을 나타내는 칼럼 생서하는게 핵심 -> 이걸로 group by할 것
-- 각 occupation 칼럼 생성
+--------+--------+-----------+-----------+-------+
| RowNum | Doctor | Professor |   Singer  | Actor |
+--------+--------+-----------+-----------+-------+
| 1      | Aamina | NULL      | NULL      | NULL  |
| 1      | NULL   | Ashley    | NULL      | NULL  |
| 2      | NULL   | Belvet    | NULL      | NULL  |
| 3      | NULL   | Britney   | NULL      | NULL  |
| 1      | NULL   | NULL      | Christeen | NULL  |
| ...    | ...    | ...       | ...       | ...   |
+--------+--------+-----------+-----------+-------+
>> order by name을 해서 Doctor ~ Actor까지 name 순서로 정렬됨

2. rownum이 일치하면 같은 record에 입력.
>> group by rownum을 했기 때문에 select에 그룹함수 min/max를 사용해주어야 함
*/


set @r1=0, @r2=0, @r3=0, @r4=0;
select max(T.Doctor), max(T.Professor), max(T.Singer), max(T.Actor)
from (
    select case when occupation = 'Doctor' then @r1 := @r1 + 1
                when occupation = 'Professor' then @r2 := @r2 + 1
                when occupation = 'Singer' then @r3 := @r3 + 1
                when occupation = 'Actor' then @r4 := @r4 + 1 end as RowNum,
           case when occupation = 'Doctor' then name end as Doctor,
           case when occupation = 'Professor' then name end as Professor,
           case when occupation = 'Singer' then name end as Singer,
           case when occupation = 'Actor' then name end as Actor
    from occupations
    order by name) T
group by T.Rownum
