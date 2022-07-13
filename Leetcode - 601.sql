/*

Problem: https://leetcode.com/problems/human-traffic-of-stadium/

*/

select id, visit_date, people
from(
    select
        id,
        visit_date,
        people,
        case
        /* first instance */
            when people >= 100 and ifnull(lag(people) over (order by id asc),0) < 100 and ifnull(lead(people) over (order by id asc),0) >= 100 and ifnull(lead(people,2) over (order by id asc),0) >= 100 then 1
        /* nth instance */    
            when people >= 100 and ifnull(lag(people) over (order by id asc),0) >= 100 and ifnull(lead(people) over (order by id asc),0) >= 100 then 1
        /* last instance */
            when people >= 100 and ifnull(lag(people) over (order by id asc),0) >= 100 and ifnull(lag(people,2) over (order by id asc),0) >= 100 and ifnull(lead(people) over (order by id asc),0) < 100 then 1
        else 0
        end as cons_check
    from Stadium
    ) as cons_check_table
where cons_check = 1
        