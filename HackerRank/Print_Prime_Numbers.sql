/*
문제)
Write a query to print all prime numbers less than or equal to 1000.
Print your result on a single line, and use the ampersand (&) character
as your separtor (instead of space).

For example, the output for all prime numbers <= 10 would be:
2&3&5&7
*/
--#############################################################################
-- solution from discussion
-- 1) 1~1000까지 숫자 테이블 생성하기
--   >> The information_schema.tables is kind of a default table.
--   >> This table has 62 rows, so it can only execute the statement
--   >>   in the SELECT clause 62 times(@num은 2~64까지 증가).
--   >> 그러므로 information_schema.tables를 2개 사용해서 cross join을 통해
--   >>   데이터를 63*63까지 생성한다.
SELECT @num:=@num+1 as NUMB
FROM information_schema.tables t1
   , information_schema.tables t2
   , (SELECT @num:=1) tmp


-- 2) prime number 찾기
--   >> 이것은 EXIST 내부에 존재하는 innver query가 된다.
--   >> 이런 inner query는 바깥에 있는 데이터의 모든 rows를 평가한다.
--   >> 따라서 NUMA는 모든 NUMB에 해당하는 값이 prime number가 되는지 확인하기 위해
--   >> 나누는 역할을 한다.
SELECT *
FROM (
    SELECT @nu:=@nu+1 as NUMA
    FROM information_schema.tables t1
       , information_schema.tables t2
       , (SELECT @nu:=1) tmp LIMIT 1000
) tatata
WHERE NUMA > 1 AND NUMA < NUMB AND FLOOR(NUMB/NUMA) = NUMB/NUMA



-- 3) '&'로 prime number 연결하기('PRIME1&PRIME2&...')
SELECT group_concat(NUMB separator '&')
FROM (SELECT @num:=@num+1 as NUMB -- 2~3845(62*62개)
      FROM information_schema.tables as t1
         , information_schema.tables as t2
         , (select @num:=1) temp1) tempNum
         -- @num=1로 셋팅
WHERE NUMB <= 1000 AND NOT EXISTS (SELECT * FROM
                                    (SELECT @nu:=@nu+1 as NUMA
                                     FROM information_schema.tables as t1
                                        , information_schema.tables as t2
                                        , (select @nu:=1) temp2) tatata
                                  WHERE NUMA>1 AND NUMA<NUMB AND FLOOR(NUMB/NUMA)=NUMB/NUMA)
