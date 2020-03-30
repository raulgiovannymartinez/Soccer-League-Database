-- common queries for the soccer league database

/* (i) Count the victories of team ”San Diego Sockers”. Return a single column
called ”wins”. */
-- count number of wins for specified team
select count(*) as wins
from Matches
-- find wins as a home or visitor team
where (hTeam = 'San Diego Sockers' and hScore > vScore) 
    or (vTeam = 'San Diego Sockers' and hScore < vScore) 
;


/* (ii) According to league rules, a defeat results in 0 points, a tie in 1 point, 
a victory at home in 2 points, and a victory away in 3 points. */
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


/* (iii) Return the names of undefeated coaches (that is, coaches whose teams 
have lost no match). */
-- find coach from the teams with no defeat
select coach
from (
    -- find the number of defeats for each team
    select name, sum(defeat) as num_defeats
    from (
        -- count defeats for home teams
        select hteam as name,
            (case 
                 when hscore < vscore then 1  
                 else 0 
             end) as defeat
        from Matches
        union all
        -- count defeats for visitor teams
        select vteam as name,
            (case 
                 when hscore > vscore then 1  
                 else 0 
             end) as defeat
        from Matches
    ) as defeats_tb
    group by name
) as num_defeats_tb
-- join teams data to get coach's name
join teams t
on num_defeats_tb.name = t.name
where num_defeats = 0 -- keep teams with no loses
;



/* (iv) Return the teams defeated only by the scoreboard leaders (i.e. ”if de- feated, 
then the winner is a leader”). The leaders are the teams with the highest number of points 
(several leaders can be tied). */
-- get teams defeated only by scoreboard leaders and those undefeated
select name 
from teams
where name not in (
    -- find teams that lost against others but not the leaders
    select t.name
    from teams t, Matches m
    where t.name = m.vteam and m.vScore < m.hScore and m.hteam not in (
        -- get scoreboard leaders
        select name
        from Scoreboard s1
        where not exists(
            select * 
            from scoreboard s2 
            where s1.points < s2.points
        )
    ) or t.name = m.hteam and m.hScore < m.vScore and m.vteam not in (
        -- get scoreboard leaders
        select name
        from Scoreboard s1
        where not exists(
            select * 
            from scoreboard s2 
            where s1.points < s2.points
        ) 
    )
)
;

