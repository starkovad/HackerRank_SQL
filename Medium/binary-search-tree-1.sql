select 
    N,
    case
        when N in (
                    select distinct bst1.N

                    from bst bst1
                    join bst bst2 on bst1.N = bst2.P
            
                    ) 
            and P is not NULL
        then 'Inner' 
        when P is NULL then 'Root'
        else 'Leaf'
    end

from
    bst 
order by 
    N