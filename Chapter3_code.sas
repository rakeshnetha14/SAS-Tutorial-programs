* The little SAS Primer - Chapter3 ;

*Proc Import datafile='/home/u64445632/sasuser.v94/Chapter2/Garden.csv' out=garden replace ;
DATA garden;
	Infile '/home/u64445632/sasuser.v94/Chapter2/Garden.csv' DLM=',' DSD MISSOVER FIRSTOBS=2;
	Input Name :$7. Tomato Zucchini Peas Grapes;
	zone = 14;
	type = 'home';
	Zucchini = Zucchini*10;
	Total = Tomato + Zucchini + Peas + Grapes;
	Perform = (Tomato/Total)*100;
Run;

Proc Print Data=garden;
Run;

DATA Pumpkin;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Pumpkin.dat';
	INPUT Name $16. Age 3. +1 Type $1. +1 Date MMDDYY10. (Score1 Score2 Score3) (4.1);
	AvgScore = MEAN(Score1,Score2,Score3);
	DayEntered = DAY(Date);
	Type = UPCASE(Type);

Proc Print DATA=Pumpkin;
	Title 'Pumpkin data by informat input';
Run;

DATA auction;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Auction.txt' DLM='09'X DSD MISSOVER FIRSTOBS=2;
	Input Make :$13. Model :$13. YearMade Seats MillionsPaid;
	If YearMade < 1890 Then Veteran = 'Yes';
	If Model = 'F-88' Then Do;
		Make = 'Oldsmobiles';
		Seats = 2;
	END;
Run;

Proc Print Data=Auction;
Title 'Cars sold at auction';
Run;

Data home;
	Infile '/home/u64445632/sasuser.v94/Chapter2/Home.txt' DLM='09'X Dsd Missover FIRSTOBS=2;
	Input Owner :$9. Description :$25. Cost;
	IF Cost = . THEN CostGroup = 'missing';
		ELSE if Cost < 2000 Then CostGroup = 'low';
		ELSE If Cost <10000 Then CostGroup = 'medium';
		ELSE CostGroup = 'high';
Run;

Proc Print Data=home;
Run;

* Working with dates;

Data librarycards;
	Infile '/home/u64445632/sasuser.v94/Chapter2/Library.dat' TRUNCOVER;
	Input Name $11. +1 BirthDate MMDDYY10. +1 IssueDate ANYDTDTE10. DueDate DATE11.;
	DaysOverDue = TODAY() - DueDate;
	CurrentAge = INT(YRDIF(BirthDate, TODAY(), 'AGE'));
	IF IssueDate > '01JAN2012'D THEN NewCard = 'yes';
Run;

Proc Print Data=librarycards;
	FORMAT IssueDate MMDDYY8. DueDate WEEKDATE17.;
	Title 'Data without and with Formats';
Run;

Data games;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Games.txt' DLM='09'X DSD MISSOVER FIRSTOBS=2;
	INPUT Month :2. Day :2. Team :$22. Hits :2. Runs :2.;
	RETAIN MaxRuns;
	MaxRuns = MAX(MaxRuns, Runs);
	RunsToDate + Runs;
Run;

Proc Print Data=games;
Run;

Data songs;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/KBRK.csv' DLM=',' DSD MISSOVER FIRSTOBS=2;
	INPUT City :$15. Age wj kt tr filp ttr;
	Array song (5) wj kt tr filp ttr;
	DO i=1 to 5;
		IF song(i) = 9 THEN song(i) = .;
	END;
Run;

Proc Print Data=songs;
Run;

Data songs1;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/KBRK.csv' DLM=',' DSD MISSOVER FIRSTOBS=2;
	INPUT City :$15. Age wj kt tr filp ttr;
	ARRAY new (5) Song1 - Song5;
	ARRAY old (5) wj -- ttr;
	DO i = 1 to 5;
		IF old(i) = 9 THEN new(i)=.;
			ELSE new(i) = old(i);
	END;
	AvgScore = MEAN(OF Song1 - Song5);

PROC Print Data=songs1;
Run;

