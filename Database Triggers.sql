-- create triggers for soccer league database

/* Write triggers to keep the Scoreboard up to date when the Matches table is 
inserted into, respectively updated. */
-- create trigger procedure
create or replace function process_match_scoreboard() returns trigger as $scoreboard$
    begin
        -- add points when tied, one to each
        if (new.hScore = new.vScore) then
            update scoreboard 
            set points = points + 1
            where (name = new.hTeam) or (name = new.vteam)
            ;
        -- add points when home wins, add 2 points to winner
        elsif (new.hScore > new.vScore) then
            update scoreboard 
            set points = points + 2
            where name = new.hTeam
            ;
        -- add points when visitor wins, add 3 points to winner
        elsif (new.hScore < new.vScore) then
            update scoreboard 
            set points = points + 3
            where name = new.vTeam
            ;
        end if;
        return null;
    end;        
$scoreboard$ language plpgsql
;

-- create trigger
create trigger tr_match_scoreboard
after insert on matches
    for each row execute procedure process_match_scoreboard()
;

