-- create pre-computed tables for soccer league database

-- create materialized view Scoreboard
create table Scoreboard (name, points) as
    -- combine home and visitor subqueries and sum points
    select name, sum(points) as points
    from (
        -- count points for home team
        select hteam as name,
            (case 
                 when hscore = vscore then 1 
                 when hscore > vscore then 2 
                 else 0 
             end) as points
        from Matches
        union all
        -- count points for visitor team
        select vteam as name,   
            (case 
                 when hscore = vscore then 1 
                 when hscore < vscore then 3
                 else 0 
             end) as points
        from Matches
    ) as pts_tb
    -- aggregate by name and order points descending
    group by name
    order by points desc
;

