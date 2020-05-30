/*
Write a SQL query to rank scores.
If there is a tie between two scores,
both should have the same ranking. Note that after a tie,
the next ranking number should be the next consecutive integer value.
In other words, there should be no "holes" between ranks.
--> rank, dense_rank, rownum 중 적절한 것 사용하기
*/




select score
     , dense_rank() over (order by score desc) as "Rank"
from scores
order by "Rank"
        -- 그냥 Rank라고 쓰니까 rank 함수로 인식해서 오류남
        -- 따옴표를 쓰면 그 안에있는 내용이 칼럼명으로 들어감
