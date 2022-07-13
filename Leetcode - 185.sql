/*

Problem: https://leetcode.com/problems/department-top-three-salaries/

A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write an SQL query to find the employees who are high earners in each of the departments.

Return the result table in any order.

*/

select Department, Employee, Salary
from (
    select td.name as Department, te.name as Employee, te.salary as Salary, dense_rank() over (partition by te.departmentId order by te.salary desc) as Salary_Rank
    from Employee te join Department td on te.departmentId = td.id
    ) as salary_rank_table
where Salary_Rank <= 3