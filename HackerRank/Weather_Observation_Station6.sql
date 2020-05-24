-- # 정규 표현식
/*
<station>
+----+---------------------+
|    Field   |    Type     |
+----+---------------------+
|     ID     |   NUMBER    |
|    CITY    | VARCHAR2(21)|
|   STATE    | VARCHAR2(2) |
|   LAT_N    |   NUMBER    |
|  LONG_W    |   NUMBER    |
+-------------+------------+


문제)
Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION.
Your result cannot contain duplicates.

*/


-- 방법1)
select distinct city
from station
where city like 'a%' or city like 'e%' or city like 'i%' or city like 'o%' or city like 'u%'



-- 방법2)
select distinct city
from station
where city regexp '^[aeiou]+' -- or '^[aeiou].*' : .*은 %같은 역할
                              -- * SQL은 다른 언어와 달리 대소문자를 구별X
