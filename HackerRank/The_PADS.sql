-- Query1
Select concat(name, '(', substring(occupation, 1, 1), ')')
from occupations
order by name;

-- Query2
select concat('There are a total of ', t.num_occupation, ' ', lower(t.occupation), 's.')
       -- concat으로 연결하면 띄어쓰기없이 연결
from (
    select occupation
         , count(*) as num_occupation
    from occupations
    group by occupation
    order by num_occupation, occupation
) t;


--###########################################################################
-- Query2의 다른 방법
SELECT "There are a total of", count(OCCUPATION), concat(lower(occupation),"s.")
FROM OCCUPATIONS
GROUP BY OCCUPATION
ORDER BY count(OCCUPATION), OCCUPATION

-- 위와 같이 입력하면 저절로 띄어쓰기가 생성됨
-- concat으로 연결하면 띄어쓰기없이 연결
