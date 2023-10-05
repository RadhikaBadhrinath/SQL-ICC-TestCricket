create database mini_proj;
use mini_proj;

#Import the csv file to a table in the database.
select * from icc;

# Extract the country name and player names from the given data and store it in seperate columns for further use.
alter table icc add column  Country varchar(5) ;
alter table icc add column  Player_name varchar(20) ;
alter table icc modify column Player_name varchar(40);

update icc set Country = substring_index(substring_index(Player,'(',-1),')',1) ;

update icc set Player_name=substring_index(Player,'(',1) ;

#From the column 'Span' extract the start_year and end_year and store them in seperate columns for further use.

alter table icc add column  start_year varchar(10) ;
alter table icc add column  end_year varchar(10) ;

update icc set start_year  = substring_index(Span,'-',1) ;

update icc set end_year  = substring_index(Span,'-',-1) ;

#The column 'HS' has the highest score scored by the player so far in any given match. The column also has details if the player 
#had completed the match in a NOT OUT status. Extract the data and store the highest runs and the NOT OUT status in different columns.

alter table icc add column  HS_NO varchar(20) ;
update icc set HS_NO=concat(HS,',',NO) ;

#Using the data given, considering the players who were active in the year of 2019, create a set of batting order of best 6 players 
#using the selection criteria of those who have a good average score across all matches for India.

select * from 
(select Player_name,Country,max(Avg) from icc
 where end_year=2019 and Country='INDIA'
 group by Player_name,Country
 order by Avg desc limit 6) as a;
 
#Using the data given, considering the players who were active in the year of 2019, create a set of batting order of best 6 players 
#using the selection criteria of those who have highest number of 100s across all matches for India.

select * from 
(select Player_name,Country, '100' from icc
 where end_year=2019 and Country='INDIA'
 group by Player_name,Country
 order by '100' desc limit 6 )as a;
 
 #Using the data given, considering the players who were active in the year of 2019, create a set of batting order of best 6 players
 #using 2 selection criterias of your own for India.
 
select * from 
(select Player_name,sum(Runs) as Total_Run ,Country,max(Avg) as maximum_average from icc
 where end_year=2019 and Country='INDIA'
 group by Player_name,Country
 having Total_Run>700 and maximum_average>42
 order by Total_Run desc limit 6) as a;
 
 #Creating a View named ‘Batting_Order_GoodAvgScorers_SA’ using the data given, considering the players who were active in the year of 2019, 
 #creating a set of batting order of best 6 players using the selection criteria of those 
 #who have a good average score across all matches for South Africa.
 
 create view  Batting_Order_GoodAvgScorers_SA as
 select Player_name,Country,max(Avg) as maximum_average from icc
 where end_year='2019' and Country = 'SA'
 group by Player_name,Country
 order by Player_name limit 6;

#Creating a View named ‘Batting_Order_HighestCenturyScorers_SA’ Using the data given, considering the players who were active in the year of 2019, 
#creating a set of batting order of best 6 players using the selection criteria of those 
#who have highest number of 100s across all matches for South Africa.

create view Batting_Order_HighestCenturyScorers_SA as
 select Player_name,Country,max(100) as maximum_average from icc
 where end_year='2019' and Country = 'SA'
 group by Player_name,Country
 order by Player_name limit 6;


