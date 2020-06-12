/*
Write a query to output the start and end dates of projects listed
by the number of days it took to complete the project in ascending order.
If there is more than one project that have the same number of completion days
, then order by the start date of the project.

<projects>
+------------+----------+
|   Column   |   Type   |
+------------+----------+
|   task_id  |  Integer |
| Start_Date |   Date   |
|  End_Date  |   Date   |
+------------+----------+
*/
--##############################################################################
SELECT Start_Date, min(End_Date)
FROM
    (SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) a, -- end_date에 나타나지 않는 start_date
    (SELECT End_Date FROM Projects WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) b  -- start_date에 나타나지 않는 end_date
WHERE Start_Date < End_Date
GROUP BY Start_Date
ORDER BY datediff(min(End_date), Start_Date), Start_Date
