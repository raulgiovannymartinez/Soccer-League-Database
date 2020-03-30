-- create indices for soccer league database

-- Matches table

CREATE INDEX home_team 
ON Matches(hTeam)
;

CREATE INDEX visitor_team 
ON Matches(vteam)
;