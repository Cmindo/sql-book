/*

Problem: https://leetcode.com/problems/human-traffic-of-stadium/

*/

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT

BEGIN

    RETURN (
         
    select    
        salary

    from (
            select salary, dense_rank() over (order by salary desc) as r from employee) as ranking
            where r = N
            limit 1
          );
END
        