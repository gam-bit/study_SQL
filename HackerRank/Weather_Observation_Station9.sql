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
Query the list of CITY names from STATION that do not start with vowels.
Your result cannot contain duplicates.
*/


-- 방법1) 정규표현식에서 포함하지 않는다는 의미의 기호를 사용
select distinct CITY
from STATION
where city regexp '^[^aeiou]'



-- 방법2) not 사용
select distinct CITY
from STATION
where city not regexp '^[aeiou]'
