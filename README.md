## Overview

In a soccer league each team has a home stadium, and each pair of teams faces each other twice during the season (once at the home stadium of each team). For a given match, the team whose stadium hosts the match is the home team, while the other team is the visitors team.

We model information about the league using the schema:
- Teams (name, coach)
- Matches (hTeam, vteam, hScore, vScore)

Where name is the primary key for table Teams and coach is a candidate key for the same table. Attributes hTeam and vteam denote the home, respectively visitors team. They are foreign keys referencing the Teams table. Their value cannot be null. The pair hTeam, vteam is the primary key for table Matches. hScore/vScore denote the score of the home/visitors team, respectively. The Matches table refers only to completed matches, listing their final scores which are not null.
