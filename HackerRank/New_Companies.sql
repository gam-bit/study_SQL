/*
Write a query to print the company_code, founder name,
total number of lead managers, total number of senior managers, total number of managers,
and total number of employees. Order your output by ascending company_code.


*Note:
- The tables may contain duplicate records.
- The company_code is string, so the sorting should not be numeric.
  For example, if the company_codes are C_1, C_2, and C_10,
  then the ascending company_codes will be C_1, C_10, and C_2.
*/
-- ############################################################################

select c.company_code
     , c.founder
     , count(distinct e.lead_manager_code) as total_lead_managers
     , count(distinct e.senior_manager_code) as total_senior_managers
     , count(distinct e.manager_code) as total_managers
     , count(distinct e.employee_code) as total_employees
from company c
left join (select distinct * from employee) e on c.company_code = e.company_code
group by c.company_code, c.founder



-- ############################################################################
-- 참고)
-- 만약 해당 테이블에 중복되는 records가 있는지 확인하고 싶으면 다음과 같은
-- 두 코드를 확인해서 값이 같은지 확인하면 된다.
select count(*) from table;
select count(*) from (select distinct * from table) t;
