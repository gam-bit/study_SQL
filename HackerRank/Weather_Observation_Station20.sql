-- 데이터가 짝수개 -> n/2, n/2 + 1번째 데이터의 평균
-- 데이터가 홀수개 -> (n+1)/2 번째 데이터 값


-- 방법1)[MySQL]
set @rownum = 0;

select round(avg(lat_n), 4) as median
from (select lat_n
     , @rownum := @rownum + 1 as rownum
     , (select count(*) from station) as n
from station
order by lat_n) t
where rownum = n/2 or rownum = n/2 + 1 or rownum = (n+1)/2



--##############################################
-- MySQL에서 row_number()

set @rownum = 0;
select col1, col2, col3
     , @rownum := @rownum + 1 as rownum
from table
order by sort_col


-- MySQL에서 dense_rank()
set @rank=0, @last=0;
select sort_col
     , if(@last < sort_col, @rank := @rank + 1, @rank) as ranking
     , @last := sort_col
from table
order by sort_col
