/*
P1(a, b), P2(c, d)
- a happens to equal the minimum value in Northern Latitude(LAT_N in <station>)
- b happens to equal the minimum value in Western Longitude (LONG_W in <station>)
- c happens to equal the maximum value in Northern Latitude (LAT_N in <station>)
- d happens to equal the maximum value in Western Longitude (LONG_W in <station>)

Query the Manhattan Distance between points P1 and P2
and round it to a scale of  decimal places.
*/
--#############################################################################

select round(abs(a-c) + abs(b-d), 4)
from (
    select min(lat_n) a
         , min(long_w) b
         , max(lat_n) c
         , max(long_w) d
    from station) t


-- 한 번에 쓸 수도 있음
SELECT ROUND(abs((MAX(LONG_W) - MIN(LONG_W)))+ABS((MAX(LAT_N)-MIN(LAT_N))),4)
FROM STATION
