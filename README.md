## 데이터 분석을 위한 SQL


### LeetCode Selected Problems


- Window function의 경우, 버전이 낮은 MySQL에서는 작동하지 않기 때문에 MS SQL를 사용했습니다. MySQL에서 window function을 작성할 수 있는 경우는 구별할 필요가 없습니다.
- [177] Window function은 MS SQL에서 작동하고, limit는 MySQL에서만 작동한다.

| # | Problems | Solutions | Acceptance | Level | Concept | Mark |
|----|----------|-----------|-------|------| --------|---|
| 672 | [Swap Salary](https://leetcode.com/problems/swap-salary/) | [MySQL](./LeetCode/[627]Swap_Salary.sql) | 74.2% | Easy | Update statement; case when;| - |
| 196 | [Delete Duplicate Emails](https://leetcode.com/problems/delete-duplicate-emails/) | [MySQL](./LeetCode/[196]Delete_Duplicate_Emails.sql) | 39.4% | Easy | Delete statement; subquery; join; | - |
| 184 | [Department Highest Salary](https://leetcode.com/problems/department-highest-salary/) | [MySQL/MS SQL](./LeetCode/[184]Department_Highest_Salary.sql) | 35.2% | Medium | Subquery;  max all; / window function;| - |
| 180 | [Consecutive Numbers](https://leetcode.com/problems/consecutive-numbers/) | [MySQL/MS SQL](./LeetCode/[180]Consecutive_Numbers.sql) | 38.6% | Medium | Self join; triple join; / window function; | - |
| 185 | [Department Top Three Salaries](https://leetcode.com/problems/department-top-three-salaries/) | [MS SQL](./LeetCode/[185]Department_Top_Three_Salaries.sql) | 33.0% | Hard | Window function; join; dense_rank; | - |
| 177 | [Nth Highest Salary](https://leetcode.com/problems/nth-highest-salary/) | [MS SQL/MySQL](./LeetCode/[177]Nth_Hightest_Salary.sql) | 30.6% | Medium | User-defined function; dense_rank; case when; if function; limit; offset; | ★ |
| 176 | [Second Highest Salary](https://leetcode.com/problems/second-highest-salary/) | [MySQL](./LeetCode/[176]]Second_Hightest_Salary.sql) | 30.9% | Easy | Case when; subquery; | ★ |
| 596 | [Classes More Than 5 Students](https://leetcode.com/problems/classes-more-than-5-students/) | [MySQL](./LeetCode/[596]Classes_More_Than_5Students.sql) | 37.7% | Easy | Group by; having절에 distinct; | - |
| 178 | [Rank Scores](https://leetcode.com/problems/rank-scores/) | [MySQL](./LeetCode/[178]Rank_Scores.sql) | 44.3% | Medium | Alias; dense_rank, rank, rownum의 차이; | - |
| 262 | [Trips and Users](https://leetcode.com/problems/trips-and-users/) | [MySQL](./LeetCode/[262]Trips_and_Users.sql) | 31.2% | Hard | Join; Data Analysis; | ★★ |

---
### HackerRank Selected Problems


- Weather Observation Station 문제들은 기본적인 정규표현식을 연습하기 좋다.


| Problems | Solutions | Level | Concept | Mark |
|----------|-----------|-------|--------|---|
| [Top Earners](https://www.hackerrank.com/challenges/earnings-of-employees/problem) | [MySQL](./HackerRank/Top_Earners.sql) | Easy | Group by; order by; limit; subquery; where; having; | - |
| [The Report](https://www.hackerrank.com/challenges/the-report/problem) | [MySQL](./HackerRank/The_Report.sql) | Medium | Select절에 조건문; join; between A and B; | - |
| [Challenges](https://www.hackerrank.com/challenges/challenges/problem) | [MySQL](./HackerRank/Challenges.sql) | Medium | Subquery; group by; having; with statement; | ★ |
| [Weather Observation Station6](https://www.hackerrank.com/challenges/weather-observation-station-6/problem) | [MySQL](./HackerRank/Weather_Observation_Station6.sql) | Easy | Regexp(정규표현식); aeiou로 시작하는 이름; | ★ |
| [Weather Observation Station9](https://www.hackerrank.com/challenges/weather-observation-station-9/problem) | [MySQL](./HackerRank/Weather_Observation_Station9.sql) | Easy | Regexp(정규표현식); aeiou로 시작하지 않는 이름; | ★ |
| [The PADS](https://www.hackerrank.com/challenges/the-pads/problem) | [MySQL](./HackerRank/The_PADS.sql) | Medium | String; concat; substring;| - |
| [Occupations](https://www.hackerrank.com/challenges/occupations/problem) | [MS SQL/MySQL](./HackerRank/Occupations.sql) | Medium | Pivot table; order by; set; | ★★ |
| [Binary Tree Nodes](https://www.hackerrank.com/challenges/binary-search-tree-1/problem) | [MySQL](./HackerRank/Binary_Tree_Nodes.sql) | Medium | Binary tree structure; subquery in select; join; case statement; | ★★ |
| [Interviews](https://www.hackerrank.com/challenges/interviews/problem) | [MySQL](./HackerRank/Interviews.sql) | Hard | Advanced join; having; order by; not equal sign; | ★★ |
