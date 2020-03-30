# import libraries
import random
import string
import itertools
import random
import string
import psycopg2

# connect with postgresql directly
con = psycopg2.connect("host = localhost dbname=soccer_league user=xxxx password = xxxx")
cur =  con.cursor()

# options
No_teams = 3000
No_coaches = 3000

################################################### Functions #################################################################### 

def randomString_team(stringLength = 5):
    letters = string.ascii_letters
    return ''.join(random.choice(letters) for i in range(stringLength)).lower().capitalize()

def randomString_coach(stringLength = 10):
    letters = string.ascii_letters
    return ''.join(random.choice(letters) for i in range(stringLength)).lower().capitalize()

################################################### Insert Data #################################################################### 

# generate sql commands for teams table
print('generating teams')

teams = dict()
while len(teams) != No_teams:
    teams[len(teams)] = randomString_team()    

coaches = dict()
while len(coaches) != No_coaches:
    coaches[len(coaches)] = randomString_coach()    

for team, coach in zip(teams.keys(), coaches.keys()):
    cur.execute('INSERT INTO Teams (name, coach) VALUES(' '\'' + teams[team] + '\''+',''\'' + coaches[coach] + '\'' + ');\n')
    
# generate sql commands for matches table
print('generating matches')
teams_list = []
for i in teams.keys():
    teams_list.append(teams[i])
    
# create tuples for teams
teams_tuples_home = list(itertools.combinations(teams_list, 2))
teams_tuples_visitor = [(i[1],i[0]) for i in teams_tuples_home]
teams_tuple_total = teams_tuples_home + teams_tuples_visitor
home = [i[0] for i in teams_tuple_total]
visitor = [i[1] for i in teams_tuple_total]

for h, v in zip(home,visitor):
    cur.execute('INSERT INTO Matches (hTeam, vteam, hScore, vScore) VALUES (' +'\''+ h + '\''+', \'' + v + '\'' + ',' + str(random.randint(0,10)) +',' + str(random.randint(0,10)) + ');\n')


# commit to postgresql session
con.commit()

con.close()












