-- create schema for soccer league database

CREATE TABLE Teams (
    name        character varying(50) PRIMARY KEY NOT NULL,
    coach       character varying(50) NOT NULL
);
CREATE TABLE Matches (
    hTeam       character varying(50) REFERENCES Teams (name) NOT NULL,
    vteam       character varying(50) REFERENCES Teams (name) NOT NULL,
    hScore      INTEGER NOT NULL,
    vScore      INTEGER NOT NULL,
    CONSTRAINT hTeam_vTeam_pk PRIMARY KEY (hTeam, vteam)
);

