-- select class
-- from (select distinct *
--       from courses) t
-- group by class
-- having count(*) >= 5


select class
from courses
group by class
having count(distinct student) >= 5
