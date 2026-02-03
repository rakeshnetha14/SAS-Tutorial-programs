DATA uspresidents;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/President.dat';
	INPUT Name $ Party $ Number;

PROC PRINT DATA=uspresidents;
RUN;

DATA toad;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/ToadJump.dat';
	INPUT Name $ Weight Attempt1 Attempt2 Attempt3;

Proc Print DATA=toad;
RUN;

* reading using column input ;
DATA Onion_rings;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/OnionRing.dat';
	INPUT VisitingTeam $ 1-20 ConcessionSales 21-24 BleacherSales 25-28 OutHits 29-31 TheirHits 32-34 OurScore 35-37 TheirScore 38-40;
	
Proc Print DATA=Onion_rings;
	Title 'Onion Sales Data';
Run;

* reading data using informat input;
DATA Pumpkin;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Pumpkin.dat';
	INPUT Name $16. Age 3. +1 Type $1. +1 Date MMDDYY10. (Score1 Score2 Score3) (4.1);

Proc Print DATA=Pumpkin;
	Title 'Pumpkin data by informat input';
Run;

* reading with mix of multiple styles;
DATA national_parks;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/NatPark.dat';
	INPUT Park $1-22 State $ Year @40 Size COMMA9.;
Run;

Proc Print DATA=national_parks;
	Title 'National Park Data';
Run;

* reading messy data with column pointers and lengths;
Data Canoes;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Canoes.dat';
	*INPUT @'School:' School $ @'Time:' RaceTime :STIMER8.;
	INPUT @'School:' School $ @'Time:' RaceTime :STIMER8.;
Run;

Proc PRINT Data=canoes;
	Title 'Column Pointers Usage Data';
Run;

* reading an obesrvation present in multiple lines;
DATA Temperatures;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Temperature.dat';
	INPUT city $ state $
	/ NormalHigh NormalLow
	#3 RecordHigh RecordLow;
Run;

Proc Print DATA=Temperatures;
	Title 'Temperature with observations in multiple lines';
Run;

DATA Temperatures1;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Temperature.dat';
	INPUT city $ state $
	#3 NormalHigh NormalLow
	#2 RecordHigh RecordLow;
Run;

Proc Print DATA=Temperatures1;
	Title 'Temperature with observations in multiple lines';
Run;

* reading multiple observations per line;
DATA rainfall;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Precipitation.dat';
	INPUT city $ state $ RainFall AverageDays @@;
Run;

Proc Print DATA=rainfall;
	Title 'Precipitation Data';
Run;

* reading part of the data;
Data traffic;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Traffic.dat';
	INPUT type $ @;
	IF type='surface' THEN DELETE;
	INPUT street $ 9-38 MoringTraffic @39 EveningTraffic;
Run;

Proc Print Data=traffic;
	Title 'Traffic Data';
Run;

* Using options in the INFILE;
Data icecream;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/IceCreamSales.dat' FIRSTOBS=3;
	INPUT Flavor $ Location $ Sold;
Run;

Proc Print Data=icecream;
Run;

Data icecream1;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/IceCreamSales.dat' FIRSTOBS=3 OBS=5;
	INPUT Flavor $ Location $ Sold;
Run;

Proc Print Data=icecream1;
Run;

* Using MISSOVER option;
Data allscores;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/AllScores.dat' MISSOVER;
	INPUT Name $ Score1 Score2 Score3 Score4 Score5;
Run;

Proc Print Data=allscores;
Run;

* Using the TURNCOVER option;

Data Address;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Address.dat' TRUNCOVER;
	INPUT Name $ 1-15 Number 16-19 Street $ 22-37;
Run;

Proc Print Data=Address;
Run;

* Using the delimiter options;
Data bands;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Bands.csv' DLM=',' DSD MISSOVER;
	INPUT BandName :$30. Date :DDMMYY10. Eightpm Ninepm Tenpm Elevenpm;
	*INPUT BandName :$30. GigDate :MMDDYY10. EightPM NinePM TenPM ElevenPM;
Run;

Proc Print Data=bands;
Run;

Proc Import datafile='/home/u64445632/sasuser.v94/Chapter2/Bands2.csv' out=music replace;
Run;

Proc print data=music;
Title 'Music data using Import function';
Run;

* reading excel files using IMPORT function;
Proc import Datafile='/home/u64445632/sasuser.v94/Chapter2/Trees.xlsx' OUT=trees replace DBMS=Xlsx;
Run;

Proc print Data=trees;
Title 'Excel sheet Data';
Run;

Data distance;
	Miles = 26.22;
	Kilometers = 1.61*Miles;
Run;
Proc Print Data=distance;
Run;

Data Bikes.distance;
	Miles = 26.22;
	Kilometers = 1.61*Miles;
Run;
Proc Print Data=Bikes.distance;
Run;

Proc Contents DATA=trees;
Run;