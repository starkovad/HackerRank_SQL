select
    con.contest_id,
    con.hacker_id,
    con.name,
    
    sum(v_sub.ts),
    sum(v_sub.tas),
    sum(v_stat.tv),
    sum(v_stat.tuv)
    
from
    Contests con
    join Colleges col on con.contest_id = col.contest_id
    join Challenges chal on col.college_id = chal.college_id
    
    left join
        (
            select
                challenge_id,
                sum(total_views) as tv,
                sum(total_unique_views) as tuv
            from 
                View_Stats
            group by
                challenge_id
        ) v_stat on  chal.challenge_id = v_stat.challenge_id
    
    left join
        (
            select 
                challenge_id,
                sum(total_submissions) as ts,
                sum(total_accepted_submissions) as tas
            from 
                Submission_Stats
            group by 
                challenge_id
        ) v_sub on chal.challenge_id = v_sub.challenge_id
    
group by
    con.contest_id,
    con.hacker_id,
    con.name
having
    (
        sum(v_sub.ts) +
        sum(v_sub.tas) +
        sum(v_stat.tv) +
        sum(v_stat.tuv)
    ) > 0
order by
    con.contest_id
