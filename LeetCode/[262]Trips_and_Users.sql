/*
두 테이블을 조인해서 cancellation rate 구하기
*/

-- 내가 쓴 쿼리
with joined_table as (
    select *
         , case when status = 1 then 0 else 1 end as 'cancelled'
    from (select t.*
          from trips t
          left join users u1 on t.client_id = u1.users_id
          left join users u2 on t.driver_id = u2.users_id
          where u1.banned = 'No' and u2.banned = 'No'
                and t.request_at between '2013-10-01' and '2013-10-03') tt
)


select request_at as Day
     , round(sum(cancelled)/count(*), 2) as "Cancellation Rate"
from joined_table
group by request_at
order by request_at



-- discussion 쿼리(더 빠름)
-- 그러나 driver에 banned인 경우가 있다면 아래 쿼리로는 필터링되지 않음
-- 그럴 땐 한번 더 join 해줘야 함
select  t.Request_at Day,
        round(sum(case when t.Status like 'cancelled_%' then 1 else 0 end)/count(*),2) "Cancellation Rate"
from Trips t
inner join Users u on t.Client_Id = u.Users_Id and u.Banned='No'
where t.Request_at between '2013-10-01' and '2013-10-03'
group by t.Request_at
