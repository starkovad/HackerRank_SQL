select
    concat(Name, '(', substring(Occupation, 1, 1), ')')

from 
    occupations
order by
    Name;
    
select 
    concat('There are a total of ', 
           convert(oc.occup_cnt, char(2)), 
           ' ',
           oc.occup, 's.') 

from
    (
        select
            lower(Occupation) as occup,
            count(Occupation) as occup_cnt
        from 
            occupations
        group by
            Occupation
        order by
            occup_cnt,
            occup
    ) as oc