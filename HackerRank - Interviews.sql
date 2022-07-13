/*

Problem: https://www.hackerrank.com/challenges/interviews/problem

*/

WITH challenge_agg as (
    
    select
        coalesce(vs.challenge_id,ss.challenge_id) as challenge_id,
        isnull(ss.submissions,0) as submissions,
        isnull(ss.accepted_submissions,0) as accepted_submissions,
        isnull(vs.views,0) as views,
        isnull(vs.unique_views,0) as unique_views
    from (
        (select challenge_id, sum(total_views) as views, sum(total_unique_views) as unique_views
        from view_stats
        group by challenge_id) vs
        full outer join
        (select challenge_id, sum(total_submissions) as submissions, sum(total_accepted_submissions) as accepted_submissions
        from submission_stats
        group by challenge_id) ss on vs.challenge_id=ss.challenge_id
    )
)

select cont.contest_id, cont.hacker_id, cont.name, SUM(agg.submissions), SUM(agg.accepted_submissions), SUM(agg.views), SUM(agg.unique_views)
from challenge_agg agg
    join challenges chal on agg.challenge_id=chal.challenge_id
    join colleges coll on chal.college_id=coll.college_id
    join contests cont on coll.contest_id=cont.contest_id
group by cont.contest_id, cont.hacker_id, cont.name
having IsNull(SUM(agg.submissions),0)+IsNull(SUM(agg.accepted_submissions),0)+IsNull(SUM(agg.views),0)+ IsNull(SUM(agg.unique_views),0) > 0
order by cont.contest_id;