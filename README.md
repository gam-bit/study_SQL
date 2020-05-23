## 데이터 분석을 위한 SQL 

 기본적으로 MySQL을 사용했습니다.

### LeetCode Selected Problems

window function의 경우, 버전이 낮은 MySQL에서는 작동하지 않기 때문에 MS SQL를 사용했습니다. MySQL에서 window function을 작성할 수 있는 경우는 구별할 필요가 없습니다.

| # | Problems | Solutions | Acceptance | Level | Concept |
|----|----------|-----------|-------|------| --------|
| 672 | [Swap Salary](https://leetcode.com/problems/swap-salary/) | [MySQL](./LeetCode/[627]Swap_Salary.sql) | 74.2% | Easy | Update statement; 조건문|
| 196 | [Delete Duplicate Emails](https://leetcode.com/problems/delete-duplicate-emails/) | [MySQL](./LeetCode/[196]Delete_Duplicate_Emails.sql) | 39.4% | Easy | Delete statement; subquery; join; |
| 184 | [Department Highest Salary](https://leetcode.com/problems/department-highest-salary/) | [MySQL/MS SQL](./LeetCode/[184]Department_Highest_Salary.sql) | 35.2% | Medium | Subquery;  max all; / window function;|
| 180 | [Consecutive Numbers](https://leetcode.com/problems/consecutive-numbers/) | [MySQL/MS SQL](./LeetCode/[180]Consecutive_Numbers.sql) | 38.6% | Medium | Self join; triple join; / window function; |
| 185 | [Department Top Three Salaries](https://leetcode.com/problems/department-top-three-salaries/) | [MS SQL](./LeetCode/[185]Department_Top_Three_Salaries.sql) | 33.0% | Hard | Window function; join; dense_rank; |

---
### HackerRank Selected Problems

| Problems | Solutions | Level | Concept |
|----------|-----------|-------|--------|
| [Top Earners](https://www.hackerrank.com/challenges/earnings-of-employees/problem) | [MySQL](./HackerRank/Top_Earners.sql) | Easy | Group by; order by; limit; subquery; where; having; |
| [The Report](https://www.hackerrank.com/challenges/the-report/problem) | [MySQL](./HackerRank/The_Report.sql) | Medium | Select절에 조건문; join; between A and B; |