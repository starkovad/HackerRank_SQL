SET sql_mode = '';

select
    t1.sd,
    min(t2.ed)

from
    (
        select
            p1.start_date sd
        from projects p1
        left join projects p2 on p1.start_date = p2.end_date
        where
            p2.end_date is NULL
    ) t1,

    (
        select
            p2.end_date ed
        from projects p1
        right join projects p2 on p1.start_date = p2.end_date
        where
            p1.end_date is NULL
    ) t2
        
where 
    t1.sd < t2.ed

group by 
    t1.sd 
order by 
    datediff(t2.ed, t1.sd), 
    t1.sd