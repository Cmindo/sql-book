/*

Problem: https://platform.stratascratch.com/coding/10284-popularity-percentage

*/

select user_id, total_friends/count(user_id) over ()*100 as popularity_pct 
from
    (select user_id, sum(friend_count) as total_friends
    from
        (
        select user1 as user_id, count(user2) as friend_count from facebook_friends group by user1
        union
        select user2 as user_id, count(user1) as friend_count from facebook_friends group by user2
        order by user_id
        ) as tbl
    group by user_id) as tbl2